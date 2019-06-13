if (!isServer) exitWith {};

// Compound task //////////////////////////////////////////////////////////////////////////////////////////////////////////////
[] spawn
{
	waitUntil {sleep 1.0; (!isNil "compoundDone")};
	["compoundTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	sleep 3.0;
	
	// Baseplate message
	[
		["Baseplate","Richman's not there? Dammit!",7.0,"RadioAmbient6"], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 10.0;
	
	[
		["Baseplate","Hack into Richman's computer in his house to give us remote access from here. Perhaps we can find some intel on his whereabouts.",10.0,"RadioAmbient2"], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 5.0;
	
	[compObj, "Hack Computer", 10, "Hacking...", "Hack Complete", "Hack Interrupted"] call AD_fnc_hack; // Add action to keyboard
	
	// Assign hacking objective
	[sabre, [["hackTask", "primTasks"], "Hack <font color='#D22E2E'>Richman's computer</font> to help Baseplate discover where he might be located.", "Hack Richman's Computer", "", getPosATL compObj, "assigned", "INTERACT"]] call FHQ_fnc_ttAddTasks;
	sleep 3.0;
	
	// Save the game in singleplayer
	waitUntil {isNil "AD_subtitle_running"};
	if (!isMultiplayer && savingEnabled) then {saveGame;};
	sleep 1.0;
	
	// Hack task ////////////////////////////////////////////////////////////////////////////////////////////////////////////
	[] spawn
	{
		waitUntil{sleep 1.0; compObj getVariable "isHacked"};
		
		["hackTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
		sleep 3.0;
		
		// Baseplate message
		[
			["Baseplate","Good job, Sabre! We're searching through his files. Stand by.",8.0,"RadioAmbient6"], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 10;
		
		[
			["Baseplate","Wait, what the Hell? It seems like Richman has been doing business with the AAF in the area.",10.0,"RadioAmbient8"], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 14;
		
		[
			["Baseplate","Holy shit! According to some of these files, it seems that Richman and the AAF in this area have been working with CSAT spec ops for a few weeks now.",15.0,"RadioAmbient2"], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 17;
		
		[
			["Baseplate"," Change of plans, Sabre! Your new orders are to move to the AAF outpost south of you. Apparently CSAT brought some strange device there. Find it!",15.0,"RadioAmbient8"], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 3.0;
		
		// Assign hacking objective
		[sabre, [["outpostTask", "primTasks"], "Infiltrate the <marker name ='outpostMkr'>AAF outpost</marker> to the west of Selakano and try to look for the unidentified <font color='#D22E2E'>CSAT device</font>.", "Find the CSAT Device", "", getMarkerPos "outpostMkr", "assigned", "SEARCH"]] call FHQ_fnc_ttAddTasks;
		
		// Add action to terminal
		[csatTerminal, "Access CSAT Terminal", "Downloading Intel...", "Download Complete!", "Download Cancelled!", false] call AD_fnc_terminalActionHold;
		sleep 5.0;
		
		// Add secondary power objective to outpost
		[sabre, [["outpostPwrTask", "secTasks"], "Shutdown the power at the AAF outpost by <font color='#D22E2E'>sabotaging</font> the <marker name ='pwrMrk_2'>transformer</marker> that routes power to the site.","Shutdown Outpost Power","", getPosATL pwrTrans_2, "created", "INTERACT"]] call FHQ_fnc_ttAddTasks;
		
		[pwrTrans_2, "Shut Off Power", 8] call AD_fnc_pickPutHold; // Add shut off action to transformer.
		sleep 6.0;
		
		[
			["Baseplate","You are cleared to engage all AAF and CSAT forces at your discretion until otherwise instructed.",10.0,"RadioAmbient2"], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 12;
		
		[
			["Baseplate","Get it done, Sabre. Baseplate, out.",7.0,"RadioAmbient6"], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 3.0;
		
		// Save the game in singleplayer
		waitUntil {isNil "AD_subtitle_running"};
		if (!isMultiplayer && savingEnabled) then {saveGame;};
		sleep 1.0;
	
		// Outpost task /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		[] spawn
		{
			waitUntil{sleep 1.0; csatTerminal getVariable "isTermComp"};
			
			["outpostTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
			["outpostMkr", "ColorRed", "aafOutpost"] call AD_fnc_crossMkr;
			sleep 3.0;
			
			// Baseplate message
			[
				["Baseplate","Alright Sabre, we'll try to decipher this new intel, which will probably take a while.",10.0,"RadioAmbient2"], AD_fnc_subtitle
			] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
			sleep 12.0;
			
			[
				["Baseplate","However, we have good news! We went through some more of Richman's intel and we found some locations he could be at. We're sending them to you now.",10.0,"RadioAmbient8"], AD_fnc_subtitle
			] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
			sleep 5.0;
			
			// Draw markers on Richman's locations
			_richLocs = [[20830.4,6565.09], [21839,5990.59], [21703.8,7537.27]];

			for "_i" from 0 to 2 do
			{
					_mkrName = "richLoc_"+str(_i);
					_richMkr = createMarker [_mkrName, (_richLocs select _i)]; 
					_richMkr setMarkerShape "ICON"; 
					_mkrName setMarkerType "hd_dot"; 
					_mkrName setMarkerColor "ColorRed"; 
					_mkrName setMarkertext "Location #"+str(_i+1);
			};
			
			[sabre, [["killTask", "primTasks"], "<img image='images\target.jpg' width='370' height='208'/><br/><br/>Find and <font color='#D22E2E'>kill Charles Richman</font> at one of his frequently visited locations. The locations have been marked on you map.", "Kill Richman", "", "", "assigned", "KILL"]] call FHQ_fnc_ttAddTasks;
			
			parsetext format ["<t color='#D22E2E' size='1.35'>Baseplate has marked Richman's possible locations on your map.</t>"] remoteExec ["hint", [0,-2] select (isMultiplayer && isDedicated)];
			sleep 8;
			
			[
				["Baseplate","Neutralize Richman and finish what you came here to do, gentlemen. Baseplate, out.",10.0,"RadioAmbient6"], AD_fnc_subtitle
			] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
			sleep 3.0;
		
			// Save the game in singleplayer
			waitUntil {isNil "AD_subtitle_running"};
			if (!isMultiplayer && savingEnabled) then {saveGame;};
			sleep 1.0;
			
			// Kill Richman /////////////////////////////////////////////////////////////////////////////////////////////////////////////
			[] spawn
			{	
				waitUntil{sleep 1.0; !alive richman_obj};
				
				["killTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
				
				// Remove Richman position markers
				for "_i" from 0 to 2 do 
				{ 
				  deleteMarker ("richLoc_"+str(_i)); 
				};
				sleep 3.0;
				
				// Baseplate message
				[
					["Baseplate","Excellent job, Sabre. The world won't miss that traitorous piece of filth. However, we have a much worse situation on our hands now!",10.0,"RadioAmbient8"], AD_fnc_subtitle
				] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
				sleep 12.0;
				
				[
					["Baseplate","According to the intel from that terminal you found earlier, CSAT has brought an experimental EMP onto Altian soil with the AAF's help!",13.0,"RadioAmbient2"], AD_fnc_subtitle
				] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
				sleep 15.0;
				
				[
					["Baseplate","That EMP must be destroyed at all costs! It's currently located at an abandoned outpost to the southeast of Feres! Get there quickly, gentlemen!",15.0,"RadioAmbient6"], AD_fnc_subtitle
				] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
				sleep 3.0;
				
				[sabre, [["empTask", "primTasks"], "Destroy the <font color='#D22E2E'>CSAT EMP</font> located at the <marker name='abanOutMkr'>abandoned outpost</marker> to the southeast of Feres.", "Destroy EMP", "", getPosATL csatEMP, "assigned", "DESTROY"]] call FHQ_fnc_ttAddTasks;
				sleep 3.0;
		
				// Save the game in singleplayer
				waitUntil {isNil "AD_subtitle_running"};
				if (!isMultiplayer && savingEnabled) then {saveGame;};
				sleep 1.0;
				
				// Destroy EMP //////////////////////////////////////////////////////////////////////////////////////////////////////////
				[] spawn
				{
					waitUntil{sleep 1.0; !alive csatEMP};
					
					["empTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
					
					// Activate alarm at old outpost
					[] spawn
					{
						while {damage alarmSpeakers < 0.9} do
						{
							playSound3D ["A3\Sounds_F\sfx\alarm_blufor.wss", alarmSpeakers];
							sleep 6.5;
						};
					};
					
					// Spawn in forces to move in on abandoned outpost
					_assaultGroup = [getMarkerPos "assGrpSpawn", independent, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Armored" >> "HAF_TankPlatoon_AA"),[],[],[],[],[],90] call BIS_fnc_spawnGroup;
					_assaultGroup deleteGroupWhenEmpty true;
					_assWp1 = _assaultGroup addWaypoint [getMarkerPos "abanOutMkr", 0];
					_assWp1 setWaypointType "SAD";
					sleep 3.0;
					
					// Baseplate message
					[
						["Baseplate","Alright, very good, Sabre. It's time to get the hell out of there!",8.0,"RadioAmbient6"], AD_fnc_subtitle
					] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
					sleep 10.0;
					
					[
						["Baseplate","It looks like you've drawn some attention to yourselves. You have multiple AAF contacts approaching your position fast!",10.0,"RadioAmbient2"], AD_fnc_subtitle
					] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
					sleep 12.0;
					
					[
						["Baseplate","There's a dock with a boat not too far from your position. Once all of you are onboard, sail out into the sea.",10.0,"RadioAmbient8"], AD_fnc_subtitle
					] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
					sleep 3.0;
	
					// Assign get in boat task
					[sabre, [["boatTask", "primTasks"], "Board the <font color='#D22E2E'>AAF gunboat</font> located at the docks near the abandoned outpost. Make sure everyone is aboard before you set sail!", "Get in the Boat", "",escBoat, "assigned", "GETIN"]] call FHQ_fnc_ttAddTasks;
					
					[escBoat,false] remoteExec ["lock", [0,-2] select (isMultiplayer && isDedicated), escBoat]; // Unlock the boat
					sleep 3.0;
		
					// Save the game in singleplayer
					waitUntil {isNil "AD_subtitle_running"};
					if (!isMultiplayer && savingEnabled) then {saveGame;};
					sleep 1.0;
					
					// Board Boat //////////////////////////////////////////////////////////////////////////////////////////////////////////////
					[] spawn
					{
						waitUntil{sleep 1.0; ({(_x in escBoat)} count units sabre == {alive _x} count units sabre)};
					
						["boatTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
					};
				};
			};
		};
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Power task (Compound)
[] spawn
{
	waitUntil{sleep 1.0; (pwrTrans_1 getVariable "isPickPut_H") || (!alive pwrTrans_1)};
	
	if (alive pwrTrans_1) then 
	{
		[pwrTrans_1, "electricity_loop"] remoteExec ["say3D", [0,-2] select (isMultiplayer && isDedicated)]; 
	};	
	["housePwrTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	
	{
		_x setDamage 0.95;
	} forEach [lamp_1,lamp_2,lamp_3,lamp_4,lamp_5];
};

// Power task (Outpost)
[] spawn
{
	waitUntil{sleep 1.0; (pwrTrans_2 getVariable "isPickPut_H") || (!alive pwrTrans_2)};
	
	if (alive pwrTrans_2) then 
	{
		[pwrTrans_2, "electricity_loop"] remoteExec ["say3D", [0,-2] select (isMultiplayer && isDedicated)]; 
	};
	["outpostPwrTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	
	// Kill the power
	_lampTypes = ["Lamps_Base_F", "Land_LampHalogen_F"];

	for [{_i=0},{_i < (count _lampTypes)},{_i=_i+1}] do
	{
		_lamps = getMarkerPos "outpostMkr" nearObjects [_lampTypes select _i, 200];
		sleep 0.1;
		{_x setDamage 0.95} forEach _lamps;
	};
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Complete primary objectives and activate extraction
[] spawn
{
	waitUntil {sleep 1.0; ["compoundTask", "hackTask", "outpostTask", "killTask", "empTask", "boatTask"] call FHQ_fnc_ttAreTasksCompleted};
	sleep 2.0;
	
	["primTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
	
	// Stop ambient music
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
	
	// Fade out music then fade in outro song
	[] spawn 
	{
		[5,0] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 5.0;
		"" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
		sleep 5.0;
		[5,1] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
		
		// Loop end song until at extraction
		while {isNil "atExtract"} do 
		{
			"Intel" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
			sleep 105; // Track length is 1:41 (101 secs)
		};
	};
	
	// Baseplate message
	[
		["Baseplate","Okay Sabre, now sail to the coordinates we've sent you for extraction. The HMS Proteus is on standby to pick you up.",10.0,"RadioAmbient8"], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];

	// Set Marker and LZ
	_extMkr = createMarker ["extMkr", getPos subExt];
	"extMkr" setMarkerText "Extraction";
	"extMkr" setMarkerColor "ColorBlufor";
	"extMkr" setMarkerType "hd_pickup";

	// Assign extraction task
	[sabre, ["extTask", "Sail to the <marker name='extMkr'>extraction point</marker> so you can board the<font color='#D22E2E'> HMS Proteus</font>", "Extraction","Extract",getMarkerPos "extMkr", "assigned"]] call FHQ_fnc_ttAddTasks;
	sleep 1.0;

	// Wait until players are at the extraction point. 
	waitUntil{sleep 1.0; !isNil "atExtract"};
	
	// End the mission
	["extTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	sleep 5.0;
	[] remoteExec ["AD_fnc_thanks", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 10.0;
	activateKey "MissionCompleted";
	["End_Win",true,true,false] remoteExec ["BIS_fnc_endMission"];
};