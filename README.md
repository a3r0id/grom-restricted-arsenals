# Grom Restricted Arsenals (Alpha)
 A useful Arma 3 mod that allows creators to initialize an infinite amount of arsenals, restricted by player role and other attributes. 

![](https://steamuserimages-a.akamaihd.net/ugc/2013706124474735514/AF4EB4D2A638312DCAD98004F7BC15E969EDEAA0/?imw=637&imh=358&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=true)

### __Modules__

> To use a module, simply drop the module anywhere in your mission's map in 3den editor and double-click on it to configure. Modules can be found under the "Systems" category in 3den editor.

![](https://steamuserimages-a.akamaihd.net/ugc/2013706759566266819/D3728CD87EFA72EC6F1B99386BDA5C6C4D71B8B2/?imw=5000&imh=5000&ima=fit&impolicy=Letterbox&imcolor=#000000&letterbox=false)

--------

#### [1] Base Arsenal

> A basic, whitelisted arsenal that everyone can access. This module can also be restricted to a specific side, ie: `BLUFOR`. You can make make as many as needed, ie: one for each "side" (or team in a pvp gammode etc).

#### [2] Restricted Arsenal

> A whitelisted arsenal in which only certain players with a specific role can access, ie: `Machinegunner@anything` as well as a specific side, ie: `BLUFOR`.

--------

### __Utilities__

#### [1] Force Vanilla Arsenal

> Dropping this module into your mission will automatically convert all restricted arsenals into an Arma 3 virtual arsenal (vanilla arsenal). Amount has no effect, 1 is enough.

--------

### __Module attributes & settings__

> - `Side`: The side that can access this arsenal. Select "ANY" to allow all sides to access the arsenal.

> - `Owner`: The object/classname of objects that own/s this whitelisted arsenal. This can be the object's classname or a variable name. If the object is destroyed, the arsenal will be destroyed as well. *Keep in mind* that you may encounter issues if you try to combine an arsenal that is owned by a classname with an arsenal that is owned by a variable name. Otherwise, you can use the same variable name/classname for multiple arsenals which will combine them into one arsenal specific to the player's side/role. *It is reccomended* that you use a variable name if you only want one specific object to own the arsenal. Otherwise, if you want multiple objects of the same type to host an arsenal, use a classname.

> - `Role (Restricted arsenal only)`: The role that can access this arsenal. For non-CBA configured role descriptions, you can enter something like `Alpha` or `Alpha 1` or `Alpha 1-1` into the role field. For CBA configured roles, let's say your targeted role is `Rifleman@Diablo 1`, you can enter `Rifleman` into the role field and any player with the role `Rifleman@ANYTHING` will be able to access the arsenal. Essentially, anything after the `@` symbol is ignored, in terms of CBA usage.

> - `Items`: The items that will be available in the arsenal. This can be an array of classnames in any of the formats below:
```sqf
["Item1", "Item2", "Item3"]

"Item1", "Item2", "Item3"

Item1, Item2, Item3
```

--------

### __Formatting Tool (3den editor plugin)__
Using the formatting tool, you can easily create your arsenals and export them in a format that can be pasted directly pasted in the `Items` attribute.

> To open the formatting tool, simply open the 3den editor and navigate to the `Tools` tab then click `Arsenal Formatter`.

> Keep in mind that the formatting tool is still in development and may improve in the future.

> IMPORT option is not available in multiplayer scenarios as Bohemia Int. has disabled accessing the clipboard in multiplayer.

> The formatting tool can also be opened in-game by locally calling `[] call GRRA_fnc_formatter;`.

![](https://steamuserimages-a.akamaihd.net/ugc/2013706759566274775/1BCD717428451A1659526291F45C23D5E456B5C1/?imw=5000&imh=5000&ima=fit&impolicy=Letterbox&imcolor=#000000&letterbox=false)

--------

### __FAQ__

> - __Q:__ Will multiple arsenals be combined if they apply to the same player?

> - __A:__ Yes. If you have multiple arsenals that apply to the same player, they will be combined into one arsenal, with the exception that arsenals that are owned by a classname and arsenals that are owned by a variable name will not connect properly. 

> - __Q:__ How do I add a weapon to the arsenal?

> - __A:__ You can add a weapon to the arsenal by adding the weapon's classname to the `Items` attribute. For example, if you wanted to add the `arifle_MX_Black_F` weapon to the arsenal, you would add `arifle_MX_Black_F` to your list of items like so: `Item1, Item2, arifle_MX_Black_F`.

> - __Q:__ Will the arsenal automatically add compatible ammo to the arsenal?

> - __A:__ Not yet, but this is a feature that will be added in the future.

--------

### __Todos__

> combine player's arsenal where classname is also a var that's used???

> add button to open formatter in pause menu

> add a feature that makes it easier to find compatible ammo for a specific weapon (ace's "single mag" icon option)

