#define DIK_F3 0x3D
#define DIK_END 0xCF
disableSerialization;
waitUntil {(dayz_preloadFinished && !isNull (findDisplay 46))};
diag_log text "TAHV: HotKey injection starting.";

if !isNil "TAHV_HKEventHandler" then {
	findDisplay 46 displayRemoveEventHandler ["KeyDown", TAHV_HKEventHandler]};
TAHV_HKLoc = SCRIPT_LOCATION + "Hotkeys\";

TAHV_HKParseKey = {
	private ["_DIKcode"];
	_handled	= false;
	_DIKcode	= _this select 1;
	_shiftState	= _this select 2;
	_ctrlState	= _this select 3;
	_altState	= _this select 4;
	if !(_DIKcode in [0x10,0x11,0x12,0x1E,0x1F,0x20,0x2C,0x2D,0x2E,0x1C,0x2A,0x38]) then {
		diag_log formatText["TAHV_HK: Debug. Key code was %1", _DIKcode]};
	
	if (_DIKcode == DIK_F3 || _DIKcode == DIK_END) then {
		execVM (TAHV_HKLoc + "StatMon.sqf");
		_handled = true};
	
	_handled
};

TAHV_HKEventHandler = findDisplay 46 displayAddEventHandler ["KeyDown", "_this call TAHV_HKParseKey"];