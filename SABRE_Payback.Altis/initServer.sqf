if (!isServer) exitWith {};

/**** SERVER VARIABLES ****/

/**** Server scripts ****/
execVM "briefing.sqf";
execVM "Scripts\serverTaskTrack.sqf";
execVM "Scripts\spotterPos.sqf";
[insHeli] execVM "Scripts\heliLight.sqf";  // Create red light inside of heli

/**** REMOTE EXECS ****/
// Add action to ammoboxes
{

	[_x, [ "<t color='#D22E2E'>Open Virtual Arsenal</t>",{ ["Open",true] spawn BIS_fnc_arsenal; },[],10,true,true,"","(_target distance _this) < 3.5"] ] remoteExec [ "addAction", [0,-2] select (isMultiplayer && isDedicated), (alive _x)];
	
}forEach [arsenal_1,arsenal_2,arsenal_3];

// Set faces of informant and warlord globally
[informant,"GreekHead_A3_06"] remoteExec ["setFace",[0,-2] select (isMultiplayer && isDedicated), (alive informant)];
[warlord,"GreekHead_A3_01"] remoteExec ["setFace",[0,-2] select (isMultiplayer && isDedicated), (alive warlord)];

/******************** MISSION PARAMETERS ***********************/
// REVIVE PARAMETER IS SET IN SABRE TEAM INIT
// Mission Parameters
// Set time
_paramTime = "Time" call BIS_fnc_getParamValue;
switch (_paramTime) do 
{
	case 0: // Morning
	{
		setDate [2035, 6, 26, 3, 37];
	};
	case 1: // Afternoon
	{
		setDate [2035, 6, 26, 12, 35];
	};
	case 2: // Evening
	{
		setDate [2035, 6, 24, 17, 43];
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

// Difficulty
_paramDifficulty = "Difficulty" call BIS_fnc_getParamValue;
if (_paramDifficulty > 0) then
{
	switch (_paramDifficulty) do // Sabre group skills were set within the editor
	{
		case 1: // Regular
		{ 
			{
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

/******************** OTHER SERVER STUFF ***********************/
if (isMultiplayer || isDedicated) then
{
	enableSaving [false,false]; // Disable saving for multiplayer
}
else
{
	enableSaving [true,true]; // Enable saving for singleplayer
};


// Set position of intel documents (Randomized)
_intelPos = selectRandom [
						[[9760.92,22317.8,1.28567], 258],	// Green house closest to the water
						[[9745.04,22295.5,1.65379], 164], 	// 2nd green house on long table
						[[9747.19,22298.7,1.88548], 74], 	// 2nd green house on small table with rifle
						[[9728.36,22274.9,4.709], 180],		// White house, 2nd story, room on right, back wall 
						[[9728.64,22277.4,4.71636], 29],	// White house, 2nd story, room on right, center table
						[[9717.43,22277.7,5.15025], 183],	// White house, 2nd story, area on left, back wall
						[[9690.9,22290.3,1.24043], 272],	// Stone house, On table next to laptop
						[[9688.17,22300.9,1.14025], 352]	// Stone house, On large table with food
					];
intelDocs setPosATL (_intelPos select 0);
intelDocs setDir (_intelPos select 1);

// Set position for planes. Number of planes can vary, but plane_1 and plane_2 will always exist
_planePosDir = [
				[[9078.96,21564.7,0], 145], // Hanger 1
				[[9098.89,21581.4,0], 145], // Hanger 2
				[[9121.09,21596.4,0], 145], // Hanger 3
				[[9156.68,21604.1,0], 64], // Infront of control tower
				[[9192.18,21640.1,0], 160], // Near fuel dump
				[[9244.8,21591.9,0], 133]  // Near emergency truck
			];

// Initalize planesArray to the number of planes (out of the 3) that exist.
_planesArray = [plane_3,plane_4,plane_5];
{
		_planeRandPos = (selectRandom _planePosDir); // Get random position
		_x setPosATL (_planeRandPos select 0);
		_x setDir (_planeRandPos select 1);
		_planePosDir = _planePosDir - [_planeRandPos]; // Remove position from array
		if (((_planeRandPos select 0) select 0) == 9244.8) then
		{
			vehCtrl action ["lightOn", _x];
		};
		sleep 0.25;
}forEach _planesArray;

// Delete any of the three planes
_delNum = floor(random 4);
switch (_delNum) do
{
	case 0: // Don't delete the planes
	{};
	case 1: // Delete 1 plane
	{
		deleteVehicle plane_3;
	};
	case 2: // Delete 2 planes
	{
		deleteVehicle plane_3;
		deleteVehicle plane_4;
	};
	case 3: // Delete all 3 planes
	{
		deleteVehicle plane_3;
		deleteVehicle plane_4;
		deleteVehicle plane_5;
	};
};

// Set position of the three officers (Randomized)
_offPosDir = [
				[[8576.15,20964.5,0.446388], 180], // House #1
				[[8565.96,20911.7,1.01202], 336], // House #2, Room #1
				[[8571.78,20908.7,1.10556], 193], // House #2, Room #2
				[[8547.72,20893.6,0.23954], 40], // House #3
				[[8551.28,20885.8,3.13502], 31], // House #4, 2nd Story
				[[8505.04,20896.1,1.02354], 276], // House #5, 1st Story, right side
				[[8500.5,20894.3,4.28252], 43], // House #5, 2nd Story, right side
				[[8496.26,20903.8,4.06584], 79], // House #5, 2nd Story, left side
				[[8550.74,20850.3,0.390266], 326], // House #6, Room #1
				[[8540.33,20847.4,1.09912], 202], // House #6, Room #2
				[[8547.33,20814.9,0.221725], 54] // House 7
			];
_offArray = [officer_1, officer_2, officer_3];			
{

	_offRandPos = (selectRandom _offPosDir); // Get random position
	_x setPosATL (_offRandPos select 0);
	_x setDir (_offRandPos select 1);
	_offPosDir = _offPosDir - [_offRandPos]; // Remove position from array
	sleep 0.25;
	
}forEach _offArray;

// Set position of the warlord
_lordPos = selectRandom [
						[[4888.19,21918.3,0], 0],	// Center shanty
						[[4811.43,21956.2,0.435974], 83], 	// HQ building
						[[4868.96,21985.5,15.3692], 74], 	// Tower, 2nd floor
						[[4869.26,21993,17.6924], 315],		// Tower, roof
						[[4861.28,21980.4,0.585968], 324]	// Green building at base of tower
					];
warlord setPosATL (_lordPos select 0);
warlord setDir (_lordPos select 1);

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
	{
		if (_x isKindOf "Car" && _x != infoTruck) then 
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

waitUntil{sleep 1.0; !isNil "BIS_fnc_init"}; // Wait until server is ready
waitUntil{sleep 1.0; {_x getVariable ["isClientLoaded",false]} count (allPlayers - entities "HeadlessClient_F") == count (allPlayers - entities "HeadlessClient_F")}; // Wait until clients are all loaded
serverLoaded = true;
publicVariable "serverLoaded"; 