/*
	File: fn_initPlayer.sqf
	Author: Grom -> https://github.com/a3r0id
	Usage: (postInit) GRRA_fnc_initPlayer;
*/

if (!hasInterface) exitWith {};

// Global flag to determine if we should use the vanilla arsenal or ace arsenal
GRRA_USE_VANILLA_ARSENAL = false;

// hashmap of arsenal objects defined by classname
GRRA_CLASSES_MAP = createhashmapfromarray[];

// hashmap of arsenal objects defined by variable
GRRA_VARS_MAP = createhashmapfromarray[];

_fnc_createOrAddArsenal = {
	params["_logicModule"];
	private["_classNameOrVariable", "_globalVariable", "_gVarCopy"];

	// Get the $Items variable from the logic object
	private _items = _logicModule getVariable["Items", []];

	// If the string contains the file:// prefix, we can assume it's a file path or a list of file paths.
	// This can be used by mission makers to define a list of items in a separate file and even chain multiple files together.
	if ("file://" in _items) then {
		_items = [_items] call GRRA_fnc_fileStringToArray
	} else {
		_items = [_items] call GRRA_fnc_strToArray;
	};

	// get the $Owner variable (className or variable name of the arsenal vehicle) from the logic object
	_classNameOrVariable = _logicModule getVariable "Owner";

	// default to GRRA_CLASSES_MAP as className usage will be more common, id assume.
	_globalVariable = "GRRA_CLASSES_MAP";

	// if the variable is not nil, then we can assume it's a variable name and not a classname 
	if !(isNil _classNameOrVariable) then {
		_globalVariable = "GRRA_VARS_MAP";
	};

	// get the current global variable (either GRRA_CLASSES_MAP or GRRA_VARS_MAP)
	_gVarCopy = missionNamespace getVariable _globalVariable;

	// check if the class/var name is already in the hashmap
	if (count(_gVarCopy getOrDefault[_classNameOrVariable, []]) == 0) then {
		// if not, add it as well as the items
		_gVarCopy set[_classNameOrVariable, _items];
	} else {
		// if it is, add the items to the existing array
		_gVarCopy set[_classNameOrVariable, (_gVarCopy get _classNameOrVariable) + _items];
	};

	// Overwrite the global variable
	missionNamespace setVariable[_globalVariable, _gVarCopy];
};

{
	// check if the module is a BaseArsenal, and if the side matche the player's side
	if (typeOf _x == "GRRA_ModuleBaseArsenal") then {
		if !([_x getVariable "Side"] call GRRA_fnc_sidesMatch) then {
			continue
		};
		[_x] call _fnc_createOrAddArsenal;
	};

	// check if the module is a RoleRestrictedArsenal, and if the side and role match the player's side and role
	if (typeOf _x == "GRRA_ModuleRoleRestrictedArsenal") then {

		// Check if the player matches the SteamID whitelist - if so, add the arsenal automatically - this is good for admins or mission makers while testing
		// Note: I've added a small change to the whitelist logic to ensure that users can still use roleDescription/side as limiting factors,
		// but ultimately, "Player" (steamID) is still the most potent factor and will override all other factors. - Grom		
		if ([_x getVariable "Player"] call GRRA_fnc_playerUIDMatch) then {
			[_x] call _fnc_createOrAddArsenal;
			continue;
		};

		// Check if the player matches the Role whitelist and the Side whitelist
		if (((_x getVariable "Role" in roleDescription player) || _x getVariable "Group" in str group player) && ([_x getVariable "Side"] call GRRA_fnc_sidesMatch)) then {
			[_x] call _fnc_createOrAddArsenal;
			continue;
		};
	};

	// Check if the module is an AceArsenalOverride, and if so, set the global variable to true
	if (typeOf _x == "GRRA_AceArsenalOverride") then {
		GRRA_USE_VANILLA_ARSENAL = true;
	};
}
forEach allMissionObjects "Logic";

// Arsenals to be initialized on a className
{
	[
		_x,
		"init",
		{
			_thisClass = typeOf(_this select 0);
			[_this select 0] call GRRA_fnc_cleanArsenalBox;
			if (GRRA_USE_VANILLA_ARSENAL) then {
				[_this select 0, GRRA_CLASSES_MAP get _thisClass] call GRRA_fnc_addItemsVanillaArsenal;
			} else {
				[_this select 0, GRRA_CLASSES_MAP get _thisClass, false] call ace_arsenal_fnc_initBox;
			};
		},
		true,
		[],
		true
	] call CBA_fnc_addClassEventHandler;
}
forEach GRRA_CLASSES_MAP;

// Arsenals to be attached to a specific variable
{
	_arsenalBox = missionNamespace getVariable _x;
	[missionNamespace getVariable _x] call GRRA_fnc_cleanArsenalBox;
	if (GRRA_USE_VANILLA_ARSENAL) then {
		[_arsenalBox, GRRA_VARS_MAP get _x] call GRRA_fnc_addItemsVanillaArsenal;
	} else {
		[_arsenalBox, GRRA_VARS_MAP get _x, false] call ace_arsenal_fnc_initBox;
	};
}
forEach GRRA_VARS_MAP;