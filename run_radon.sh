#!/bin/bash
RADON_TXT=${1-'reports/radon_report.txt'}
RADON_XML=${2-'reports/radon_report.xml'}

GREEN='\033[0;32m'
NO_COLOUR='\033[0m'
printf "${GREEN}RUNNING RADON${NO_COLOUR}\n"

echo 'Calculating McCabe Cyclomatic Complexity!'
echo 'Functions with CC>10 will be shown below:'

radon cc --min C . # To show colours on stdout.
radon cc . > $RADON_TXT # Save output without colours.
radon cc --xml --output-file $RADON_XML .

echo "Saving Radon results to $RADON_TXT and $RADON_XML!"
echo "Take note that $RADON_TXT has colours saved to it"
echo ''
