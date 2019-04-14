// Loadouts for Sabre Team
if (!(local player)) exitWith {};
waitUntil {!isNull player};
waitUntil {!isNil "isStealth"};

_unit = _this select 0;
_unitClass = typeOf _unit;
_ownedDLCs = getDLCs 1; // Get all of the owned DLCs
_dlcType = "";

// Check if both Apex and Marksmen DLCs are owned
if ((395180 in (_ownedDLCs)) && (332350 in (_ownedDLCs))) then
{
	_dlcType = "bothOwned";
}
else
{
    if ((395180 in (_ownedDLCs))) then // Check for Apex
    {
        _dlcType = "apex";
    }
    else
    {
       if ((332350 in (_ownedDLCs))) then // Check for Marksmen
		{
			_dlcType = "marksmen";
		};
    };
};

// Remove all gear from unit
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;


switch (_unitClass) do 
{
	////////////////////////////////
	//////// Caesar Loadout ////////
	////////////////////////////////
	case "B_Soldier_TL_F":
	{
		[_unit,"Caesar"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), true];
		
		switch (_dlcType) do 
		{
			case "bothOwned":
			{
				_unit forceAddUniform "U_B_T_Soldier_SL_F";
				for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
				for "_i" from 1 to 3 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
				_unit addVest "V_PlateCarrier2_tna_F";
				for "_i" from 1 to 3 do {_unit addItemToVest "FirstAidKit";};
				for "_i" from 1 to 9 do {_unit addItemToVest "30Rnd_556x45_Stanag";};
				_unit addBackpack "B_Kitbag_rgr";
				for "_i" from 1 to 10 do {_unit addItemToBackpack "1Rnd_HE_Grenade_shell";};
				for "_i" from 1 to 5 do {_unit addItemToBackpack "1Rnd_Smoke_Grenade_shell";};
				for "_i" from 1 to 5 do {_unit addItemToBackpack "HandGrenade";};
				for "_i" from 1 to 5 do {_unit addItemToBackpack "SmokeShell";};
				_unit addHeadgear "H_MilCap_tna_F";
				_unit addGoggles "G_Tactical_Black";
				
				_unit addWeapon "arifle_SPAR_01_GL_khk_F";
				_unit addPrimaryWeaponItem "acc_pointer_IR";
				_unit addPrimaryWeaponItem "optic_ERCO_khk_F";
				_unit addWeapon "hgun_Pistol_heavy_01_F";
				_unit addHandgunItem "optic_MRD";
				_unit addWeapon "Laserdesignator_01_khk_F";


				_unit linkItem "ItemMap";
				_unit linkItem "ItemCompass";
				_unit linkItem "ItemWatch";
				_unit linkItem "ItemRadio";
				_unit linkItem "ItemGPS";
				_unit linkItem "NVGogglesB_blk_F";
				
				if (isStealth) then
				{
					_unit addPrimaryWeaponItem "muzzle_snds_M";
					_unit addHandgunItem "muzzle_snds_acp";
				};
				
			};
			case "apex":
			{
				_unit forceAddUniform "U_B_T_Soldier_SL_F";
				for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
				for "_i" from 1 to 3 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
				_unit addVest "V_PlateCarrier2_tna_F";
				for "_i" from 1 to 3 do {_unit addItemToVest "FirstAidKit";};
				for "_i" from 1 to 9 do {_unit addItemToVest "30Rnd_556x45_Stanag";};
				_unit addBackpack "B_Kitbag_rgr";
				for "_i" from 1 to 10 do {_unit addItemToBackpack "1Rnd_HE_Grenade_shell";};
				for "_i" from 1 to 5 do {_unit addItemToBackpack "1Rnd_Smoke_Grenade_shell";};
				for "_i" from 1 to 5 do {_unit addItemToBackpack "HandGrenade";};
				for "_i" from 1 to 5 do {_unit addItemToBackpack "SmokeShell";};
				_unit addHeadgear "H_MilCap_tna_F";

				_unit addWeapon "arifle_SPAR_01_GL_khk_F";
				_unit addPrimaryWeaponItem "acc_pointer_IR";
				_unit addPrimaryWeaponItem "optic_ERCO_khk_F";
				_unit addWeapon "hgun_Pistol_heavy_01_F";
				_unit addHandgunItem "optic_MRD";
				_unit addWeapon "Laserdesignator_01_khk_F";


				_unit linkItem "ItemMap";
				_unit linkItem "ItemCompass";
				_unit linkItem "ItemWatch";
				_unit linkItem "ItemRadio";
				_unit linkItem "ItemGPS";
				_unit linkItem "NVGogglesB_blk_F";
				
				if (isStealth) then
				{
					_unit addPrimaryWeaponItem "muzzle_snds_M";
					_unit addHandgunItem "muzzle_snds_acp";
				};
			};
			
		};
		
	};
	
	////////////////////////////////
	//////// Taz Loadout ////////
	////////////////////////////////
	case "B_soldier_LAT_F":
	{	
		
		[_unit,"Taz"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), true];
		
		switch (_dlcType) do 
		{
			case "bothOwned":
			{
				comment "Add containers";
				_unit forceAddUniform "U_B_CTRG_Soldier_2_F";
				for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
				for "_i" from 1 to 3 do {_unit addItemToUniform "30Rnd_580x42_Mag_F";};
				_unit addVest "V_PlateCarrierL_CTRG";
				for "_i" from 1 to 3 do {_unit addItemToVest "FirstAidKit";};
				for "_i" from 1 to 3 do {_unit addItemToVest "HandGrenade";};
				for "_i" from 1 to 3 do {_unit addItemToVest "16Rnd_9x21_Mag";};
				for "_i" from 1 to 3 do {_unit addItemToVest "SmokeShell";};
				for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_580x42_Mag_F";};
				_unit addBackpack "B_AssaultPack_rgr";
				for "_i" from 1 to 2 do {_unit addItemToBackpack "NLAW_F";};
				_unit addHeadgear "H_Watchcap_blk";
				_unit addGoggles "G_Shades_Black";

				comment "Add weapons";
				_unit addWeapon "arifle_CTAR_blk_F";
				_unit addPrimaryWeaponItem "acc_pointer_IR";
				_unit addPrimaryWeaponItem "optic_ERCO_blk_F";
				_unit addWeapon "launch_NLAW_F";
				_unit addWeapon "hgun_Rook40_F";
				_unit addWeapon "Rangefinder";

				comment "Add items";
				_unit linkItem "ItemMap";
				_unit linkItem "ItemCompass";
				_unit linkItem "ItemWatch";
				_unit linkItem "ItemRadio";
				_unit linkItem "ItemGPS";
				_unit linkItem "NVGogglesB_blk_F";
				
				_unit addItemToBackpack "NLAW_F"; // Arsenal refused to add this to the backpack
				
				if (isStealth) then
				{
					_unit addPrimaryWeaponItem "muzzle_snds_58_blk_F";
					_unit addHandgunItem "muzzle_snds_L";
				};
			};
			case "apex":
			{
				comment "Add containers";
				_unit forceAddUniform "U_B_CTRG_Soldier_2_F";
				for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
				for "_i" from 1 to 3 do {_unit addItemToUniform "30Rnd_580x42_Mag_F";};
				_unit addVest "V_PlateCarrierL_CTRG";
				for "_i" from 1 to 3 do {_unit addItemToVest "FirstAidKit";};
				for "_i" from 1 to 3 do {_unit addItemToVest "HandGrenade";};
				for "_i" from 1 to 3 do {_unit addItemToVest "16Rnd_9x21_Mag";};
				for "_i" from 1 to 3 do {_unit addItemToVest "SmokeShell";};
				for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_580x42_Mag_F";};
				_unit addBackpack "B_AssaultPack_rgr";
				for "_i" from 1 to 2 do {_unit addItemToBackpack "NLAW_F";};
				_unit addHeadgear "H_Watchcap_blk";

				comment "Add weapons";
				_unit addWeapon "arifle_CTAR_blk_F";
				_unit addPrimaryWeaponItem "acc_pointer_IR";
				_unit addPrimaryWeaponItem "optic_ERCO_blk_F";
				_unit addWeapon "launch_NLAW_F";
				_unit addWeapon "hgun_Rook40_F";
				_unit addWeapon "Rangefinder";

				comment "Add items";
				_unit linkItem "ItemMap";
				_unit linkItem "ItemCompass";
				_unit linkItem "ItemWatch";
				_unit linkItem "ItemRadio";
				_unit linkItem "ItemGPS";
				_unit linkItem "NVGogglesB_blk_F";
				
				_unit addItemToBackpack "NLAW_F"; // Arsenal refused to add this to the backpack
				
				if (isStealth) then
				{
					_unit addPrimaryWeaponItem "muzzle_snds_58_blk_F";
					_unit addHandgunItem "muzzle_snds_L";
				};
			};
			
		};
		
	};
	
	////////////////////////////////
	//////// Hawkes Loadout ////////
	////////////////////////////////
	case "B_sniper_F":
	{	
		
		[_unit,"Hawkes"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), true];
		
		switch (_dlcType) do 
		{
			case "bothOwned":
			{
				comment "Add containers";
				_unit forceAddUniform "U_B_T_FullGhillie_tna_F";
				for "_i" from 1 to 5 do {_unit addItemToUniform "FirstAidKit";};
				for "_i" from 1 to 3 do {_unit addItemToUniform "9Rnd_45ACP_Mag";};
				_unit addVest "V_PlateCarrierH_CTRG";
				for "_i" from 1 to 8 do {_unit addItemToVest "10Rnd_338_Mag";};
				_unit addBackpack "B_AssaultPack_rgr";
				for "_i" from 1 to 3 do {_unit addItemToBackpack "HandGrenade";};
				for "_i" from 1 to 3 do {_unit addItemToBackpack "SmokeShell";};
				for "_i" from 1 to 4 do {_unit addItemToBackpack "10Rnd_338_Mag";};
				_unit addHeadgear "H_Bandanna_gry";

				comment "Add weapons";
				_unit addWeapon "srifle_DMR_02_camo_F";
				_unit addPrimaryWeaponItem "acc_pointer_IR";
				_unit addPrimaryWeaponItem "optic_AMS";
				_unit addPrimaryWeaponItem "bipod_01_F_blk";
				_unit addWeapon "hgun_ACPC2_F";
				_unit addWeapon "Rangefinder";

				comment "Add items";
				_unit linkItem "ItemMap";
				_unit linkItem "ItemCompass";
				_unit linkItem "ItemWatch";
				_unit linkItem "ItemRadio";
				_unit linkItem "ItemGPS";
				_unit linkItem "NVGogglesB_blk_F";
				
				if (isStealth) then
				{
					_unit addPrimaryWeaponItem "muzzle_snds_338_black";
					_unit addHandgunItem "muzzle_snds_acp";
				};

			};
			case "apex":
			{
				comment "Add containers";
				_unit forceAddUniform "U_B_T_FullGhillie_tna_F";
				for "_i" from 1 to 5 do {_unit addItemToUniform "FirstAidKit";};
				for "_i" from 1 to 3 do {_unit addItemToUniform "9Rnd_45ACP_Mag";};
				_unit addVest "V_PlateCarrierH_CTRG";
				for "_i" from 1 to 10 do {_unit addItemToVest "20Rnd_762x51_Mag";};
				_unit addBackpack "B_AssaultPack_rgr";
				for "_i" from 1 to 3 do {_unit addItemToBackpack "HandGrenade";};
				for "_i" from 1 to 3 do {_unit addItemToBackpack "SmokeShell";};
				_unit addHeadgear "H_Bandanna_gry";

				comment "Add weapons";
				_unit addWeapon "arifle_SPAR_03_khk_F";
				_unit addPrimaryWeaponItem "acc_pointer_IR";
				_unit addPrimaryWeaponItem "optic_Nightstalker";
				_unit addPrimaryWeaponItem "bipod_01_F_blk";
				_unit addWeapon "hgun_ACPC2_F";
				_unit addWeapon "Rangefinder";

				comment "Add items";
				_unit linkItem "ItemMap";
				_unit linkItem "ItemCompass";
				_unit linkItem "ItemWatch";
				_unit linkItem "ItemRadio";
				_unit linkItem "ItemGPS";
				_unit linkItem "NVGogglesB_blk_F";	
				
				if (isStealth) then
				{
					_unit addPrimaryWeaponItem "muzzle_snds_B";
					_unit addHandgunItem "muzzle_snds_acp";
				};	
			};
			
		};
		
	};
	
	////////////////////////////////
	//////// Foster Loadout /////////
	////////////////////////////////
	case "B_engineer_F":
	{	
		[_unit,"Foster"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), true];
		
		switch (_dlcType) do 
		{
			case "bothOwned":
			{
				comment "Add containers";
				_unit forceAddUniform "U_B_T_Soldier_F";
				for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
				for "_i" from 1 to 3 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
				_unit addVest "V_PlateCarrierGL_tna_F";
				for "_i" from 1 to 3 do {_unit addItemToVest "FirstAidKit";};
				for "_i" from 1 to 3 do {_unit addItemToVest "HandGrenade";};
				for "_i" from 1 to 3 do {_unit addItemToVest "SmokeShell";};
				for "_i" from 1 to 2 do {_unit addItemToVest "150Rnd_556x45_Drum_Mag_F";};
				_unit addBackpack "B_TacticalPack_rgr";
				_unit addItemToBackpack "ToolKit";
				for "_i" from 1 to 5 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
				for "_i" from 1 to 2 do {_unit addItemToBackpack "150Rnd_556x45_Drum_Mag_F";};
				_unit addHeadgear "H_HelmetB_Enh_tna_F";

				comment "Add weapons";
				_unit addWeapon "arifle_SPAR_02_khk_F";
				_unit addPrimaryWeaponItem "acc_pointer_IR";
				_unit addPrimaryWeaponItem "optic_Arco_blk_F";
				_unit addPrimaryWeaponItem "bipod_01_F_blk";
				_unit addWeapon "hgun_P07_khk_F";
				_unit addWeapon "Rangefinder";

				comment "Add items";
				_unit linkItem "ItemMap";
				_unit linkItem "ItemCompass";
				_unit linkItem "ItemWatch";
				_unit linkItem "ItemRadio";
				_unit linkItem "ItemGPS";
				_unit linkItem "NVGogglesB_blk_F";
				
				_unit addItemToVest "150Rnd_556x45_Drum_Mag_F";
				
				if (isStealth) then
				{
					_unit addPrimaryWeaponItem "muzzle_snds_M";
					_unit addHandgunItem "muzzle_snds_L";
				};
			};
			case "apex":
			{
				comment "Add containers";
				_unit forceAddUniform "U_B_T_Soldier_F";
				for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
				for "_i" from 1 to 3 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
				_unit addVest "V_PlateCarrierGL_tna_F";
				for "_i" from 1 to 3 do {_unit addItemToVest "FirstAidKit";};
				for "_i" from 1 to 3 do {_unit addItemToVest "HandGrenade";};
				for "_i" from 1 to 3 do {_unit addItemToVest "SmokeShell";};
				for "_i" from 1 to 2 do {_unit addItemToVest "150Rnd_556x45_Drum_Mag_F";};
				_unit addBackpack "B_TacticalPack_rgr";
				_unit addItemToBackpack "ToolKit";
				for "_i" from 1 to 5 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
				for "_i" from 1 to 2 do {_unit addItemToBackpack "150Rnd_556x45_Drum_Mag_F";};
				_unit addHeadgear "H_HelmetB_Enh_tna_F";

				comment "Add weapons";
				_unit addWeapon "arifle_SPAR_02_khk_F";
				_unit addPrimaryWeaponItem "acc_pointer_IR";
				_unit addPrimaryWeaponItem "optic_Arco_blk_F";
				_unit addPrimaryWeaponItem "bipod_01_F_blk";
				_unit addWeapon "hgun_P07_khk_F";
				_unit addWeapon "Rangefinder";

				comment "Add items";
				_unit linkItem "ItemMap";
				_unit linkItem "ItemCompass";
				_unit linkItem "ItemWatch";
				_unit linkItem "ItemRadio";
				_unit linkItem "ItemGPS";
				_unit linkItem "NVGogglesB_blk_F";
				
				_unit addItemToVest "150Rnd_556x45_Drum_Mag_F";
				
				if (isStealth) then
				{
					_unit addPrimaryWeaponItem "muzzle_snds_M";
					_unit addHandgunItem "muzzle_snds_L";
				};
			};
			
		};
		
	};
	
	////////////////////////////////
	//////// Apollo Loadout ////////
	////////////////////////////////
	case "B_medic_F":
	{	
		
		[_unit,"Apollo"] remoteExec ["setIdentity", [0,-2] select (isMultiplayer && isDedicated), true];
		
		switch (_dlcType) do 
		{
			case "bothOwned":
			{
				comment "Add containers";
				_unit forceAddUniform "U_B_T_Soldier_F";
				for "_i" from 1 to 3 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
				for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_65x39_caseless_green";};
				_unit addVest "V_PlateCarrier1_tna_F";
				for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
				for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
				for "_i" from 1 to 7 do {_unit addItemToVest "30Rnd_65x39_caseless_green";};
				for "_i" from 1 to 3 do {_unit addItemToVest "10Rnd_50BW_Mag_F";};
				_unit addBackpack "B_AssaultPack_tna_F";
				for "_i" from 1 to 10 do {_unit addItemToBackpack "FirstAidKit";};
				_unit addItemToBackpack "Medikit";
				_unit addHeadgear "H_Cap_grn";

				comment "Add weapons";
				_unit addWeapon "arifle_ARX_blk_F";
				_unit addPrimaryWeaponItem "acc_pointer_IR";
				_unit addPrimaryWeaponItem "optic_Hamr";
				_unit addWeapon "hgun_Rook40_F";
				_unit addWeapon "Rangefinder";

				comment "Add items";
				_unit linkItem "ItemMap";
				_unit linkItem "ItemCompass";
				_unit linkItem "ItemWatch";
				_unit linkItem "ItemRadio";
				_unit linkItem "ItemGPS";
				_unit linkItem "NVGogglesB_blk_F";
				
				if (isStealth) then
				{
					_unit addPrimaryWeaponItem "muzzle_snds_65_TI_blk_F";
					_unit addHandgunItem "muzzle_snds_L";
					for "_i" from 1 to 5 do {_unit addItemToUniform "Chemlight_blue";};
				};
			};
			case "apex":
			{
				comment "Add containers";
				_unit forceAddUniform "U_B_T_Soldier_F";
				for "_i" from 1 to 3 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
				for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_65x39_caseless_green";};
				_unit addVest "V_PlateCarrier1_tna_F";
				for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
				for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
				for "_i" from 1 to 7 do {_unit addItemToVest "30Rnd_65x39_caseless_green";};
				for "_i" from 1 to 3 do {_unit addItemToVest "10Rnd_50BW_Mag_F";};
				_unit addBackpack "B_AssaultPack_tna_F";
				for "_i" from 1 to 10 do {_unit addItemToBackpack "FirstAidKit";};
				_unit addItemToBackpack "Medikit";
				_unit addHeadgear "H_Cap_grn";

				comment "Add weapons";
				_unit addWeapon "arifle_ARX_blk_F";
				_unit addPrimaryWeaponItem "acc_pointer_IR";
				_unit addPrimaryWeaponItem "optic_Hamr";
				_unit addWeapon "hgun_Rook40_F";
				_unit addWeapon "Rangefinder";

				comment "Add items";
				_unit linkItem "ItemMap";
				_unit linkItem "ItemCompass";
				_unit linkItem "ItemWatch";
				_unit linkItem "ItemRadio";
				_unit linkItem "ItemGPS";
				_unit linkItem "NVGogglesB_blk_F";
				
				if (isStealth) then
				{
					_unit addPrimaryWeaponItem "muzzle_snds_65_TI_blk_F";
					_unit addHandgunItem "muzzle_snds_L";
					for "_i" from 1 to 5 do {_unit addItemToUniform "Chemlight_blue";};
				};
			};
			
		};
	
	};

};

[_unit,"CombatPatrol"] call bis_fnc_setUnitInsignia;
_unit setUnitTrait ["loadCoef", 0.75];