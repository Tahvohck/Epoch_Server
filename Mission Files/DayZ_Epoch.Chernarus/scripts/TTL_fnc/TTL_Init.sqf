ttl_inited	= false;	//For hot restarts. Leave this alone.
#define WHITE	"'#FFFFFF'"
#define YELLOW	"'#FFFF00'"
#define RED		"'#FF0000'"
#define VERSION "1.1 DEV"

if (!isNil "ttl_TowOp") then {
	player removeAction ttl_TowOp;
	player removeAction ttl_LiftOp;
	player removeAction ttl_DropOp;
	player removeAction ttl_QuickDetach;
	player removeAction ttl_SelectOp;
	player removeAction ttl_CancelOp;
};
#include "TTL_Settings.sqf";

if (isNil "ttl_canTow") then {ttl_canTow = ["LandVehicle", -1, "Air", -1, "Ship", -1]};
if (isNil "ttl_canLift") then {ttl_canLift = ["LandVehicle", -1, "Air", -1, "Ship", -1]};
if (isNil "ttl_weightClass") then {ttl_weightClass = ["LandVehicle", 0, "Air", 0, "Ship", 0]};

//###########################
//## Code Below this Point ##
//###########################
ttl_TowOp		= -1;	ttl_UntowOp		= -1; //
ttl_LiftOp		= -1;	ttl_DropOp		= -1; //
ttl_SelectOp	= -1;	ttl_CancelOp	= -1; //
ttl_QuickDetach	= -1; //
ttl_AllIDS		= [];

ttl_selObject		=	objNull;	//
ttl_selObjWeight	=	-1;			//

_lastVehIn	= objNull;
_lastTarget	= objNull;
_cursType	= "";
_cursName	= "";
_cursTowAbl	= -1;
_cursWeight	= -1;
_showDist	= -1;
_liftAbl	= -1;
_liftNearest= false;

_nearObject = objNull;
_selNearObj	= objNull;


//###############
//## Functions ##
//###############
ttl_gCorClass = {
	_askedFor 	= typeOf (_this select 0);
	_findIn		= _this select 1;
	_PC	= "";	//Parent Class. Holder for the most specific class found.
	_SCC = -1;	//Searched Corresponding Class
	if (!isNull (_this select 0)) then {
		for [{_i = 0}, {_i < count _findIn}, {_i = _i + 2}] do {
			if (_askedFor isKindOf (_findIn select _i)) then {
				//Specificity walk: If _PC has not been set, set. If has been, set if currently set Class is not
				//a subtype of the currently selected class (would get less specific then)
				if ((_PC == "") || !(_PC isKindOf (_findIn select _i))) then {
					_PC = _findIn select _i;
					_SCC = _findIn select (_i + 1)};
			};
		};
	};
	_SCC
};
ttl_carMon = compile preprocessFileLineNumbers (ttl_loc+"carry_monitor.sqf");

