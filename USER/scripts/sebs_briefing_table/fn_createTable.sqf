/*
* Author: Seb, with optimisations by Leopard20
*
* This function creates a minified representation of a marker area on a table, both given as arguments. It
*
* Arguments:
* 0: Table on which to create the minified representation. if a minified representation already exists, it will be cleared before starting. <OBJECT>
* 1: AREA marker string representation (i.e "marker_0") <strinG>
* 2: Optional <NUMBER> (default: 20) - Terrain resolution (x*y resolution of terrain cubes). setting this too high will be VERY laggy.
* 4: Optional <NUMBER> (default: 1) - Scale multiplier. 3 = map is 3x the size of the table. Useful for spanning multiple tables.
* 4: Optional <BOOL> (default: true). Use terrain. if false then the map will be entirely flat. Just like the earth;)
* 5: Optional <BOOL> (default: true) - Create environment sounds tirgger:
* Create a trigger that disables envionmental sounds when the current unit comes near, and puts it back to its original state when the player leaves.
* This is because all the bushes that appear on the table will still play cricket sounds, buildings will play air conditoner hums etc.
* 6: Optional <NUMBER> (default: 0) - Offset Z height. if your map doesn't fit on your table quite right, use this to tweak how high the entire thing shows up.
*
* Return Value:
* NONE
*
* Example:
* TABLE OBJECT inIT:
* [this, "marker_0", 20, 1, true, true, 0] call sebs_briefing_table_fnc_createTable;
*
* SCRIPT call (Multiplayer & join in progress COMPATIBLE):
* [table, "marker_0", 20, 1, true, true, 0] remoteExec ["sebs_briefing_table_fnc_createTable", 0, table];
*
* NEVER EVER EVER REMOTexec from OBJECT inIT!
*
* Public: [No]
*/
if !(hasinterface) exitwith {};
params [
    "_table",
    "_marker",
    ["_terrainResolution", 20],
    ["_scaleMultiplier", 1],
    ["_useterrainHeight", true],
    ["_createTrigger", true],
    ["_manualZoffset", 0]
];

if (isnil "_table" || {
    isNull _table || {
        _marker == "" || {
            private _temp = createMarkerlocal [_marker, [0, 0, 0]];
            deleteMarkerlocal _temp;
            _temp != ""
        }
    }
}) exitwith {};

_table enableSimulation false;
_table call sebs_briefing_table_fnc_clearTable;
private _tableObjects = [];

