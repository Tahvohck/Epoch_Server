#define OPEN +"<t font='LucidaConsoleB' "+

#define BIG "size='1.1' "+
#define SML "size='0.8' "+

#define LFT "align='left'  "+
#define RGT "align='right' "+
#define CEN "align='center' "+

#define WHT "color='#FFFFFF' "+
#define RED "color='#FF5555' "+
#define GRN "color='#33FF33' "+
#define BLU "color='#5555FF' "+
#define YEL "color='#FFBF00' "+

_time = time;
_hoursR = floor (_time / 3600);
_minutesR = round ((_time % 3600) / 60);
_hours = format[" %1", _hoursR];
_minutes = if (_minutesR > 9) then [{format["%1",_minutesR]},{format["0%1",_minutesR]}];

hintSilent parseText format[""
	OPEN BIG CEN RED ">Highway to Hell</t><br/>"
	+"<br/>"
	OPEN SML LFT YEL ">Day: </t>" OPEN SML LFT WHT ">%1</t>"
	OPEN SML RGT YEL ">Humanity: </t>" OPEN SML RGT WHT ">%2</t><br/>"
	OPEN SML LFT YEL ">Blood: </t>" OPEN SML LFT WHT ">%3%4</t>"
	OPEN SML RGT YEL ">Players: </t>" OPEN SML RGT WHT ">%5</t><br/>"
	+"<br/>"
	OPEN SML LFT YEL ">Zeds Killed: </t>" OPEN SML RGT WHT ">%6</t><br/>"
	OPEN SML LFT YEL ">Bandits Killed: </t>" OPEN SML RGT WHT ">%7</t><br/>"
	OPEN SML LFT YEL ">Murders: </t>" OPEN SML RGT WHT ">%8</t><br/>"
	OPEN SML LFT YEL ">Headshots: </t>" OPEN SML RGT WHT ">%9</t><br/>"
	+"<br/>"
	OPEN SML CEN GRN ">%10</t>" OPEN SML CEN WHT ">  [FPS: %11]</t><br/>"
	OPEN SML CEN RED ">http://HtHDayz.enjin.com</t><br/>"
	OPEN SML CEN YEL ">Server uptime </t>" OPEN SML CEN WHT "> %12:%13</t><br/>",
	//Variables
	dayz_Survived, player getVariable['humanity', 0],
	floor (r_player_blood / 120), "%", count playableUnits,
	player getVariable['zombieKills', 0],
	player getVariable['banditKills', 0],
	player getVariable['humanKills', 0],
	player getVariable['headShots', 0],
	dayz_PreviousTown, round diag_fps,
	_hours, _minutes];