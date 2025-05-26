/*

	main function, add to any vehicle in 3den

	[this] call grad_vehicleHealing_fnc_addVehicleHeal;

*/


params ["_vehicle"];

if (!isServer) exitWith {};


[{
	params ["_args", "_handle"];
	_args params ["_vehicle"];

	private _pilot = driver _vehicle;

	// pilot needs to be onboard
	if (isNull _pilot) exitWith {};

	// if cargo is injured, heal
	{
		if (_x call ACE_medical_ai_fnc_isInjured) exitWith {
			[_pilot, _x] call grad_vehicleHealing_fnc_healingLogic;
		};
	} forEach (allPlayers select {objectParent _x == _vehicle});

}, 1, [_vehicle]] call CBA_fnc_addPerFrameHandler;
