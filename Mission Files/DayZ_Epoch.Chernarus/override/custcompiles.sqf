//#include "\z\addons\dayz_code\init\compiles.sqf"
#define OVERRIDE(FILE) compile preprocessFileLineNumbers ("override\" + FILE##);

fnc_usec_selfActions = OVERRIDE("fn_selfActions.sqf")
dayz_spaceInterrupt = OVERRIDE("spaceInterrupt.sqf")

if (!isDedicated) then {
	player_build			= compile preprocessFileLineNumbers "custom\snap_build\player_build.sqf";
	player_buildControls	= compile preprocessFileLineNumbers "custom\snap_build\player_buildControls.sqf";
	snap_object				= compile preprocessFileLineNumbers "custom\snap_build\snap_object.sqf";
};