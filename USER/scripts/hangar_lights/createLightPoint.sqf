params ["_position"];

private _light = "#lightpoint" createVehicleLocal _position;

// 2. Make the flare visible
_light setLightUseFlare        true;
_light setLightFlareSize       2;
_light setLightFlareMaxDistance 10;

// 3. Set up the light itself
_light setLightColor           [1,1,1];
_light setLightAmbient         [0.5,0.5,0.5];

// 4. Configure attenuation for a 2.5 m fall-off (5 m diameter)
_light setLightAttenuation [0, 2, 4, 4, 0, 9, 10];

_light setLightBrightness 1.5;