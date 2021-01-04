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
sed -i .backup "s/\\\@/\@/g" $outfile # replace \@ with @
sed -i .backup "s/\\\^/\^/g" $outfile # replace \^ with ^
sed -i .backup "s/\\\_/\_/g" $outfile # replace \_ with _
sed -i .backup 's/\\\[/\[/g' $outfile # replace \[ with [
sed -i .backup 's/\\\]/\]/g' $outfile # replace \] with ]
sed -i .backup "s/\\\'/\'/g" $outfile # replace \' with '
sed -i .backup "s/\\\</\</g" $outfile # replace \< with <
sed -i .backup "s/\\\>/\>/g" $outfile # replace \> with >
# sed -i .backup "s/\\\*/\*/g" $outfile # replace \* with * (TODO: doesn't work)

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
sed -E -i .backup 's/\[\(.*\)\](\1)/\[\1\]()/g' $outfile # plain URLs

# Turn Unicode into TeX
sed -i backup 's/\(.\)̃/\\tilde\{\1\}/g' $outfile # replace ã with \tilde{a}

sed -i backup 's/α/\\alpha/g' $outfile
sed -i backup 's/β/\\beta/g' $outfile
sed -i backup 's/γ/\\gamma/g' $outfile
sed -i backup 's/δ/\\delta/g' $outfile
sed -i backup 's/ε/\\epsilon/g' $outfile
sed -i backup 's/ζ/\\zeta/g' $outfile
sed -i backup 's/η/\\eta/g' $outfile
sed -i backup 's/θ/\\theta/g' $outfile
sed -i backup 's/κ/\\kappa/g' $outfile
sed -i backup 's/λ/\\lambda/g' $outfile
sed -i backup 's/μ/\\mu/g' $outfile
sed -i backup 's/ν/\\nu/g' $outfile
sed -i backup 's/ξ/\\xi/g' $outfile
sed -i backup 's/ο/\\omicron/g' $outfile
sed -i backup 's/π/\\pi/g' $outfile
sed -i backup 's/ρ/\\rho/g' $outfile
sed -i backup 's/σ/\\sigma/g' $outfile
sed -i backup 's/τ/\\tau/g' $outfile
sed -i backup 's/υ/\\upsilon/g' $outfile
sed -i backup 's/ϕ/\\phi/g' $outfile
sed -i backup 's/χ/\\chi/g' $outfile
sed -i backup 's/ψ/\\psi/g' $outfile
sed -i backup 's/ω/\\omega/g' $outfile

sed -i backup 's/Α/\\Alpha/g' $outfile
sed -i backup 's/Β/\\Beta/g' $outfile
sed -i backup 's/Γ/\\Gamma/g' $outfile
sed -i backup 's/Δ/\\Delta/g' $outfile
sed -i backup 's/Ε/\\Epsilon/g' $outfile
sed -i backup 's/Ζ/\\Zeta/g' $outfile
sed -i backup 's/Η/\\Eta/g' $outfile
sed -i backup 's/Θ/\\Theta/g' $outfile
sed -i backup 's/Κ/\\Kappa/g' $outfile
sed -i backup 's/Λ/\\Lambda/g' $outfile
sed -i backup 's/Μ/\\Mu/g' $outfile
sed -i backup 's/Ν/\\Nu/g' $outfile
sed -i backup 's/Ξ/\\Xi/g' $outfile
sed -i backup 's/Ο/\\Omicron/g' $outfile
sed -i backup 's/Π/\\Pi/g' $outfile
sed -i backup 's/Ρ/\\Rho/g' $outfile
sed -i backup 's/Σ/\\Sigma/g' $outfile
sed -i backup 's/Τ/\\Tau/g' $outfile
sed -i backup 's/Υ/\\Upsilon/g' $outfile
sed -i backup 's/Φ/\\Phi/g' $outfile
sed -i backup 's/Χ/\\Chi/g' $outfile
sed -i backup 's/Ψ/\\Psi/g' $outfile
sed -i backup 's/Ω/\\Omega/g' $outfile

sed -i backup 's/∩/\\cap/g' $outfile
sed -i backup 's/∪/\\cup/g' $outfile
sed -i backup 's/≥/\\geq/g' $outfile
sed -i backup 's/⇒/\$\\implies\$/g' $outfile
sed -i backup 's/∈/\\in/g' $outfile
sed -i backup 's/∞/\\infty/g' $outfile
sed -i backup 's/≤/\\leq/g' $outfile
sed -i backup 's/∇/\\nabla/g' $outfile
sed -i backup 's/∏/\\prod/g' $outfile
sed -i backup 's/∑/\\sum/g' $outfile
sed -i backup 's/×/\\times/g' $outfile

# Fix bad TeX
# See https://stackoverflow.com/a/6361362 for look aheads/behinds
perl -pi.backup -e "s/(?<!~)~(.)~(?!~)/_\1/g" $outfile # replace a~i~ with a_i, but not ~~foo~~
perl -pi.backup -e "s/(?<!~)~([^\s]{2,})~(?!~)/_{\1}/g" $outfile # replace a~ij~ with a_{ij}, but not ~~foo~~
perl -pi.backup -e "s/\^(.)\^/\^\1/g" $outfile # replace a^i^ with a^i
perl -pi.backup -e "s/\^([^\s]{2,})\^/\^{\1}/g" $outfile # replace a^ij^ with a^{ij}

# Report back
echo "Successfully cleaned $outfile"
