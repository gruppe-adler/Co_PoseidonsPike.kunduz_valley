// execute locally

params ["_monitor"];

if (_monitor distance player > 100) exitWith {};

grad_fps = 2;

[{
	params ["_args", "_handle"];
	_args params ["_monitor"];

	private _distance = _monitor distance player;

	if (_distance > 100) exitWith {};

	if (_distance > 200) exitWith {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};

	if (grad_fps < 25) then {
		grad_fps = grad_fps + 1;
	} else {
		grad_fps = 2;
	};

	_monitor setObjectTexture ["monitor", "user\grad_intel\rickroll\frame_" + str grad_fps + ".paa"];

}, 1/12, [_monitor]] call CBA_fnc_addPerFramehandler;