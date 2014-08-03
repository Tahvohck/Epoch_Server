execVM (SCRIPT_LOCATION + "DynamicWeatherEffects.sqf");		//Start Dynamic Weather


if (!isDedicated) then {
	diag_log text "[TRACE][SI] Waiting for player record.";
	waitUntil {!isNil ("PVDZE_plr_LoginRecord")};
	diag_log text "[TRACE][SI] Player record found.";
	execVM (SCRIPT_LOCATION + "ServPoint\service_point.sqf");
	execVM (SCRIPT_LOCATION + "TTL_fnc\TTL_Init.sqf");			//Tiered Towing and Lifting
	execVM (SCRIPT_LOCATION + "skaronametags.sqf");
	execVM "DZAI_Client\dzai_initclient.sqf";
	RUN (SCRIPT_LOCATION + "RandomLoadout.sqf");
	//_nil = [] execVM "custom\VehicleKeyChanger\VehicleKeyChanger_init.sqf";
	//##UID Based Custom Spawn Locations##
	if (dayzPlayerLogin2 select 2) then
	{
		execVM (SCRIPT_LOCATION + "CustomSpawns.sqf");
	};
	
	execVM (SCRIPT_LOCATION + "Custom_selfactions.sqf");
};



