 // add healing in vehicles
["Air", "init", {
	params [["_vehicle", objNull]];

	diag_log format ["added vehicle heal to %1", _vehicle];
	[_vehicle] call grad_vehiclehealing_fnc_addVehicleHeal;

}, true, [], true] call CBA_fnc_addClassEventHandler;