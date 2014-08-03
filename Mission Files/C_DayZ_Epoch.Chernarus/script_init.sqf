waitUntil {!isNil ("PVDZ_plr_LoginRecord")};
if (!isDedicated) then {
	execVM (SCRIPT_LOCATION + "ServPoint\service_point.sqf");
	//_nil = [] execVM "custom\VehicleKeyChanger\VehicleKeyChanger_init.sqf";
};

execVM (SCRIPT_LOCATION + "DynamicWeatherEffects.sqf");		//Start Dynamic Weather
execVM (SCRIPT_LOCATION + "TTL_fnc\TTL_Init.sqf");			//Tiered Towing and Lifting
execVM (SCRIPT_LOCATION + "skaronametags.sqf");
execVM "DZAI_Client\dzai_initclient.sqf";
RUN (SCRIPT_LOCATION + "RandomLoadout.sqf");

//##UID Based Custom Spawn Locations##
p2_newspawn = compile preprocessFileLineNumbers (SCRIPT_LOCATION + "CustomSpawns.sqf");
if (dayzPlayerLogin2 select 2) then
{
    player spawn p2_newspawn;
};

execVM (SCRIPT_LOCATION + "Custom_selfactions.sqf");
