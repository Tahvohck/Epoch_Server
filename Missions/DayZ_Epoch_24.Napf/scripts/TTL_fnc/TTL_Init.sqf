ttl_inited	= false;	//For hot restarts. Leave this alone.
#define WHITE	"'#FFFFFF'"
#define YELLOW	"'#FFFF00'"
#define RED		"'#FF0000'"

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
ttl_TowOp		=	-1;	//
ttl_UntowOp		=	-1;	//
ttl_QuickDetach	=	-1; //
ttl_LiftOp		=	-1;	//
ttl_DropOp		=	-1;	//
ttl_SelectOp	=	-1;	//
ttl_CancelOp	=	-1;	//

ttl_selectedObject	=	objNull;	//
ttl_selectedObjWght	=	-1;			//

_lastVeh	= objNull;
_insideVeh	= objNull;
_cType		= "";
_cName		= "";
_targName	= "";
_nearObject = objNull;
_sNearObject= objNull;
_cTowAbl	= -1;
_liftAbl	= -1;
_cWeight	= -1;
_showDist	= 7;


//###############
//## Functions ##
//###############
ttl_gCorClass = {
	_askedFor 	= typeOf (_this select 0);
	_findIn		= _this select 1;
	_PC	= "";	//Parent Class. Holder for the most specific class found.
	_SCC = -1;	//Searched Corresponding Class
	for [{_i = 0}, {_i < count _findIn}, {_i = _i + 2}] do {
		if (_askedFor isKindOf (_findIn select _i)) then {
			//Specificity walk: If _PC has not been set, set. If has been, set if currently set Class is not
			//a subtype of the currently selected class (would get less specific then)
			if ((_PC == "") || !(_PC isKindOf (_findIn select _i))) then {
				_PC = _findIn select _i;
				_SCC = _findIn select (_i + 1)};
		};
	};
	_SCC
};

