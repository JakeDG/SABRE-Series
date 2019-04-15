waitUntil {!isNull player};

// Disable Teamswitching and sentences
enableTeamSwitch false;
enableSentences false;

100 cutText ["Loading...", "BLACK FADED", 1];

[player] execVM "Scripts\sabreLoadouts.sqf";
{
	if (!isPlayer _x && player == (leader _x)) then 
	{
		waitUntil{local _x && alive _x && !isNil "isStealth"};
		[_x] execVM "Scripts\sabreLoadouts.sqf";
		_x enableFatigue false;
		doStop _x;
		
		if (isStealth) then
		{
			_x setCombatMode "GREEN";
			//_x setBehaviour "STEALTH"; // Set sabre team to stealth mode
		};
		
		if ([] call AD_fnc_isNight) then
		{
			_x enableIRLasers true;
		};
	};
}forEach units sabre;

// Play Jason theme at easter egg location
[] spawn
{
	while {alive easterEggLoc} do
	{
		easterEggLoc say3D "EasterEgg";
		sleep 10;
	};
};

// Play sound at CSAT data terminal 
[] spawn
{
	while {alive csatTerminal} do
	{
		csatTerminal say3D "DataTerminalLoop";
		sleep 11.0;
	};
};

// Play sound at CSAT EMP
[] spawn 
{ 
 while {alive csatEMP} do 
 { 
  csatEMP say3D "Device_assembled_loop"; 
  sleep 29.3; 
 }; 
};

// Set fatigue
_paramfatigue = "Fatigue" call BIS_fnc_getParamValue;
if (_paramfatigue == 0) then
{
	player enableFatigue false;
};

100 cutText ["Loading Complete", "BLACK FADED", 1];
waitUntil{!isNil "BIS_fnc_init"};
[player] call AD_fnc_clientLoaded;

if (isNil "introDone") then 
{
	execVM "Scripts\intro.sqf";
}
else
{
	100 cutText ["You have joined the mission in progress.", "BLACK FADED", 1];
	player allowDamage false; // Make player unknowingly briefly invincible
	sleep 1.0;
	
	if (("Music" call BIS_fnc_getParamValue) == 1) then 
	{
		waitUntil{sleep 1.0; !isNil "dedicatedMusic"};
		if (dedicatedMusic && ((["primTasks"] call FHQ_fnc_ttGetTaskState) != "completed")) then // Only works on dedicated servers
		{
			_tracks = ["Wetworks","BlackMarket","Tactical","Camo","Scout"];
			playMusic (selectRandom _tracks);
			ehID = addMusicEventHandler [
										"MusicStop", 
										{
											[] spawn
											{
												_tracks = ["Wetworks","BlackMarket","Tactical","Camo","Scout"];
												sleep 5.0;
												playMusic (selectRandom _tracks);;
											};
										}
									];
		};
	};
	
	if ((leader player != player) && (player distance leader player) > 350) then
	{
		100 cutText ["You are being moved near the squad leader...", "BLACK FADED", 1];
		sleep  5.0;
		[player] call AD_fnc_moveToLeader;
	};
	
	sleep 2.0;
	100 cutText ["", "BLACK FADED", 1];
	100 cutFadeOut 5;
	enableSentences true; // Re-enable sentences
	player allowDamage true; // Turn off player's invinciblity
};