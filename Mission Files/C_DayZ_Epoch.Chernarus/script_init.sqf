if (!isDedicated) then {
	execVM (SCRIPT_LOCATION + "service_point.sqf");
	//_nil = [] execVM "custom\VehicleKeyChanger\VehicleKeyChanger_init.sqf";
};

execVM (SCRIPT_LOCATION + "DynamicWeatherEffects.sqf");		//Start Dynamic Weather
execVM (SCRIPT_LOCATION + "TTL_fnc\TTL_Init.sqf");			//Tiered Towing and Lifting
execVM (SCRIPT_LOCATION + "skaronametags.sqf");
RUN (SCRIPT_LOCATION + "RandomLoadout.sqf");
