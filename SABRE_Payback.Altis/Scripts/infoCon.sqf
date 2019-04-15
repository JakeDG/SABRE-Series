// Conversation with Sabre and the informant at the LZ
if (!(local player)) exitWith {};

if (alive informant && ((player distance informant) < 15)) then 
{
	["<t size='0.6'><t color='#D22E2E'>Rigas:</t> About time you guys arrived. I was starting to worry.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] spawn BIS_fnc_dynamicText;
};
sleep 8.0;

if (alive informant && ((player distance informant) < 15)) then 
{
	["<t size='0.6'><t color='#D22E2E'>Rigas:</t> These thugs showed up just before you guys got here. Luckily, they didn't have a clue who they were fuckin' with.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] spawn BIS_fnc_dynamicText;
};
sleep 8.0;

if (alive informant && ((player distance informant) < 15)) then 
{
	["<t size='0.6'><t color='#D22E2E'>Rigas:</t> Anyways, here are the keys to my offroad. I won't be needing it anymore. Also, I put a drone I kept from my years at ION in the back if you need it.</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] spawn BIS_fnc_dynamicText;
};
sleep 8.0;

if (alive informant && ((player distance informant) < 15)) then 
{
	["<t size='0.6'><t color='#D22E2E'>Rigas:</t> One more thing before I go. The militia's locked down the area. Expect heavy resistance from those lowlifes. They won't go down easy!</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] spawn BIS_fnc_dynamicText;
};
sleep 8.0;

// Unlock truck
[infoTruck, false] remoteExec ["lock",[0,-2] select (isMultiplayer && isDedicated), (alive infoTruck)];
informant enableAI "MOVE";

if (alive informant && ((player distance informant) < 15)) then 
{
	["<t size='0.6'><t color='#D22E2E'>Rigas:</t> Godspeed fellas! I'll see you on the other side!</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.3, 10, 0.25, 0, 198] spawn BIS_fnc_dynamicText;
};

convoDone = true;

