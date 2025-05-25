params ["_computer"];

if (!(_computer getVariable ["GRAD_intel_upload_done", false])) then {
	_computer setObjectTexture ["monitor", "data\aol.paa"];
};

[ 
 _computer, 
 "Upload Intel", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
 "_this distance _target < 3 && !(_target getVariable ['GRAD_intel_upload_done', false]) &&
 [_this, 'FlashDisk'] call bIs_fnc_hasitem", 
 "_caller  distance _target < 3", 
 { params ["_target"];
	["Starting upload...", 1, [1,1,1,1], true] call CBA_fnc_notify;
	private _uploadsound = playSound3D [getMissionPath "USER\sounds\upload.ogg", player, true, getPosASL player, 10];
	_target setVariable ["grad_uploadsound", _uploadsound];

 }, 
 {  [] spawn {
			for "_i" from 1 to 2 do { 
				playSound3D [getMissionPath "USER\sounds\" + selectRandom ["keypad_1", "keypad_2", "keypad_3"] + ".ogg", player, true, getPosASL player, 10];
				sleep (0.1 + random 0.05);
		 	};
		};
		true
 }, 
 {
	params ["_target"];
	_target setVariable ['GRAD_intel_upload_done', true, true];
	["Intel upload finished.", 1, [1,1,1,1], true] call CBA_fnc_notify;

	["missionControl_curatorInfo", [player, "intelupload", "complete"]] call CBA_fnc_globalEvent;

	[_target, "USER\grad_intel\intel_rickroll.sqf"] remoteExec ["BIS_fnc_execVM", 0, true];

	playSound3D [getMissionPath "USER\sounds\rickroll.ogg", _target, true, getPosASL _target, 1]; 
},
 { 
	params ["_target"];
	private _sound = _target getVariable ["grad_uploadsound", -1];
	stopSound _sound;

	["missionControl_curatorInfo", [player, "intelupload", "aborted"]] call CBA_fnc_globalEvent;
	
	["Aborted upload", 1, [1,1,1,1], true] call CBA_fnc_notify; }, 
 [], 10, nil, false, false 
] call BIS_fnc_holdActionAdd;
