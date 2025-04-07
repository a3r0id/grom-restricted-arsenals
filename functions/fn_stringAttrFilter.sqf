/*
	File: GRRA_fnc_rolesMatch.sqf
	Author: Grom -> https://github.com/a3r0id
	Usage: [_definedRole] call GRRA_fnc_rolesMatch -> bool
    Description: Check if the player 
*/

params ["_definedRole", "_definedGroup"];
private ["_playerRole", "_playerGroup"];


// If vanilla (not CBA) roleDescription should be something like "Rifleman" or "Medic"
// If CBA, it should be something like "Rifleman@Tombstone" or "Medic@Tombstone"
_playerRole = roleDescription player;

// 
_playerGroup = str group player;

// callsign (vanilla)
_callsign = roleDescription player;
// CBA roleDescription format
if ('@' in _callsign) then {
	_callsign = (_callsign splitString '@')#0;
};
(_callsign == _definedRole)