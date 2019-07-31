if (!isServer) exitWith {};

/******************** SERVER VARIABLES ***********************/
// Computer at power plant
compHacked = false;
publicVariable "compHacked";

/******************** SERVER SCRIPTS ***********************/
execVM "briefing.sqf";
execVM "Scripts\serverTaskTrack.sqf";
[leader sabre, 45] execVM "Scripts\flyBys.sqf";

/******************** REMOTE EXECS ***********************/
// Add action to ammoboxes
{

	[_x, [ "<t color='#D22E2E'>Open Virtual Arsenal</t>",{ ["Open",true] spawn BIS_fnc_arsenal; },[],10,true,true,"","(_target distance _this) < 5"] ] remoteExec [ "addAction", [0,-2] select (isMultiplayer && isDedicated), (alive _x)];
	
}forEach [arsenal_1,arsenal_2,arsenal_pwr,arsenal_fire];

// Add action to mobile arsenal drone, ensure player operating it cannot use the arsenal while using it
[arsenal_drone, [ "<t color='#D22E2E'>Open Virtual Arsenal</t>",{ ["Open",true] spawn BIS_fnc_arsenal; },[],10,true,true,"","(_target distance _this) < 5 && ((UAVControl _target) select 1) != 'DRIVER' && ((UAVControl _target) select 1) != 'GUNNER'"] ] remoteExec [ "addAction", [0,-2] select (isMultiplayer && isDedicated), (alive arsenal_drone)];

// Add action to meltdown laptop
[meltLaptop, [ "<t color='#D22E2E'>Begin Meltdown</t>","Scripts\powerHack.sqf",[],10,true,true,"","(_target distance _this) < 2.5"] ] remoteExec [ "addAction", [0,-2] select (isMultiplayer && isDedicated), true ];

/******************** MISSION PARAMETERS ***********************/
// REVIVE PARAMETER IS SET IN SABRE TEAM INIT
// Set time
_paramTime = "Time" call BIS_fnc_getParamValue;
switch (_paramTime) do 
{
	case 0: // Dusk
	{
		setDate [2035, 8, 9, 17, 26];
	};
	case 1: // Midnight
	{
		setDate [2035, 8, 9, 23, 56];
	};
	case 2: // Dawn
	{
		setDate [2035, 8, 10, 4, 12];
	};
};

// Set weather
_paramWeather = "Weather" call BIS_fnc_getParamValue;
switch (_paramWeather) do 
{
	case 0: // Clear
	{
		[0] call BIS_fnc_setOvercast;
	};
	case 1: // Cloudy
	{
		[0.25] call BIS_fnc_setOvercast;
	};
	case 2: // Overcast
	{
		[0.5] call BIS_fnc_setOvercast;
	};
	case 3: // Rainy
	{
		[0.75] call BIS_fnc_setOvercast;
	};
	case 4: // Stormy
	{
		[1] call BIS_fnc_setOvercast;
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
		if (faction _x == "IND_F") then // Unit is part of the AAF
		{
			_x unassignItem "NVGoggles_INDEP";
			_x removeItem "NVGoggles_INDEP";
		};
	} forEach allUnits;
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
				
			} forEach allUnits;
		
		};
		case 2: // Hardened
		{ 
			{
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
				
			} forEach allUnits;
		};
		case 3: // Commando
		{ 
			{
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
				
			} forEach allUnits;
		};
	};
};

// Set ambient music
_paramMusic = "Music" call BIS_fnc_getParamValue;
if (_paramMusic == 1) then 
{
	trackList = [
			"Fallout",
			"AmbientTrack01a_F",
			"LeadTrack02_F",
			"AmbientTrack03_F",
			"SkyNet",
			"Wasteland",
			"AmbientTrack01_F_Orange",
			"AmbientTrack01a_F_Tacops",
			"AmbientTrack01b_F_Tacops",
			"AmbientTrack02a_F_Tacops",
			"AmbientTrack02b_F_Tacops",
			"AmbientTrack03a_F_Tacops",
			"AmbientTrack03b_F_Tacops",
			"AmbientTrack04a_F_Tacops",
			"AmbientTrack04b_F_Tacops"
		];

	publicVariable "trackList";

	if (!isDedicated) then // All music is synced over the network through player host
	{
		ehID = addMusicEventHandler [
										"MusicStop", 
										{
											[] spawn
											{
												sleep 5.0;
												(selectRandom trackList) remoteExec ["playMusic",0];
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

// Randomize fuel levels for all cars except the starting truck at the insertion
[] spawn 
{
	{
		if (_x isKindOf "LandVehicle" && _x != startTruck) then 
		{
			_x setFuel (random [0.20, 0.50, 0.90]);
		};
	} forEach vehicles;
};

// Move officer
_officerPos = selectRandom [[17060.7,11306.1,1.12971],[16861.3,10245.2,0.841483],[15765.8,10649.9,0.670425]];
r_officer setPosATL _officerPos;

vehControl action ["LandGearUp", heliDown]; // Put crashed heli gear up

// Constant check if everyone is down
[] spawn 
{
	waitUntil{sleep 5.0; ({_x getVariable ["AIS_unconscious", false]} count units sabre == {alive _x} count units sabre)};
	["End_AllDown",false,true,false] remoteExec ["BIS_fnc_endMission"];
};

waitUntil{sleep 1.0; !isNil "BIS_fnc_init"}; // Wait until server is ready
waitUntil{sleep 1.0; {_x getVariable ["isClientLoaded",false]} count (allPlayers - entities "HeadlessClient_F") == count (allPlayers - entities "HeadlessClient_F")}; // Wait until clients are all loaded
serverLoaded = true;
publicVariable "serverLoaded"; 