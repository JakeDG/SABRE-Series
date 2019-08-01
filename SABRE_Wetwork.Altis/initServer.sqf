if (!isServer) exitWith {};

/******************** SERVER VARIABLES ***********************/

/******************** SERVER SCRIPTS ***********************/
execVM "briefing.sqf";
execVM "Scripts\serverTaskTrack.sqf";

/******************** REMOTE EXECS ***********************/
// Add action to ammoboxes
{

	[_x, [ "<t color='#D22E2E'>Open Virtual Arsenal</t>",{ ["Open",true] spawn BIS_fnc_arsenal; },[],10,true,true,"","(_target distance _this) < 3.5"] ] remoteExec [ "addAction", [0,-2] select (isMultiplayer && isDedicated), (alive _x)];
	
}forEach [arsenal_1,arsenal_2];

[richman_obj,"WhiteHead_08"] remoteExec ["setFace",[0,-2] select (isMultiplayer && isDedicated), (alive richman_obj)];

/******************** MISSION PARAMETERS ***********************/
// REVIVE PARAMETER IS SET IN SABRE TEAM INIT
// Set time
_paramTime = "Time" call BIS_fnc_getParamValue;
if (_paramTime == 0) then
{
	setDate [2035, 7, 13, 19, 35]; // Dusk
}
else
{	
	setDate [2035, 7, 13, 00, 13]; // Midnight
};

// Set difficulty
_paramDifficulty = "Difficulty" call BIS_fnc_getParamValue;
if (_paramDifficulty > 0) then // if user selects difficulty other than their own skill settings
{
	switch (_paramDifficulty) do // Sabre group skills were set within the editor
	{
		case 1: // Regular
		{ 
			{
				if ((side _x) == east) then // Unit is part of CSAT
				{
					_x setSkill ["reloadspeed", 0.5];
					_x setSkill ["aimingshake", 0.55];
					_x setSkill ["aimingspeed", 0.5];
					_x setSkill ["spottime", 0.5];
					_x setSkill ["spotdistance", 0.5];
					_x setSkill ["aimingaccuracy", 0.55];
					_x setSkill ["commanding", 0.45];
					_x setSkill ["general", 0.5];
				};
				
				if (faction _x == "IND_F") then // Unit is part of the AAF
				{
					_x setSkill ["reloadspeed", 0.45];
					_x setSkill ["spotdistance", 0.4];
					_x setSkill ["aimingshake", 0.4];
					_x setSkill ["aimingspeed", 0.4];
					_x setSkill ["spottime", 0.4];
					_x setSkill ["aimingaccuracy", 0.35];
					_x setSkill ["commanding", 0.4];
					_x setSkill ["general", 0.45];
				};
				
				if (faction _x == "IND_G_F") then // Unit is part of the FIA
				{
					_x setSkill ["reloadspeed", 0.35];
					_x setSkill ["spotdistance", 0.3];
					_x setSkill ["aimingshake", 0.3];
					_x setSkill ["aimingspeed", 0.3];
					_x setSkill ["spottime", 0.3];
					_x setSkill ["aimingaccuracy", 0.25];
					_x setSkill ["commanding", 0.3];
					_x setSkill ["general", 0.35];
				};
				
			} forEach allUnits;
		
		};
		case 2: // Hardened
		{ 
			{
				if ((side _x) == east) then // Unit is part of CSAT
				{
					_x setSkill ["reloadspeed", 0.7];
					_x setSkill ["spotdistance", 0.65];
					_x setSkill ["aimingshake", 0.65];
					_x setSkill ["aimingspeed", 0.6];
					_x setSkill ["spottime", 0.65];
					_x setSkill ["aimingaccuracy", 0.7];
					_x setSkill ["commanding", 0.55];
					_x setSkill ["general", 0.7];
				};
				
				if (faction _x == "IND_F") then // Unit is part of the AAF
				{
					_x setSkill ["reloadspeed", 0.55];
					_x setSkill ["spotdistance", 0.5];
					_x setSkill ["aimingshake", 0.5];
					_x setSkill ["aimingspeed", 0.5];
					_x setSkill ["spottime", 0.5];
					_x setSkill ["aimingaccuracy", 0.45];
					_x setSkill ["commanding", 0.5];
					_x setSkill ["general", 0.55];
				};
				
				if (faction _x == "IND_G_F") then // Unit is part of the FIA
				{
					_x setSkill ["reloadspeed", 0.45];
					_x setSkill ["spotdistance", 0.4];
					_x setSkill ["aimingshake", 0.4];
					_x setSkill ["aimingspeed", 0.4];
					_x setSkill ["spottime", 0.4];
					_x setSkill ["aimingaccuracy", 0.35];
					_x setSkill ["commanding", 0.4];
					_x setSkill ["general", 0.45];
				};
				
			} forEach allUnits;
		};
		case 3: // Commando
		{ 
			{
				if ((side _x) == east) then // Unit is part of CSAT
				{
					_x setSkill ["reloadspeed", 0.8];
					_x setSkill ["spotdistance", 0.75];
					_x setSkill ["aimingshake", 0.75];
					_x setSkill ["aimingspeed", 0.7];
					_x setSkill ["spottime", 0.75];
					_x setSkill ["aimingaccuracy", 0.8];
					_x setSkill ["commanding", 0.75];
					_x setSkill ["general", 0.85];
				};
				
				if (faction _x == "IND_F") then // Unit is part of the AAF
				{
					_x setSkill ["reloadspeed", 0.65];
					_x setSkill ["spotdistance", 0.6];
					_x setSkill ["aimingshake", 0.6];
					_x setSkill ["aimingspeed", 0.6];
					_x setSkill ["spottime", 0.6];
					_x setSkill ["aimingaccuracy", 0.55];
					_x setSkill ["commanding", 0.6];
					_x setSkill ["general", 0.65];
				};
				
				if (faction _x == "IND_G_F") then // Unit is part of the FIA
				{
					_x setSkill ["reloadspeed", 0.55];
					_x setSkill ["spotdistance", 0.5];
					_x setSkill ["aimingshake", 0.5];
					_x setSkill ["aimingspeed", 0.5];
					_x setSkill ["spottime", 0.5];
					_x setSkill ["aimingaccuracy", 0.45];
					_x setSkill ["commanding", 0.5];
					_x setSkill ["general", 0.55];
				};
				
			} forEach allUnits;
		};
	};
};

