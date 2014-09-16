The tools in this directory are used for easily porting Bitcoin to another coin. The tools just rename files and strings in the files, but it's up to you to modify what you need to in the code.

**rename.sh**
Renames the files from containing the word "bitcoin" so that they contain "deuscoin"

**sed-replace.sh**
Changes "bitcoin" related strings to "deuscoin" related strings without crapping on Bitcoin's copyrights

**graphics.sh**
Copies the graphics from /tools/graphics into the /src/qt/res tree

**production-release.sh**
Switch the build into production release more easily.
