// Creates ambient flybys of AAF Vehicles near Sabre Team's squad leader
_unit = _this select 0; // Group leader
_itrNum = _this select 1; // # of flybys
_flyUnits = ["I_Heli_light_03_F", "I_Heli_Transport_02_F", "I_Plane_Fighter_03_dynamicLoadout_F", "I_Plane_Fighter_04_F"]; // AAF flying units

for "_i" from 1 to _itrNum do
{
	_spawnPos = _unit getPos [1500, selectRandom [90,270]];
	_endPos = _unit getPos [2500, selectRandom [180,0]];
	[_spawnPos, _endPos, 100, "NORMAL", selectRandom _flyUnits, independent] call BIS_fnc_ambientFlyby; 
	sleep random [180,300,450];   
};


