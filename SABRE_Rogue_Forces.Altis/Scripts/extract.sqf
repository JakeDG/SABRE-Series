// Blazerunner extracts Sabre

if (!isServer) exitWith {};

// Create blaze runner crew and heli
_extCrew = createGroup west;
sleep 1.0;
_extVeh = [getMarkerPos "heliSpawnMkr", 200, "B_CTRG_Heli_Transport_01_sand_F", _extCrew] call bis_fnc_spawnvehicle;
_extHeli = (_extVeh select 0);

// Create constant check to see if Blazerunner is dead
[_extHeli] spawn
{
	waitUntil{sleep 1.0; !alive (_this select 0)};
	
	["<t size='0.6'><t color='#D22E2E'>Baseplate:</t> Blazerunner is down! Mission failed!</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
	sleep 5.0;
	["End_BlazeDead",false,true,true] call BIS_fnc_endMission;
};

/*
{
	[_x, false] remoteExec ["allowDamage", [0,-2] select (isMultiplayer && isDedicated), _x]; 
} forEach (crew _extHeli)+[_extHeli];
*/

_extCrew allowFleeing 0;
_extCrew setBehaviour "CARELESS";
vehControl action ["CollisionLightOff", _extHeli];
sleep 1.0;

// Create a green smoke at extraction point
[_extHeli] spawn 
{
	waitUntil {((_this select 0) distance extLZ) < 250};
	
	while {({(_x in (_this select 0))} count units sabre != {alive _x} count units sabre)} do 
	{
		"SmokeShellGreen" createVehicle (getPos extLZ);
		sleep 25;
	};
};

// Waypoints to extraction
_wp1 = _extCrew addWaypoint [(getMarkerPos "extWp1"), 0];
[_extCrew, 0] setWaypointBehaviour "CARELESS";
_wp1 setWaypointType "MOVE";
_wp1 setWaypointSpeed "NORMAL";
	
_wp2 = _extCrew addWaypoint [(getMarkerPos "extWp2"), 1];
_wp2 setWaypointType "MOVE";

_wp3 = _extCrew addWaypoint [(getMarkerPos "extWp3"), 2];
_wp3 setWaypointType "MOVE";

_wp4 = _extCrew addWaypoint [(getPos extLZ), 4];
_wp4 setWaypointType "MOVE";
_wp4 setWaypointStatements ["true", "vehicle this land 'get in'"];
_wp4 setWaypointSpeed "LIMITED";

_wp5 = _extCrew addWaypoint [(getPos extLZ), 5];
_wp5 setWaypointType "MOVE";
_wp5 setWaypointStatements ["{(_x in vehicle this)} count units sabre == {alive _x} count units sabre", ""];

// Open doors
waitUntil { (_extHeli distance extLZ) < 50 };
[_extHeli, "OPEN"] call AD_fnc_animHeliDoors;
["defendTask", "succeeded"] call FHQ_fnc_ttSetTaskState;

// Set Marker and LZ
_extMkr = createMarker ["extMkr", (getPos extLZ)];
"extMkr" setMarkerText "Extraction";
"extMkr" setMarkerColor "ColorBlufor";
"extMkr" setMarkerType "hd_pickup";

// Wait until Blazerunner has landed
waitUntil {sleep 1.0; isTouchingGround _extHeli};

// Create extraction task
[sabre, ["extTask", "<marker name='extMkr'>Extract</marker> from the area via <font color='#D22E2E'>Blazerunner's helicopter</font>", "Extraction","Extract", getPos _extHeli, "assigned"]] call FHQ_fnc_ttAddTasks;
sleep 2.0;

// Blazerunner message
[["RadioAmbient2"],AD_fnc_soundAmp] remoteExec ["call", [0,-2] select (isMultiplayer && isDedicated)];
["<t size='0.6'><t color='#D22E2E'>Blazerunner:</t> Sabre, I've landed. Let's get you guys outta here. Jump in when you're ready.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];

// Wait until everyone is in Blazerunner 
waitUntil { ({(_x in _extHeli)} count units sabre == {alive _x} count units sabre) };

// Play music
"LeadTrack01b_F_EXP" remoteExec ["playMusic",[0,-2] select (isMultiplayer && isDedicated)];

// Lock the heli doors
[_extHeli,true] remoteExec ["lock", [0,-2] select (isMultiplayer && isDedicated), true];
sleep 1.0;

// Blazerunner message
["<t size='0.6'><t color='#D22E2E'>Blazerunner:</t> Alright, we are RTB. Nice job kickin' ass out there, Sabre.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];

// Create final waypoint
_wp6 = _extCrew addWaypoint [(getMarkerPos "extWp1"), 6];
_wp6 setWaypointType "MOVE";
_wp6 setWaypointSpeed "NORMAL";

["extTask", "succeeded"] call FHQ_fnc_ttSetTaskState;
[15, 0.25] remoteExec ["fadeSound", [0,-2] select (isMultiplayer && isDedicated)];
sleep 10.0;

[] remoteExec ["AD_fnc_thanks", [0,-2] select (isMultiplayer && isDedicated)];
sleep 15;

["<t size='0.6'><t color='#D22E2E'>Blazerunner:</t> By the way, Colonel Maxis said he wants to speak with you guys right away. He said something about CSAT in the Pacific.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] remoteExec ["BIS_fnc_dynamicText", [0,-2] select (isMultiplayer && isDedicated)];
sleep 16;

activateKey "MissionCompleted";
sleep 1.0;
["End_Win",true,true,false] remoteExec ["BIS_fnc_endMission"];
