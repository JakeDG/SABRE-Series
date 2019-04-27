// Blazerunner extracts Sabre
if (!isServer) exitWith {};

[] spawn
{
	// Baseplate message
	[
		["Baseplate","Great job, Sabre! Altis is a much safer place without those scumbags.",10,"RadioAmbient8"], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 12.0;
	
	[
		["Baseplate","We need you guys back at base immediately. We're sending Blazerunner to extract you.",10,"RadioAmbient2"], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 12.0;

	// Blazerunner messege
	[
		["Blazerunner","I'm inbound, Sabre. ETA 90 seconds. LZ's on your map.",10,"RadioAmbient6"], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
};

// Set Marker and LZ
_extMkr = createMarker ["extMkr", [4961.59,21840.1]];
"extMkr" setMarkerText "Extraction";
"extMkr" setMarkerColor "ColorBlufor";
"extMkr" setMarkerType "hd_pickup";

// Move invisible helipad to LZ marker
extLZ setPos (getMarkerPos "extMkr");

// Create crew and heli
_extCrew = createGroup west;
sleep 1.0;
_extVeh = [getMarkerPos "heliSpawnMkr", 16, "B_CTRG_Heli_Transport_01_sand_F", _extCrew] call bis_fnc_spawnvehicle;
_extHeli = (_extVeh select 0);

[_extHeli] spawn
{
	waitUntil{sleep 1.0; !alive (_this select 0)};

	[
		["Baseplate","Shit, Sabre! Blazerunner is down! Mission failed!",10,"RadioAmbient6"], AD_fnc_subtitle
	] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 5.0;
	["End_blazeDead",false,true,true] call BIS_fnc_endMission;
};
/*
{
	[_x, false] remoteExec ["allowDamage", [0,-2] select (isMultiplayer && isDedicated), _x]; 
} forEach (crew _extHeli)+[_extHeli];
*/
_extHeli setCaptive true;
_extCrew setBehaviour "CARELESS";
sleep 1.0;

[sabre, ["extTask", "<marker name='extMkr'>Extract</marker> from the area via <font color='#D22E2E'>Blazerunner's helicopter</font>", "Extraction","Extract",getMarkerPos "extMkr", "assigned"]] call FHQ_fnc_ttAddTasks;
sleep 1.0;

[_extHeli] spawn 
{
	while {({(_x in (_this select 0))} count units sabre != {alive _x} count units sabre)} do 
	{
		"SmokeShellGreen" createVehicle (getPos extLZ);
		sleep 25;
	};
};

// Waypoint to extraction
_wp1 = _extCrew addWaypoint [(getMarkerPos "extMkr"), 0];
[_extCrew, 2] setWaypointBehaviour "CARELESS";
_wp1 setWaypointType "MOVE";
_wp1 setWaypointStatements ["true", "vehicle this land 'get in'"];

_wp2 = _extCrew addWaypoint [(getMarkerPos "extMkr"), 1];
[_extCrew, 2] setWaypointBehaviour "UNCHANGED";
_wp2 setWaypointType "MOVE";
_wp2 setWaypointStatements ["{(_x in vehicle this)} count units sabre == {alive _x} count units sabre", ""];

// Open doors
waitUntil { (_extHeli distance extLZ) < 35 };
[_extHeli, "OPEN"] call AD_fnc_animHeliDoors;

// Play music
"Trinity" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];

// Wait until Blazerunner has landed
waitUntil {isTouchingGround _extHeli};
sleep 1.0;

[
	["Blazerunner","Alright Sabre, I've landed. Hop in when you're ready to leave!",10,"RadioAmbient8"], AD_fnc_subtitle
] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];

// Wait until everyone is in Blazerunner 
waitUntil { ({(_x in _extHeli)} count units sabre == {alive _x} count units sabre) };

[_extHeli,true] remoteExec ["lock", [0,-2] select (isMultiplayer && isDedicated), true];
sleep 1.0;

[
	["Blazerunner","Baseplate this is Blazerunner, Sabre is aboard and we are RTB, out.",10,"RadioAmbient2"], AD_fnc_subtitle
] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];

_wp3 = _extCrew addWaypoint [(getMarkerPos "extHeliEnd"), 0];
[_extCrew, 2] setWaypointBehaviour "UNCHANGED";
_wp3 setWaypointType "MOVE";

["extTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
sleep 10.0;
[] remoteExec ["AD_fnc_thanks", [0,-2] select (isMultiplayer && isDedicated)];
sleep 25;

activateKey "MissionCompleted";
sleep 1.0;
["End_Win",true,true,false] remoteExec ["BIS_fnc_endMission"];
