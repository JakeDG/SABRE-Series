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
		
		[sabre, [["pilotTask", "stealTasks"], "<font color='#D22E2E'>Defend the VTOL Pilot</font> from CSAT forces while he arrives and <font color='#D22E2E'>steals the VTOL</font>.", "Protect Pilot", "", vtolPilot, "assigned", "DEFEND"]] call FHQ_fnc_ttAddTasks;
		
		// Fox messege
		[
			["Spectre","Alright Sabre, my pilot is on his way. Make sure he gets to that VTOL safe and sound.",10.0,"RadioAmbient2"], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 12.0;
	
		// Fox messege
		[
			["Spectre","Be advised, one of my contacts has informed me that CSAT is sending reinforcements to Comms Bravo. Stay vigilant, Sabre! Spectre Out.",10.0,"RadioAmbient6"], AD_fnc_subtitle
		] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 1.0;
		
		// Save the game in singleplayer
		waitUntil {isNil "AD_subtitle_running"};
		if (!isMultiplayer && savingEnabled) then {saveGame;};
		sleep 1.0;
		
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
	
	// VTOL Pilot messege
	[
		["VTOL Pilot","Thanks for the cover, Sabre. I'm outta' here.",10.0,"RadioAmbient6"], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 1.0;
	
	["pilotTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	sleep 3.0;
	
	["stealTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
	
	["vtolBaseMkr", "ColorRed", "vtolBaseMkr"] call AD_fnc_crossMkr;
	
	// Save the game in singleplayer
	waitUntil {isNil "AD_subtitle_running"};
	if (!isMultiplayer && savingEnabled) then {saveGame;};
	sleep 1.0;
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
	waitUntil {sleep 1.0; (EMP getVariable ["isPickPut_H",false])};
	["empTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	["empMkr", "ColorRed", "empMkr"] call AD_fnc_crossMkr;
	
	// Save the game in singleplayer
	waitUntil {isNil "AD_subtitle_running"};
	if (!isMultiplayer && savingEnabled) then {saveGame;};
	sleep 1.0;
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
	waitUntil {sleep 1.0; ((term1 getVariable ["isTermComp",false]) && (term2 getVariable ["isTermComp",false]))};
	
	// Add CSAT intel to briefing
	[sabre, ["CSAT Intel", "[Translated] After years of research, we have finally found it! Who would've guessed that the planes crashed into a volcano of all things. By the looks of it, I believe that the planes weren't shot down, but that the EMP prototype that the cargo plane was carrying malfunctioned and sent both the plane and its escorts plummeting toward the ground. Luckily, the EMP seems mostly intact, though it's been sitting underground for a few years. The technology used to create it is ancient, but through extensive reverse engineering I believe that we could have weaponized EMPs in just a couple years. - March 11, 2033"]] call FHQ_fnc_ttAddBriefing;
	sleep 1.0;
	
	["intelTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	["volMkr", "ColorRed", "volMkr"] call AD_fnc_crossMkr;
	
	// Save the game in singleplayer
	waitUntil {isNil "AD_subtitle_running"};
	if (!isMultiplayer && savingEnabled) then {saveGame;};
	sleep 1.0;
};

// Extract task
[] spawn
{
	waitUntil {sleep 1.0; ["meetTask", "stealTasks", "empTask", "intelTask"] call FHQ_fnc_ttAreTasksCompleted};
	sleep 1.0;
	
	["primTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
	sleep 3.0;
	
	// Remove bandit markers
	deleteMarker "banditMkr_1";
	deleteMarker "banditMkr_2";
	
	// Create area marker
	"|extMkr_1|[10327.8,11888.5]|Empty|ELLIPSE|[1050,1050]|0|FDiagonal|colorOPFOR|1" call BIS_fnc_stringToMarker;
	"|extMkr_2|[10327.8,11888.5]|Empty|ELLIPSE|[1050,1050]|0|Border|colorOPFOR|1" call BIS_fnc_stringToMarker;
	
	[sabre, ["extTask", "<font color='#D22E2E'>Leave the area</font> by any means necessary!", "Leave the Area","",getMarkerPos "extMkr_1","assigned"]] call FHQ_fnc_ttAddTasks;
	sleep 3.0;
	
	// Fox messege
	[
		["Spectre","Sabre, we just intercepted CSAT comms! They've dispatched two Kajman gunships! Inbound, ETA three mikes. You guys need to get out of the AO however you can!",10.0,"RadioAmbient8"], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 12.0;
};

[] spawn
{
	waitUntil {sleep 1.0; extracted};

	["extTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	sleep 1.0;
	
	// Fox messege
	[
		["Spectre","Good, you guys made it out alive. You did excellent work today, Sabre. We'll link back up at base soon. Spectre out.",10.0,"RadioAmbient8"], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	
	"LeadTrack01b_F_EXP" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
	sleep 13.0;
	
	[] remoteExec ["AD_fnc_thanks", [0,-2] select (isMultiplayer && isDedicated)];
	sleep  15.0;
	
	activateKey "MissionCompleted";
	sleep 1.0;
	["End_Win",true,true,false] remoteExec ["BIS_fnc_endMission"];
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