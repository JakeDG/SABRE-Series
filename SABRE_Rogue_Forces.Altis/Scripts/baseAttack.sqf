// Creates the reinforcements that attack the outpost

if (!isServer) exitWith {};

/* Create vehicles with crews */
// Create lead attack vehicles
_attVeh1 = [[16822.8,12344.9,0], 165, "I_MRAP_03_hmg_F", independent] call bis_fnc_spawnvehicle;
sleep 0.5;
_attVeh2 = [[16801.9,12423.7,0], 167, "I_APC_Wheeled_03_cannon_F", independent] call bis_fnc_spawnvehicle;
sleep 0.5;

// Create transport trucks
_transVeh1 = [[16935.2,12557.8,0], 210, "I_Truck_02_covered_F", independent] call bis_fnc_spawnvehicle;
sleep 0.5;
_transVeh2 = [[16967.8,12595.6,0], 220, "I_Truck_02_covered_F", independent] call bis_fnc_spawnvehicle;
sleep 0.5;

/* Spawn infantry in the transport trucks */
// 1st group of soldiers
_attGrp1 = [getMarkerPos "attInfSpawnMkr", independent, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad"),[],[],[],[],[],0] call BIS_fnc_spawnGroup;
sleep 0.5;

// Second group of soldiers
_attGrp2 = [getMarkerPos "attInfSpawnMkr", independent, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad"),[],[],[],[],[],10] call BIS_fnc_spawnGroup;

// Third group of soldiers
_attGrp3 = [getMarkerPos "attInfSpawnMkr", independent, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad"),[],[],[],[],[],15] call BIS_fnc_spawnGroup;

// Forth group of soldiers
_attGrp4 = [getMarkerPos "attInfSpawnMkr", independent, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad"),[],[],[],[],[],20] call BIS_fnc_spawnGroup;

/* Move troops into the trucks */
_attackGrps = (units _attGrp1) + (units _attGrp2) + (units _attGrp3); // Add both groups together so only 1 loop needs to be performed

// Move both groups in the transports
{ 
	if (_forEachIndex < 16) then // Add first group to first truck
	{
		_x assignAsCargo (_transVeh1 select 0); _x moveIncargo (_transVeh1 select 0);
	}
	else // Add second group to second truck
	{
		_x assignAsCargo (_transVeh2 select 0); _x moveIncargo (_transVeh2 select 0);
	};
	
} forEach _attackGrps;

/* Create waypoints for all units */
// First attack vehicle
_attVeh1Wp1 = (_attVeh1 select 2) addWaypoint [getMarkerPos "rForceWp_1", 0];
[(_attVeh1 select 2), 2] setWaypointBehaviour "AWARE";
_attVeh1Wp1 setWaypointType "MOVE";
_attVeh1Wp1 setWaypointSpeed "FULL";

_attVeh1Wp2 = (_attVeh1 select 2) addWaypoint [getMarkerPos "rForceWp_3", 1];
_attVeh1Wp2 setWaypointType "SAD";

// Second attack vehicle
_attVeh2Wp1 = (_attVeh2 select 2) addWaypoint [getMarkerPos "rForceWp_1", 0];
[(_attVeh2 select 2), 2] setWaypointBehaviour "AWARE";
_attVeh2Wp1 setWaypointType "MOVE";
_attVeh2Wp1 setWaypointSpeed "FULL";

_attVeh2Wp2 = (_attVeh2 select 2) addWaypoint [getMarkerPos "rForceWp_3", 1];
_attVeh2Wp2 setWaypointType "SAD";

// First transport vehicle
_transVeh1Wp1 = (_transVeh1 select 2) addWaypoint [getMarkerPos "rForceWp_1", 0];
[(_transVeh1 select 2), 2] setWaypointBehaviour "AWARE";
_transVeh1Wp1 setWaypointType "MOVE";
_transVeh1Wp1 setWaypointSpeed "FULL";

_transVeh1Wp2 = (_transVeh1 select 2) addWaypoint [getMarkerPos "rForceWp_2a", 1];
_transVeh1Wp2 setWaypointType "TR UNLOAD";

// Second transport vehicle
_transVeh2Wp1 = (_transVeh2 select 2) addWaypoint [getMarkerPos "rForceWp_1", 0];
[(_transVeh2 select 2), 2] setWaypointBehaviour "AWARE";
_transVeh2Wp1 setWaypointType "MOVE";
_transVeh2Wp1 setWaypointSpeed "FULL";

_transVeh2Wp2 = (_transVeh2 select 2) addWaypoint [getMarkerPos "rForceWp_2b", 1];
_transVeh2Wp2 setWaypointType "TR UNLOAD";

/* Create waypoints for infantry */
// First infantry group
_attGrp1Wp1 = _attGrp1 addWaypoint [getMarkerPos "baseMkr", 0];
[_attGrp1, 2] setWaypointBehaviour "AWARE";
_attGrp1Wp1 setWaypointType "SAD";
_attGrp1Wp1 setWaypointSpeed "NORMAL";

// Second infantry group
_attGrp2Wp1 = _attGrp2 addWaypoint [getMarkerPos "baseMkr", 0];
[_attGrp2, 2] setWaypointBehaviour "AWARE";
_attGrp2Wp1 setWaypointType "SAD";
_attGrp2Wp1 setWaypointSpeed "NORMAL";

// Third infantry group
_attGrp3Wp1 = _attGrp3 addWaypoint [getMarkerPos "baseMkr", 0];
[_attGrp3, 2] setWaypointBehaviour "AWARE";
_attGrp3Wp1 setWaypointType "SAD";
_attGrp3Wp1 setWaypointSpeed "NORMAL";

// Forth infantry group
_attGrp4Wp1 = _attGrp4 addWaypoint [getMarkerPos "baseMkr", 0];
[_attGrp4, 2] setWaypointBehaviour "AWARE";
_attGrp4Wp1 setWaypointType "SAD";
_attGrp4Wp1 setWaypointSpeed "NORMAL";
