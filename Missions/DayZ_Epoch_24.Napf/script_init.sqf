if (isServer) then {
	
};

if (!isDedicated) then {
	execVM "scripts\service_point.sqf";
	_nil = [] execVM "custom\VehicleKeyChanger\VehicleKeyChanger_init.sqf";
};

execVM "scripts\DynamicWeatherEffects.sqf";		//Start Dynamic Weather
execVM "R3F_ARTY_AND_LOG\init.sqf";				//R3F Artillery and Logistics
execVM "scripts\skaronametags.sqf";
call compile preprocessFileLineNumbers "config\RandomLoadout.sqf";

setViewDistance 2500;
