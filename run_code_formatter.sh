#!/bin/bash
FORMATTING_REPORT=${1-'reports/black_formatting_report.txt'}

GREEN='\033[0;32m'
NO_COLOUR='\033[0m'
printf "${GREEN}RUNNING BLACK PYTHON CODE FORMATTER${NO_COLOUR}\n"

black . 2>&1 | tee $FORMATTING_REPORT

echo "Saving formatter output in $FORMATTING_REPORT"
echo ''