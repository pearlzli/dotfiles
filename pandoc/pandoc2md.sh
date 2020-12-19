#!/bin/bash

# Parse input argument
if [[ "$#" -ne 1 ]]; then
    echo "ERROR: Run script using path/to/pandoc2md.sh path/to/input/file"
    exit 1
fi
infile="$(realpath $1)"
outfile="${infile%%.*}.md"

# Run pandoc
pandoc $infile -o $outfile
echo "Ran pandoc on $infile"

# Un-escape things
sed -i .backup 's/\\\[/\[/g' $outfile # \[ -> [
sed -i .backup 's/\\\]/\]/g' $outfile # \] -> ]
sed -i .backup "s/\\\'/\'/g" $outfile # \' -> '

# Remove > indents
# https://www.systutorials.com/how-to-match-multiple-lines-using-regex-in-perl-one-liners/
perl -0777 -pi.backup -e 's/\s+\>//g' $outfile

# Fix spacing
sed -i .backup 's/    /  /g' $outfile # change indent level from 4 to 2
sed -i .backup 's/\-   /\- /g' $outfile # remove extra spaces after bullets
perl -0777 -pi.backup -e 's/^\s*(^\s*\-.*$)$/$1/gm' $outfile # remove empty line before bullet
perl -0777 -pi.backup -e 's/(#+.*$)\s*(^\s*\-.*)/$1\n\n$2/gm' $outfile # add back empty line after header

# Clean URLs
sed -i .backup 's/{\.ul}//g' $outfile
sed -i .backup 's/\[\[/\[/g' $outfile
sed -i .backup 's/\]\]/\]/g' $outfile
sed -i .backup 's/\[\(.*\)\](\1)/\[\1\]()/g' $outfile # plain URLs

# Report back
echo "Successfully cleaned $outfile"
