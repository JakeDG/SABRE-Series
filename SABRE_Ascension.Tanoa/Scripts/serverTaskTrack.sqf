if (!isServer) exitWith {};

// Meeting task
[] spawn
{
	waitUntil {sleep 1.0; !isNil "meetDone"};
	
	["meetTask", "succeeded", "clearTask", "empTask", "intelTask", "pilotTask"] call FHQ_fnc_ttSetTaskStateAndNext;
	sleep 1.5;
	[[], "Scripts\foxCon.sqf"] remoteExec ["BIS_fnc_execVM", [0,-2] select (isMultiplayer && isDedicated)];
	
	// Fade out intro song
	[5,0] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 5.0;
	"" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
	sleep 5.0;
	[5,1] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
};

// Pilot defend task
[] spawn
{
	waitUntil {sleep 1.0; !isNil "baseCleared"};
	
	if (alive vtol && alive vtolPilot) then
	{
		["clearTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
		sleep 3.0;
		
		[sabre, [["pilotTask", "stealTasks"], "Defend the VTOL Pilot from CSAT forces while he arrives and steals the VTOL.", "Protect Pilot", "", vtolPilot, "assigned", "DEFEND"]] call FHQ_fnc_ttAddTasks;
		
		// Fox messege
		[["RadioAmbient2"],AD_fnc_soundAmp] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		["<t size='0.6'><t color='#D22E2E'>Spectre:</t> Alright Sabre, my pilot is on his way. Make sure he gets to that VTOL safe and sound.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 6.0;
		
		["<t size='0.6'><t color='#D22E2E'>Spectre:</t> Be advised, one of my contacts has informed me that CSAT is sending reinforcements to Comms Bravo. Stay vigilant!</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
		
		// Ensure pilot gets in drivers seat of the VTOL (Added in V1.1)
		waitUntil {sleep 1.0; (vtolPilot in vtol)};
		
		sleep 1.0;
		_roleArray = assignedVehicleRole vtolPilot;
		if ((_roleArray select 0) != "Driver") then // Force pilot out of the VTOL then teleport him to the driver's seat
		{
			vtolPilot action ["getOut", vtol];
			unassignVehicle vtolPilot;
			sleep 0.25;
			vtolPilot assignAsDriver vtol;
			vtolPilot moveInDriver vtol;
		};
		
		vtolPilot setBehaviour "CARELESS";
	};
};

// Steal tasks completed
[] spawn
{
	//waitUntil {sleep 1.0; ((vtolPilot in vtol) && !isTouchingGround vtol)};
	waitUntil {sleep 1.0; vtolPilot in vtol};
	
	["<t size='0.6'><t color='#D22E2E'>VTOL Pilot:</t> Thanks for the cover Sabre. I'm outta' here.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 1.0;
	
	["pilotTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	sleep 3.0;
	
	["stealTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
	
	["vtolBaseMkr", "ColorRed", "vtolBaseMkr"] call AD_fnc_crossMkr;
};

// Steal tasks failed
[] spawn
{
	waitUntil {sleep 1.0; (!alive vtol || !alive vtolPilot)};
	
	if (["stealTasks"] call FHQ_fnc_ttGetTaskState != "succeeded") then 
	{
		["stealTasks", "failed"] call FHQ_fnc_ttSetTaskState;
		sleep 3.0;
		
		if (["clearTask"] call FHQ_fnc_ttGetTaskState != "succeeded") then
		{
			["clearTask", "canceled"] call FHQ_fnc_ttSetTaskState;
			sleep 3.0;
		};
		
		if (["pilotTask"] call FHQ_fnc_ttGetTaskState != "succeeded" && alive vtolPilot) then
		{
			["pilotTask", "canceled"] call FHQ_fnc_ttSetTaskState;
		}
		else
		{
			if (["pilotTask"] call FHQ_fnc_ttGetTaskState != "succeeded" && !alive vtolPilot) then
			{
				["pilotTask", "failed"] call FHQ_fnc_ttSetTaskState;
			};
		};
	};
};

// EMP tracker task
[] spawn
{
	waitUntil {sleep 1.0; (EMP getVariable "isPickPut")};
	["empTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	["empMkr", "ColorRed", "empMkr"] call AD_fnc_crossMkr;
};

// EMP fail task
[] spawn
{
	waitUntil {sleep 1.0; !alive EMP};
	["empTask", "failed"] call FHQ_fnc_ttSetTaskState;
	["empMkr", "ColorRed", "empMkr"] call AD_fnc_crossMkr;
};

// Intel task
[] spawn
{
	waitUntil {sleep 1.0; ((term1 getVariable "isTermComp") && (term2 getVariable "isTermComp"))};
	
	[sabre, ["CSAT Intel", "[Translated] After years of research, we have finally found it! Who would've guessed that the planes crashed into a volcano of all things. By the looks of it, I believe that the planes weren't shot down, but that the EMP protoype that the cargo plane was carrying malfunctioned and sent both the plane and its escorts plummiting toward the ground. Luckily, the EMP seems mostly intact, though it's been sitting underground for a few years. The technology used to create it is ancient, but through extensive reverse engineering I believe that we could have weaponized EMPs in just a couple years. - March 11, 2033"]] call FHQ_fnc_ttAddBriefing;
	sleep 1.0;
	
	["intelTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	["volMkr", "ColorRed", "volMkr"] call AD_fnc_crossMkr;
};

// Extract task
[] spawn
{
	waitUntil {sleep 1.0; ["meetTask", "stealTasks", "empTask", "intelTask"] call FHQ_fnc_ttAreTasksCompleted};
	sleep 1.0;
	
	["primTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
	sleep 3.0;
	
	_extMkr = createMarker ["extMkr", [8889.37,11898.2,0]];
	"extMkr" setMarkerText "Extraction";
	"extMkr" setMarkerColor "ColorBlufor";
	"extMkr" setMarkerType "hd_pickup";
	
	[sabre, ["extTask", "Head to the lumberyard for extraction!<br/><font color='#D22E2E'>One of Agent Fox's contact will be arriving in a civilian truck to pick you up.</font>", "Move to Extraction Point","Extract",getMarkerPos "extMkr", "assigned"]] call FHQ_fnc_ttAddTasks;
	sleep 3.0;
	
	// Fox messege
	[["RadioAmbient8"],AD_fnc_soundAmp] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	["<t size='0.6'><t color='#D22E2E'>Spectre:</t> Sabre, CSAT just dispatched two gunships! ETA three mikes. Get to the lumberyard due west of the volcano for extraction. Haul ass!</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
	
	canExtract = true;
};

// Extracted, end mission
[] spawn
{
	waitUntil {sleep 1.0; (canExtract && ({(_x in escapeVeh)} count units sabre == {alive _x} count units sabre))};
	
	[escapeVeh, false] remoteExec ["lock",[0,-2] select (isMultiplayer && isDedicated)];

	["extTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	sleep 1.0;
	
	["<t size='0.6'><t color='#D22E2E'>Driver:</t> Okay, we're outta' here!</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 2.0;
	
	"Watchtower" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
	sleep 5.0;
	
	[] remoteExec ["AD_fnc_thanks", [0,-2] select (isMultiplayer && isDedicated)];
	sleep  30.0;
	
	activateKey "MissionCompleted";
	sleep 1.0;
	["End_Win",true,true,false] remoteExec ["BIS_fnc_endMission"];
};

// Extract dead
[] spawn
{
	waitUntil {sleep 1.0; canExtract && !alive escapeVeh};
	
	["extTask", "failed"] call FHQ_fnc_ttSetTaskState;
	sleep 1.0;
	
	// Fox messege
	[["RadioAmbient6"],AD_fnc_soundAmp] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	["<t size='0.6'><t color='#D22E2E'>Spectre:</t> Dammmit, Sabre! Looks like the extraction vehicle was destroyed!</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 8.0;
	["<t size='0.6'><t color='#D22E2E'>Spectre:</t> Move to the alt extraction point at the village of Bwawa! Hurry!</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
	
	[sabre, ["extTaskAlt", "The extraction vehicle has been destroyed!<br/><font color='#D22E2E'>Move to the secondary extraction point at the Village of Bwawa</font>.", "Move to Bwawa","Move",getMarkerPos "extAlt", "assigned"]] call FHQ_fnc_ttAddTasks;
	
	[] spawn
	{
		waitUntil {sleep 1.0; !isNil "atAltExtract"};
		
		["extTaskAlt", "succeeded"] call FHQ_fnc_ttSetTaskState;
		sleep 3.0;
		[] remoteExec ["AD_fnc_thanks", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 12.0;
		["End_Win",true,true,true] call BIS_fnc_endMission;
	};
};

// Possible volcano reinforcements
if (floor(random 2) == 1) then
{
	[] spawn 
	{
		waitUntil {sleep 1.0; !isNil "inVolcano"};
		
		// Spawn heli
		_heliCrew = createGroup east;
		_heli = [getMarkerPos "heliSpawnMkr", 140, "O_Heli_Light_02_unarmed_F", _heliCrew] call BIS_fnc_spawnVehicle;
		_heliCrew setBehaviour "CARELESS";
		
		// Reinforcements
		_infGroup = [getMarkerPos "heliSpawnMkr", east, (configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfSquad"),[],[],[],[],[],90] call BIS_fnc_spawnGroup;
		_infGroup deleteGroupWhenEmpty true;
		
		// Infantry waypoints
		_wp1inf = _infGroup addWaypoint [getMarkerPos "volMkr", 0];
		[_infGroup, 2] setWaypointBehaviour "AWARE";
		_wp1inf setWaypointType "SAD";
		
		// Waypoints for heli
		_wp1 = _heliCrew addWaypoint [(getPos rf_LZ), 0];
		[_heliCrew, 2] setWaypointBehaviour "CARELESS";
		[_heliCrew, 2] setWaypointCombatMode "BLUE";
		_wp1 setWaypointType "TR UNLOAD";
		_wp1 setWaypointSpeed "NORMAL";
		_wp1 setWaypointStatements ["true", "this land 'land'"];
		
		_wp2 = _heliCrew addWaypoint [(getMarkerPos "heliSpawnMkr"), 0];
		[_heliCrew, 2] setWaypointBehaviour "CARELESS";
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointSpeed "FULL";
		_wp2 setWaypointStatements ["true","_heli = vehicle leader this; {deleteVehicle _x} forEach crew _heli + [_heli]; deleteGroup (group this);"];
		sleep 1.0;
		
		// Move group into heli
		{ 
			_x assignAsCargo (_heli select 0); 
			_x moveIncargo (_heli select 0);
		} forEach units _infGroup;
		
	};
};