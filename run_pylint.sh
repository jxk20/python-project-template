#!/bin/bash
PYLINT_RCFILE='.pylintrc'
PYLINT_REPORT=${1-'reports/pylint_report.txt'}
PWD_NAME=$(basename "$PWD")

GREEN='\033[0;32m'
BROWN='\033[0;33m'
NO_COLOUR='\033[0m'
printf "${GREEN}RUNNING PYLINT${NO_COLOUR}\n"

printf "${BROWN}Make sure that you are running pylint inside the popeyes Docker container!${NO_COLOUR}\n"


TEMP_INITS=(
    '__init__.py'
)

for f in ${TEMP_INITS[@]}; do
    touch $f
done

python3 -m pylint \
    --rcfile $PYLINT_RCFILE \
    --output-format parseable \
    $PWD_NAME | tee ${PYLINT_REPORT}

for f in ${TEMP_INITS[@]}; do
    rm $f
done



echo "Saving pylint results in $PYLINT_REPORT"
echo ''
