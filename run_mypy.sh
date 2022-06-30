#!/bin/bash
MYPY_CONFIG='mypy.ini'
MYPY_REPORT=${1-'reports/mypy_report.txt'}

GREEN='\033[0;32m'
BROWN='\033[0;33m'
NO_COLOUR='\033[0m'
printf "${GREEN}RUNNING MYPY${NO_COLOUR}\n"

printf "${BROWN}Make sure that you are running mypy inside the popeyes Docker container!${NO_COLOUR}\n"

mypy --config-file ${MYPY_CONFIG} \
    main.py src/**/*.py \
    | tee ${MYPY_REPORT}

