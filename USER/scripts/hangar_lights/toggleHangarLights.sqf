/*
    Turns on 12 lamps in four waves (3-at-once, 1 s delay).

    [] execvm "user\scripts\hangar_lights\toggleHangarLights.sqf";
*/

if (isServer) then {

    [] spawn {
        private _strength = 1;

        while {_strength < 6} do {
            {
                _x setHit [format["light_%1_hitpoint",_strength],0];
            } forEach [tentlamp_1, tentlamp_2, tentlamp_3];
            sleep 1;
            _strength = _strength + 1;
        };
    };

    sleep 15;

    [] spawn {
        
    #define GRAD_HANGARLIGHTS_COUNT     15
    #define GRAD_HANGARLIGHTS_BASENAME  "grad_hangarlamp_"
    #define GRAD_HANGARLIGHTS_SOUNDS    ["user\sounds\light_on_1.ogg", "user\sounds\light_on_2.ogg", "user\sounds\light_on_3.ogg"]

    private _lamps = [];
        for "_i" from 1 to GRAD_HANGARLIGHTS_COUNT do
        {
            private _varName = format ["%1%2", GRAD_HANGARLIGHTS_BASENAME, _i];          // e.g. "grad_hangarlamp_7"
            private _lamp = missionNamespace getVariable _varName;
            _lamps pushBack _lamp;
        };

        private _i = count _lamps - 1;

        while { _i >= 0 } do
        {
            // pick up to 3 lamps ending at _i
            private _batchSize = 3 min _i + 1;
            private _start     = _i - (_batchSize - 1);
            private _batch     = _lamps select [_start, _batchSize];

            {
                [[getPos _x], "user\scripts\hangar_lights\createLightPoint.sqf"]
                    remoteExec ["BIS_fnc_execvm", 0, true];

                playSound3D [getMissionPath selectRandom GRAD_HANGARLIGHTS_SOUNDS, _x, true, getPosASL _x, 5, 1, 300];
                sleep 0.05;
            } forEach _batch;

            _i = _i - 3;    // move to the next group of three
            sleep 3;
        };
    };

};
