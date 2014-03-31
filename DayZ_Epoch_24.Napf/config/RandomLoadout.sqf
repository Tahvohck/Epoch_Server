//Random loadouts version one, true random.
//Author: E. Richardson (Tahvohck@gmail.com)
//Date: 2014-03-29
//Pub key: N/a
private ["_weaponRand","_numBandages","_numFood","_numDrinks","_screwedOnMedSupplies","_luckyMechanic","_luckyDigger","_luckySeer"];

//pack
_posPacks = ["DZ_Patrol_Pack_EP1", "DZ_Assault_Pack_EP1","DZ_Czech_Vest_Puch","DZ_TerminalPack_EP1"];
DefaultBackpack = _posPacks select floor random count _posPacks;

//Items
_mags = [];
_numbandages = (floor random 5) + 2; 	//Can have between 2-6 bandages.
_screwedOnMedSupplies = ((random floor 5) == 0);	//unless of course they're screwed on meds. (1 in 5 chance)
if (!_screwedOnMedSupplies) then {
	for [{_i=0},{_i<_numbandages},{_i=_i+1}] do {
		_mags set [count _mags, "ItemBandage"];
	};
	_mags = _mags + ["ItemPainkiller","ItemMorphine"];
};
_numFood = (floor random 3) + 1;	//1-3 food
_posFood = ["FoodCanFrankBeans","FoodCanBakedBeans","FoodCanSardines","FoodCanPasta"];
for [{_i=0},{_i<_numFood},{_i=_i+1}] do {
	_mags set [count _mags, (_posFood select floor random count _posFood)];
};
_numDrinks = (floor random 3) + 1;	//1-3 drinks
for [{_i=0},{_i<_numDrinks},{_i=_i+1}] do {
	_isbottle = ((floor random 5) == 0);		//1 in 5 chance of water bottle.
	_superiorDrink = ((floor random 3) != 0);	//2 in 3 chance of Coke
	if (_isbottle) then {
		_mags = _mags + ["ItemWaterbottle"];
	}
	else{
		if (_superiorDrink) then {
			_mags = _mags + ["ItemSodaCoke"];
		}
		else{
			_mags = _mags + ["ItemSodaPepsi"];
		};
	};
};

DefaultMagazines = _mags;

//Tools
_luckyMechanic = ((floor random 20) == 0);
_luckyDigger = ((floor random 50) == 0);
_luckySeer = ((floor random 100) == 0);
_wepsAndTools = ["MeleeHatchet_DZE", "ItemFlashlightRed"];
if (_luckyMechanic) then {_wepsAndTools = _wepsAndTools + ["ItemToolbox","ItemCrowbar"]};
if (_luckyDigger) then {_wepsAndTools = _wepsAndTools + ["ItemEtool"]};
if (_luckySeer) then {_wepsAndTools = _wepsAndTools + ["NVGoggles"]};
