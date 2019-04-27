// Conversation with Sabre and the informant at the LZ
if (!(local player)) exitWith {};

if (alive informant && ((player distance informant) < 15)) then 
{
	["Rigas", "About time you guys arrived. I was starting to worry.", 10] call AD_fnc_subtitle;
};
sleep 8.0;

if (alive informant && ((player distance informant) < 15)) then 
{
	["Rigas", "These thugs showed up just before you guys got here. Luckily, they didn't have a clue who they were fuckin' with.", 10] call AD_fnc_subtitle;
};
sleep 8.0;

if (alive informant && ((player distance informant) < 15)) then 
{
	["Rigas", "Anyways, here are the keys to my offroad. I won't be needing it anymore. Also, I put a drone I kept from my years at ION in the back if you need it.", 10] call AD_fnc_subtitle;
};
sleep 8.0;

if (alive informant && ((player distance informant) < 15)) then 
{
	["Rigas", "One more thing before I go. The militia's locked down the area. Expect heavy resistance from those lowlifes. They won't go down easy!", 10] call AD_fnc_subtitle;
};
sleep 8.0;

// Unlock truck
[infoTruck, false] remoteExec ["lock",[0,-2] select (isMultiplayer && isDedicated), (alive infoTruck)];
informant enableAI "MOVE";

if (alive informant && ((player distance informant) < 15)) then 
{
	["Rigas", "Godspeed fellas! I'll see you on the other side!", 10] call AD_fnc_subtitle;
};

convoDone = true;