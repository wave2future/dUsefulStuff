#!/bin/bash

# -- PB User Script Info --
# %%%{PBXName=Uncrustify code}%%%
# %%%{PBXKeyEquivalent=^F}%%%
# %%%{PBXInput=None}%%%
# %%%{PBXOutput=ReplaceAllText}%%%

# -- Custom User Script Info --
# %%%{USRDir=40-Code}%%%
# %%%{USRName=99-uncrustify.sh}%%%

# Delete old uncrustfy file.
deleteUncrustifyFile() {
	if [ ! -f %%%{PBXFilePath}%%%.uncrustify ]; then
		rm -fr %%%{PBXFilePath}%%%.uncrustify
	fi
}

deleteUncrustifyFile

/usr/local/bin/uncrustify -q -c ~/uncrustify/obj_c.cfg -l OC
head -c %%%{PBXSelectionStart}%%% %%%{PBXFilePath}%%%.uncrustify
echo -n "%%%{PBXSelection}%%%"
tail -c +$((%%%{PBXSelectionStart}%%%+1)) %%%{PBXFilePath}%%%.uncrustify

deleteUncrustifyFile
