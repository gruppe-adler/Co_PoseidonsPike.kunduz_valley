if (!isServer) exitWith {};

// unhides layers and enables enemies
{
	private _identifier = _x;
	private _units = getMissionLayerEntities _identifier;
	_units params [["_objects1", []], ["_markers", []], ["_groups1", []]];

	{
		_x hideObjectGlobal true;
        _x disableAI "PATH";
        _x setVariable ["lambs_danger_disableAI", true, true];
        _x setVariable ["lambs_danger_disableGroupAI", true, true];
	} forEach _objects1;

	[{
		params ["_objects", "_groups", "_identifier"];
		missionNameSpace getVariable [_identifier, false]
	},{
		params ["_objects", "_groups"];

		{
            _x hideObjectGlobal false;
        } forEach _objects1;

	}, [_objects1, _groups1, _identifier]] call CBA_fnc_waitUntilAndExecute;

} forEach ["macrohard_enemies", "terrorcell_enemies", "binhoden_enemies"];