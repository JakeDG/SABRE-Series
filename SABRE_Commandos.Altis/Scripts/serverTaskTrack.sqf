if (!isServer) exitWith {};

// Rescue task
[] spawn
{
	waitUntil {sleep 1.0; !(sniper getVariable "isHostage")};
	
	["saveTask", "succeeded"] call FHQ_fnc_ttSetTaskState; 
	sleep 1.0;
	
	// Save the game in singleplayer
	if (!isMultiplayer && savingEnabled) then {saveGame;};
	sleep 1.0;
	
	// Sniper joins sabre team
	sniper setCaptive false;
	[sniper] joinSilent sabre;
	
	// Enable sniper's AI
	sniper enableAI "ANIM";
	sniper enableAI "MOVE";
	sleep 1.0;
	
	// Initialize revive for sniper
	[sniper] call AIS_System_fnc_loadAIS;
	
	_line1 = ["Crow", "Thanks for saving me, guys. Now lets get the fuck outta' here!"];
	[[[_line1],"CUSTOM"], TP_fnc_simpleConv] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 6.0;
	
	//"LeadTrack01_F" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
	
	// Give the sniper a pistol
	[sniper, "hgun_Rook40_F", 4] call BIS_fnc_addWeapon;
	
	// Assign evac objective
	[sabre, [["evacTask", "primTasks"], "Leave the village and return to the <marker name='stageMkr'>staging area</marker> with the sniper.", "Evac the Sniper", "", getMarkerPos "stageMkr", "assigned", "run"]] call FHQ_fnc_ttAddTasks;
	
	// Make reinforcements block the roads
	execVM "Scripts\roadblocks.sqf";
};

// Complete mission
[] spawn
{
	waitUntil {sleep 1.0; !isNil "snprSaved"};
	
	["evacTask", "succeeded"] call FHQ_fnc_ttSetTaskState; 
	
	// delete music event handler
	if (("Music" call BIS_fnc_getParamValue) == 1) then 
	{
		if (isDedicated) then
		{
			[["MusicStop", ehID]] remoteExec ["removeMusicEventHandler",-2,true]; // Remove everyones music event handlers
		}
		else
		{
			removeMusicEventHandler ["MusicStop", ehID]; // remove player host music event handler
		};
	};
	
	sleep 1.0;
	["primTasks", "succeeded"] call FHQ_fnc_ttSetTaskState; 
	sleep 4.0;
	
	[] remoteExec ["AD_fnc_thanks", [0,-2] select (isMultiplayer && isDedicated)];
	sleep  8.0;
	
	activateKey "MissionCompleted";
	sleep 1.0;
	
	"EventTrack02_F_Orange" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
	["End_Win",true,true,false] remoteExec ["BIS_fnc_endMission"];
};

// Sniper dead fail
[] spawn
{
	waitUntil {sleep 1.0; !alive sniper};
	
	["saveTask", "failed"] call FHQ_fnc_ttSetTaskState; 
	sleep 3.0;
	
	_line1 = ["Baseplate", "Goddammit, Sabre! The sniper's dead. Pull out of there. Mission failed!"];
	[[[_line1],"CUSTOM"], TP_fnc_simpleConv] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 3.0;
	
	["End_SnprDead",false] remoteExec ["BIS_fnc_endMission"];
};

// Assist Bravo task 
[] spawn
{
	waitUntil {sleep 1.0; !isNil "bravoSaved"};
	
	["bravoTask", "succeeded"] call FHQ_fnc_ttSetTaskState; 
	
	{
		_x enableAI "MOVE";
		_x enableAI "ANIM";
		_x setCaptive false;
	} forEach units bravo;
	
	deleteMarker "bravoMkr_1";
	sleep 2.5;
	
	if (!isMultiplayer && savingEnabled) then {saveGame;};
	
	_bravoMkr = createMarker ["bravoLeadMkr", (getPos (leader bravo))]; 
	"bravoLeadMkr" setMarkerType "b_recon"; 
	"bravoLeadMkr" setMarkerColor "ColorBLUFOR"; 
	"bravoLeadMkr" setMarkertext "Bravo";

	[] spawn
	{
		while {{alive _x} count units bravo != 0} do // Constantly updating marker for Bravo's location
		{
			"bravoLeadMkr" setMarkerPos (getPos (leader bravo));
			sleep 0.25;
		};
		
		deleteMarker "bravoLeadMkr";
	};
	
	_line1 = ["Bravo Lead", "Hey Sabre, thanks for the assist. Those guys showed up out of nowhere."];
	_line2 = ["Bravo Lead", "Tell you what, since you helped us, we'll help you assault Oreokastro. Just let us get in position, then give us the word when you want us to attack."];
	[[[_line1,_line2],"CUSTOM"], TP_fnc_simpleConv] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
};

// Cache task
[] spawn
{
	waitUntil {sleep 1.0; {alive _x} count [cache_1,cache_2,cache_3] == 0};
	
	["cacheTask", "succeeded"] call FHQ_fnc_ttSetTaskState; 
};

