private ["_maxRange","_humanitycheck","_humanity","_skaroTag","_cursorTarget","_bandit","_hero","_color","_string","_targetControl","_untrustworthy"];
//Created by Skaronator - http://www.skaronator.com - Version 1.3
Waituntil{!isNull player};
disableSerialization;


_display = uiNamespace getVariable 'DAYZ_GUI_display';
_maxRange = 5; // Max. Range from the Target // Default: 5 meter
_humanitycheck = true; //true = Bandit: Red / Untrustworthy: Orange / Hero: Blue / Survivor: White <<<>>> false = always white (POSSIBLE VALUES: true // false)
_bandit = -5000; //Player Humanity for a Bandit
_untrustworthy = 1000; //Player Humanity for an untrustworthy player
_hero = 5000; //Player Humanity for a Hero

/*---------------------------------------------------------------------------------------------*/
//Other Stuff do not change!
_humanity = 2500; //Don't change this! It's only a failsave if getVariable failed
_targetControl = _display displayCtrl 1199;
_string = "";
dayz_humanitytarget = "";

 
while {true} do {
	_humanityTarget = cursorTarget;

	if (!isNull _humanityTarget and isPlayer _humanityTarget and alive _humanityTarget) then {
		_distance = (player distance _humanityTarget);
		if (_distance <= _maxRange) then {
			_size = (1-(floor(_distance/5)*0.1)) max 0.1;
			_humanity = _humanityTarget getVariable ["humanity",0];
			_color = "color='#ffffff'";
				if (_humanitycheck) then {
					if(_humanity > _hero) then {
					_color = "color='#3333ff'"}; // Hero - Blue
					if(_humanity < _untrustworthy) then {
						_color = "color='#ff9900'"}; // Untrustworthy - Orange
					if(_humanity < _bandit) then {
						_color = "color='#ff0000'"};  // Bandit - Red
				};
			_string = format["<t %2 align='center' size='%3'>%1</t>",(name _humanityTarget),_color,_size];
		} else {
			_string = "";
		};
	};


	// update gui if changed
	if (dayz_humanitytarget != _string) then {
			_targetControl ctrlSetStructuredText (parseText _string);
			dayz_humanitytarget = _string;
	};

 
sleep 0.5;
};
 