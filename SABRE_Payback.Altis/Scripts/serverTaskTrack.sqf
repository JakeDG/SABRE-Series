if (!isServer) exitWith {};

// Board task
[] spawn
{
	waitUntil {sleep 1.0; {(_x in insHeli)} count units sabre == {(alive _x && isPlayer _x)} count units sabre};
	
	{
		if (!isPlayer _x && alive _x) then 
		{ 
			//_x moveInCargo insHeli; 
			[_x, insHeli] remoteExec ["moveInCargo",[0,-2] select (isMultiplayer && isDedicated), true];
			_x assignAsCargo insHeli;
		};
	}forEach units sabre;
	
	[insHeli, true] remoteExec ["lock",[0,-2] select (isMultiplayer && isDedicated), true];
	
	["boardTask", "succeeded", "talkTask"] call FHQ_fnc_ttSetTaskStateAndNext;
	["Scripts\heliIntro.sqf"] remoteExec ["BIS_fnc_execVM",[0,-2] select (isMultiplayer && isDedicated)];
	sleep 2.0;
	
	["<t size='0.6'><t color='#D22E2E'>Blazerunner:</t> All aboard? Okay, here we go!</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
	
	sleep 5.0;
	
	// Assign heli waypoints
	_wp1 = insBlaze addWaypoint [(getMarkerPos "insHeliWp1"), 0];
	_wp1 setWaypointType "MOVE";
	
	_wp2 = insBlaze addWaypoint [(getMarkerPos "insHeliWp1"), 1]; // Slow heli down
	_wp2 setWaypointType "MOVE";
	_wp2 setWaypointSpeed "LIMITED";
	
	_wp3 = insBlaze addWaypoint [(getMarkerPos "insMkr"), 2]; // Heli lands
	_wp3 setWaypointType "MOVE";
	_wp3 setWaypointSpeed "UNCHANGED";
	_wp3 setWaypointStatements ["true", "vehicle this land 'Get Out'"];
	
	_wp4 = insBlaze addWaypoint [(getMarkerPos "insMkr"), 3]; // Heli waits for squad to leave
	_wp4 setWaypointType "MOVE";
	_wp4 setWaypointSpeed "UNCHANGED";
	_wp4 setWaypointStatements ["{!(_x in vehicle this)} count units sabre == {alive _x} count units sabre", ""];
	
	_wp5 = insBlaze addWaypoint [(getMarkerPos "ussFreeMkr"), 4]; // Heli leaves
	_wp5 setWaypointType "MOVE";
	_wp5 setWaypointSpeed "NORMAL";
	_wp5 setWaypointStatements ["true","{deleteVehicle _x} forEach crew insHeli + [insHeli]; deleteGroup insBlaze;"];
};

// Talk task
[] spawn
{
	waitUntil {sleep 1.0; (!isNil "meetContact")};
	[[], "Scripts\infoCon.sqf"] remoteExec ["BIS_fnc_execVM", [0,-2] select (isMultiplayer && isDedicated)];
	waitUntil{sleep 1.0; (!isNil "convoDone")};
	["talkTask", "succeeded", "docsTask", "fuelTask", "planeTask", "officersTask"] call FHQ_fnc_ttSetTaskStateAndNext;
	
	"TopSecret" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
};

// Weapons documents task
[] spawn
{
	waitUntil {sleep 1.0; (intelDocs getVariable "isPickPut")};
	
	deleteVehicle intelDocs;
	["docsTask", "succeeded", "talkTask", "fuelTask", "planeTask", "officersTask"] call FHQ_fnc_ttSetTaskStateAndNext;
	["shipOpMkr", "ColorRed", "X_shipOp"] call AD_fnc_crossMkr;
	sleep 3.0;
	parseText format ["<t color='#FFFFFF' size='2'>Spotter Intel Found!</t><br/><t color='#D22E2E' size='1.3'>While looking through the documents you found something that mentions where the militia is keeping the captured spotter.<br/>The location has been marked on your map!</t>"] remoteExec ["hint", [0,-2] select (isMultiplayer && isDedicated)];
	
	// Set Marker
	_spotMkr = createMarker ["spotterMkr", (getPos sptr_obj)];
	"spotterMkr" setMarkerText "Spotter!";
	"spotterMkr" setMarkerColor "ColorBlufor";
	"spotterMkr" setMarkerType "hd_dot";
};

// Fuel dump task
[] spawn
{
	waitUntil {sleep 1.0; ({alive _x} count [dump_1, dump_2]) == 0};
	
	["fuelTask", "succeeded", "talkTask", "docsTask", "planeTask", "officersTask"] call FHQ_fnc_ttSetTaskStateAndNext;
};

// Destroy planes task
[] spawn
{
	waitUntil {sleep 1.0; (({alive _x} count [plane_1,plane_2,plane_3,plane_4,plane_5]) == 0)};
	
	["planeTask", "succeeded", "talkTask", "docsTask", "fuelTask", "officersTask"] call FHQ_fnc_ttSetTaskStateAndNext;
};

// Airfield tasks completed
[] spawn
{
	waitUntil {sleep 1.0; ["fuelTask", "planeTask"] call FHQ_fnc_ttAreTasksCompleted};
	sleep 0.25;
	
	["airfieldTasks", "succeeded", "talkTask", "docsTask", "officersTask"] call FHQ_fnc_ttSetTaskStateAndNext;
	["airfieldOpMkr", "ColorRed", "X_airfield"] call AD_fnc_crossMkr;
};

// Kill officers task
[] spawn
{
	waitUntil {sleep 1.0; ({alive _x} count [officer_1, officer_2, officer_3]) == 0};
	
	["officersTask", "succeeded", "talkTask", "docsTask", "fuelTask", "planeTask"] call FHQ_fnc_ttSetTaskStateAndNext;
	["killMkr", "ColorRed", "X_officers"] call AD_fnc_crossMkr;
};

[] spawn // Update number of officers left to the players
{
	_offDead = ({alive _x} count [officer_1, officer_2, officer_3]);
	
	waitUntil {sleep 1.0; ({alive _x} count [officer_1, officer_2, officer_3]) < 3};
	parseText format ["<t color='#D22E2E' size='1.5'>Two militia officers remain.</t>"] remoteExec ["hint", [0,-2] select (isMultiplayer && isDedicated)];
	
	waitUntil {sleep 1.0; ({alive _x} count [officer_1, officer_2, officer_3]) < 2};
	parseText format ["<t color='#D22E2E' size='1.5'>One militia officer remains.</t>"] remoteExec ["hint", [0,-2] select (isMultiplayer && isDedicated)];
};

// Unlock castle raid task
[] spawn
{
	waitUntil {sleep 1.0; ["boardTask","talkTask", "docsTask", "airfieldTasks", "officersTask"] call FHQ_fnc_ttAreTasksCompleted};
	sleep 1.0;
	
	// Baseplate messege
	["<t size='0.6'><t color='#D22E2E'>Baseplate:</t> Excellent job out there, Sabre! Now it's time to finish the militia off once and for all.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 12.0;
	
	["<t size='0.6'><t color='#D22E2E'>Baseplate:</t> Head to Thronos Castle, clear it out, and kill the militia's warlord.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 199] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 2.5;
	
	"Agent" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
	
	[sabre, [["raidTasks", "primTasks"], "<img image='images\castle.jpg' width='370' height='208'/><br/><br/>Clear out <marker name='castleMkr'>Thronos Castle</marker> and neutralize the militia's Warlord.", "Raid Thronos Castle", "", getMarkerPos "castleMkr", "assigned", "ATTACK"]] call FHQ_fnc_ttAddTasks;
	sleep 6.0;
	
	[sabre, [["clearTask", "raidTasks"], "Clear out <marker name='castleMkr'>Thronos Castle</marker> of all <font color='#D22E2E'>militia personnel</font>.", "Secure the Castle", "", "", "created", "TARGET"]] call FHQ_fnc_ttAddTasks;
	sleep 6.0;
	
	[sabre, [["warlordTask", "raidTasks"], "<img image='images\warlord.jpg' width='370' height='208'/><br/><br/>Neutralize the <font color='#D22E2E'>militia's leader</font> located in <marker name='castleMkr'>Thronos Castle</marker>.", "Neutralize the Warlord", "", "", "created", "KILL"]] call FHQ_fnc_ttAddTasks;
	sleep 6.0;
	
	// Execute supply drop
	execVM "Scripts\supplyDrop.sqf";
	
	// Clear castle task
	[] spawn
	{
		waitUntil {sleep 1.0; !isNil "castleCleared"};
		
		["clearTask", "succeeded"] call FHQ_fnc_ttSetTaskState; 
	};

	// Kill warlord task
	[] spawn
	{
		waitUntil {sleep 1.0; !alive warlord};
		
		["warlordTask", "succeeded"] call FHQ_fnc_ttSetTaskState; 
	};

	// Castle tasks completed
	[] spawn
	{
		waitUntil {sleep 1.0; ["clearTask", "warlordTask"] call FHQ_fnc_ttAreTasksCompleted};
		sleep 5.0;
		
		["raidTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
		["castleMkr", "ColorRed", "X_castle"] call AD_fnc_crossMkr;
	};
};
/////////////////////////////////////// Secondary tasks //////////////////////////////////////////////////////////////

// Spotter task
[] spawn
{
	waitUntil {sleep 1.0; sptr_obj getVariable "isPickPut_H"};
	["spotterTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	sleep 4.0;
	["secTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Complete primary objectives and activate extraction
[] spawn
{
	waitUntil {sleep 1.0; ["boardTask", "talkTask", "docsTask", "airfieldTasks", "officersTask", "raidTasks"] call FHQ_fnc_ttAreTasksCompleted};
	sleep 5.5;
	
	["primTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
	sleep 5.0;
	
	// Activate extraction
	execVM "Scripts\extract.sqf";
	
	"Trinity" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
};

// Insertion stuff
[] spawn
{
	waitUntil {sleep 1.0; !isNil "heliIntroDone" && isTouchingGround insHeli};
	
	[insHeli,false] remoteExec ["lock", [0,-2] select (isMultiplayer && isDedicated), true];
	
	{doGetOut _x} forEach units sabre;
	
	["<t size='0.6'><t color='#D22E2E'>Blazerunner:</t> Alright guys, this is your stop!</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
	
	waitUntil {sleep 1.0; {!(_x in insHeli)} count units sabre == {alive _x} count units sabre};
	
	[insHeli,true] remoteExec ["lock", [0,-2] select (isMultiplayer && isDedicated), true];
	sleep 1.0;
	
	["<t size='0.6'><t color='#D22E2E'>Blazerunner:</t> Good luck out there, Sabre! I'm RTB.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
	
	sleep 1.0;

	[insHeli, "CLOSE"] call AD_fnc_animHeliDoors;
	
	//deleteVehicle insHeliTgr; // Very important to delete otherwise mission will fail!!!!
	
	// Fade out intro song
	[20,0] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 20.0;
	"" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
	sleep 20.0;
	[20,1] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
	
};