sleep ttl_mRefRate * 5;
ttl_inited = true;
diag_log text "TAHV_TTL: Init success. Starting...";
//########################
//## Begin monitor loop ##
//########################
while {ttl_inited} do {
	_currVeh	= vehicle player;
	if (_currVeh == player) then {
		//Purge inside actions
		if (!isNull _insideVeh) then {
			_insideVeh removeAction ttl_QuickDetach;
			_insideVeh removeAction ttl_LiftOp;
			_insideVeh removeAction ttl_DropOp;
			ttl_QuickDetach = -1;
			ttl_LiftOp = -1;
			ttl_DropOp = -1;
			_insideVeh = objNull;
			_liftAbl = -1;
		};
		//Outside of a vehicle
		_dist = player distance _lastVeh;
		_showDist = sizeOf typeOf cursorTarget / 2;
		if (_showDist < 4) then {_showDist = 4};
		if (_showDist < 7) then {_showDist = 7};
		if (cursorTarget != _lastVeh || _dist >= _showDist) then {
			if (isNull cursorTarget) then {_cType = "";};
			if (cursorTarget != _lastVeh) then {
				_lastVeh	= cursorTarget;
				_cType		= typeOf _lastVeh;
				_cName		= getText (configFile >> "CfgVehicles" >> _cType >> "displayName");
				_cTowAbl	= [_lastVeh, ttl_canTow] call ttl_gCorClass;
				_cWeight	= [_lastVeh, ttl_WeightClass] call ttl_gCorClass;
				_dist		= player distance _lastVeh;
				if (_cType != "") then {
					//diag_log formatText["[%1] %2 || Tow: %3 || Weight: %4", _cType, _cName, _cTowAbl, _cWeight];
				};
			};
			if ((ttl_TowOp + ttl_UntowOp + ttl_SelectOp) != -3) then {
				//remove all actions relating to the last vehicle
				player removeAction ttl_TowOp;
				player removeAction ttl_UntowOp;
				player removeAction ttl_SelectOp;
				ttl_TowOp = -1;
				ttl_UntowOp = -1;
				ttl_SelectOp = -1;
		};};
		if ((_cType isKindOf "Air" || _cType isKindOf "LandVehicle" || _cType isKindOf "Ship") && _dist < _showDist) then {
			if (ttl_selectOp == -1 && ttl_selectedObject != _lastVeh && _cWeight != -1  && !(_lastVeh getVariable ["beingTowed", false])) then {
				_title = format["<t color="+YELLOW+">Tow %1...</t>", _cName];
				ttl_selectOp = player addAction [_title, ttl_loc+"TargetCtrl.sqf",
												["sel", cursorTarget], 3];
			};
			if (ttl_UntowOp == -1 && _lastVeh getVariable ["beingTowed", false]) then {
				_title = format["<t color="+YELLOW+">Untow %1</t>", _cName];
				ttl_UntowOp = player addAction [_title,ttl_loc+"TowCtrl.sqf",
												["Untow", cursorTarget],3.1];
			};
			if (!isNull ttl_selectedObject && ttl_selectedObject != cursorTarget &&
				ttl_TowOp == -1 && _cTowAbl != -1) then {
				_title = format["<t color="+YELLOW+">... to %1</t>", _cName];
				ttl_TowOp = player addAction [_title,ttl_loc+"TowCtrl.sqf",
												["Tow", ttl_selectedObject, cursorTarget],3.2];
		};};
	} else {
		//Inside a vehicle
		_insideVeh	= _currVeh;
		if (_liftAbl == -1) then {
			_liftAbl	= [_insideVeh, ttl_canLift] call ttl_gCorClass;
			_targWeight	= [ttl_selectedObject, ttl_WeightClass] call ttl_gCorClass;
		};
		//Purge outside actions
		if ((ttl_TowOp + ttl_UntowOp + ttl_SelectOp) != -3) then {
			player removeAction ttl_TowOp;
			player removeAction ttl_UntowOp;
			player removeAction ttl_SelectOp;
			ttl_TowOp = -1;
			ttl_UntowOp = -1;
			ttl_SelectOp = -1;
		};
		//Quick detach
		if (_insideVeh getVariable ["beingTowed", false] && ttl_QuickDetach == -1) then {
				_title = format["<t color="+RED+">Quick detach</t>"];
				ttl_QuickDetach = _insideVeh addAction [_title,ttl_loc+"Quickdetach.sqf",
														[],	0, false, false];
		};
		
		if (!(_insideVeh getVariable ["isTowing", false])) then {
			if (getPosATL _insideVeh select 2 > 5 && getPosATL _insideVeh select 2 < ttl_towRadius) then {
				//Inside of tow height
				if (!isNull ttl_selectedObject && ttl_LiftOp == -1 && ttl_selectedObject distance _insideVeh < ttl_towRadius) then {
					//Guided tow: selected object in range.
					_targName	= getText (configFile >> "CfgVehicles" >> typeOf ttl_selectedObject >> "displayName");
					_title = format["<t color="+YELLOW+">Lift %1 (Guided)</t>", _targName];
					ttl_LiftOp = _insideVeh addAction [_title,ttl_loc+"LiftCtrl.sqf",
															["Lift", ttl_selectedObject, _insideVeh], 3, false, false];
				}else{
					//find nearest object, remove option if nearest object does not match object option
					_nearObject = nearestObjects [_insideVeh, ["LandVehicle", "Ship", "Air"], ttl_towRadius] select 1;
					if (!isNull _nearObject && _nearObject != _sNearObject) then {
						_insideVeh removeAction ttl_LiftOp;
						ttl_LiftOp = -1;
					};
					if (isNull _nearObject) then {
						_insideVeh removeAction ttl_LiftOp;
						ttl_LiftOp = -1;
					};
					if (!isNull _nearObject && ttl_LiftOp == -1) then {
						_targName	= getText (configFile >> "CfgVehicles" >> typeOf _nearObject >> "displayName");
						_sNearObject = _nearObject;
						_title = format["<t color="+YELLOW+">Lift %1</t>", _targName];
						ttl_LiftOp = _insideVeh addAction [_title,ttl_loc+"LiftCtrl.sqf",
																["Lift", _nearObject, _insideVeh], 3, false, false];
				}};
			}else{
				//Outside of tow heights, clear tow options
				_insideVeh removeAction ttl_LiftOp;
				ttl_LiftOp = -1;
			};
		}else{
			//Already towing/lifting something, handle drop options.
			if (typeOf _insideVeh isKindOf "Air") then {
				if (ttl_DropOp == -1) then {
					_liftName = _insideVeh getVariable ["TowedName", ""];
					_title = format["<t color="+YELLOW+">Drop %1</t>", _liftName];
					ttl_DropOp = _insideVeh addAction [_title,ttl_loc+"LiftCtrl.sqf",
															["Drop"], 3, false, false];
				};
			}else{
				if (ttl_QuickDetach == -1) then {
					_title = format["<t color="+RED+">Quick detach</t>"];
					ttl_QuickDetach = _insideVeh addAction [_title,ttl_loc+"Quickdetach.sqf",
															[],	0, false, false];
			}};
		};
	};
	
	sleep ttl_mRefRate;
};
