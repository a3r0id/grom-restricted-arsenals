/*
	File: fn_playerUIDMatch.sqf
	Author: gumbekk -> https://github.com/gumbekk
	Usage: [_definedUID] call GRRA_fnc_playerUIDMatch -> bool
*/

params ["_definedUID"];
// playerUID
_UID = getPlayerUID player;

(_UID == _definedUID)