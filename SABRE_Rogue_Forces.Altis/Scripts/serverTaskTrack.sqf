if (!isServer) exitWith {};

/***************** MAIN OBJECTIVES **********************/
// Cross MSR Task
[] spawn
{
	waitUntil {sleep 1.0; (!isNil "msrCrossed")};
	
	["msrTask", "succeeded", "artyTask_1"] call FHQ_fnc_ttSetTaskStateAndNext;
};

/************************ ARTY TASKS ********************************/
// Artillery #1 Task
[] spawn
{
	waitUntil {sleep 1.0; (!alive arty_1)};
	
	["artyTask_1", "succeeded", "commTask"] call FHQ_fnc_ttSetTaskStateAndNext;
	["artyMkr_1", "ColorRed", "X_arty_1"] call AD_fnc_crossMkr;
};

// Artillery Firebase Task
[] spawn
{
	waitUntil {sleep 1.0; (!alive arty_2) && (!alive arty_3)};
	
	["artyTask_2", "succeeded", "artyTask_3"] call FHQ_fnc_ttSetTaskStateAndNext;
	["artyBaseMkr", "ColorRed", "X_artyBase"] call AD_fnc_crossMkr;
};

// Artillery #2 Task
[] spawn
{
	waitUntil {sleep 1.0; (!alive arty_4)};
	
	["artyTask_3", "succeeded", "aaTask_1", "aaTask_2", "baseTask"] call FHQ_fnc_ttSetTaskStateAndNext;
	["artyMkr_2", "ColorRed", "X_arty_2"] call AD_fnc_crossMkr;
};

