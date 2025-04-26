# 0.2.2 Release Notes:

- Whitelist changes: Substring filter attributes (Role/Group) that are empty will be treated as a match.

- Config cleanup.

- Added reusable Side-select component for the filter menu.

- Added "Group" filter to restricted arsenal module.

- Development: Added build task for VSCode. (CTRL + SHIFT + B to rebuild the PBO file)

# 0.2.0 Release Notes:

- Added release notes!

- Removed Arsenal Formatter tool. You can use Ace Arsenal to export classnames instead.

- Cleaned up some of the documentation.

- Removed the fallback for CBA role descriptions - Now it will check for a substring, so nothing has changed in functionality unless you are using CBA role descriptions.
In that case, you will can now filter by something like "Medic@Tombstone" instead of just "Medic" but can just also use "Medic" as well.

