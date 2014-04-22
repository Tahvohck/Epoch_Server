//##############
//## Settings ##
//##############

//The next three settings define lifting/towing behavior. If the lift/tow class is higher than or
//		or equal to the weight class, it can perform a lift/tow.
//Objects that can tow. Format "<classname>", "<towing class>"
ttl_canTow = [
	//Class 14: AHAHAHAHAHAHAHA
	"TowingTractor", 14,
	"Tractor", 14,
		"tractorOld", 14,
	//Class 6: _Very_ powerful (Single rotor choppers)
	"Truck", 6,
	"Ikarus_base", 6,
	//Class 5: Powerful (APCs)
	"Wheeled_APC", 5,
		"BTR40_MG_base_EP1", 5,
	"M113Ambul_Base", 5,
	//Class 4: Strong (HMMWVs)
	"HMMWV_Base", 4,
	"BAF_Jackal2_BASE_D", 4,
	"LandRover_Base", 4,
	//Class 3: Civilian strong (SUVs, beefy pickups)
	"hilux1_civil_1_open", 3,
	"hilux1_civil_3_open_EP1", 3,
	"Offroad_DSHKM_base", 3,
	"SUV_Base_EP1", 3,
	"ArmoredSUV_Base_PMC", 3,
	//Class 2: Civilian medium (Compacts, small pickups)
	"datsun1_civil_1_open", 2,
	"Pickup_PK_Base", 2,
	"UAZ_Base", 2,
	"SkodaBase", 2,
	"Lada_base", 2,
	"S1203_TK_CIV_EP1", 2,
	"VWGolf", 2,
	"Volha_TK_CIV_Base_EP1", 2,
	//Class 1: Can't tow shit
	"ATV_Base_EP1", 1,
	//Class 0: AAAAAAHAHAHAHAHA!
	"Motorcycle", 0,
	//Defaults: Cannot tow.
	"LandVehicle", -1,
	"Air", -1,
	"Ship", -1
];
//Objects that can lift. Format "<classname>", "<lifting class>"
ttl_canLift = [
	"Ka137_Base_PMC", 0,
	"CSJ_GyroC", 0,
	"CSJ_GyroP", 0,
	"pook_H13_base", 1,
	"AH6_Base_EP1", 2,
	"Helicopter", 6,
	
	"CH47_Base_EP1", 7,
	"MV22", 7,
	"C130J_US_EP1", 7,
	"BAF_Merlin_HC3_D", 7,
	"AW159_Lynx_BAF", 7,
	
	"LandVehicle", -1,
	"Air", 0,
	"Ship", -1
];
//List of liftable/towable objects. Format "<classname>", "<weight class>". -1 disables.
ttl_weightClass = [
	//Class 0: Everything can tow/lift
	"Motorcycle", 0,
	"JetSkiYanahui_Yellow", 0,
	//Class 1: Very small, most things can tow/lift
	"ATV_Base_EP1", 1,
	"TowingTractor", 1,
	"Tractor", 1,
		"tractorOld", 1,
	"Boat", 1,
	"Ka137_Base_PMC", 1,
	"pook_H13_base", 1,
	"CSJ_GyroC", 1,			//Mozzie
	"CSJ_GyroP", 1,			//AutoGyro
	//Class 2: Small, most compact cars, small pickups
	"SkodaBase", 2,
		"datsun1_civil_1_open", 2,
	"Lada_base", 2,
	"S1203_TK_CIV_EP1", 2,
	"VWGolf", 2,
	"Volha_TK_CIV_Base_EP1", 2,
	"GNT_C185", 2,				//Cessna
	"UAZ_Base", 2,
	"SeaFox", 2,
	//Class 3: Medium, SUVs, heavy pickups
	"hilux1_civil_1_open", 3,
	"hilux1_civil_3_open_EP1", 3,
	"SUV_Base_EP1", 3,
	"Pickup_PK_Base", 3,
	"Offroad_DSHKM_base", 3,
	"Fishing_Boat", 3,
	"AH6_Base_EP1", 3,
	//Class 4: Heavy, armored cars, Trucks
	"ArmoredSUV_Base_PMC", 4,
	"HMMWV_Base", 4,
	"LandRover_Base", 4,
	"Ikarus", 4,
	"BAF_Jackal2_BASE_D", 4,
	"Truck", 4,
	//Class 5: Very heavy, large trucks and APCs
	"Wheeled_APC", 5,
	"M113_Base", 5,
	"Tracked_APC", 5,
	//Class 6: transport choppers
	"Helicopter", 6,
	//Class 7: Dual rotor choppers and large planes
	"CH47_Base_EP1", 7,
	"MV22", 7,
	"C130J", 7,
	"BAF_Merlin_HC3_D", 7,
	"AW159_Lynx_BAF", 7,
	//Defaults
	"Tank", 10,
	"LandVehicle", 0,
	"Air", -1,
	"Ship", -1
];

ttl_towRadius	= 30;		//Radius in meters within which towing works.
ttl_maxHookSpeed= 60;
ttl_mRefRate	= .25;		//How long to wait in seconds between attempts to add menu items.
ttl_canChain	= 0;		//Not implemented.
//This is the directory that TTL will look for its files in. Keep in mind that the function files are
//NOT prefixed if you move them around.
ttl_loc			= "scripts\TTL_fnc\";

diag_log text "TAHV_TTL: Settings initialized...";