// Set stealth
_paramStealth = "Stealth" call BIS_fnc_getParamValue;
if (_paramStealth == 1) then
{
	isStealth = true;
	publicVariable "isStealth";
}
else
{
	isStealth = false;
	publicVariable "isStealth";
};

// Set enemy night vision
_paramEnemyNVG = "EnemyNVG" call BIS_fnc_getParamValue;
if (_paramEnemyNVG == 0) then
{
	{
		if ((side _x) == east) then // Unit is part of CSAT
		{
			_x unassignItem "NVGoggles_OPFOR";
			_x removeItem "NVGoggles_OPFOR";
		};
		
		if (faction _x == "IND_F") then // Unit is part of the AAF
		{
			_x unassignItem "NVGoggles_INDEP";
			_x removeItem "NVGoggles_INDEP";
		};
	} forEach allUnits;
};

// Set ambient music
_paramMusic = "Music" call BIS_fnc_getParamValue;
if (_paramMusic == 1) then 
{
	if (!isDedicated) then // All music is synced over the network through player host
	{
		ehID = addMusicEventHandler [
										"MusicStop", 
										{
											[] spawn
											{
												_tracks = ["Wetworks","BlackMarket","Tactical","Camo","Scout"];
												sleep 5.0;
												(selectRandom _tracks) remoteExec ["playMusic",0];
											};
										}
									];
		dedicatedMusic = false;
		publicVariable "dedicatedMusic";
	}
	else
	{
		dedicatedMusic = true;
		publicVariable "dedicatedMusic";
	};
}
else
{
	dedicatedMusic = false;
	publicVariable "dedicatedMusic";
};

/******************** OTHER SERVER STUFF ***********************/
if (isMultiplayer || isDedicated) then
{
	enableSaving [false,false]; // Disable saving for multiplayer
}
else
{
	enableSaving [true,true]; // Enable saving for singleplayer
};

[pwrTrans_1, "Shut Off Power", 8] call AD_fnc_pickPutHold; // Add shut off action to compound transformer.
[pwrTrans_2, "Shut Off Power", 8] call AD_fnc_pickPutHold; // Add shut off action to outpost transformer.

// Set Richman's bodyguard loadouts and remove enemy NVGs
{
	if (faction _x == "IND_G_F") then // Unit is part of the FIA
	{
		[_x] execVM "Scripts\guardLoadouts.sqf";
	};
} forEach allUnits;

// Easter egg stuff
_bloodSpot1 = createSimpleObject ["a3\characters_f\blood_splash.p3d", getPosWorld victim_1]; 
_bloodSpot1 setDir (random 360);

// Move Richman to 1 of his 3 possible positions
_richPos = selectRandom [
						[[20832.8,6567.23,4.04776], 200],	// Selakano House
						[[21919.2,5955.75,6.36648], 223], 	// Mazi Harbor
						[[21706.9,7536.99,4.26133], 251] 	// Feres Shop
					];
richman_obj setPosATL (_richPos select 0);
richman_obj setDir (_richPos select 1);

// Set sabre team's AI skill
{
	_x setSkill ["reloadspeed", 1.0];
	_x setSkill ["aimingshake", 0.95];
	_x setSkill ["aimingspeed", 0.95];
	_x setSkill ["spottime", 0.95];
	_x setSkill ["spotdistance", 0.95];
	_x setSkill ["aimingaccuracy", 0.95];
	_x setSkill ["commanding", 0.95];
	_x setSkill ["general", 0.95];
} forEach units sabre;

// Randomize fuel levels for all cars except the starting offroad at the insertion
[] spawn 
{
	_milVehs = ["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_APC_Wheeled_03_cannon_F"];
	{
		if (_x isKindOf "Car" && !(typeOf _x in _milVehs) && _x != startTruck) then 
		{
			_x setFuel (random [0.20, 0.50, 0.90]);
		};
	} forEach vehicles;
};

// Constant check if everyone is down
[] spawn 
{
	waitUntil{sleep 5.0; ({_x getVariable ["AIS_unconscious", false]} count units sabre == {alive _x} count units sabre)};
	["End_AllDown",false,true,false] remoteExec ["BIS_fnc_endMission"];
};

// Constant check if boat is dead
[] spawn 
{
	waitUntil{sleep 5.0; !alive escBoat};
	["End_BoatDead",false,true,false] remoteExec ["BIS_fnc_endMission"];
};

waitUntil{sleep 1.0; !isNil "BIS_fnc_init"}; // Wait until server is ready
waitUntil{sleep 1.0; {_x getVariable ["isClientLoaded",false]} count (allPlayers - entities "HeadlessClient_F") == count (allPlayers - entities "HeadlessClient_F")}; // Wait until clients are all loaded
serverLoaded = true;
publicVariable "serverLoaded"; 