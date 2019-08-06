// Conversation with Sabre and the Fox at the village hut
if (!(local player)) exitWith {};

if (alive fox && ((player distance fox) < 15)) then 
{
	["Fox", "Greetings Sabre! Hope your trip here wasn't too bad.", 10] call AD_fnc_subtitle;
};
sleep 8.0;

if (alive fox && ((player distance fox) < 15)) then 
{
	["Fox", "I'm Agent Fox and these CTRG guys are with me, obviously.", 10] call AD_fnc_subtitle;
};
sleep 8.0;

if (alive fox && ((player distance fox) < 15)) then 
{
	["Fox", "You've already been briefed so I'm not going to repeat what you gentlemen already know.", 10] call AD_fnc_subtitle;
};
sleep 8.0;

if (alive fox && ((player distance fox) < 15)) then 
{
	["Fox", "If you guys want supplies it's right next to me. These bandits were very generous with their donation to us.", 10] call AD_fnc_subtitle;
};
sleep 8.0;

if (alive fox && ((player distance fox) < 15)) then 
{
	["Fox", "Once you're ready. I recommend following the path into the jungle to get up the mountain easier, but be careful, some of the bandits retreated into the woods.", 10] call AD_fnc_subtitle;
};
sleep 8.0;

if (alive fox && ((player distance fox) < 15)) then 
{
	["Fox", "Oh, and welcome to the jungle, boys. Hopefully you won't die.", 10] call AD_fnc_subtitle;
};

// Save the game in singleplayer
waitUntil {isNil "AD_subtitle_running"};
if (!isMultiplayer && savingEnabled) then {saveGame;};