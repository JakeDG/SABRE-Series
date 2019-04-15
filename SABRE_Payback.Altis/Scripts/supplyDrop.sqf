// Blazerunner drops off supplies after first stage objectives are completed
if (!isServer) exitWith {};

// Blazerunner messege
["<t size='0.6'><t color='#D22E2E'>Blazerunner:</t> Sabre, I'm imbound with some supplies for you. I'll be making the drop at Aristi.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
sleep 12.0;
parsetext format ["<t color='#FFFFFF' size='2'>Blazerunner is dropping off supplies for you!</t><br/><t color='#D22E2E' size='1.3'>The drop location has been marked on your map!</t>"] remoteExec ["hint", [0,-2] select (isMultiplayer && isDedicated)];

// Set Marker
_supplyMkr = createMarker ["supplyMkr", [7928.88,21325.8]];
"supplyMkr" setMarkerText "Supply Drop";
"supplyMkr" setMarkerColor "ColorBlufor";
"supplyMkr" setMarkerType "hd_dot";

// Create crew and heli
_supplyCrew = createGroup west;
_supplyVeh = [getMarkerPos "heliSpawnMkr", 16, "B_CTRG_Heli_Transport_01_sand_F", _supplyCrew] call bis_fnc_spawnvehicle;
_supplyHeli = (_supplyVeh select 0);
{
	[_x, false] remoteExec ["allowDamage", [0,-2] select (isMultiplayer && isDedicated), _x]; 
} forEach (crew _supplyHeli)+[_supplyHeli];
_supplyHeli setCaptive true;
_supplyCrew setBehaviour "CARELESS";

// Create supply crate
_supCrate = "B_supplyCrate_F" createVehicle (getMarkerPos "heliSpawnMkr");
[_supCrate, [ "<t color='#D22E2E'>Open Virtual Arsenal</t>",{ ["Open",true] spawn BIS_fnc_arsenal; },[],10,true,true,"","(_target distance _this) < 3.5"] ] remoteExec [ "addAction", [0,-2] select (isMultiplayer && isDedicated), true];
[_supCrate, false] remoteExec ["allowDamage", [0,-2] select (isMultiplayer && isDedicated), _supCrate];
sleep 0.1;

// Slingload supply crate to heli
_slinged = _supplyHeli setSlingLoad _supCrate;

// Waypoint to drop supplies
_wp1 = _supplyCrew addWaypoint [(getMarkerPos "supplyMkr"), 0];
[_supplyCrew, 2] setWaypointBehaviour "CARELESS";
[_supplyCrew, 2] setWaypointCombatMode "RED";
_wp1 setWaypointType "UNHOOK";
_wp1 setWaypointSpeed "FULL";

// Blazerunner drop off messege
[_supplyHeli] spawn 
{
	waitUntil {isNull (getSlingLoad (_this select 0))};
	["<t size='0.6'><t color='#D22E2E'>Blazerunner:</t> Ok Sabre, I've dropped off the supplies at the designated location. I'm RTB.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
};

// Leave waypoint
_wp2 = _supplyCrew addWaypoint [(getMarkerPos "heliSpawnMkr"), 0];
[_supplyCrew, 2] setWaypointBehaviour "CARELESS";
_wp2 setWaypointType "MOVE";
_wp2 setWaypointStatements ["true", "{deleteVehicle vehicle _x} forEach thislist;{deleteVehicle _x} forEach thislist; deleteGroup (group this);"];