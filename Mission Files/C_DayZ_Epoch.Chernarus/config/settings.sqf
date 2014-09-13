// DayZ Epoch config
SCRIPT_LOCATION = "custom\";
// Spawn
spawnShoremode = 1; // Default = 1 (on shore)
spawnArea= 1500;			// Default = 1500
dayz_paraSpawn = true;

// AI spawn
dayz_maxLocalZombies = 30;	// Default = 30 
dayz_maxAnimals = 5; // Default: 8
dayz_tameDogs = true;


// Assorted Map settings
dayz_fullMoonNights = false;
DZE_requireplot = 0;
DZE_BuildOnRoads = true;	// Default: False
DZE_MissionLootTable = true;

//Vehicles
MaxVehicleLimit = 200;				// Default: 50
MaxDynamicDebris = 250;				// Default: 100
DynamicVehicleDamageLow = 0;		// Default: 0
DynamicVehicleDamageHigh = 75;		// Default: 100
DynamicVehicleFuelLow = 0;			// Default: 0
DynamicVehicleFuelHigh = 65;		// Default: 100
dayz_sellDistance_vehicle = 20;
dayz_sellDistance_boat = 30;
dayz_sellDistance_air = 40;
DZE_TRADER_SPAWNMODE = true; //Vehicles bought with traders will parachute in instead of just spawning on the ground.
DZE_vehicleAmmo = 0; 
	//Default = 0, Supposed to control ammo on spawn, broken.

//Loadout
DefaultMagazines = ["ItemBandage","ItemBandage","ItemBandage","ItemBandage",
					"ItemPainkiller","ItemMorphine","ItemSodaCoke","FoodCanFrankBeans"]; 
DefaultWeapons = ["MeleeFlashlightRed","MeleeHatchet_DZE"]; 
DefaultBackpack = "DZ_Patrol_Pack_EP1"; 
DefaultBackpackWeapon = "";

//Unorganized
DZE_BackpackGuard = false; //Default = True, deletes backpack contents if logging out or losing connection beside another player if set to true.
DZE_BuildingLimit = 150; //Default = 150, decides how many objects can be built on the server before allowing any others to be built. Change value for more buildings.

//Events
EpochEvents = 
[["any","any","any","any",30,"crash_spawner_ANIM"],
["any","any","any","any",0,"crash_spawner_ANIM"],
["any","any","any","any",15,"supply_drop"]];