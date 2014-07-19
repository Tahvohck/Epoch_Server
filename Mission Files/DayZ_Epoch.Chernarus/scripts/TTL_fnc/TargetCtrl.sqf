//Usage: [Target]
//If target is objNull, cancels selection
_ID = "";
_target = "";
if (count _this > 1) then {
	_ID		= _this select 2;
	_target	= _this select 3 select 0;
}else{
	_target = objNull;
};
//Code
if (!isNull _target) then {
	//Remove, just in case they selected without cancelling previous target
	player removeAction ttl_CancelOp;
	ttl_CancelOp = -1;
	ttl_selObject = _target;
	ttl_selObjWeight = [ttl_selObject, ttl_WeightClass] call ttl_gCorClass;
	
	_title = format["<t color='#FFFFFF'>Cancel towing %1</t>",
						getText (configFile >> "CfgVehicles" >> typeOf _target >> "displayName")];
	ttl_CancelOp = player addAction [_title, ""+ttl_loc+"TargetCtrl.sqf", [objNull], 3.1];
	player removeAction ttl_SelectOp;
	ttl_SelectOp = -1;
}else{
	ttl_selObject = objNull;
	ttl_selObjWeight = -1;
	player removeAction ttl_CancelOp;
	player removeAction ttl_TowOp;
	ttl_CancelOp = -1;
	ttl_TowOp = -1;
};