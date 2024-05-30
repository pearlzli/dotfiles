#!/bin/bash

# Parse aux file for bib file
if [[ "$#" -ne 1 ]]; then
    echo "ERROR: Run script using path/to/mendeley-fixup.sh path/to/aux-file-no-ext"
    exit 1
fi

basedir="$(realpath $(dirname $1))"
bibnames="$(grep -h \bibdata $1.aux | sed 's|.*\\bibdata{\(.*\)}|\1|' | sed 's|,| |')"
for bibname in $bibnames; do
    # Add .bib to file name if necessary
    if [[ $bibname == *.bib ]]; then
        bibfile=$bibname
    else
        bibfile="$bibname.bib"
    fi

    if [[ "${bibfile:0:1}" == / || "${bibfile:0:2}" == ~[/a-z] ]]; then
        # Absolute path
        bibpath="$bibfile"
    else
        # Relative path
        bibpath="$(realpath "$basedir/$bibfile")"
    fi

    if [[ ! -e "$bibpath" ]]; then
        echo "ERROR: File $bibpath can't be found"
        exit 1
    fi

    # Remove escape characters from URLs
    sed -i.backup '/^url/ s|\$\\sim\$|~|g' "$bibpath" # $\sim$  to ~
    sed -i.backup '/^url/ s|{~}|~|g'   "$bibpath" # {~}  to ~
    sed -i.backup '/^url/ s|{\\%}|%|g' "$bibpath" # {\%} to %
    sed -i.backup '/^url/ s|{\\_}|_|g' "$bibpath" # {\_} to _

    # Change double braces around titles to single braces
    sed -i.backup '/^title/ s|{{|{|g' "$bibpath"
    sed -i.backup '/^title/ s|}}|}|g' "$bibpath"

    # Change double hyphens to single hyphens
    sed -i.backup '/^pages/ s|--|-|g' "$bibpath"

    # Escape ampersands in journal names
    # TODO: repeatedly running mendeley-fixup adds duplicate backslashes
    # sed -i.backup '/^journal/ s| &| \\&|g' "$bibpath"

    # Delete fields
    sed -i.backup '/^abstract/d'      "$bibpath"
    sed -i.backup '/^doi/d'           "$bibpath"
    sed -i.backup '/^file/d'          "$bibpath"
    sed -i.backup '/^isbn/d'          "$bibpath"
    sed -i.backup '/^issn/d'          "$bibpath"
    sed -i.backup '/^keywords/d'      "$bibpath"
    sed -i.backup '/^mendeley-tags/d' "$bibpath"

    # Print success and return
    echo "Successfully fixed up $bibfile"
done
