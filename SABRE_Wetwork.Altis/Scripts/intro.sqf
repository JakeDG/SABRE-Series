// Creates the intro
player enableSimulation false;

if (isMultiplayer) then 
{
	100 cutText ["", "BLACK FADED", 999];
	100 cutText ["Server Loading...", "BLACK FADED", 999];
	0 fadeSound 0;
	0 fadeMusic 0;
	enableRadio false;
	enableEnvironment false;	
	clearRadio;
	waitUntil {sleep 1; !isNil "serverLoaded"};
	100 cutText ["Server Loaded", "BLACK FADED", 999];
}
else
{
	100 cutText ["", "BLACK FADED", 999];
	100 cutText ["Mission Loading...", "BLACK FADED", 999];
	0 fadeSound 0;
	0 fadeMusic 0;
	enableRadio false;
	enableEnvironment false;	
	clearRadio;
	waitUntil {sleep 1; !isNil "serverLoaded"};
	100 cutText ["Mission Loaded", "BLACK FADED", 999];
};
sleep 1.0;
100 cutText ["", "BLACK FADED", 999];
enableEnvironment true;	
10 fadeSound 1; // Fade sound back in
0 fadeMusic 1; // Fade music back in
sleep 4.0;
	
playMusic "Remnants"; // Play intro music

101 cutText ["<t size='2.0'>''Every evil man's downfall will be his false sense of invincibility.''<br/>- Unknown</t>", "BLACK", 3.0,true,true];
sleep 7.0;
101 cutFadeOut 1.0;
sleep 4.0;

101 cutText ["<t size='2.0' color='#D22E2E'>AlphaDog presents...</t>", "BLACK", 3.0,true,true];
sleep 7.0;
101 cutFadeOut 1.0;
sleep 4.0;

101 cutText ["<t  size = '5.0' shadow = '0' color='#D22E2E'>SABRE:<br/></t><t  size = '5.0' shadow = '0'>Wetwork</t>", "BLACK", 4.0,true,true];
sleep 5.0;
101 cutFadeOut 4.5;

100 cutText ["", "BLACK IN", 15];
player enableSimulation true;
enableRadio true;
//enableEnvironment true;
enableSentences true;

sleep 15.0;
_date = [] call AD_fnc_getDate;
_time = [] call AD_fnc_getTime;
_text = 
	[ 
		["Sabre Team","<t color='#D22E2E' font='PuristaBold'>%1</t><br/>",8], 
		["AAF Restricted Zone, Altis","<t font='PuristaMedium'>%1</t><br/>",8],
		[_time + " Hours","<t font='PuristaMedium'>%1</t><br/>",8],		
		[_date,"<t font='PuristaMedium'>%1</t><br/>",20] 
	]; 
[_text,-safezoneX,safeZoneY+safeZoneH-0.4,"<t align='center'>%1</t>"] spawn BIS_fnc_typeText;

introDone = true;
publicVariable "introDone";

if (("Music" call BIS_fnc_getParamValue) == 1) then
{
	waitUntil{sleep 1.0; !isNil "dedicatedMusic"};
	if (dedicatedMusic) then // Only works on dedicated servers
	{
		ehID = addMusicEventHandler [
									"MusicStop", 
									{
										[] spawn
										{
											_tracks = ["Wetworks","BlackMarket","Tactical","Camo"];
											sleep 5.0;
											playMusic (selectRandom _tracks);;
										};
									}
								];
	};
};
