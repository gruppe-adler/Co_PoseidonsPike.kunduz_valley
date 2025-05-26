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
		params ["_objects", "_groups", "_identifier"];

		{
            _x hideObjectGlobal false;
        } forEach _objects;

		if (_identifier == "binhoden_reinforcements") then {
			[_objects] spawn {
				params ["_objects"];
				{
					private _vehicle = _x;
					if (_vehicle isKindOf "UK3CB_TKP_O_Lada_Police") then {
						_vehicle enableAI "PATH";
						{ _x enableAI "PATH"; } forEach units group (driver _vehicle);
						if (random 2 > 1) then {
							[_vehicle] call UK3CB_Factions_Vehicles_Lada_fnc_siren; 
						};
						_vehicle setPilotLight true;
						_vehicle animateSource ['Beacon', 1];
						private _wp = (group driver _vehicle) addWaypoint [getMarkerPos "mrk_binhoden", 50];
						_wp setWaypointType "MOVE";
						_wp setWaypointSpeed "FULL";
						_wp setWaypointBehaviour "CARELESS";
					};
					sleep 1 + random 0.5;
				} forEach _objects;
			};
		};

	}, [_objects1, _groups1, _identifier]] call CBA_fnc_waitUntilAndExecute;

} forEach ["macrohard_enemies", "terrorcell_enemies", "binhoden_enemies", "binhoden_reinforcements"];