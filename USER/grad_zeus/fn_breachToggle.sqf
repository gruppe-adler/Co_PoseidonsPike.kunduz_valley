/* unlocks or locks doors in radius for breach mod */

params ["_position", "_lock"];

private _actionRadius = 7;

private _lockInt = if (_lock) then { 1 } else { 0 };
private _types = ["BUILDING", "HOUSE", "CHURCH", "CHAPEL", "BUNKER", "FORTRESS", "VIEW-TOWER", "LIGHTHOUSE", "FUELSTATION", "HOSPITAL", "TOURISM"];
private _amount = 0;

{ 
	for "_i" from 0 to (count (configfile >> "CfgVehicles" >> typeOf _x >> "UserActions")) do {
		_x setVariable [format ["bis_disabled_Door_%1", _i], _lockInt, true]
		_amount = _amount + 1;
	};
} forEach (nearestTerrainObjects [_position, _types, _actionRadius] + nearestObjects [_position, _types, _actionRadius]);

private _hint = str _amount + " doors UNLOCKED";
if (_lock) then {
	_hint = str _amount + " doors LOCKED";
};

_hint call CBA_fnc_notify;