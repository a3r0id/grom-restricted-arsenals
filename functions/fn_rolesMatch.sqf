/*
	File: GRRA_fnc_rolesMatch.sqf
	Author: Grom -> https://github.com/a3r0id
	Usage: [_definedRole] call GRRA_fnc_rolesMatch -> bool
*/

params ["_definedRole"];
// callsign (vanilla)
_callsign = roleDescription player;
// CBA roleDescription format
if ('@' in _callsign) then {
	_callsign = (_callsign splitString '@')#0;
};
(_callsign == _definedRole)