/*
	File: fn_initPlayer.sqf
	Author: Grom -> https://github.com/a3r0id
	Usage: (postInit) GRRA_fnc_initPlayer;
*/

if (isServer && !hasInterface) exitWith {};

systemChat format ["GRRA: %1", "Initializing player"];

// hashmap of arsenal objects defined by classname
GRRA_CLASSES_MAP    = createhashmapfromarray[];

// hashmap of arsenal objects defined by variable
GRRA_VARS_MAP       = createhashmapfromarray[];

fnc_createOrAddArsenal = {
	params ["_globalVariable", "_items", "_classNameOrVariable"];

	// get a copy of the global variable
	_gVarCopy = missionNamespace getVariable _globalVariable;

	// check if the class/var is already in the hashmap
	if (count (_gVarCopy getOrDefault [_classNameOrVariable, []]) == 0) then {
		// if not, add it as well as the items
		_gVarCopy set [_classNameOrVariable, _x getVariable "Items"];
	} else {
		// if it is, add the items to the existing array
		_gVarCopy set [_classNameOrVariable, (_gVarCopy get _classNameOrVariable) + _items];
	};	

	// Overwrite the global variable
	missionNamespace setVariable [_globalVariable, _gVarCopy];
};

{
	// check if the module is a BaseArsenal
	if (typeOf _x == "GRRA_ModuleBaseArsenal") then {
		if !([_x getVariable "Side"] call GRRA_fnc_sidesMatch) then {continue};
		if (isNil (_x getVariable "Owner")) then {
			// is className, hopefully...
			// check if the class is already in the hashmap
			if (count (GRRA_CLASSES_MAP getOrDefault [_x getVariable "Owner", []]) == 0) then {
				// if not, add it
				GRRA_CLASSES_MAP set [_x getVariable "Owner", _x getVariable "Items"];
			} else {
				// if it is, add the items to the existing array
				GRRA_CLASSES_MAP set [_x getVariable "Owner", (GRRA_CLASSES_MAP get (_x getVariable "Owner")) + (_x getVariable "Items")];
			};
		} else {
			// is variable
			// check if the class is already in the hashmap
			if (count (GRRA_VARS_MAP getOrDefault [_x getVariable "Owner", []]) == 0) then {
				// if not, add it
				GRRA_VARS_MAP set [_x getVariable "Owner", _x getVariable "Items"];
			} else {
				// if it is, add the items to the existing array
				GRRA_VARS_MAP set [_x getVariable "Owner", (GRRA_VARS_MAP get (_x getVariable "Owner")) + (_x getVariable "Items")];
			};
		};
	};

	// check if the module is a RoleRestrictedArsenal
	if (typeOf _x == "GRRA_ModuleRoleRestrictedArsenal") then {
		if !([_x getVariable "Role"] call GRRA_fnc_rolesMatch) then {continue};
		if !([_x getVariable "Side"] call GRRA_fnc_sidesMatch) then {continue};
		if (isNil (_x getVariable "Owner")) then {
			// is className, hopefully...
			if (count (GRRA_CLASSES_MAP getOrDefault [_x getVariable "Owner", []]) == 0) then {
				GRRA_CLASSES_MAP set [_x getVariable "Owner", _x getVariable "Items"];
			} else {
				GRRA_CLASSES_MAP set [_x getVariable "Owner", GRRA_CLASSES_MAP get (_x getVariable "Owner") + (_x getVariable "Items")];
			};
		} else {
			// is variable
			if (count (GRRA_VARS_MAP getOrDefault [_x getVariable "Owner", []]) == 0) then {
				GRRA_VARS_MAP set [_x getVariable "Owner", _x getVariable "Items"];
			} else {
				GRRA_VARS_MAP set [_x getVariable "Owner", GRRA_VARS_MAP get (_x getVariable "Owner") + (_x getVariable "Items")];
			};
		};
	};
} forEach allMissionObjects "Logic";

systemChat format ["GRRA: %1", "Arsenal classes: " + str(GRRA_CLASSES_MAP)];
missionNamespace setVariable ["GRRAGRRA_CLASSES_MAP", GRRA_CLASSES_MAP];

// Arsenals to be initialized by a className
{
	[
		_x,
		"init",
		{ 
			diag_log format ["[GRRA]: %1", "Initializing arsenal"];
			diag_log format ["[GRRA]: %1", missionNamespace getVariable "GRRAGRRA_CLASSES_MAP"];
			[_arsenalBox] call GRRA_fnc_cleanArsenalBox;
			[_this select 0, [(missionNamespace getVariable "GRRAGRRA_CLASSES_MAP") get (typeOf (_this select 0))] call GRRA_fnc_strToArray, false] call ace_arsenal_fnc_initBox;
		},
		true,
		[],
		true
	] call CBA_fnc_addClassEventHandler;
} forEach GRRA_CLASSES_MAP;

// Arsenals to be attached to a specific variable
{	
	_arsenalBox = missionNamespace getVariable _x;
	[_arsenalBox] call GRRA_fnc_cleanArsenalBox;
	[_arsenalBox, [GRRA_VARS_MAP get _x] call GRRA_fnc_strToArray, false] call ace_arsenal_fnc_initBox;
} forEach GRRA_VARS_MAP;