// Cache map
[] spawn
{
	waitUntil {sleep 1.0; (cacheMap getVariable "isPickPut")};

	// Draw markers on cache locations
	{
	
		_mkrName = "cacheLoc_"+str(_forEachIndex);
		_cacheMkr = createMarker [_mkrName, getPos _x]; 
		_cacheMkr setMarkerShape "ICON"; 
		_mkrName setMarkerType "hd_dot"; 
		_mkrName setMarkerColor "ColorBlack"; 
		_mkrName setMarkertext "Cache";
		
		// Delete marker when a cache is destroyed
		[_x, _mkrName] spawn
		{	
			waitUntil {sleep 1.0; !alive (_this select 0)};
			deleteMarker (_this select 1); 
		};
		
	} forEach [cache_1,cache_2,cache_3];
	
	parsetext format ["<t color='#FFFFFF' size='1.2'>You have found a map showing the militia weapon cache locations.</t><br/><t color='#D22E2E' size='1.5'>They have been marked on your map!</t>"] remoteExec ["hint", [0,-2] select (isMultiplayer && isDedicated)];
};

// Complete secondary tasks
[] spawn
{
	waitUntil {sleep 1.0; ["cacheTask", "bravoTask"] call FHQ_fnc_ttAreTasksCompleted};
	
	sleep 1.0;
	["secTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
};

/******************************* Bravo movement stuff ***********************************/
// Bravo in position
[] spawn
{
	waitUntil {sleep 1.0; !isNil "bravoWait"};
	
	_line1 = ["Bravo Lead", "Sabre, we are in position and awaiting your orders to move-in on the village. Bravo out."];
	[[[_line1],"CUSTOM"], TP_fnc_simpleConv] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];

	// Add support item (fixed to work on dedi servers)
	[[(leader sabre), "BravoAttack"], BIS_fnc_addCommMenuItem] remoteExec ["call", (leader sabre)];
};

// Bravo attacking
[] spawn
{
	waitUntil {sleep 1.0; !isNil "bravoGo"};
	
	_line1 = ["Bravo Lead", "Copy that, Sabre. Bravo is rolling. We're gonna move up the main road and hit 'em with the 50. They won't see this coming. Bravo out."];
	[[[_line1],"CUSTOM"], TP_fnc_simpleConv] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
};

// Bravo dead warning
[] spawn
{
	waitUntil {sleep 1.0; {alive _x} count units bravo == 0};
	
	if (isNil "bravoSaved") then // Bravo dead before being saved
	{	
		sleep 1.0;
		["bravoTask", "failed"] call FHQ_fnc_ttSetTaskState; 
	};
	
	if (!isNil "bravoLeadMkr") then
	{
		deleteMarker "bravoLeadMkr";
	};
	
	_line1 = ["Baseplate", "Sabre, Bravo Team has been wiped out. Stay alert out there men. Baseplate, out."];
	[[[_line1],"CUSTOM"], TP_fnc_simpleConv] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
};

/******************************** Misc **************************************/

// Civilian freed
if (!isNil "civHostage") then 
{
	[] spawn
	{
		waitUntil {sleep 1.0; !(civHostage getVariable "isHostage")};
		
		[civHostage, "civ_1"] remoteExec ["directSay",[0,-2] select (isMultiplayer && isDedicated)];
		sleep 6.0;
		[civHostage, "civ_2"] remoteExec ["directSay",[0,-2] select (isMultiplayer && isDedicated)];
	};
};

// Insertion stuff
[] spawn
{
	waitUntil {sleep 1.0; isTouchingGround insHeli};
	
	_line1 = ["Blazerunner", "Alright guys, this is your stop!"];
	[[[_line1],"CUSTOM",0.15], TP_fnc_simpleConv] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	
	waitUntil {sleep 1.0; {!(_x in insHeli)} count units sabre == {alive _x} count units sabre};
	sleep 1.0;
	
	_line1 = ["Blazerunner", "Kick some ass out there, Sabre! We are RTB, out."];
	[[[_line1],"CUSTOM",0.15], TP_fnc_simpleConv] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	
	sleep 1.0;
	[insHeli, "CLOSE"] call AD_fnc_animHeliDoors;
	
	// Fade out intro song
	[15,0] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 15.0;
	"" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
	sleep 0.25;
	
	// Activate music if ambient music is enabled
	if (("Music" call BIS_fnc_getParamValue) == 1) then 
	{
		"LeadTrack01_F_Orange" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
		sleep 15.0;
		[15,1] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
	};
};

// Blazerunner's sees truck at beginning
/*
[] spawn
{
	waitUntil {sleep 1.0; !isNil "blazeTalk"};
	[blazerunner, "Baseplate this is Blazrunner. I got a technical heading northbound on the road toward the staging area. How copy?"] remoteExec ["sideChat",[0,-2] select (isMultiplayer && isDedicated)];
	sleep 10.0;
	[] remoteExec ["clearRadio",[0,-2] select (isMultiplayer && isDedicated)];
	
	[baseplate, "Say again, Blazeruuner."] remoteExec ["sideChat",[0,-2] select (isMultiplayer && isDedicated)];
	
	waitUntil {sleep 1.0; !alive introTruck};
	
	sleep 2.0;
	[] remoteExec ["clearRadio",[0,-2] select (isMultiplayer && isDedicated)];
	[blazerunner, "Holy shit! Nevermind Baseplate. Problem solved."] remoteExec ["sideChat",[0,-2] select (isMultiplayer && isDedicated)];
};
*/