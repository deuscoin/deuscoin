The tools in this directory are used for easily porting Bitcoin to another coin. The tools just rename files and strings in the files, but it's up to you to modify what you need to in the code.

**rename.sh**

Renames the files from containing the word "bitcoin" so that they contain "deuscoin." Run this before graphics.sh so that the old files don't overwrite your new ones.

**sed-replace.sh**

Changes "bitcoin" related strings to "deuscoin" related strings without crapping on Bitcoin's copyrights

**graphics.sh**

Copies the graphics from /tools/graphics into the tree

**production-release.sh**

Switch the build into production release more easily.

**change-client-name.sh**

Change the name of the client / user agent.
