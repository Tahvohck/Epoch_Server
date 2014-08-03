#include "\z\addons\dayz_code\actions\dayz_spaceInterrupt.sqf";
#define DIK_F3 0x3D
#define DIK_END 0xCF
_HKInjectionLoc = SCRIPT_LOCATION + "Hotkeys\";

if (_dikCode == DIK_F3 || _dikCode == DIK_END) then {
	execVM (_HKInjectionLoc + "StatMon.sqf");
	_handled = true;
};

//SNAP_PRO
if ((_dikCode == 0x21 && (!_alt && !_ctrl)) || (_dikCode in actionKeys "User6")) then {
	DZE_F = true;
};
//E_SNAP_PRO
_handled 