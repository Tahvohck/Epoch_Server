#define RUN call compile preprocessFileLineNumbers
startLoadingScreen ["","RscDisplayLoadCustom"];
cutText ["","BLACK OUT"];
enableSaving [false, false];

//REALLY IMPORTANT VALUES
dayzHiveRequest = [];
initialized = false;
dayz_previousID = 0;

#include "config\MAPDATA.sqf";

//disable greeting menu 
player setVariable ["BIS_noCoreConversations", true];
//disable radio messages to be heard and shown in the left lower corner of the screen
enableRadio false;
// May prevent "how are you civillian?" messages from NPC
enableSentences false;

RUN "config\settings.sqf";

//Load in compiled functions
//Initilize the Variables (IMPORTANT: Must happen very early)
RUN "\z\addons\dayz_code\init\variables.sqf";
progressLoadingScreen 0.1;
//Initilize the publicVariable event handlers
RUN "\z\addons\dayz_code\init\publicEH.sqf";
progressLoadingScreen 0.2;
//Functions used by CLIENT for medical
RUN "\z\addons\dayz_code\medical\setup_functions_med.sqf";
progressLoadingScreen 0.4;
//Compile regular functions
RUN "\z\addons\dayz_code\init\compiles.sqf";
RUN "override\custcompiles.sqf";
progressLoadingScreen 0.5;
//Compile trader configs
RUN "server_traders.sqf";
progressLoadingScreen 1.0;

"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";

if (isServer) then {
	RUN "\z\addons\dayz_server\server_init.sqf";
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
//#include "\z\addons\dayz_code\system\REsec.sqf"
#include "\z\addons\dayz_code\system\BIS_Effects\init.sqf"

#include "script_init.sqf"

setViewDistance 3500;
if (!isDedicated) then {
	spawn {sleep 15; endLoadingScreen; diag_log text "[TRACE] Forcing loading screen to close."}
}