sleep ttl_mRefRate * 5;
ttl_inited = true;
diag_log text ("TAHV_TTL: TTL "+VERSION+" init success. Starting...");
//########################
//## Begin monitor loop ##
//########################
while {ttl_inited} do {
	_currVeh	= vehicle player;
	if (_currVeh == player) then {
	//Player outside of vehicle
		//Purge inside actions/data
		if (!isNull _lastVehIn) then {
			_lastVehIn removeAction ttl_QuickDetach;ttl_QuickDetach = -1;
			_lastVehIn removeAction ttl_LiftOp;		ttl_LiftOp = -1;
			_lastVehIn removeAction ttl_DropOp;		ttl_DropOp = -1;
			_lastVehIn = objNull;
			_liftAbl = -1;
		};
		_cursTarg = cursorTarget;
		//Recalc values if target doesn't match last target, remove actions from last target.
		if (_cursTarg != _lastTarget) then {
			_cursType	= typeOf _cursTarg;
			_cursName	= getText (configFile >> "CfgVehicles" >> _cursType >> "displayName");
			_cursTowAbl	= [_cursTarg, ttl_canTow] call ttl_gCorClass;
			_cursWeight	= [_cursTarg, ttl_WeightClass] call ttl_gCorClass;
			_showDist	= sizeOf typeOf cursorTarget / 2;
			//bound checks
			if (_showDist < 6) then {_showDist = 6};
			if (_showDist > 17) then {_showDist = 17};
			//remove all actions relating to the last vehicle
			player removeAction ttl_TowOp;		ttl_TowOp = -1;
			player removeAction ttl_UntowOp;	ttl_UntowOp = -1;
			player removeAction ttl_SelectOp;	ttl_SelectOp = -1;
		};
		_dist = player distance _cursTarg;
		
		//Target is towable and in range.
		if (_dist <= _showDist && _cursWeight != -1) then {
			//Action not assigned, target not towed.
			if (ttl_selectOp == -1 && !(_cursTarg getVariable["beingTowed",false]) && _cursTarg != ttl_selObject) then {
				_title = format["<t color="+YELLOW+">Tow %1...</t>", _cursName];
				ttl_selectOp = player addAction [_title, ttl_loc+"TargetCtrl.sqf",[_cursTarg], 0];
			};
			//Action not assigned, target towed.
			if (ttl_UntowOp == -1 && _cursTarg getVariable ["beingTowed", false]) then {
				_title = format["<t color="+YELLOW+">Untow %1</t>", _cursName];
				ttl_UntowOp = player addAction [_title,ttl_loc+"detach.sqf",[_cursTarg],3.1];
			};
		};
		//Target can tow, is in range, and there is an object selected for towing (that is not the target).
		if (_dist <= _showDist && _cursTowAbl != -1 && !isNull ttl_selObject && ttl_selObject != _cursTarg) then {
			//Action not assigned, target not towed.
			if (ttl_TowOp == -1 && !(_cursTarg getVariable["beingTowed",false])) then {
				_title = format["<t color="+YELLOW+">... to %1</t>", _cursName];
				ttl_TowOp = player addAction [_title,ttl_loc+"Tow.sqf", [ttl_selObject, _cursTarg],3.2];
			};
		};
		
		if (_dist > _showDist) then {
			player removeAction ttl_TowOp;		ttl_TowOp = -1;
			player removeAction ttl_UntowOp;	ttl_UntowOp = -1;
			player removeAction ttl_SelectOp;	ttl_SelectOp = -1;
		};
		
		_lastTarget = _cursTarg;
	}else{
	//Player inside of vehicle
		//Purge outside actions, prep inside data
		if (isNull _lastVehIn) then {
			player removeAction ttl_TowOp;		ttl_TowOp = -1;
			player removeAction ttl_UntowOp;	ttl_UntowOp = -1;
			player removeAction ttl_SelectOp;	ttl_SelectOp = -1;
			_lastVehIn = _currVeh;
			_liftAbl = [_currVeh, ttl_canLift] call ttl_gCorClass;
		};
		_beingTowed = _currVeh getVariable["beingTowed", false];
		_towing		= _currVeh getVariable["isTowing", false];
		
		//Only do these if the player is driving.
		if (driver _currVeh == player) then {
			//Quick detach if being towed.
			if (_beingTowed && ttl_QuickDetach == -1) then {
				_beingTowed = true;
				_title = format["<t color="+RED+">Quick detach</t>"];
				ttl_QuickDetach = _currVeh addAction [_title,ttl_loc+"Internaldetach.sqf",[],0, false, false];
			};
			player globalChat format["%1", _towing];
			//If towing and haven't added QD or Drop actions, add.
			if (_towing && (ttl_DropOp + ttl_QuickDetach) == -2) then {
				player globalChat "QD";
				//Same effect, but different names in the scroll menu if we're lifting instead of towing.
				if (_liftAbl != -1) then {
					_liftName = _currVeh getVariable ["TowedName", ""];
					_title = format["<t color="+YELLOW+">Drop %1</t>", _liftName];
					ttl_DropOp = _currVeh addAction [_title,ttl_loc+"Internaldetach.sqf",[], 3, false, false];
				}else{
					_priority = 0;
					_title = "<t color="+RED+">Quick detach</t>";
					ttl_QuickDetach = _currVeh addAction [_title,ttl_loc+"Internaldetach.sqf",[], 0, false, false];
				};
			};
			//Remove QD and drop options if not towing or being towed.
			if (!(_beingTowed || _towing) && (ttl_DropOp + ttl_QuickDetach) != -2) then {
				_beingTowed = false;
				_towing = false;
				_currVeh removeAction ttl_QuickDetach;	ttl_QuickDetach = -1;
				_currVeh removeAction ttl_DropOp;	ttl_DropOp = -1;
			};
			
			if !(_beingTowed || _towing) then {
				_height = getPosATL _currVeh select 2;
				if (_height >= ttl_minLiftHeight && _height <= ttl_maxLiftHeight) then {
					//Only bother with these if we have an object selected
					if (!isNull ttl_selObject) then {
						_selectedDist = _currVeh distance ttl_selObject;
						//If lifting in nearest mode but the selected object is in range, remove option.
						if (_liftNearest && _selectedDist <= ttl_maxLiftHeight) then {
							_currVeh removeAction ttl_LiftOp;	ttl_LiftOp = -1;};
						//If not lifting in nearest mode and selected object is out of range, remove option.
						if (!_liftNearest && _selectedDist > ttl_maxLiftHeight) then {
							_currVeh removeAction ttl_LiftOp;	ttl_LiftOp = -1;};
							
						//If an object is selected and in range.
						if (ttl_LiftOp == -1 && !isNull ttl_selObject && _selectedDist <= ttl_maxLiftHeight) then {
							_liftNearest = false;
							_targName	= getText (configFile >> "CfgVehicles" >> typeOf ttl_selObject >> "displayName");
							_title = format["<t color="+YELLOW+">Lift %1 (Guided)</t>", _targName];
							ttl_LiftOp = _currVeh addAction [_title,ttl_loc+"Lift.sqf",[ttl_selObject], 3, false, false];
						};
					};
					_nears = nearestObjects [_currVeh, ["LandVehicle", "Ship", "Air"], ttl_maxLiftHeight];
					if (count _nears > 1) then { 
						_nearObject = _nears select 1;
					}else{
						_nearObject = objNull;
					};
					_nearIsLiftable = ([_nearObject, ttl_weightClass] call ttl_gCorClass) != -1;
					if (_nearIsLiftable) then {
						//Tricky. If the nearest is liftable, it does not equal the selected nearest, and we _are_ in nearest lift mode.
						if (_nearIsLiftable && _selNearObj != _nearObject && _liftNearest) then {
							_currVeh removeAction ttl_LiftOp;	ttl_LiftOp = -1;};
						//If the nearest object is in range, we're moving slow enough, and it's liftable.
						if (ttl_LiftOp == -1 && _nearIsLiftable && speed _currVeh < ttl_maxHookSpeed) then {
							_liftNearest = true;
							_selNearObj = _nearObject;
							_targName	= getText (configFile >> "CfgVehicles" >> typeOf _nearObject >> "displayName");
							_title = format["<t color="+YELLOW+">Lift %1</t>", _targName];
							ttl_LiftOp = _currVeh addAction [_title,ttl_loc+"Lift.sqf",[_nearObject], 3, false, false];
						};
					}else{
						//If the nearest object is not liftable but we are in nearest lift mode, there is nothing in range.
						if (_liftNearest) then {
							_currVeh removeAction ttl_LiftOp;	ttl_LiftOp = -1;};
					};
				}else{
				//Outisde of tow height
					_currVeh removeAction ttl_LiftOp;	ttl_LiftOp = -1;
				};
			};
		}else{
		//Not the driver, remove options.
			if (ttl_QuickDetach + ttl_LiftOp + ttl_DropOp != -1) then {
				_lastVehIn removeAction ttl_QuickDetach;ttl_QuickDetach = -1;
				_lastVehIn removeAction ttl_LiftOp;		ttl_LiftOp = -1;
				_lastVehIn removeAction ttl_DropOp;		ttl_DropOp = -1;
			};
		};
	};
	
	ttl_AllIDs = [ttl_TowOp,ttl_UntowOp,ttl_QuickDetach,ttl_LiftOp,ttl_DropOp,ttl_SelectOp,ttl_CancelOp];
	sleep ttl_mRefRate;
};
