/*
	DZAI User-Specified Settings File
	
	Description: 	Use this file to store your preferred settings. The variables stored in this file will override DZAI's default settings in DZAI\init\dzai_config.sqf.
					
	Instructions:	Copy over the lines from DZAI\init\dzai_config.sqf containing the setting(s) that you wish to keep after each DZAI update.
					Whenever you update to a newer version of DZAI, overwrite the default DZAI_settings_override file with your edited copy.
	
	Reminder: Remember to check if anything has changed in the dzai_config.sqf file after each update to DZAI.
	
	Example: If you always want your server to have helicopters enabled with a maximum of 5 helicopters, and using the UH1H and Mi17, then the contents of this file would look like this:
	
	-------------------------(Begin Example File)-------------------------
	

	//Add your preferred settings below this line.
	
	DZAI_maxHeliPatrols = 5;									//Maximum number of active AI helicopters patrols. (Default: 0).
	DZAI_heliTypes = ["UH1H_DZ","Mi17_DZ"];						//Classnames of helicopter types to use. (Default: "UH1H_DZ").

	-------------------------(End of Example File)-------------------------
*/

diag_log text "[STRACE][DZAI] Loading config override, file:";
diag_log text "    " + __FILE__;
diag_log formatText["    Vs. %1", DZAI_directory];

//Add your preferred settings below this line.

DZAI_weaponNoise = true;
DZAI_tempNVGs = true;
DZAI_humanityGain = 125;
DZAI_staticAI = false;
DZAI_maxSpawnTime = 2700;
DZAI_huntingChance = 0.10;

DZAI_banAIWeapons = ["M107_DZ","BAF_AS50_scoped"];	

DZAI_maxHeliPatrols = 1;
DZAI_respawnTMinA = 3600;
DZAI_respawnTMaxA = 10800;
DZAI_heliList = [["UH1H_DZE",1], ["UH1Y_DZE",1], ["MH60S_DZE",1], ["Mi17_Ins",1]];

DZAI_maxLandPatrols = 4;
//DZAI_respawnTMinL = 600;
DZAI_respawnTMaxL = 1800;
// DZAI_vehUnitLevel = 3;
DZAI_vehGunnerUnits = 1;
DZAI_vehCargoUnits = 5;

DZAI_bpmedicals = 3; 	
DZAI_bpedibles = 4;	
DZAI_numMiscItemS = 4;		


//Default weapon classname tables - DZAI will ONLY use these tables if the dynamic weapon list (DZAI_dynamicWeaponList) is disabled, otherwise they are ignored and overwritten if it is enabled.
//Note: Low-level AI (weapongrade 0) may use pistols listed in DZAI_Pistols0 or DZAI_Pistols1. Mid/high level AI (weapongrade 1+) will carry pistol weapons but not use them - they will use rifle weapons instead.
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DZAI_Pistols0 = ["Makarov","Colt1911","revolver_EP1"]; 				//Weapongrade 0 pistols
DZAI_Pistols1 = ["M9","M9SD","MakarovSD","UZI_EP1","glock17_EP1"]; 	//Weapongrade 1 pistols
DZAI_Pistols2 = ["M9SD","MakarovSD","UZI_EP1","glock17_EP1"]; 		//Weapongrade 2 pistols
DZAI_Pistols3 = ["M9SD","MakarovSD","UZI_EP1","glock17_EP1"]; 		//Weapongrade 3 pistols

DZAI_Rifles0 = ["LeeEnfield","Winchester1866","MR43","huntingrifle","LeeEnfield","Winchester1866","MR43"]; //Weapongrade 0 rifles
DZAI_Rifles1 = ["M16A2","M16A2GL","AK_74","M4A1_Aim","AKS_74_kobra","AKS_74_U","AK_47_M","M24","M1014","DMR_DZ","M4A1","M14_EP1","Remington870_lamp","MP5A5","MP5SD","M4A3_CCO_EP1"]; //Weapongrade 1 rifles
DZAI_Rifles2 = ["M16A2","M16A2GL","M249_DZ","AK_74","M4A1_Aim","AKS_74_kobra","AKS_74_U","AK_47_M","M24","SVD_CAMO","M1014","DMR_DZ","M4A1","M14_EP1","Remington870_lamp","M240_DZ","M4A1_AIM_SD_camo","M16A4_ACG","M4A1_HWS_GL_camo","Mk_48_DZ","M4A3_CCO_EP1","Sa58V_RCO_EP1","Sa58V_CCO_EP1","M40A3","Sa58P_EP1","Sa58V_EP1"]; //Weapongrade 2 rifles
DZAI_Rifles3 = ["FN_FAL","FN_FAL_ANPVS4","Mk_48_DZ","M249_DZ","BAF_L85A2_RIS_Holo","G36C","G36C_camo","G36A_camo","G36K_camo","AK_47_M","AKS_74_U","M14_EP1","bizon_silenced","DMR_DZ","RPK_74"]; //Weapongrade 3 rifles

	
/*
	Custom rifle tables can be defined below this line (DZAI_Rifles4 - DZAI_Rifles9) for the corresponding custom weapongrade level using the same format above. 
	Note: If a custom weapongrade is used without defining the corresponding custom rifle array, the DZAI_Rifles3 array will be used instead.
	Instructions: Replace "nil" with the wanted rifle array. Refer to the above rifle arrays for examples on how to define custom rifle tables.
	Custom rifle tables can only be used with custom-defined spawns (spawns created using the DZAI_spawn function). 
*/

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DZAI_Rifles4 = nil; //weapongrade 4 weapons
DZAI_Rifles5 = nil; //weapongrade 5 weapons
DZAI_Rifles6 = nil; //weapongrade 6 weapons
DZAI_Rifles7 = nil; //weapongrade 7 weapons
DZAI_Rifles8 = nil; //weapongrade 8 weapons
DZAI_Rifles9 = nil; //weapongrade 9 weapons


