params ["_unit"];

private _position = deaddrop getPos [0.1, getDir deaddrop-180];
_unit setVariable ["lambs_danger_disableAI", true, true];
(group _unit) setVariable ["lambs_danger_disableGroupAI", true, true];

private _home = getPosASL _unit;
_unit setVariable ["grad_unithome", _home, true];

// _unit setUnitPos "UP";
_unit forceWalk true;

private _wp = (group _unit) addWaypoint [AGLtoASL _position, -1];
_wp setWaypointType "MOVE";
_wp setWaypointSpeed "LIMITED";
_wp setWaypointBehaviour "CARELESS";


// start at the first waypoint immediately
(group _unit) setCurrentWaypoint [(group _unit), 0];

[{
    params ["_unit"];
    _unit distance deaddrop < 2
},{
    params ["_unit"];

    _unit doWatch deaddrop;
    (group _unit) setFormDir (_unit getDir deaddrop);

    [_unit] spawn {
        params ["_unit"];

        sleep 1;

        [_unit, "ace_gestures_point"] call ace_common_fnc_doGesture;
        deaddrop setVariable ["GRAD_intel_placed", true, true];

        sleep 2;

        _unit setUnitPos "UP";

        doStop _unit;
        private _home = _unit getVariable ["grad_unithome", [0,0,0]];
    
        private _wp = (group _unit) addWaypoint [_home, -1];
        _wp setWaypointType "MOVE";
        _wp setWaypointSpeed "LIMITED";
        _wp setWaypointBehaviour "CARELESS";
        _unit doFollow _unit;
        (group _unit) setCurrentWaypoint [(group _unit), 0];
    };
}, [_unit]] call CBA_fnc_waitUntilAndExecute;