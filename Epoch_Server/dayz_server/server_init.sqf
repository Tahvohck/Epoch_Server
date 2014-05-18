//Server Bootup
diag_log text "SERVER STATUS: Booting DZE server code."
//Compile vehicle configs
call compile preprocessFileLineNumbers "\z\addons\dayz_server\missions\DayZ_Epoch_24.Napf\dynamic_vehicle.sqf";				
// Add trader citys
_nil = [] execVM "\z\addons\dayz_server\missions\DayZ_Epoch_24.Napf\mission.sqf";
if (isNil "sm_done") then {
	_serverMonitor = 	[] execVM "\z\addons\dayz_code\system\server_monitor.sqf"};

waitUntil {!isNil "sm_done"};

//Launch modules
diag_log text "SERVER STATUS: Boot done. Launching server-side modules."
[] ExecVM "\z\addons\dayz_server\WAI\init.sqf";