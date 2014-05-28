//Server Bootup
diag_log text "SERVER STATUS: Booting DZE server code.";
//Compile vehicle configs
call compile preprocessFileLineNumbers "\z\addons\dayz_server\Vehicle_List.sqf";
// Add trader citys
_nil = [] execVM "\z\addons\dayz_server\missions\DayZ_Epoch_24.Napf\mission.sqf";
if (isNil "sm_done") then {
	_serverMonitor = 	[] execVM "\z\addons\dayz_code\system\server_monitor.sqf"};

waitUntil {!isNil "sm_done"};

//Load stored death records if any
PlayerDeaths = profileNamespace getVariable["StoredPDeaths", []];

//Override server functions as needed
diag_log text "SERVER STATUS: Overriding server functions as needed.";
#include "\z\addons\dayz_server\compile_override.sqf"

//Launch modules
diag_log text "SERVER STATUS: Launching server-side modules.";
ExecVM "\z\addons\dayz_server\WAI\init.sqf";
ExecVM "\z\addons\dayz_server\DZAI\init\dzai_initserver.sqf";