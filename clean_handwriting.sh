#!/bin/bash

# Parse input argument
if [[ "$#" -ne 1 ]]; then
    echo "ERROR: Run script using ~/dotfiles/clean_handwriting.sh path/to/input/file"
    exit 1
fi
infile="$(realpath $1)"

# Line breaks
echo -n "$(tr -d "\n" < $infile)" > $infile # remove newlines
sed -I "" -E "s/[•◦]/\n*/g" $infile # add line breaks before bullets; normalize both bullet chars to *
sed -I "" "/^$/d" $infile # remove empty lines

# Tidy TeX
sed -I "" -E "s/[[:space:]]*\^/\^/g" $infile # remove spaces before ^
sed -I "" -E "s/[[:space:]]*_/_/g"   $infile # remove spaces before _
sed -I "" "s/\\\nicefrac/\\\frac/g"  $infile # \nicefrac -> \frac (not supported by Zotero)

# Spaces around math mode
SOH=$'\x01'
STX=$'\x02'
sed_args=(
    -e 's/([^\])\$([^$]+)\$/\1'"$SOH"'$\2$'"$STX"'/g'              # add sentinels around math not at start of line, skip escaped \$
    -e 's/^\$([^$]+)\$/'"$SOH"'$\1$'"$STX"'/'                      # add sentinels around math at start of line
    -e 's/\([[:space:]]*'"$SOH"'/('"$SOH"'/g'                      # no space after opening (
    -e 's/([^[:space:](])[[:space:]]*'"$SOH"'/\1 '"$SOH"'/g'       # else exactly one space before
    -e 's/'"$STX"'[[:space:]]+([.,;:!?)])/'"$STX"'\1/g'            # no space before closing punctuation
    -e 's/'"$STX"'[[:space:]]*([^.,;:!?)[:space:]])/'"$STX"' \1/g' # else exactly one space after
    -e 's/['"$SOH""$STX"']//g'                                     # remove sentinels
)
sed -I "" -E "${sed_args[@]}" $infile

# (?) and (!)
sed -I "" -E "s/ \\\left\( ([?!]) \\\right\)\\$/\$ (\1)/g" $infile # move (?)/(!) outside math mode
sed -I "" -E "s/[[:space:]]*\(([?!])\)/(\1)/g" $infile # remove spaces before (?)/(!)

# Replace standalone Unicode characters with math-mode TeX
sed -I "" 's/α/\$\\alpha\$/g'   $infile
sed -I "" 's/β/\$\\beta\$/g'    $infile
sed -I "" 's/γ/\$\\gamma\$/g'   $infile
sed -I "" 's/δ/\$\\delta\$/g'   $infile
sed -I "" 's/ε/\$\\epsilon\$/g' $infile
sed -I "" 's/ζ/\$\\zeta\$/g'    $infile
sed -I "" 's/η/\$\\eta\$/g'     $infile
sed -I "" 's/θ/\$\\theta\$/g'   $infile
sed -I "" 's/κ/\$\\kappa\$/g'   $infile
sed -I "" 's/λ/\$\\lambda\$/g'  $infile
sed -I "" 's/μ/\$\\mu\$/g'      $infile
sed -I "" 's/ν/\$\\nu\$/g'      $infile
sed -I "" 's/ξ/\$\\xi\$/g'      $infile
sed -I "" 's/ο/\$\\omicron\$/g' $infile
sed -I "" 's/π/\$\\pi\$/g'      $infile
sed -I "" 's/ρ/\$\\rho\$/g'     $infile
sed -I "" 's/σ/\$\\sigma\$/g'   $infile
sed -I "" 's/τ/\$\\tau\$/g'     $infile
sed -I "" 's/υ/\$\\upsilon\$/g' $infile
sed -I "" 's/ϕ/\$\\phi\$/g'     $infile
sed -I "" 's/χ/\$\\chi\$/g'     $infile
sed -I "" 's/ψ/\$\\psi\$/g'     $infile
sed -I "" 's/ω/\$\\omega\$/g'   $infile

sed -I "" 's/Α/\$\\Alpha\$/g'   $infile
sed -I "" 's/Β/\$\\Beta\$/g'    $infile
sed -I "" 's/Γ/\$\\Gamma\$/g'   $infile
sed -I "" 's/Δ/\$\\Delta\$/g'   $infile
sed -I "" 's/Ε/\$\\Epsilon\$/g' $infile
sed -I "" 's/Ζ/\$\\Zeta\$/g'    $infile
sed -I "" 's/Η/\$\\Eta\$/g'     $infile
sed -I "" 's/Θ/\$\\Theta\$/g'   $infile
sed -I "" 's/Κ/\$\\Kappa\$/g'   $infile
sed -I "" 's/Λ/\$\\Lambda\$/g'  $infile
sed -I "" 's/Μ/\$\\Mu\$/g'      $infile
sed -I "" 's/Ν/\$\\Nu\$/g'      $infile
sed -I "" 's/Ξ/\$\\Xi\$/g'      $infile
sed -I "" 's/Ο/\$\\Omicron\$/g' $infile
sed -I "" 's/Π/\$\\Pi\$/g'      $infile
sed -I "" 's/Ρ/\$\\Rho\$/g'     $infile
sed -I "" 's/Σ/\$\\Sigma\$/g'   $infile
sed -I "" 's/Τ/\$\\Tau\$/g'     $infile
sed -I "" 's/Υ/\$\\Upsilon\$/g' $infile
sed -I "" 's/Φ/\$\\Phi\$/g'     $infile
sed -I "" 's/Χ/\$\\Chi\$/g'     $infile
sed -I "" 's/Ψ/\$\\Psi\$/g'     $infile
sed -I "" 's/Ω/\$\\Omega\$/g'   $infile