// All arty tasks completed
[] spawn
{
	waitUntil {sleep 1.0; ["artyTask_1", "artyTask_2", "artyTask_3"] call FHQ_fnc_ttAreTasksCompleted};
	sleep 5.0;
	
	["artyTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
};

/********************* ANTI-AIR TASKS *************************/
// Anti-Air #1 Task
[] spawn 
{
	waitUntil {sleep 1.0; (!alive aa_1)};
	
	["aaTask_1", "succeeded", "artyTask_3", "aaTask_2", "baseTask"] call FHQ_fnc_ttSetTaskStateAndNext;
	["aaMkr_1", "ColorRed", "X_aa_1"] call AD_fnc_crossMkr;
};

// Anti-Air #2 Task
[] spawn 
{
	waitUntil {sleep 1.0; (!alive aa_2)};
	
	["aaTask_2", "succeeded", "baseTask"] call FHQ_fnc_ttSetTaskStateAndNext;
};

// All AA tasks completed
[] spawn
{
	waitUntil {sleep 1.0; ["aaTask_1", "aaTask_2"] call FHQ_fnc_ttAreTasksCompleted};
	sleep 5.0;
	
	["aaTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
};

/***************** OTHER MAIN OBJECTIVES *****************/
// Communications Task
[] spawn 
{
	waitUntil{sleep 1.0; aafTerminal getVariable "isTermComp"};
	
	["commTask", "succeeded", "artyTask_2"] call FHQ_fnc_ttSetTaskStateAndNext;
	["commMkr", "ColorRed", "X_comm"] call AD_fnc_crossMkr;
};

// Faronaki Base Task
[] spawn
{
	waitUntil {sleep 1.0; (!isNil "baseCleared")};
	
	["baseTask", "succeeded", "aaTask_2"] call FHQ_fnc_ttSetTaskStateAndNext;
	["baseMkr", "ColorRed", "X_base"] call AD_fnc_crossMkr;
};

/***************** Secondary Objectives **********************/
// Officer Task
[] spawn
{
	waitUntil {sleep 1.0; (!alive r_officer)};
	
	["officerTask", "succeeded"] call FHQ_fnc_ttSetTaskState; 
};

// Meltdown Task
[] spawn
{
	waitUntil {sleep 1.0; (compHacked)};
	
	["meltTask", "succeeded"] call FHQ_fnc_ttSetTaskState; 
	["pwrMkr", "ColorRed", "X_shipOp"] call AD_fnc_crossMkr;
};

// Rescue Task
[] spawn
{
	_loyals = [loyal1, loyal2, loyal3];
	
	waitUntil {sleep 1.0; {!(_x getVariable "isHostage")} count _loyals == {alive _x} count _loyals};
	
	if (({!(_x getVariable "isHostage")} count _loyals != 0) && {alive _x} count _loyals != 0) then 
	{
		["rescueTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
		sleep 2.0;
		
		// Display message from loyalists
		_captivesAlive = {alive _x} count [loyal1,loyal2,loyal3]; // Count number of loyalists
		if (_captivesAlive > 1) then // More than one survivor
		{
			["<t size='0.6'><t color='#D22E2E'>Loyalist:</t> Thanks for saving us from these traitors! We'll join up with you guys.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
		}
		else
		{
			if (_captivesAlive == 1) then // Only one survivor
			{
				["<t size='0.6'><t color='#D22E2E'>Loyalist:</t> Thanks for saving me! I guess I'll follow you guys.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
			};
		};	
	}
	else
	{
		["rescueTask", "failed"] call FHQ_fnc_ttSetTaskState;
	};
};

// Create events for freeing each Loyalist
{
	[_x] spawn
	{
		_loyal = _this select 0;
		waitUntil {sleep 1.0; (!(_loyal getVariable "isHostage") || !alive _loyal)};
		
		if (alive _loyal) then
		{
			[_loyal] join sabre; // Join group
			sleep 5.5;
			
			// Give loadouts to captives
			_captiveType = typeOf _loyal;
			switch (_captiveType) do
			{
				case "I_Soldier_LAT2_F":
				{
					_loyal setUnitLoadout (getUnitLoadout _captiveType);
				};
				case "I_Soldier_M_F":
				{
					_loyal setUnitLoadout (getUnitLoadout _captiveType);
				};
				case "I_Soldier_AR_F":
				{
					_loyal setUnitLoadout (getUnitLoadout _captiveType);
				};
			};

			_loyal enableAI "MOVE";
			_loyal setCaptive false;
			_loyal enableFatigue false;
			
			if ("Revive" call BIS_fnc_getParamValue == 1) then 
			{ 
				[_loyal] call AIS_System_fnc_loadAIS; // Initialize revive for loyalist
			}; 
		};
	};
}forEach [loyal1, loyal2, loyal3];

// Complete secondary tasks
[] spawn
{
	waitUntil {sleep 1.0; ["meltTask", "rescueTask", "officerTask"] call FHQ_fnc_ttAreTasksCompleted};
	
	sleep 1.0;
	["secTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
};

/****************** Extraction Task ******************/
// Complete primary objectives and activate extraction 
[] spawn
{
	waitUntil {sleep 1.0; ["artyTasks", "aaTasks", "commTask", "baseTask"] call FHQ_fnc_ttAreTasksCompleted};
	sleep 2.0;
	["primTasks", "succeeded"] call FHQ_fnc_ttSetTaskState;
	sleep 5.0;
	
	// Send enemies to outpost
	execVM "Scripts\baseAttack.sqf";
	
	// Baseplate message
	[["RadioAmbient2"],AD_fnc_soundAmp] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	["<t size='0.6'><t color='#D22E2E'>Baseplate:</t> Job well done, Sabre! We are dispatching Blazerunner to your location.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 11.0;
	
	[["RadioAmbient8"],AD_fnc_soundAmp] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	["<t size='0.6'><t color='#D22E2E'>Baseplate:</t> Be advised, it looks like General Zane is sending a welcoming party to your location from Pyrgos. Hold your ground until extraction arrives!</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 199] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 12.0;

	// Blazerunner messege
	[["RadioAmbient6"],AD_fnc_soundAmp] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	["<t size='0.6'><t color='#D22E2E'>Blazerunner:</t> Sabre, this is Blazerunner. I'm inbound. ETA 5 mikes. Blazerunner Out.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];

	sleep 10.0;
	
	// Delete the music event handler
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
	
	// Fade out music then fade in defense theme
	[] spawn 
	{
		[5,0] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 5.0;
		"" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
		sleep 1.0;
		[5,1] remoteExec ["fadeMusic", [0,-2] select (isMultiplayer && isDedicated)];
		"Static" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];
	};
	
	// Assign defend objective
	[sabre, 
		[
			"defendTask", 
			"<font color='#D22E2E'>Defend</font> the area near the <marker name='baseMkr'>Faronaki outpost</marker> until extraction arrives.", 
			"Defend Faronaki Outpost",
			"Defend", 
			getMarkerPos "baseMkr", 
			"assigned",
			"DEFEND"
		]
	] call FHQ_fnc_ttAddTasks;
	
	sleep 45.0;
	
	// Activate extraction
	execVM "Scripts\extract.sqf";
};
