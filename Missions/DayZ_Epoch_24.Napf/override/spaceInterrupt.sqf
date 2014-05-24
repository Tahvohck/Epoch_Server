#include "\z\addons\dayz_code\actions\dayz_spaceInterrupt.sqf";
#define DIK_F3 0x3D
#define DIK_END 0xCF
_HKInjectionLoc = SCRIPT_LOCATION + "Hotkeys\";

if (_dikCode == DIK_F3 || _DIKcode == DIK_END) then {
	execVM (_HKInjectionLoc + "StatMon.sqf");
	_handled = true;
};

_handled 