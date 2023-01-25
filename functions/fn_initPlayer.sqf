/*
	File: fn_initPlayer.sqf
	Author: Grom -> https://github.com/a3r0id
	Usage: (postInit) GRRA_fnc_initPlayer;
*/

if (isServer && !hasInterface) exitWith {};

systemChat format ["GRRA: %1", "Initializing player"];

// hashmap of arsenal objects defined by classname
_arsenalClasses    = createhashmapfromarray[];
/*
	[
		["B_supplyCrate_F", ["ToolKit", ...]],
		["ACE_medicalSupplyCrate_advanced", ["MediKit", ...]]
	]
*/

// hashmap of arsenal objects defined by variable
_arsenalObjectVars = createhashmapfromarray[];
/*
	[
		["BOX_VAR_ENGINEER", ["ToolKit", ...]],
		["BOX_VAR_MEDICAL", ["MediKit", ...]]
	]
*/

{
	if (typeOf _x == "GRRA_ModuleBaseArsenal") then {
		if !([_x getVariable "Side"] call GRRA_fnc_sidesMatch) then {continue};
		if (isNil (_x getVariable "Owner")) then {
			// is className, hopefully...
			if (count (_arsenalClasses getOrDefault [_x getVariable "Owner", []]) == 0) then {
				_arsenalClasses set [_x getVariable "Owner", _x getVariable "Items"];
			} else {
				_arsenalClasses set [_x getVariable "Owner", _arsenalClasses get (_x getVariable "Owner") + (_x getVariable "Items")];
			};
		} else {
			// is variable
			if (count (_arsenalObjectVars getOrDefault [_x getVariable "Owner", []]) == 0) then {
				_arsenalObjectVars set [_x getVariable "Owner", _x getVariable "Items"];
			} else {
				_arsenalObjectVars set [_x getVariable "Owner", _arsenalObjectVars get (_x getVariable "Owner") + (_x getVariable "Items")];
			};
		};
	};
	if (typeOf _x == "GRRA_ModuleRoleRestrictedArsenal") then {
		if !([_x getVariable "Role"] call GRRA_fnc_rolesMatch) then {continue};
		if !([_x getVariable "Side"] call GRRA_fnc_sidesMatch) then {continue};
		if (isNil (_x getVariable "Owner")) then {
			// is className, hopefully...
			if (count (_arsenalClasses getOrDefault [_x getVariable "Owner", []]) == 0) then {
				_arsenalClasses set [_x getVariable "Owner", _x getVariable "Items"];
			} else {
				_arsenalClasses set [_x getVariable "Owner", _arsenalClasses get (_x getVariable "Owner") + (_x getVariable "Items")];
			};
		} else {
			// is variable
			if (count (_arsenalObjectVars getOrDefault [_x getVariable "Owner", []]) == 0) then {
				_arsenalObjectVars set [_x getVariable "Owner", _x getVariable "Items"];
			} else {
				_arsenalObjectVars set [_x getVariable "Owner", _arsenalObjectVars get (_x getVariable "Owner") + (_x getVariable "Items")];
			};
		};
	};
} forEach allMissionObjects "Logic";

missionNamespace setVariable ["GRRA_arsenalClasses", _arsenalClasses];


// Arsenals to be initialized by a className
{
	[
		_x,
		"init",
		{ 
			[_arsenalBox] call GRRA_fnc_cleanArsenalBox;
			[_this select 0, [(missionNamespace getVariable "GRRA_arsenalClasses") get (typeOf (_this select 0))] call GRRA_fnc_strToArray, false] call ace_arsenal_fnc_initBox;
		},
		true,
		[],
		true
	] call CBA_fnc_addClassEventHandler;
} forEach _arsenalClasses;

// Arsenals to be attached to a specific variable
{	
	_arsenalBox = missionNamespace getVariable _x;
	[_arsenalBox] call GRRA_fnc_cleanArsenalBox;
	[_arsenalBox, [_arsenalObjectVars get _x] call GRRA_fnc_strToArray, false] call ace_arsenal_fnc_initBox;
} forEach _arsenalObjectVars;



