//Usage: [Target action, Target]
_tAct	= objNull;
_ID		= -1;

//Allow for using this script without addAction.
if (typeName (_this select 0) == "STRING") then {
		_tAct	= _this select 0;
	} else {
		_ID		= _this select 2;
		_tAct	= _this select 3 select 0;
};
//Parameter check
if ("STRING" != typeName _tAct) then {
	_oldAct = _tAct;
	//_tAct = "cancel";
	diag_log text "TAHV_TTL: Had to default on select.";
	diag_log formatText["TAHV_TTL: Was originally [%1]::%2", typeName _oldAct, _oldAct];
};


//Code
switch (toLower _tAct) do {
	case "sel";
	case "select": {
		//Remove, just in case they selected without cancelling previous target
		player removeAction ttl_CancelOp;
		ttl_CancelOp = -1;
		ttl_selectedObject = _this select 3 select 1;
		_title = format["<t color='#FFFFFF'>Cancel towing %1</t>", getText (configFile >> "CfgVehicles" >> typeOf ttl_selectedObject >> "displayName")];
		ttl_CancelOp = player addAction [_title, ""+ttl_loc+"TargetCtrl.sqf", ["cancel"], 3.1];
		player removeAction ttl_SelectOp;
		ttl_SelectOp = -1;
	};
	case "cancel": {
		ttl_selectedObject = objNull;
		player removeAction ttl_CancelOp;
		player removeAction ttl_TowOp;
		ttl_CancelOp = -1;
		ttl_TowOp = -1;
	};
	default {diag_log _tAct}
};
