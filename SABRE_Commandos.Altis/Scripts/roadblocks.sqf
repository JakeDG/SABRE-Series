// Setup roadblocks to stop Sabre's return to the staging area
if (!isServer) exitWith {};

_paramDifficulty = "Difficulty" call BIS_fnc_getParamValue;
_randNum = floor (random 5); 

if (_paramDifficulty < 3) then
{
	switch (_randNum) do
	{
		case 0: // Send in the technical
		{
			_vehCrew = createGroup resistance;
			_techVeh = [getMarkerPos "backupMkr_1", 115, "I_G_Offroad_01_armed_F", _vehCrew] call BIS_fnc_spawnVehicle;
	
			_wp1v = _vehCrew addWaypoint [(getMarkerPos "techVehWp_1"), 0];
			[_vehCrew, 2] setWaypointBehaviour "CARELESS";
			[_vehCrew, 2] setWaypointCombatMode "BLUE";
			_wp1v setWaypointType "GUARD";
			_wp1v setWaypointSpeed "FULL";
		};
		case 1: // Send in the troops
		{
			blockCar setPosATL [4671.07,20595.7,0];
			blockCar setDir 75;
			
			_blockGrpInf = [getMarkerPos "backupMkr_2", resistance, ["I_G_Soldier_TL_F","I_G_Soldier_GL_F","I_G_Soldier_F","I_G_Soldier_AR_F","I_G_Soldier_LAT_F"],[],[],[],[],[],340] call BIS_fnc_spawnGroup;
		};
		case 2: // Send everyone ("Luck" of the draw)
		{
			_vehCrew = createGroup resistance;
			_techVeh = [getMarkerPos "backupMkr_1", 115, "I_G_Offroad_01_armed_F", _vehCrew] call BIS_fnc_spawnVehicle;
			
			_wp1v = _vehCrew addWaypoint [(getMarkerPos "techVehWp_1"), 0];
			[_vehCrew, 2] setWaypointBehaviour "CARELESS";
			[_vehCrew, 2] setWaypointCombatMode "BLUE";
			_wp1v setWaypointType "GUARD";
			_wp1v setWaypointSpeed "FULL";
			
			blockCar setPosATL [4671.07,20595.7,0];
			blockCar setDir 75;
			
			_blockGrpInf = [getMarkerPos "backupMkr_2", resistance, ["I_G_Soldier_TL_F","I_G_Soldier_GL_F","I_G_Soldier_F","I_G_Soldier_AR_F","I_G_Soldier_LAT_F"],[],[],[],[],[],340] call BIS_fnc_spawnGroup;
		};
		case 3: // No roadblocks
		{};
	};
}
else // Send everyone (Commando difficulty)
{
	_vehCrew = createGroup resistance;
	_techVeh = [getMarkerPos "backupMkr_1", 115, "I_G_Offroad_01_armed_F", _vehCrew] call BIS_fnc_spawnVehicle;
			
	_wp1v = _vehCrew addWaypoint [(getMarkerPos "techVehWp_1"), 0];
	[_vehCrew, 2] setWaypointBehaviour "CARELESS";
	[_vehCrew, 2] setWaypointCombatMode "BLUE";
	_wp1v setWaypointType "GUARD";
	_wp1v setWaypointSpeed "FULL";
			
	blockCar setPosATL [4671.07,20595.7,0];
	blockCar setDir 75;
			
	_blockGrpInf = [getMarkerPos "backupMkr_2", resistance, ["I_G_Soldier_TL_F","I_G_Soldier_GL_F","I_G_Soldier_F","I_G_Soldier_AR_F","I_G_Soldier_LAT_F"],[],[],[],[],[],340] call BIS_fnc_spawnGroup;
};
