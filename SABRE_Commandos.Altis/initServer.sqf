if (!isServer) exitWith {};

/**** SERVER VARIABLES ****/

/**** SERVER SCRIPTS ****/
execVM "briefing.sqf";
execVM "Scripts\serverTaskTrack.sqf";
execVM "Scripts\sniperPos.sqf";

/**** REMOTE EXECS ****/
// Add action to ammoboxes
[baseArsenal, [ "<t color='#D22E2E'>Open Virtual Arsenal</t>",{ ["Open",true] spawn BIS_fnc_arsenal; },[],10,true,true,"","(_target distance _this) < 3.5"] ] remoteExec [ "addAction", [0,-2] select (isMultiplayer && isDedicated), true];

[sniper, "Crow"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), true];

/**** OTHER SERVER STUFF ****/
// Move caches into random positions
_cachePos_1 = selectRandom [[4503.37,21442.9,4.03299],[4542,21517.9,0.282135],[4559.33,21490.8,0.508392],[4578.66,21411.5,0.392639]];
cache_1 setPosATL _cachePos_1;

_cachePos_2 = selectRandom [[4505.96,21442.9,3.6918],[4627.89,21355.1,0.313629],[4537.62,21340.6,4.30786],[4569.29,21435,0.4617],[4593.03,21327.7,4.48608]];
cache_2 setPosATL _cachePos_2;

_cachePos_3 = selectRandom [[4636.08,21376.4,5.77866],[4630.79,21427.3,5.23181],[4490.76,21367.3,0.38205],[4690.92,21384,0.891693]];
cache_3 setPosATL _cachePos_3;

// Mission Parameters
_paramTime = "Time" call BIS_fnc_getParamValue;
switch (_paramTime) do 
{
	case 0: // Morning
	{
		setDate [2035, 6, 24, 6, 20];
	};
	case 1: // Afternoon
	{
		setDate [2035, 6, 24, 12, 30];
	};
	case 2: // Evening
	{
		setDate [2035, 6, 24, 18, 15];
	};
	case 3: // Night
	{
		setDate [2035, 6, 24, 19, 30];
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

// Give AI's flashlights if it's night
if ([] call AD_fnc_isNight) then 
{
	[] spawn 
	{
		// Add flashlights to militia guns
		{
			if ((side _x) == resistance) then
			{
				_x addPrimaryWeaponItem "acc_flashlight";
				sleep 0.2;
				_x enablegunlights "forceOn";
			};
		} forEach allUnits;
	};
};

// Difficulty
_paramDifficulty = "Difficulty" call BIS_fnc_getParamValue;
if (_paramDifficulty > 0) then // if user selects difficulty other than their own skill settings
{
	switch (_paramDifficulty) do // Sabre group skills were set within the editor
	{
		case 1: // Regular
		{ 
			{
				if ((side _x) == east) then
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
				
				if ((side _x) == resistance) then
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
				if ((side _x) == east) then
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
				
				if ((side _x) == resistance) then
				{
					_x setSkill ["reloadspeed", 0.4];
					_x setSkill ["spotdistance", 0.45];
					_x setSkill ["aimingshake", 0.45];
					_x setSkill ["aimingspeed", 0.4];
					_x setSkill ["spottime", 0.45];
					_x setSkill ["aimingaccuracy", 0.4];
					_x setSkill ["commanding", 0.35];
					_x setSkill ["general", 0.5];
				};
				
			} forEach allUnits;
		};
		case 3: // Commando
		{ 
			{
				if ((side _x) == east) then
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
				
				if ((side _x) == resistance) then
				{
					_x setSkill ["reloadspeed", 0.45];
					_x setSkill ["spotdistance", 0.55];
					_x setSkill ["aimingshake", 0.5];
					_x setSkill ["aimingspeed", 0.45];
					_x setSkill ["spottime", 0.45];
					_x setSkill ["aimingaccuracy", 0.45];
					_x setSkill ["commanding", 0.5];
					_x setSkill ["general", 0.6];
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
		if (side _x == east) then // Unit is part of the CSAT
		{
			_x unassignItem "NVGoggles_OPFOR";
			_x removeItem "NVGoggles_OPFOR";
		};
	} forEach allUnits;
};

// Set ambient music
_paramMusic = "Music" call BIS_fnc_getParamValue;
if (_paramMusic == 1) then 
{
	trackList = [
			"Fallout",
			"AmbientTrack01_F",
			"AmbientTrack01a_F",
			"AmbientTrack01b_F",
			"LeadTrack02_F",
			"AmbientTrack03_F",
			"SkyNet",
			"Wasteland",
			"LeadTrack01_F_Tacops",
			"LeadTrack02_F_Tacops",
			"LeadTrack03_F_Tacops",
			"LeadTrack04_F_Tacops",
			"AmbientTrack01a_F_Tacops",
			"AmbientTrack01b_F_Tacops",
			"AmbientTrack02a_F_Tacops",
			"AmbientTrack02b_F_Tacops",
			"AmbientTrack03a_F_Tacops",
			"AmbientTrack03b_F_Tacops",
			"AmbientTrack04a_F_Tacops",
			"AmbientTrack04b_F_Tacops",
			"EventTrack01a_F_Tacops",
			"EventTrack01b_F_Tacops",
			"EventTrack02a_F_Tacops",
			"EventTrack02b_F_Tacops",
			"EventTrack03a_F_Tacops",
			"EventTrack03b_F_Tacops",
			"AmbientTrack01_F_Orange",
			"LeadTrack03_F_Tank",
			"AmbientTrack01_F_TanK",
			//"LeadTrack02_F_Bootcamp",
			"LeadTrack03_F_EPB",
			"AmbientTrack01_F_Orange",
			"LeadTrack01_F_Orange",
			"BackgroundTrack01a_F",
			"BackgroundTrack01a_F",
			"BackgroundTrack01_F",
			"AmbientTrack03_F",
			"LeadTrack03_F_Mark"
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