/*
    Turns on 12 lamps in four waves (3-at-once, 1 s delay).
*/

#define GRAD_HANGARLIGHTS_BASENAME  "grad_hangarlamp_"
#define GRAD_HANGARLIGHTS_COUNT     12
#define GRAD_HANGARLIGHTS_SOUNDS    ["light_on_1", "light_on_2", "light_on_3"]

if (!isServer) exitWith {};                                        // single-exec guard

private _lamps = [];
for "_i" from 1 to GRAD_HANGARLIGHTS_COUNT do
{
    private _varName = format ["%1%2", GRAD_HANGARLIGHTS_BASENAME, _i];          // e.g. "lamp7"
    private _lamp = missionNamespace getVariable _varName;
    if (!isNil "_lamp" && { !isNull _lamp }) then
    {
        _lamps pushBack _lamp;
    };
};

//—Process in chunks of 3
for "_i" from 0 to (count _lamps - 1) step 3 do
{
    private _batch = _lamps select [_i, 3];                         // up-to-3 lamps

    {
        _x enableSimulationGlobal true;

        [_x, selectRandom GRAD_HANGARLIGHTS_SOUNDS] remoteExec ["say3D", 0];
    } forEach _batch;

    sleep 1;                                                       // 1 s between waves
};
