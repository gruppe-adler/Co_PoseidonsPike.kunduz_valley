params ["_object"];

// global call
[_object, true, [0, 1, 1], 10, true, true] call ace_dragging_fnc_setCarryable;
diag_log format ["added carry to %1", _object];