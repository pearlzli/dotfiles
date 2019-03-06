#!/bin/bash

# Parse aux file for bib file
if [[ "$#" -ne 1 ]]; then
    echo "ERROR: Run script using path/to/mendeley-fixup.sh path/to/aux-file-no-ext"
    exit 1
fi

bibfile="$(grep -h \bibdata $1.aux | sed 's|.*\\bibdata{\(.*\)}|\1|').bib"
bibpath="$(realpath $bibfile)"

if [[ ! -e $bibpath ]]; then
    echo "ERROR: File $bibpath can't be found"
    exit 1
fi

# Remove escape characters from URLs
sed -i.backup '/^url/ s|{~}|~|g'   $bibpath # {~}  to ~
sed -i.backup '/^url/ s|{\\%}|%|g' $bibpath # {\%} to %
sed -i.backup '/^url/ s|{\\_}|_|g' $bibpath # {\_} to _

# Change double braces around titles to single braces
sed -i.backup '/^title/ s|{{|{|g' $bibpath
sed -i.backup '/^title/ s|}}|}|g' $bibpath

# Print success and return
echo "Successfully fixed up $bibfile"
