if (!isServer) exitWith {};

/******************** SERVER VARIABLES ***********************/
canExtract = false;

/******************** SERVER SCRIPTS ***********************/
execVM "briefing.sqf";
execVM "Scripts\serverTaskTrack.sqf";

/******************** REMOTE EXECS ***********************/
[fox, "Fox"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), true];

// Add action to ammoboxes
{

	[_x, [ "<t color='#D22E2E'>Open Virtual Arsenal</t>",{ ["Open",true] spawn BIS_fnc_arsenal; },[],10,true,true,"","(_target distance _this) < 3.5"] ] remoteExec [ "addAction", [0,-2] select (isMultiplayer && isDedicated), (alive _x)];
	
}forEach [arsenal_1,arsenal_2,arsenal_3];

// Play theme from the radio on table in the meeting hut
[] spawn
{
	waitUntil {sleep 1.0; ({!(_x in insertVeh)} count units sabre == {alive _x} count units sabre)};
	
	_i = 0;
	while {alive hutRadio && (_i < 3)} do
	{
		_i = _i + 1;
		[hutRadio, "TopSecret"] remoteExec [ "say3D", [0,-2] select (isMultiplayer && isDedicated)];
		sleep 330.0; // Length = 5:30
	};
};
 
/******************** MISSION PARAMETERS ***********************/
// REVIVE PARAMETER IS SET IN SABRE TEAM INIT
// Set time
_paramTime = "Time" call BIS_fnc_getParamValue;
switch (_paramTime) do 
{
	case 0: // Morning
	{
		setDate [2035, 8, 29, 6, 20];
	};
	case 1: // Afternoon
	{
		setDate [2035, 8, 29, 14, 10];
	};
	case 2: // Evening
	{
		setDate [2035, 8, 29, 16, 20];
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

_vehPos = [[[10579.2,11577.6,0], 90], [[9901.68,12143.8,0], 145], [[10027.7,12153.5,0], 206]];

switch (_paramDifficulty) do
{
	case 0: // Player custom difficulty
	{
		_vehCustom = ["","O_T_MRAP_02_hmg_ghex_F","O_T_LSV_02_armed_ghex_F","O_T_LSV_02_armed_ghex_F",""];
		for "_i" from 0 to 1 do
		{
			_randVeh = selectRandom _vehCustom;
			if (_randVeh != "") then 
			{
				_veh = [((_vehPos select _i) select 0), ((_vehPos select _i) select 1), _randVeh, east] call bis_fnc_spawnvehicle;
				_vehObj = (_veh select 0);
				_vehObj setFuel 0;
				_vehObj deleteVehicleCrew driver _vehObj;
				_vehObj deleteVehicleCrew commander _vehObj;
				sleep 0.1;
			};
		};
	};
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
				_x setSkill ["aimingspeed", 0.35];
				_x setSkill ["spottime", 0.3];
				_x setSkill ["aimingaccuracy", 0.35];
				_x setSkill ["commanding", 0.3];
				_x setSkill ["general", 0.35];
			};
			
		} forEach allUnits;
		
		_vehReg = ["","O_T_MRAP_02_hmg_ghex_F","O_T_LSV_02_armed_ghex_F","O_T_LSV_02_armed_ghex_F",""];
		for "_i" from 0 to 1 do
		{
			_randVeh = selectRandom _vehReg;
			if (_randVeh != "") then 
			{
				_veh = [((_vehPos select _i) select 0), ((_vehPos select _i) select 1), _randVeh, east] call bis_fnc_spawnvehicle;
				_vehObj = (_veh select 0);
				_vehObj setFuel 0;
				_vehObj deleteVehicleCrew driver _vehObj;
				_vehObj deleteVehicleCrew commander _vehObj;
				sleep 0.1;
			};
		};
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
				_x setSkill ["commanding", 0.45];
				_x setSkill ["general", 0.5];
			};
			
		} forEach allUnits;
		
		_vehHard = ["O_T_MRAP_02_hmg_ghex_F","O_T_MRAP_02_hmg_ghex_F","O_T_LSV_02_armed_ghex_F","","O_T_APC_Wheeled_02_rcws_ghex_F"];
		for "_i" from 0 to 1 do
		{
			_randVeh = selectRandom _vehHard;
			if (_randVeh != "") then 
			{
				_veh = [((_vehPos select _i) select 0), ((_vehPos select _i) select 1), _randVeh, east] call bis_fnc_spawnvehicle;
				_vehObj = (_veh select 0);
				_vehObj setFuel 0;
				_vehObj deleteVehicleCrew driver _vehObj;
				_vehObj deleteVehicleCrew commander _vehObj;
				sleep 0.1;
			};
		};
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
				_x setSkill ["general", 0.55];
			};
			
		} forEach allUnits;
		
		// Extra vehicle in volcano
		_vehCom = ["O_T_APC_Wheeled_02_rcws_ghex_F", "O_T_APC_Tracked_02_cannon_ghex_F"];
		for "_i" from 0 to 2 do
		{
			_randVeh = selectRandom _vehCom;	
			_veh = [((_vehPos select _i) select 0), ((_vehPos select _i) select 1), _randVeh, east] call bis_fnc_spawnvehicle;
			_vehObj = (_veh select 0);
			_vehObj setFuel 0;
			_vehObj deleteVehicleCrew driver _vehObj;
			_vehObj deleteVehicleCrew commander _vehObj;
			sleep 0.1;
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

// Add action to terminals
{
	[_x, "Access CSAT Terminal", "Downloading Intel...", "Download Complete!", "Download Cancelled!", false] call AD_fnc_terminalActionHold;
}forEach [term1,term2];

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