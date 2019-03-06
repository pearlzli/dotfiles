#!/bin/bash

# Parse argument (input file)
if [[ "$#" -ne 1 ]]; then
    echo "ERROR: Run script using path/to/mendeley-fixup.sh path/to/bib-file.bib"
    exit 1
fi

if [[ "$(dirname $1)" == . ]]; then
    bibfile=$1
    bibpath="$(pwd)/$1"
else
    bibfile="$(basename $1)"
    bibpath=$1
fi

if [[ ! -e $bibpath ]]; then
    echo "ERROR: File $bibpath can't be found"
    exit 1
fi

# Remove escape characters from URLs
sed -i.backup '/^url/ s|{~}|~|g'   $bibpath # {~}  to ~
sed -i.backup '/^url/ s|{\\%}|%|g' $bibpath # {\%} to %
sed -i.backup '/^url/ s|{\\_}|_|g' $bibpath # {\_} to _

# Print success and return
echo "Successfully fixed up $bibfile"
