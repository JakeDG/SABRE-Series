// Intro that plays when the whole squads enters the chopper and is taken to the insertion
0 fadeMusic 0;
playMusic "Black"; // Play intro music
5 fadeMusic 1;

sleep 20.0;
["<t size='1.0' color='#D22E2E'>AlphaDog Presents...</t>", safeZoneX+0.1, safeZoneY+safeZoneH-0.9, 4, 4, 0, 200] spawn BIS_fnc_dynamicText;
sleep 10.0;

["<t  size = '3.0' shadow = '0' color='#D22E2E'>SABRE: </t><t  size = '3.0' shadow = '0'>Payback</t>", safeZoneX+0.45,safeZoneY+safeZoneH-0.9, 8, 7, 0, 200] spawn BIS_fnc_dynamicText;
sleep 5.0;

heliIntroDone = true;
publicVariable "heliIntroDone";