/* unlocks or locks doors in radius for breach mod */

params ["_position", "_lock"];

private _actionradius = 7;

private _lockint = if (_lock) then {
    1
} else {
    0
};
private _types = ["BUILDinG", "HOUSE", "CHURCH", "CHAPEL", "BUNKER", "forTRESS", "VIEW-toWER", "LIGHTHOUSE", "fuelSTATION", "HOSpiTAL", "toURISM"];
private _amount = 0;

{
    for "_i" from 0 to (count (configFile >> "Cfgvehicles" >> typeOf _x >> "Useractions")) do {
        _x setVariable [format ["bis_disabled_door_%1", _i], _lockint, true];
        _amount = _amount + 1;
    };
} forEach (nearestTerrainObjects [_position, _types, _actionradius] + nearestobjects [_position, _types, _actionradius]);

private _hint = str _amount + " doors UNlocked";
if (_lock) then {
    _hint = str _amount + " doors locked";
};

_hint call CBA_fnc_notify;