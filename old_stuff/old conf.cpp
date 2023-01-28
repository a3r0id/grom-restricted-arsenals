#define MOD_DESCRIPTION 3DEN module that allows creators to initialize an infinite amount of ACE arsenals restricted by player role and other attributes.
#define MOD_LOGO 		grra\data\grra.paa
#define MOD_AUTHOR 		Grom
#define MOD_NAME 	    Grom Restricted Arsenals

// #define GRRA_DEBUG 1 // Debug functions from a mission file

class CfgPatches
{
	class GRRA
	{
		name=MOD_NAME;
		author=MOD_AUTHOR;
		logo=MOD_LOGO;
		logoOver=MOD_LOGO;
		tooltip=MOD_DESCRIPTION;
		tooltipOwned=MOD_DESCRIPTION;
		picture=MOD_LOGO;
		url="https://github.com/a3r0id";
		units[] = {"GRRA_ModuleRoleRestrictedArsenal"};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F"};
	};
};

class CfgFactionClasses
{
	class NO_CATEGORY;
	class GRRA_Modules: NO_CATEGORY
	{
		displayName = MOD_NAME;
	};
};

class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit;					// Default edit box (i.e. text input field)
			class Combo;				// Default combo box (i.e. drop-down menu)
			class Checkbox;				// Default checkbox (returned value is Boolean)
			class CheckboxNumber;		// Default checkbox (returned value is Number)
			class ModuleDescription;	// Module description
			class Units;				// Selection of units on which the module is applied
		};

		// Description base classes (for more information see below):
		class ModuleDescription
		{
			class AnyBrain;
		};
	};

	class GRRA_ModuleRoleRestrictedArsenal: Module_F
	{
		// Standard object definitions:
		scope = 2;										        // Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "Restricted Arsenal";						// Name displayed in the menu
		icon = "\GRRA\data\grra.paa";	    			// Map icon. Delete this entry to use the default icon.
		category = "GRRA_Modules";

		function = "";                    						// Name of function triggered once conditions are met
		functionPriority = 1;				                    // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		isGlobal = 1;						                    // 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isTriggerActivated = 1;				                    // 1 for module waiting until all synced triggers are activated
		isDisposable = 1;					                    // 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation won't work)
		is3DEN = 1;							                    // 1 to run init function in Eden Editor as well
		curatorInfoType = "";                                   // Menu displayed when the module is placed or double-clicked on by Zeus

		// Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
		class Attributes: AttributesBase
		{

			// Module-specific arguments:
			class Side: Combo
			{
				property = "GRRA_ModuleRoleRestrictedArsenal_Side";				// Unique property (use "<GRRA>_<moduleClass>_<attributeClass>" format to ensure that the name is unique)
				displayName = "Side";			                                // Argument label
				tooltip = "Side that can use the arsenal.";	                    // Tooltip description
				typeName = "NUMBER";							                // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "0";							                    // Default attribute value. Warning: This is an expression, and its returned value will be used (50 in this case).

				// Listbox items:
				class Values
				{
					class opt0	{ name = "ALL";	        value = 0; };
					class opt1	{ name = "BLUFOR";	    value = 1; };
                    class opt2	{ name = "OPFOR";	    value = 2; };
                    class opt3	{ name = "INDEPENDENT";	value = 3; };
                    class opt4	{ name = "CIVILIAN";	value = 4; };
				};
			};

            class Owner: Edit
            {
                property = "GRRA_ModuleRoleRestrictedArsenal_Owner";	
                displayName = "Owner";
                tooltip = "Variable or classname of the arsenal object.";
                // Default text for the input box:
                defaultValue = """"""; // Because this is an expression, one must have a string within a string to return a string
            };

			class Role: Edit
			{
                property = "GRRA_ModuleRoleRestrictedArsenal_Role";
				displayName = "Role";
				tooltip = "Role of the unit/s that can use the arsenal.";
				// Default text for the input box:
				defaultValue = """Alpha 1-1"""; // Because this is an expression, one must have a string within a string to return a string
			};

			class Items: Edit
			{
                property = "GRRA_ModuleRoleRestrictedArsenal_Items";
				displayName = "Items";
				tooltip = "Array/comma-seperated values of items that the unit/s can use.";
				// Default text for the input box:
				defaultValue = """[]"""; // Because this is an expression, one must have a string within a string to return a string
			};            
		};
	};

	class GRRA_ModuleBaseArsenal: Module_F
	{
		// Standard object definitions:
		scope = 2;										// Editor visibility; 2 will show it in the menu, 1 will hide it.
		displayName = "Base Arsenal";				// Name displayed in the menu
		icon = "\GRRA\data\grra.paa";	// Map icon. Delete this entry to use the default icon.
		category = "GRRA_Modules";

		function = "";// Name of function triggered once conditions are met
		functionPriority = 1;				// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		isGlobal = 1;						// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isTriggerActivated = 1;				// 1 for module waiting until all synced triggers are activated
		isDisposable = 1;					// 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation won't work)
		is3DEN = 1;							// 1 to run init function in Eden Editor as well
		curatorInfoType = "";               // Menu displayed when the module is placed or double-clicked on by Zeus

		// Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
		class Attributes: AttributesBase
		{

			// Module-specific arguments:
			class Side: Combo
			{
				property = "GRRA_ModuleBaseArsenal_Side";				        // Unique property (use "<GRRA>_<moduleClass>_<attributeClass>" format to ensure that the name is unique)
				displayName = "Side";			                                // Argument label
				tooltip = "Side that has access to the base arsenal.";	        // Tooltip description
				typeName = "NUMBER";							                // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "0";							                    // Default attribute value. Warning: This is an expression, and its returned value will be used (50 in this case).

				// Listbox items:
				class Values
				{
					class opt0	{ name = "ALL";	        value = 0; };
					class opt1	{ name = "BLUFOR";	    value = 1; };
                    class opt2	{ name = "OPFOR";	    value = 2; };
                    class opt3	{ name = "INDEPENDENT";	value = 3; };
                    class opt4	{ name = "CIVILIAN";	value = 4; };
				};
			};

            class Owner: Edit
            {
                property = "GRRA_ModuleBaseArsenal_Owner";	
                displayName = "Owner";
                tooltip = "Variable or classname of the arsenal object.";
                // Default text for the input box:
                defaultValue = """"""; // Because this is an expression, one must have a string within a string to return a string
            };

			class Items: Edit
			{
                property = "GRRA_ModuleBaseArsenal_Items";
				displayName = "Items";
				tooltip = "Array/comma-seperated values of items included in the base arsenal.";
				// Default text for the input box:
				defaultValue = """[]"""; // Because this is an expression, one must have a string within a string to return a string
			};            
		};
	};    

	class GRRA_AceArsenalOverride: Module_F
	{
		scope = 2;							    
		displayName = "Force Vanilla Arsenal";	
		icon = "\GRRA\data\grra.paa";			
		category = "GRRA_Modules";				
		function = "";							
		functionPriority = 1;					
		isGlobal = 1;							
		isTriggerActivated = 1;					
		isDisposable = 1;						
		is3DEN = 1;						
		curatorInfoType = "";               	
		class Attributes: AttributesBase {};
	};    	
};

#undef MOD_DESCRIPTION
#undef MOD_LOGO
#undef MOD_AUTHOR
#undef MOD_NAME

#include "CfgFunctions.hpp"