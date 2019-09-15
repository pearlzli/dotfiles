#!/bin/bash

# Parse aux file for bib file
if [[ "$#" -ne 1 ]]; then
    echo "ERROR: Run script using path/to/mendeley-fixup.sh path/to/aux-file-no-ext"
    exit 1
fi

basedir="$(realpath $(dirname $1))"
bibnames="$(grep -h \bibdata $1.aux | sed 's|.*\\bibdata{\(.*\)}|\1|' | sed 's|,| |')"
for bibname in $bibnames; do
    bibfile="$bibname.bib"
    bibpath="$(realpath "$basedir/$bibfile")"

    if [[ ! -e "$bibpath" ]]; then
        echo "ERROR: File $bibpath can't be found"
        exit 1
    fi

    # Remove escape characters from URLs
    sed -i.backup '/^url/ s|{~}|~|g'   "$bibpath" # {~}  to ~
    sed -i.backup '/^url/ s|{\\%}|%|g' "$bibpath" # {\%} to %
    sed -i.backup '/^url/ s|{\\_}|_|g' "$bibpath" # {\_} to _

    # Change double braces around titles to single braces
    sed -i.backup '/^title/ s|{{|{|g' "$bibpath"
    sed -i.backup '/^title/ s|}}|}|g' "$bibpath"

    # Change double hyphens to single hyphens
    sed -i.backup '/^pages/ s|--|-|g' "$bibpath"

    # Delete fields
    sed -i.backup '/^abstract/d'      "$bibpath"
    sed -i.backup '/^doi/d'           "$bibpath"
    sed -i.backup '/^edition/d'       "$bibpath"
    sed -i.backup '/^file/d'          "$bibpath"
    sed -i.backup '/^isbn/d'          "$bibpath"
    sed -i.backup '/^issn/d'          "$bibpath"
    sed -i.backup '/^keywords/d'      "$bibpath"
    sed -i.backup '/^mendeley-tags/d' "$bibpath"
    sed -i.backup '/^url/d'           "$bibpath"

    # Print success and return
    echo "Successfully fixed up $bibfile"
done
