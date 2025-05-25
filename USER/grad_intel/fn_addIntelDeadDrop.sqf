params ["_object"];


[ 
 _object, 
 "Search Object", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", 
 "_this distance _target < 3 && player != (_this getVariable ['BIS_fnc_moduleRemoteControl_owner', objNull])", 
 "_caller  distance _target < 3", 
 { ["Searching...", 1, [1,1,1,1], true] call CBA_fnc_notify; }, 
 {  
		true
 }, 
 {
	params ["_target"];
	if (_target getVariable ['GRAD_intel_found', false]) then {
		"This has been searched before, its empty" call CBA_fnc_notify;
	} else {
		if (_target getVariable ["GRAD_intel_placed", false]) then {
			if (player canAdd "FlashDisk") then {
				player addItem "FlashDisk";
			} else {
				"Item_Flashdisk" createVehicle position player;
			};
			_target setVariable ['GRAD_intel_found', true, true];
			["I found an USB stick, interesting!", 1, [1,1,1,1], true] call CBA_fnc_notify;
		} else {
			["Its empty, I think the courier was not here yet.", 1, [1,1,1,1], true] call CBA_fnc_notify;
		};
	};
	["GRAD_intel_deaddrop_searched", []] call CBA_fnc_globalEvent;
	
},
 { ["Aborted search", 1, [1,1,1,1], true] call CBA_fnc_notify; }, 
 [], 10, nil, false, false 
] call BIS_fnc_holdActionAdd;




[ 
 _object, 
 "Place Intel", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", 
 "_this distance _target < 3 && player == (_this getVariable ['BIS_fnc_moduleRemoteControl_owner', objNull])", 
 "_caller  distance _target < 3", 
 { ["Placing...", 1, [1,1,1,1], true] call CBA_fnc_notify; }, 
 {  
		true
 }, 
 {
	params ["_target"];
	if (!(_target getVariable ["GRAD_intel_placed", false])) then {
		_target setVariable ["GRAD_intel_placed", true, true];
		["Intel placed!", 1, [1,1,1,1], true] call CBA_fnc_notify;
	} else {
		["Intel already placed!", 1, [1,1,1,1], true] call CBA_fnc_notify;
	};
},
 { ["Aborted placing", 1, [1,1,1,1], true] call CBA_fnc_notify; }, 
 [], 2, nil, false, false 
] call BIS_fnc_holdActionAdd;