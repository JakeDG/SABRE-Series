// Creates loadouts for all of Richman's thugs
if (!isServer) exitWith {};

_unit = _this select 0;

// Remove all gear from unit
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_uniforms = ["U_I_C_Soldier_Bandit_2_F", "U_I_C_Soldier_Bandit_5_F", "U_I_C_Soldier_Para_4_F", "U_I_C_Soldier_Bandit_3_F", "U_BG_Guerilla2_1","U_BG_Guerilla2_2","U_BG_Guerilla2_3", "U_IG_Guerilla3_1"];
_vests = ["V_Chestrig_blk", "V_Rangemaster_belt", "V_TacVest_blk", "V_TacVest_oli", "V_BandollierB_khk", "V_BandollierB_blk"]; 
_hats = ["H_Bandanna_gry", "H_Bandanna_cbr", "H_Bandanna_khk", "H_Booniehat_oli", "H_Booniehat_khk", "H_Cap_blk", "H_Cap_blu", "H_Shemag_olive"];
_goggles = ["", "G_Bandanna_blk", "G_Bandanna_khk", ""];
_weapons = ["arifle_AK12_F","arifle_AKM_F","arifle_AKS_F", "arifle_TRG20_F", "arifle_Katiba_C_F", "SMG_05_F", "SMG_02_F"]; 

_uni = selectRandom _uniforms;
if (_uni == "U_IG_Guerilla3_1") then // tac vests will clip through jacket uniform
{
	_vests = _vests - ["V_TacVest_blk","V_TacVest_oli"]; // Remove vests from array
};
_unit forceAddUniform _uni; // Add randomly selected uniform
_unit addItemToUniform "FirstAidKit";
_unit addVest (selectRandom _vests); // Add randomly selected vest
_unit addItemToVest "MiniGrenade";
_unit addHeadgear (selectRandom _hats); // Add randomly selected hats

_goggle = selectRandom _goggles; // Add randomly selected goggles
if (_goggle != "") then 
{
	_unit addGoggles _goggle; 
};

_unitWeapon = [_unit, (selectRandom _weapons), 6, 0] call BIS_fnc_addWeapon; // Add randomly selected weapon

_unit addPrimaryWeaponItem "acc_flashlight";
sleep 0.1;
_unit enablegunlights "forceOn";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
