#define GRRA_MOD_DESCRIPTION 3DEN module that allows creators to initialize an infinite amount of ACE arsenals restricted by player role and other attributes.
#define GRRA_MOD_LOGO 		 grra\data\grra.paa
#define GRRA_MOD_ICON        grra\data\grra_icon.paa
#define GRRA_MOD_AUTHOR 	 Grom
#define GRRA_MOD_NAME 	     Grom Restricted Arsenals

// #define GRRA_DEBUG 1 // Debug functions from a mission file
#ifdef GRRA_DEBUG
    // running from mission folder
    #define GRRA_FUNCTIONS_DIR functions
#else
    // running as mod
    #define GRRA_FUNCTIONS_DIR \GRRA\functions
#endif

class CfgPatches
{
	class GRRA
	{
		name=GRRA_MOD_NAME;
		author=GRRA_MOD_AUTHOR;
		logo=GRRA_MOD_LOGO;
		logoOver=GRRA_MOD_LOGO;
		tooltip=GRRA_MOD_DESCRIPTION;
		tooltipOwned=GRRA_MOD_DESCRIPTION;
		picture=GRRA_MOD_LOGO;
		url="https://github.com/a3r0id";
		units[] = {"GRRA_ModuleRoleRestrictedArsenal", "GRRA_ModuleBaseArsenal", "GRRA_AceArsenalOverride"};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F", "3DEN"};
	};
};

class CfgFactionClasses
{
	class NO_CATEGORY;
	class GRRA_Modules: NO_CATEGORY
	{
		displayName = GRRA_MOD_NAME;
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
			class Edit;				
			class Combo;				
			class Checkbox;				
			class CheckboxNumber;		
			class ModuleDescription;	
			class Units;				
		};

		class ModuleDescription
		{
			class AnyBrain;
		};
	};

	class GRRA_ModuleRoleRestrictedArsenal: Module_F
	{
		scope = 2;										       
		displayName = "Restricted Arsenal";				
		icon = GRRA_MOD_ICON;	    		
		category = "GRRA_Modules";
		function = "";                    						
		functionPriority = 1;				                    
		isGlobal = 1;						                   
		isTriggerActivated = 1;				                   
		isDisposable = 1;					                   
		is3DEN = 1;							                   
		curatorInfoType = "";                                

		class Attributes: AttributesBase
		{
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
				tooltip = "Array/comma-seperated values of items that the unit/s can use. Also accepts file/s; IE: 'file://path\to\file.sqf' or 'file://path\to\file.sqf//path\to\file2.sqf'.";
				// Default text for the input box:
				defaultValue = """[]"""; // Because this is an expression, one must have a string within a string to return a string
			};            
		};
	};

	class GRRA_ModuleBaseArsenal: Module_F
	{
		scope = 2;									
		displayName = "Base Arsenal";				
		icon = GRRA_MOD_ICON;
		category = "GRRA_Modules";

		function = "";
		functionPriority = 1;				
		isGlobal = 1;						
		isTriggerActivated = 1;				
		isDisposable = 1;					
		is3DEN = 1;							
		curatorInfoType = "";               

		class Attributes: AttributesBase
		{

			// Module-specific arguments:
			class Side: Combo
			{
				property = "GRRA_ModuleBaseArsenal_Side";				       
				displayName = "Side";			                                
				tooltip = "Side that has access to the base arsenal.";	        
				typeName = "NUMBER";							               
				defaultValue = "0";							                    

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
                defaultValue = """""";
            };

			class Items: Edit
			{
                property = "GRRA_ModuleBaseArsenal_Items";
				displayName = "Items";
				tooltip = "Array/comma-seperated values of items that the unit/s can use. Also accepts file/s; IE: 'file://path\to\file.sqf' or 'file://path\to\file.sqf//path\to\file2.sqf'.";
				defaultValue = """[]""";
			};            
		};
	};    

	class GRRA_AceArsenalOverride: Module_F
	{
		scope = 2;							    
		displayName = "Force Vanilla Arsenal";	
		icon = GRRA_MOD_ICON;			
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

#include "CfgFunctions.hpp"

class ctrlMenuStrip;
class display3DEN
{
	class Controls
	{
		class MenuStrip: ctrlMenuStrip
		{
			class Items
			{
				class Tools
				{
					items[] += {"GRRA_ArsenalEditor"};
				};
				class GRRA_ArsenalEditor
				{
					text    = "Arsenal Formatter";
					picture = GRRA_MOD_ICON;
					action  = "[] call GRRA_fnc_formatter;";
                    opensNewWindow = 1;
				};
			};
		};
	};
};
