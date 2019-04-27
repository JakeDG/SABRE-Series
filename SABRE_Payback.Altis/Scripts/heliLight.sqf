_heli = _this select 0;

while {alive _heli} do
{
	/* _lightStatic = "#lightpoint" createVehicle position _heli;
	_lightStatic lightAttachObject [_heli, [0,1,0.25]];
	_lightStatic setLightColor[250, 0.0, 0.0];   
	_lightStatic setLightAttenuation [0.3,0,0,500];   
	_lightStatic setLightIntensity 200;

	waitUntil {isTouchingGround _heli};
	deleteVehicle _lightStatic;
	sleep 0.5; */
	
	waitUntil {isTouchingGround _heli};
	while {isTouchingGround _heli} do 
	{
		_lightFlash = "#lightpoint" createVehicle position _heli;
		_lightFlash lightAttachObject [_heli, [0,1,0.25]];
		_lightFlash setLightColor[250, 0.0, 0.0];   
		_lightFlash setLightAttenuation [0.3,0,0,500];   
		_lightFlash setLightIntensity 200;
		
		sleep 1.5;
		
		deleteVehicle _lightFlash;
		
		sleep 1,5;
	}; 
};