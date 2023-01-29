# Grom: Restricted Arsenals (Alpha)
 A useful Arma 3 mod that allows creators to initialize an infinite amount of arsenals, restricted by player role and other attributes.

![](https://steamuserimages-a.akamaihd.net/ugc/2013706124474735514/AF4EB4D2A638312DCAD98004F7BC15E969EDEAA0/?imw=637&imh=358&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=true)

### __Modules__

> To use a module, simply drop the module anywhere in your mission's map in 3den editor and double-click on it to configure. Modules can be found under the "Systems" category in 3den editor.

#### [1] Base Arsenal

> A basic, whitelisted arsenal that can everyone can access. This module can also be restricted to a specific side, ie: `BLUFOR`. You can make make as many as needed, ie: one for each "side" (or team in a pvp gammode etc).

#### [2] Restricted Arsenal

> A whitelisted arsenal that can only certain players with a specific role can access, ie: `Machinegunner@anything` as well as to a specific side, ie: `BLUFOR`.

--------

### __Utilities__

#### [1] Force Vanilla Arsenal

> Dropping this module into your mission will automatically convert all restricted arsenals into an Arma 3 virtual arsenal (vanilla arsenal). Amount has no effect, 1 is enough.

--------

### Module attributes & settings:

> - `Side`: The side that can access this arsenal. Select "ANY" to allow all sides to access the arsenal.

> - `Owner`: The object/classname of objects that own/s this whitelisted arsenal. This can be the object's classname or a variable name. If the object is destroyed, the arsenal will be destroyed as well. *Keep in mind* that you may encounter issues if you try to combine an arsenal that is owned by a classname with an arsenal that is owned by a variable name. Otherwise, you can use the same variable name/classname for multiple arsenals which will combine them into one arsenal specific to the player's side/role.

> - `Role (Restricted arsenal only)`: The role that can access this arsenal. For non-CBA configured role descriptions, you can enter something like `Alpha` or `Alpha 1` or `Alpha 1-1` into the role field. For CBA configured roles, let's say your targeted role is `Rifleman@Diablo 1`, you can enter `Rifleman` into the role field and any player with the role `Rifleman@ANYTHING` will be able to access the arsenal. Essentially, anything after the `@` symbol is ignored, in terms of CBA usage.

--------

### __Todos__

> combine player's arsenal where classname is also a var that's used???

> add button to open formatter in pause menu

> add a feature that makes it easier to find compatible ammo for a specific weapon (ace's "single mag" icon option)