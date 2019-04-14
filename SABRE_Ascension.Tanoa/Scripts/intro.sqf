// Creates the intro

if (isMultiplayer) then 
{
	100 cutText ["", "BLACK FADED", 999];
	100 cutText ["Server Loading...", "BLACK FADED", 999];
	0 fadeSound 0;
	5 fadeMusic 1;
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
	5 fadeMusic 1;
	enableRadio false;
	enableEnvironment false;	
	clearRadio;
	waitUntil {sleep 1; !isNil "serverLoaded"};
	100 cutText ["Mission Loaded", "BLACK FADED", 999];
};
sleep 1.0;
100 cutText ["", "BLACK FADED", 999];

10 fadeSound 1; // Fade sound back in
sleep 5.0;
["<t  size = '1.0'>Somewhere in Northern Tanoa...</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.85, 4, 4, 0, 200] spawn BIS_fnc_dynamicText;
sleep 10.0;

["<t size='1.0' color='#D22E2E'>AlphaDog Presents...</t>", safeZoneX+0.45, safeZoneY+safeZoneH-0.85, 4, 4, 0, 200] spawn BIS_fnc_dynamicText;

playMusic "PIB"; // Play intro music
sleep 10.0;

["<t  size = '3.0' shadow = '0' color='#D22E2E'>SABRE: </t><t  size = '3.0' shadow = '0'>Ascension</t>", safeZoneX+0.45,safeZoneY+safeZoneH-0.9, 8, 7, 0, 200] spawn BIS_fnc_dynamicText;
sleep 5.0;

100 cutText ["", "BLACK IN", 15];
enableRadio true;
enableEnvironment true;

sleep 12.0;
_date = [] call AD_fnc_getDate;
_time = [] call AD_fnc_getTime;
_text = 
	[ 
		["Sabre Team","<t color='#D22E2E' font='PuristaBold'>%1</t><br/>",8], 
		["Tanoa, South Pacific","<t font='PuristaMedium'>%1</t><br/>",8],
		[_time + " Hours","<t font='PuristaMedium'>%1</t><br/>",8],		
		[_date,"<t font='PuristaMedium'>%1</t><br/>",20] 
	]; 
[_text,-safezoneX,safeZoneY+safeZoneH-0.4,"<t align='center'>%1</t>"] spawn BIS_fnc_typeText;

enableSentences true;

introDone = true;
publicVariable "introDone";

