_SAPre = "SelfActions\";
_refreshPeriod = 0.25;

_a_plr_selfBB = -1;
_l_selfBBLoc = (SCRIPT_LOCATION + _SAPre + "player_selfbloodbag.sqf");

while {1==1} do
{
	_mags = magazines player;
	_vehicle = vehicle player;
	_isPZombie = player isKindOf "PZombie_VB";
	_inVehicle = (_vehicle != player);
	_onLadder =	(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
	_canDo = (!r_drag_sqf and !r_player_unconscious and !_onLadder);
	
	_hasBloodBag = "ItemBloodbag" in _mags;
	
	// Krixes Self Bloodbag
	if((speed player <= 1) && _hasBloodBag && _canDo && (r_player_blood < 12000)) then {
		if (_a_plr_selfBB < 0) then {
			_a_plr_selfBB = player addAction[("<t color=""#c70000"">" + ("Self Bloodbag") +"</t>"),_l_selfBBLoc,"",5,false,true,"", ""];
		};
	} else {
		player removeAction _a_plr_selfBB;
		_a_plr_selfBB = -1;
	};
	
	sleep _refreshPeriod;
};
