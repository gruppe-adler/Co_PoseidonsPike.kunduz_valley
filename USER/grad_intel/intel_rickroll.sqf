// execute locally

params ["_monitor"];

if (_monitor distance player > 100) exitWith {};

grad_fps = 1;

[{
	params ["_args", "_handle"];
	_args params ["_monitor"];

	if (grad_fps < 25) then {
		grad_fps = grad_fps + 1;
	} else {
		grad_fps = 1;
	};

	_monitor setObjectTexture [0, "user\grad_intel\rickroll\frame" + str grad_fps + ".paa"];

}, 1/25, [_monitor]] call CBA_fnc_addPerFramehandler;