// Creates the intro
player enableSimulation false;

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
	
sleep 5.0;
playMusic "Contract";
["<t  size = '1.0'>Six days after the coup...</t>", safeZoneX+0, safeZoneY+safeZoneH-0.9, 4, 4, 0, 200] spawn BIS_fnc_dynamicText;
sleep 10.0;

["<t size='1.0' color='#D22E2E'>AlphaDog Presents...</t>", safeZoneX+0.1, safeZoneY+safeZoneH-0.9, 4, 4, 0, 200] spawn BIS_fnc_dynamicText;
sleep 10.0;

["<t  size = '3.0' shadow = '0'color='#D22E2E'>SABRE:</t><t  size = '3.0'> Rogue Forces</t>", safeZoneX+0.45,safeZoneY+safeZoneH-0.9, 8, 7, 0, 200] spawn BIS_fnc_dynamicText;
sleep 5.0;

100 cutText ["", "BLACK IN", 15];
player enableSimulation true;
5 fadeSound 1;
5 fadeMusic 1;
enableRadio true;
enableEnvironment true;
enableSentences true;

sleep 12.0;
_date = [] call AD_fnc_getDate;
_time = [] call AD_fnc_getTime;
_text = 
	[ 
		["Sabre Team","<t color='#D22E2E' font='PuristaBold'>%1</t><br/>",8], 
		["Southern Altis","<t font='PuristaMedium'>%1</t><br/>",8],
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
											_tracks = [
														"Fallout",
														"AmbientTrack01a_F",
														"LeadTrack02_F",
														"AmbientTrack03_F",
														"SkyNet",
														"Wasteland",
														"AmbientTrack01_F_Orange",
														"AmbientTrack01a_F_Tacops",
														"AmbientTrack01b_F_Tacops",
														"AmbientTrack02a_F_Tacops",
														"AmbientTrack02b_F_Tacops",
														"AmbientTrack03a_F_Tacops",
														"AmbientTrack03b_F_Tacops",
														"AmbientTrack04a_F_Tacops",
														"AmbientTrack04b_F_Tacops"
													];
											sleep 5.0;
											playMusic (selectRandom _tracks);;
										};
									}
								];
	};
};