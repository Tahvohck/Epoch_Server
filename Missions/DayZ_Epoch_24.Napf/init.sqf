startLoadingScreen ["","RscDisplayLoadCustom"];
cutText ["","BLACK OUT"];
enableSaving [false, false];

//REALLY IMPORTANT VALUES
dayZ_instance =	24;				//The instance
dayzHiveRequest = [];
initialized = false;
dayz_previousID = 0;

//disable greeting menu 
player setVariable ["BIS_noCoreConversations", true];
//disable radio messages to be heard and shown in the left lower corner of the screen
enableRadio false;
// May prevent "how are you civillian?" messages from NPC
enableSentences false;

call compile preprocessFileLineNumbers "config\settings.sqf";

//Load in compiled functions
//Initilize the Variables (IMPORTANT: Must happen very early)
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";
progressLoadingScreen 0.1;
//Initilize the publicVariable event handlers
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";
progressLoadingScreen 0.2;
//Functions used by CLIENT for medical
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";
progressLoadingScreen 0.4;
//Compile regular functions
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";
call compile preprocessFileLineNumbers "override\custcompiles.sqf";
progressLoadingScreen 0.5;
//Compile trader configs
call compile preprocessFileLineNumbers "server_traders.sqf";
progressLoadingScreen 1.0;

"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";

if (isServer) then {
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\missions\DayZ_Epoch_24.Napf\dynamic_vehicle.sqf";				
	//Compile vehicle configs
	
	// Add trader citys
	_nil = [] execVM "\z\addons\dayz_server\missions\DayZ_Epoch_24.Napf\mission.sqf";
	_serverMonitor = 	[] execVM "\z\addons\dayz_code\system\server_monitor.sqf";
};

if (!isDedicated) then {
	//Conduct map operations
	0 fadeSound 0;
	waitUntil {!isNil "dayz_loadScreenMsg"};
	dayz_loadScreenMsg = (localize "STR_AUTHENTICATING");
	
	//Run the player monitor
	_id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";	
	
	//Lights
	//[false,12] execVM "\z\addons\dayz_code\compile\local_lights_init.sqf";
};
#include "\z\addons\dayz_code\system\REsec.sqf"
#include "\z\addons\dayz_code\system\BIS_Effects\init.sqf"

#include "script_init.sqf"

setViewDistance 2500;
