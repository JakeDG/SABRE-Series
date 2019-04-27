// This script will change the location of the dead spotter. The 1 of 3 locations will be built.

if (!isServer) exitWith {};

// Build location of spotter
_spotNum = floor(random 3);
switch (_spotNum) do
{
	case 0:	// Warehouse
	{
		_light1 = "Land_PortableLight_single_F" createVehicle [0,0,0];
		_light1 setDir 117;
		_light1 setPosATL [9352.78,21148.6,0.257999]; // Need to set location again
		
		_light2 = "Land_PortableLight_single_F" createVehicle [0,0,0];
		_light2 setDir 73.5;
		_light2 setPosATL [9353.31,21151.4,0.113998]; // Need to set location again
		
		_chair1 = "Land_CampingChair_V2_F" createVehicle [0,0,0];
		_chair1 setDir 67;
		_chair1 setPosATL [9351.26,21148.7,0.289001];
		
		_chair2 = "Land_ChairWood_F" createVehicle [0,0,0];
		_chair2 setDir 274.477;
		_chair2 setPosATL [9348.92,21150.3,0.111546];
		
		_table1 = "Land_CampingTable_F" createVehicle [0,0,0];
		_table1 enableSimulationGlobal false;
		_table1 setDir 22.6;
		_table1 setPosATL [9350.36,21148.1,0.417988];
		
		// Setup spotter's rifle
		spotRifle setPosATL [9350.56,21148.1,1.250];
		spotRifle setVectorDirAndUp [[-0.469594,-0.882617,0.0216295],[0.00153619,0.0236819,0.999718]];
		spotScope setPosATL [9350.58,21147.9,1.263];
		spotScope setDir 212.8;
		spotSup setPosATL [9350.01,21148.4,1.188];
		spotSup setDir 239;
		spotBi setPosATL [9350.25,21148.3,1.181];
		spotBi setDir 190;
		
		//Setup tools on table
		_file = "Land_File_F" createVehicle [0,0,0];
		_file enableSimulationGlobal false;
		_file setDir 188.531;
		_file setPosATL [9350.52,21152.2,0.94];
		
		_grind = "Land_Grinder_F" createVehicle [0,0,0];
		_grind enableSimulationGlobal false;
		_grind setDir 37.8;
		_grind setPosATL [9350.92,21152.3,0.941483];
		
		_glove = "Land_Gloves_F" createVehicle [0,0,0];
		_glove enableSimulationGlobal false;
		_glove setDir 357.7;
		_glove setPosATL [9351.13,21152.1,0.936105];
		
		_butTorch = "Land_ButaneTorch_F" createVehicle [0,0,0];
		_butTorch enableSimulationGlobal false;
		_butTorch setDir 341.7;
		_butTorch setPosATL [9351.28,21152.2,0.935001];
		
		_butCan = "Land_ButaneCanister_F" createVehicle [0,0,0];
		_butCan enableSimulationGlobal false;
		_butCan setDir 0;
		_butCan setPosATL [9351.45,21152.2,0.932251];
		
		_screwPhil = "Land_Screwdriver_V2_F" createVehicle [0,0,0];
		_screwPhil enableSimulationGlobal false;
		_screwPhil setDir 347;
		_screwPhil setPosATL [9351.47,21152,0.927547];
		
		_screwSlot = "Land_Screwdriver_V1_F" createVehicle [0,0,0];
		_screwSlot enableSimulationGlobal false;
		_screwSlot setDir 17.3;
		_screwSlot setPosATL [9351.55,21152.1,0.927715];
		
		_tape = "Land_DuctTape_F" createVehicle [0,0,0];
		_tape enableSimulationGlobal false;
		_tape setDir 0;
		_tape setPosATL [9351.68,21152.1,0.925114];
		
		_drill = "Land_DrillAku_F" createVehicle [0,0,0];
		_drill enableSimulationGlobal false;
		_drill setDir 296.5;
		_drill setPosATL [9352.3,21152.1,0.916];
		
		_truck = "I_G_Offroad_01_F" createVehicle [9358.46,21161,0];
		_truck setDir 286;
		
		_van = "I_G_Van_02_vehicle_F" createVehicle [9370.23,21150.9,0];
		_van setDir 7;
		vehCtrl action ["lightOn", _van];
		
		// Move men
		spotGuard_1 setPosATL [9350.73,21149.3,0.191673];
		spotGuard_1 setDir 287;
		
		spotGuard_2 setPosATL [9354.48,21150.8,0.152153];
		spotGuard_2 setDir 148;
		
		sptr_obj setPosATL [9348.83,21150.295,0.704001];
		sptr_obj setDir 95;
	};
	case 1:	// House on hill near officer compound
	{
		_light1 = "Land_PortableLight_single_F" createVehicle [0,0,0];
		_light1 setDir 195;
		_light1 setPosATL [8633.86,20792.1,3.41943]; // Need to set location again
		
		_chair1 = "Land_ChairWood_F" createVehicle [0,0,0];
		_chair1 setDir 28;
		_chair1 setPosATL [8635.95,20797.9,3.0094];
		
		_table1 = "Land_CampingTable_small_F" createVehicle [0,0,0];
		_table1 enableSimulationGlobal false;
		_table1 setDir 161;
		_table1 setPosATL [8632.48,20797.6,3.17855];
		
		// Setup spotter's rifle
		spotRifle setPosATL [8632.51,20797.5,4];
		spotRifle setVectorDirAndUp [[-0.696941,0.717129,0.000481088],[0.000690285,0,1]];
		spotScope setPosATL [8632.36,20797.6,4.00562];
		spotScope setDir 309;
		spotSup setPosATL [8632.77,20797.4,4];
		spotSup setDir 357.7;
		spotBi setPosATL [8632.78,20797.7,3.98035];
		spotBi setDir 298;
		
		//Setup tools on table
		_file = "Land_File_F" createVehicle [0,0,0];
		_file enableSimulationGlobal false;
		_file setDir 188.531;
		_file setPosATL [8634.31,20798.2,3.97289];
		
		_grind = "Land_Grinder_F" createVehicle [0,0,0];
		_grind enableSimulationGlobal false;
		_grind setDir 53;
		_grind setPosATL [8633.64,20798.1,4.00235];
		
		_glove = "Land_Gloves_F" createVehicle [0,0,0];
		_glove enableSimulationGlobal false;
		_glove setDir 357.696;
		_glove setPosATL [8633.97,20797.7,3.96754];
		
		_butTorch = "Land_ButaneTorch_F" createVehicle [0,0,0];
		_butTorch enableSimulationGlobal false;
		_butTorch setDir 300;
		_butTorch setPosATL [8634.24,20797.8,3.95656];
		
		_butCan = "Land_ButaneCanister_F" createVehicle [0,0,0];
		_butCan enableSimulationGlobal false;
		_butCan setDir 0;
		_butCan setPosATL [8634.37,20797.9,3.95593];
		
		_screwPhil = "Land_Screwdriver_V2_F" createVehicle [0,0,0];
		_screwPhil enableSimulationGlobal false;
		_screwPhil setDir 0;
		_screwPhil setPosATL [8633.53,20797.6,3.98672];
		
		_screwSlot = "Land_Screwdriver_V1_F" createVehicle [0,0,0];
		_screwSlot enableSimulationGlobal false;
		_screwSlot setDir 342;
		_screwSlot setPosATL [8633.62,20797.7,3.98425];
		
		_tape = "Land_DuctTape_F" createVehicle [0,0,0];
		_tape enableSimulationGlobal false;
		_tape setDir 0;
		_tape setPosATL [8633.97,20798,3.98341];
		
		_drill = "Land_DrillAku_F" createVehicle [0,0,0];
		_drill enableSimulationGlobal false;
		_drill setDir 296.5;
		_drill setPosATL [8634.06,20798.2,3.98969];
		
		_truck = "I_G_Offroad_01_F" createVehicle [8647.53,20804.8,0];
		_truck setDir 46;
		vehCtrl action ["lightOn", _truck];
		
		_atv1 = "I_G_Quadbike_01_F" createVehicle [8628.81,20801.1,0];
		_atv1 setDir 108;
		
		_atv2 = "I_G_Quadbike_01_F" createVehicle [8627.33,20798.3,0];
		_atv2 setDir 134;
		
		// Move men
		spotGuard_1 setPosATL [8633.7,20795.5,3.244];
		spotGuard_1 setDir 55;
		
		spotGuard_2 setPosATL [8634.51,20796.1,0.308502];
		spotGuard_2 setDir 16;
		
		sptr_obj setPosATL [8635.98,20797.9,3.57038];
		sptr_obj setDir 209;
	};
	case 2:	// Houses near garbage fire
	{
		_light1 = "Land_PortableLight_single_F" createVehicle [0,0,0];
		_light1 setDir 113.624;
		_light1 setPosATL [9256.2,22193.8,0.687249]; // Need to set location again
		
		_light2 = "Land_PortableLight_single_F" createVehicle [0,0,0];
		_light2 setDir 202;
		_light2 setPosATL [9251.49,22192.2,0.44574]; // Need to set location again
		
		_chair1 = "Land_CampingChair_V2_F" createVehicle [0,0,0];
		_chair1 setDir 184;
		_chair1 setPosATL [9259.89,22190.8,0.740543];
		
		_chair2 = "Land_ChairWood_F" createVehicle [0,0,0];
		_chair2 setDir 342.8;
		_chair2 setPosATL [9252.79,22195.4,0.536096];
		
		_table1 = "Land_CampingTable_F" createVehicle [0,0,0];
		_table1 enableSimulationGlobal false;
		_table1 setDir 314.4;
		_table1 setPosATL [9255.19,22192.6,0.667971];
		
		// Setup spotter's rifle
		spotRifle setPosATL [9259.79,22192,1.72144];
		spotRifle setVectorDirAndUp [[0.306817,0.951703,0.0111306],[-0.00448846,-0.0102477,0.999937]];
		spotScope setPosATL [9259.76,22192.2,1.72144];
		spotScope setDir 36.8;
		spotSup setPosATL [9260.39,22191.8,1.72144];
		spotSup setDir 31;
		spotBi setPosATL [9260.23,22191.8,1.72144];
		spotBi setDir 357;
		
		//Setup tools on table
		_saw = "Land_Saw_F" createVehicle [0,0,0];
		_saw enableSimulationGlobal false;
		_saw setDir 321;
		_saw setPosATL [9255.66,22193.2,1.48657];
		
		_file = "Land_File_F" createVehicle [0,0,0];
		_file enableSimulationGlobal false;
		_file setDir 308;
		_file setPosATL [9254.87,22192.5,1.4747];
		
		_grind = "Land_Grinder_F" createVehicle [0,0,0];
		_grind enableSimulationGlobal false;
		_grind setDir 277;
		_grind setPosATL [9255.37,22192.8,1.48352];
		
		_glove = "Land_Gloves_F" createVehicle [0,0,0];
		_glove enableSimulationGlobal false;
		_glove setDir 140;
		_glove setPosATL [9254.95,22192.7,1.47635];
		
		_butTorch = "Land_ButaneTorch_F" createVehicle [0,0,0];
		_butTorch enableSimulationGlobal false;
		_butTorch setDir 160;
		_butTorch setPosATL [9254.6,22192.3,1.45654];
		
		_butCan = "Land_ButaneCanister_F" createVehicle [0,0,0];
		_butCan enableSimulationGlobal false;
		_butCan setDir 109;
		_butCan setPosATL [9254.51,22192.2,1.45035];
		
		_screwPhil = "Land_Screwdriver_V2_F" createVehicle [0,0,0];
		_screwPhil enableSimulationGlobal false;
		_screwPhil setDir 150;
		_screwPhil setPosATL [9255.44,22193.2,1.48281];
		
		_screwSlot = "Land_Screwdriver_V1_F" createVehicle [0,0,0];
		_screwSlot enableSimulationGlobal false;
		_screwSlot setDir 132;
		_screwSlot setPosATL [9255.38,22193.1,1.48206];
		
		_tape = "Land_DuctTape_F" createVehicle [0,0,0];
		_tape enableSimulationGlobal false;
		_tape setDir 339;
		_tape setPosATL [9254.76,22192.4,1.46749];
		
		_drill = "Land_DrillAku_F" createVehicle [0,0,0];
		_drill enableSimulationGlobal false;
		_drill setDir 204;
		_drill setPosATL [9254.86,22192.2,1.47053];
		
		_truck = "I_G_Offroad_01_F" createVehicle [9252.79,22180.9,0];
		_truck setDir 79;
		
		// Move men
		spotGuard_1 setPosATL [9253.9,22193,0.599271];
		spotGuard_1 setDir 196;
		
		spotGuard_2 setPosATL [9258.92,22191.1,0.725];
		spotGuard_2 setDir 203;
		
		sptr_obj setPosATL [9252.78,22195.4,1.04];
		sptr_obj setDir 160.25;
	};
};