//AI skin classnames. DZAI will use any of these classnames for AI spawned. Note: Additional skins may be included on a per-map or per-mod basis - see folders in \world_classname_configs
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DZAI_BanditTypes = ["Survivor2_DZ", "SurvivorW2_DZ", "Bandit1_DZ", "BanditW1_DZ", "Camo1_DZ", "Sniper1_DZ"];


//AI Backpack types (for weapongrade levels 0-3)
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DZAI_Backpacks0 = ["DZ_Patrol_Pack_EP1","DZ_Czech_Vest_Puch","DZ_Assault_Pack_EP1"];
DZAI_Backpacks1 = ["DZ_Patrol_Pack_EP1","DZ_Czech_Vest_Puch","DZ_Assault_Pack_EP1","DZ_British_ACU","DZ_TK_Assault_Pack_EP1","DZ_CivilBackpack_EP1","DZ_ALICE_Pack_EP1"];
DZAI_Backpacks2 = ["DZ_CivilBackpack_EP1","DZ_British_ACU","DZ_Backpack_EP1"];
DZAI_Backpacks3 = ["DZ_CivilBackpack_EP1","DZ_Backpack_EP1"];


//AI Food/Medical item types. DZAI_Edibles: Drinkable and edible items. DZAI_Medicals1: List of common medical items to be added to AI inventory. DZAI_Medicals2: List of all medical items available only in hospitals to be added to AI backpack.
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DZAI_Edibles = ["ItemSodaCoke", "ItemSodaPepsi", "ItemWaterbottle", "FoodCanSardines", "FoodCanBakedBeans", "FoodCanFrankBeans", "FoodCanPasta", "ItemWaterbottleUnfilled","ItemWaterbottleBoiled","FoodmuttonCooked","FoodchickenCooked","FoodBaconCooked","FoodRabbitCooked","FoodbaconRaw","FoodchickenRaw","FoodmuttonRaw","foodrabbitRaw","FoodCanUnlabeled","FoodPistachio","FoodNutmix","FoodMRE"];
DZAI_Medicals1 = ["ItemBandage", "ItemPainkiller"];
DZAI_Medicals2 = ["ItemPainkiller", "ItemMorphine", "ItemBandage", "ItemBloodbag", "ItemAntibiotic","ItemEpinephrine"];


//AI Miscellaneous item types. DZAI_MiscItemS: List of random low-value items. DZAI_MiscItemL: List of random semi-valuable/useful items
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DZAI_MiscItemS = ["ItemHeatpack", "HandRoadFlare", "HandChemBlue", "HandChemRed", "HandChemGreen","SmokeShell","TrashTinCan","TrashJackDaniels","ItemSodaEmpty"];
DZAI_MiscItemL = ["ItemJerrycan", "PartWheel", "PartEngine", "PartFueltank", "PartGlass", "PartVRotor","PartWoodPile"];


//AI toolbelt item types. Toolbelt items are added to AI inventory upon death. Format: [item classname, item probability]
//Weapongrade level 0-1 AI will use DZAI_tools0 table, weapongrade level 2-3 AI will use DZAI_tools1 table. Custom-spawned AI will use DZAI_tools1 table.
//NOTE: To remove an item, set its chance to 0, don't delete it from the array. To add a toolbelt item as loot, add it to the end of the array.
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DZAI_tools0 = [["ItemFlashlight",0.65],["ItemWatch",0.65],["ItemKnife",0.50],["ItemHatchet",0.40],["ItemCompass",0.40],["ItemMap",0.35],["ItemToolbox",0.125],["ItemMatchbox",0.15],["ItemFlashlightRed",0.05],["ItemGPS",0.005],["ItemRadio",0.005]];
DZAI_tools1 = [["ItemFlashlight",0.75],["ItemWatch",0.75],["ItemKnife",0.75],["ItemHatchet",0.70],["ItemCompass",0.75],["ItemMap",0.70],["ItemToolbox",0.35],["ItemMatchbox",0.40],["ItemFlashlightRed",0.10],["ItemGPS",0.10],["ItemRadio",0.075]];


//AI-useable toolbelt item types. These items are added to AI inventory at unit creation and may be used by AI. Format: [item classname, item probability]
//Weapongrade level 0-1 AI will use DZAI_gadgets0 table, weapongrade level 2-3 AI will use DZAI_gadgets1 table. Custom-spawned AI will use DZAI_gadgets1 table.
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DZAI_gadgets0 = [["binocular",0.40],["NVGoggles",0.00]];
DZAI_gadgets1 = [["binocular",0.60],["NVGoggles",0.05]];


/*DZAI client-side addon settings. 
**NOTE**: These settings require the DZAI client-side addon to be installed to your mission pbo file in order to work.
--------------------------------------------------------------------------------------------------------------------*/	
//Enable to use client-side radio addon for radio messages instead of remote execution method. (Default: false)
DZAI_clientRadio = true;
//Enable or disable AI hostility to zombies. If enabled, AI will attack zombies. (Default: false)
DZAI_zombieEnemy = true;	
//Maximum distance for AI group leader to detect zombies. Increasing range beyond default may impact server performance. (Default: 150)							
DZAI_zDetectRange = 100;									
