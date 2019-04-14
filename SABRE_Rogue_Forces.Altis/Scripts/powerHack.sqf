// This script will begin the hack at the solar plant
if (!isNull player) then
{
	meltLaptop remoteExec ["removeAllActions",[0,-2] select (isMultiplayer && isDedicated),true];
	
	player switchMove "HubSpectator_stand"; // Disable player movement
	
	_text =
		[
			["Hacking In...","<t size='0.7' font='PuristaSemiBold'>%1</t>",6],
			["Access Granted","<t color='#26C934' size='0.7' font='PuristaBold'>%1</t><br/>",6],
			["Breaching Voltage System...","<t size='0.7' font='PuristaSemiBold'>%1</t>",6],
			["Successful","<t color='#26C934' size='0.7' font='PuristaBold'>%1</t><br/>",6],
			["Attempting Overvolt...","<t size='0.7' font='PuristaSemiBold'>%1</t>",6],
			["Successful","<t color='#26C934' size='0.7' font='PuristaBold'>%1</t><br/>",6]
		];
	
	[_text,-safezoneX,0.7,"<t align='center'>%1</t>"] spawn BIS_fnc_typeText;
	sleep 19;
	
	_text =
		[
			["Overvolting Transformers...","<t size='0.7' font='PuristaSemiBold'>%1</t><br/>",5],
			["WARNING:","<t color='#D22E2E' size='0.7' font='PuristaBold'>%1</t>",5],
			["VOLTAGE LEVELS CRITICAL","<t size='0.7' font='PuristaBold'>%1</t><br/>",5],
			["WARNING:","<t color='#D22E2E' size='0.7' font='PuristaBold'>%1</t>",5],
			["TRANSFORMER TEMPURATURES RISING","<t size='0.7' font='PuristaBold'>%1</t><br/>",5],
			["WARNING:","<t color='#D22E2E' size='0.7' font='PuristaBold'>%1</t>",5],
			["90 SECONDS UNTIL MELTDOWN","<t size='0.7' font='PuristaBold'>%1</t><br/>",5]
		];
	[_text,-safezoneX,0.7,"<t align='center'>%1</t>"] spawn BIS_fnc_typeText;
	sleep 21;
    player playMove "AmovPercMstpSlowWrflDnon"; // Re-enable player movement
			
	if (compHacked) exitWith {}; // Last check to ensure meltdown script runs only once
				
	compHacked = true;
	publicVariable "compHacked";
				
	// Execute meltdown on server
    ["Scripts\meltdown.sqf"] remoteExec ["BIS_fnc_execVM", 2]; 
};