private _bbr = 2 boundingBoxReal _table;
private _p1 = _bbr#0;
private _p2 = _bbr#1;
private _tableWidth = abs ((_p2#0) - (_p1#0));
private _tableLength = abs ((_p2#1) - (_p1#1));
private _tableHeight = abs ((_p2#2) - (_p1#2));

private _markerDir = markerDir _marker;
private _markerPos = getmarkerPos _marker;
private _markersize = getmarkersize _marker;
private _maxsize = _markersize#0 max _markersize#1;
// longest edge of marker
_marker setMarkersize [_maxsize, _maxsize];
// Marker must be square

private _tableDir = getDir _table;
private _tablesize = ((_tableWidth min _tableLength) / 2) * _scaleMultiplier * 0.9;
// Gets shortest edge of table. Why do I have to divide by 2???????????????
private _scale = _tablesize/_maxsize;
// fit longest edge of marker on table

private _squareDist = sqrt (2*_maxsize*_maxsize);
private _objects = (nearestTerrainObjects [_markerPos, [], _squareDist, false, true]) inAreaArray _marker;
// Terrian objects
_objects append ((_markerPos nearObjects ["Static", _squareDist]) inAreaArray _marker);
// Will pick up custom placed objects, but contains duplicates from above
_objects = _objects arrayintersect _objects;
// removes duplicates

private _dummy = "land_HelipadEmpty_F" createvehiclelocal _markerPos;
_markerPos set [2, (0 max getTerrainHeightASL _markerPos) + 1];
_dummy enableSimulation false;
_dummy setPosASL _markerPos;
_dummy setDir _markerDir;

private _zOffset = if (_useterrainHeight) then {
    private _minHeight = 100000;
    {
        _minHeight = _minHeight min (getPosASL _x)#2;
    } forEach _objects;
    (getPosASL _dummy#2) - _minHeight
} else {
    0
};
private _vectorDiff = [0, 0, _tableHeight/2 + (_zOffset * _scale) + 0.05 + _manualZoffset];
// neatly fit all the stuff on the top of the table

{
    private _model = (getmodelinfo _x)#1;
    if (_model != "" && !(isObjectHidden _x) && {
        (((boundingBoxReal _x)#2) * _scale * getobjectScale _x) > 0.005
    }) then {
        isnil {
            private _relCentre = _dummy worldToModel (ASLtoAGL getPosWorld _x);
            private _relVectDir = _dummy vectorworldToModel (vectorDir _x);
            private _relVectUp = _dummy vectorworldToModel (vectorUp _x);
            private _tableObj = createSimpleObject [_model, [0, 0, 0], true];
            private _scaledPos = _relCentre vectorMultiply _scale;
            private _newPos = if (_useterrainHeight) then {
                (_table modeltoWorldWorld (_scaledPos vectorAdd _vectorDiff))
            } else {
                _table modeltoWorldWorld (_scaledPos vectorAdd _vectorDiff)
            };
            _tableObj setPosWorld _newPos;
            _tableObj setvectorDirAndUp [_table vectorModelToWorld _relVectDir, _table vectorModelToWorld _relVectUp];
            _tableObj setobjectScale _scale * getobjectScale _x;
            _tableObjects pushBack _tableObj;
        };
    };
} forEach _objects;

private _step = 2/_terrainResolution;
private _dirandUp = [vectorDir _table, vectorUp _table];
for "_posX" from -1 to 1 step _step do {
    for "_posY" from -1 to 1 step _step do {
        isnil {
            private _tablePos = [_posX*_tablesize, _posY*_tablesize, 0];
            private _worldPos = (_dummy modeltoWorld (_tablePos vectorMultiply 1/_scale));
            // divide by scale to scale back up
            private _road = roadAt (_worldPos select [0, 2]);
            private _texture = if (!isNull _road) then {
                getRoadinfo _road select 3
            } else {
                surfacetexture _worldPos
            };
            private _normal = vectorUp _table;
            private _cubesize = _step * _tablesize;
            if (_useterrainHeight) then {
                private _normals = [];
                private _averagestep = _step/2;
                // Sample normals over cube area:
                for "_normalX" from -2*_averagestep to 2*_averagestep step _averagestep do {
                    for "_normalY" from -2*_averagestep to 2*_averagestep step _averagestep do {
                        private _checkPos = _worldPos vectorAdd [_normalX, _normalY];
                        _normals pushBack (surfaceNormal _checkPos);
                    };
                };
                {
                    _normal = _normal vectorAdd _x;
                } forEach _normals;
                // You don't need to average the normals for the normal to look good.
                // _normal = _normal vectorMultiply 1/count _normals;
                // I have no idea why.
                _normal = [_normal, _tableDir -_markerDir, 2] call BIS_fnc_rotateVector3D;
                // not sure why I have to do this.
                private _cos = abs (vectorUp _table vectorCos _normal);
                private _dynamicsize = 1.1/_cos;
                // scale cubes based on angle
                _cubesize = _cubesize * _dynamicsize;
                // _tablePos set [2, -(_worldPos#2 * _scale + _cubesize/(2*_cos) + 0.5)];
                // Z flip from worldpos. wtf?.
            } else {
                _tablePos set [2, -0.5 - _cubesize/2]
            };
            private _groundobject = createSimpleObject ["land_VR_Shape_01_cube_1m_F", [0, 0, 0], true];
            _groundobject enableSimulation false;
            _groundobject setPosASL (_table modeltoWorldWorld (_tablePos vectorAdd _vectorDiff));
            _groundobject setvectorDirAndUp _dirandUp;
            _groundobject setvectorUp _normal;
            for "_selection" from 0 to 6 do {
                _groundobject setobjectMaterial [_selection, "\a3\data_f\default.rvmat"];
                _groundobject setobjecttexture [_selection, _texture];
            };
            _groundobject setobjectScale _cubesize;
            _tableObjects pushBack _groundobject;
        };
    };
};

_table setVariable ["sebs_briefing_table_tableObjects", _tableObjects];
deletevehicle _dummy;

if (_createTrigger) then {
    _trg = createTrigger ["EmptyDetector", getPos _table, false];
    _trg settriggerArea [_tablesize + 15, _tablesize + 15, getDir _table, true];
    if (isnil {
        sebs_briefing_table_originalEnv
    }) then {
        sebs_briefing_table_originalEnv = environmentEnabled
    };
    _trg settriggerActivation ["NONE", "PRESENT", true];
    _trg settriggerStatements [
        "player inArea thistrigger",
        "enableEnvironment false",
        "enableEnvironment sebs_briefing_table_originalEnv"
    ];
    _trg settriggerInterval 1;
    _tableObjects pushBack _trg;
};

if !(_table getVariable ["seb_briefing_table_hasDeletedEH", false]) then {
    _table addEventHandler ["Deleted", {
        _table call sebs_briefing_table_fnc_clearTable;
    }];
    _table setVariable ["seb_briefing_table_hasDeletedEH", true];
};