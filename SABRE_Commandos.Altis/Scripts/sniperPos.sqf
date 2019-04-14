// Move the sniper and CSAT guards to a random house in the village

_sniperPos = floor (random 6);
switch (_sniperPos) do
{
	case 0: // House #1
	{
		deleteVehicle gCar1;
		
		gCar2 setDir 344;
		gCar2 setPosATL [4583.94,21379.0,0];
		gCar2 animateDoor ["Door_rear", 1];
		
		gTruck setDir 109;
		gTruck setPosATL [4579.96,21386.9,0];
		
		sniper setPosATL [4593.08,21366.2,0.403656];
		sniper setDir 341;
		
		g1 setPosATL [4582.36,21363.2,0.468445];
		g1 setUnitPos "UP";
		g1 setDir 318;
		
		g2 setPosATL [4587.59,21360.8,0.596924];
		g2 setUnitPos "UP";
		g2 setDir 300;
		
		g3 setPosATL [4599.31,21380.8,3.89139];
		g3 setUnitPos "UP";
		g3 setDir 259;
		
		g4 setPosATL [4595.23,21367.7,0.385986];
		g4 setUnitPos "UP";
		g4 setDir 297;
		
		g5 setPosATL [4583.09,21388.5,0];
		g5 setDir 17;
		
		g6 setPosATL [4591,21374.7,0];
		g6 setDir 290;
	};
	case 1: // House #2
	{
		gCar1 setDir 10;
		gCar1 setPosATL [4586.79,21405.4,0];
		
		gCar2 setDir 107;
		gCar2 setPosATL [4611.22,21409.5,0.5];
		
		gTruck setDir 295;
		gTruck setPosATL [4579.96,21386.9,0];
		
		sniper setPosATL [4595.02,21395.6,0.253296];
		sniper setDir 100;
		
		g1 setPosATL [4605.12,21404.6,0];
		g1 setUnitPos "UP";
		g1 setDir 67;
		
		g2 setPosATL [4597.08,21389,0];
		g2 setUnitPos "UP";
		g2 setDir 215;
		
		g3 setPosATL [4599.31,21380.8,3.89139];
		g3 setUnitPos "UP";
		g3 setDir 259;
		
		g4 setPosATL [4596.08,21398.5,0.293854];
		g4 setUnitPos "UP";
		g4 setDir 165;
		
		g5 setPosATL [4581.87,21391.4,0];
		g5 setDir 198;
		
		g6 setPosATL [4586.17,21382.5,0];
		g6 setDir 115;
	};
	case 2: // House #3
	{
		deleteVehicle gCar1;
		
		gCar2 setDir 150;
		gCar2 setPosATL [4561.59,21395.7,0];
		
		gTruck setDir 109;
		gTruck setPosATL [4579.96,21386.9,0];
		
		sniper setPosATL [4567.34,21381.6,3.28326];
		sniper setDir 242;
		
		g1 setPosATL [4565.17,21382.7,0.380432];
		g1 setUnitPos "UP";
		g1 setDir 207;
		
		g2 setPosATL [4564.9,21382.5,3.25677];
		g2 setUnitPos "UP";
		g2 setDir 190;
		
		g3 setPosATL [4564.14,21376.1,3.55942];
		g3 setUnitPos "UP";
		g3 setDir 235;
		
		g4 setPosATL [4562.27,21399,0];
		g4 setUnitPos "UP";
		g4 setDir 95;
		
		g5 setPosATL [4581.29,21381.8,0];
		g5 setDir 198;
		
		g6 setPosATL [4579.18,21390.2,0];
		g6 setDir 342;
	};
	case 3: // House #4
	{
		gCar1 setDir 10;
		gCar1 setPosATL [4586.79,21405.4,0];
		
		gCar2 setDir 232;
		gCar2 setPosATL [4566.34,21418.7,0];
		
		gTruck setDir 109;
		gTruck setPosATL [4579.96,21386.9,0];
		
		sniper setPosATL [4572.8,21406.8,3.25018];
		sniper setDir 123;
		
		g1 setPosATL [4571.07,21400.3,0];
		g1 setUnitPos "UP";
		g1 setDir 204;
		
		g2 setPosATL [4572.22,21405.9,0.375885];
		g2 setUnitPos "UP";
		g2 setDir 84;
		
		g3 setPosATL [4577.4,21403,3.45737];
		g3 setUnitPos "UP";
		g3 setDir 150;
		
		g4 setPosATL [4578.36,21406.7,3.24673];
		g4 setUnitPos "UP";
		g4 setDir 313;
		
		g5 setPosATL [4584.92,21399.4,0];
		g5 setDir 217;
		
		g6 setPosATL [4568.69,21417.2,0];
		g6 setDir 141;
	};
	case 4: // House #5
	{
		gCar1 setDir 224;
		gCar1 setPosATL [4561.16,21413.5,0];
		
		gCar2 setDir 145;
		gCar2 setPosATL [4561.59,21395.7,0];
		
		deleteVehicle tWreck;
		sleep 0.25;
		
		gTruck setDir 140;
		gTruck setPosATL [4545.36,21412.9,0];
		
		sniper setPosATL [4544.5,21400.4,0.897522];
		sniper setDir 31;
		
		g1 setPosATL [4543.5,21402.6,0.837372];
		g1 setUnitPos "UP";
		g1 setDir 80;
		
		g2 setPosATL [4550.35,21393.4,1.05823];
		g2 setUnitPos "UP";
		g2 setDir 30;
		
		g3 moveInGunner gCar1;
		
		g4 setPosATL [4548.06,21400.2,0.705109];
		g4 setUnitPos "UP";
		g4 setDir 300;
		
		g5 setPosATL [4563.1,21393.4,0];
		g5 setDir 100;
		
		g6 setPosATL [4548.23,21408.4,0];
		g6 setDir 58;
	};
	case 5: // House #6
	{
		deleteVehicle gCar1;
		
		gCar2 setDir 160;
		gCar2 setPosATL [4573.18,21445.4,0];
		
		gTruck setDir 6;
		gTruck setPosATL [4580.86,21453.2,0];
		
		sniper setPosATL [4562.25,21442.3,4.78027];
		sniper setDir 66;
		
		g1 setPosATL [4561.01,21449.6,0.371185];
		g1 setUnitPos "UP";
		g1 setDir 40;
		
		g2 setPosATL [4565.37,21448.5,4.11795];
		g2 setUnitPos "UP";
		g2 setDir 217;
		
		g3 setPosATL [4559.17,21451.8,3.65317];
		g3 setUnitPos "UP";
		g3 setDir 260;
		
		g4 setPosATL [4563.23,21441.2,4.81616];
		g4 setUnitPos "UP";
		g4 setDir 48;
		
		g5 setPosATL [4553.75,21445.6,0];
		g5 setDir 350;
		
		g6 setPosATL [4569.7,21455.6,0];
		g6 setDir 73;
		
		// Create extra guard (AT Urban Rifleman) standing next to Ifirit on main road
		_extra = "O_soldierU_LAT_F" createVehicle [4580.49,21446.8,0];
		_extra setDir 156;
	};
};