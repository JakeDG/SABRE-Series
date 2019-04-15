/* Creates meltdown effect
  Since the explosions won't cause damage to anything if spawned on the transformers they  are spawned on invisible helipads.
*/
if (!isServer) exitWith {};

if (compHacked) then
{
	_detTime = 90;

	_explLoc = [expl_1,expl_7,expl_4,expl_6,expl_3,expl_8,expl_2,expl_5];
	
	// Activate alarm
	[] spawn
	{
		_time = 95;
		while {_time > 0} do
		{
			playSound3D ["A3\Sounds_F\sfx\alarm_blufor.wss", solarAlarm];
			_time = _time - 5;
			sleep 5.0;
		};
	};
	
	// Countdown
	/*
	while {_detTime > 0} do
	{
		//parseText format ["<t color='#D22E2E' font='PuristaBold' size='1.5'>Meltdown in %1</t>", _detTime] remoteExec ["hint", [0,-2] select (isMultiplayer && isDedicated)];
		_countText = parseText format ["<t color='#D22E2E' font='PuristaBold' size='1.5'>Meltdown in %1</t>", _detTime];
		hint _countText;
		_detTime = _detTime - 1;
		sleep 1.0;
	};

	// Get rid of hint
	"" remoteExec ["hint", [0,-2] select (isMultiplayer && isDedicated), true];
	*/
	
	sleep random [85, 90, 95];

	{	
		_pos = getPos _x;
		//_pos  = [(_pos select 0)+3,(_pos select 1)+3,(_pos select 2)+1];

		_explType = selectRandom ["Bo_GBU12_LGB_MI10","Sh_120_HE","HelicopterExploBig","Bo_GBU12_LGB","Bo_Mk82","HelicopterExploBig","Bo_Mk82","Bo_Mk82","Bo_GBU12_LGB_MI10","Sh_120_HE","HelicopterExploBig","Bo_GBU12_LGB"];
		
		_delay = random 2;
		_expl = _explType createVehicle _pos;
		sleep _delay;
		
		// Chance to create a fire
		_fire = floor(random 3);
		if (_fire == 1) then
		{
			"test_EmptyObjectForFireBig" createVehicle _pos;
		};
	} forEach _explLoc;
	sleep 3.0;

	["pwrTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
	sleep 3.0;

	// Kill the power
	_lampTypes = ["Lamps_Base_F", "PowerLines_base_F", "Land_PowerPoleWooden_F", "Land_LampHarbour_F", "Land_LampShabby_F", "Land_PowerPoleWooden_L_F", "Land_PowerPoleWooden_small_F", "Land_LampDecor_F", "Land_LampHalogen_F", "Land_LampStreet_small_F", "Land_LampStreet_F", "Land_LampAirport_F", "Land_PowerPoleWooden_L_F"];

	for [{_i=0},{_i < (count _lampTypes)},{_i=_i+1}] do
	{
		_lamps = getMarkerPos "powerOut" nearObjects [_lampTypes select _i, 2500];
		sleep 0.1;
		{_x setDamage 1} forEach _lamps;
	};
};
