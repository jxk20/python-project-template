#!/bin/bash
USAGE="Usage: ./`basename $0` [-h] [<test_file>]

Optional arguments:
  -h           Show this help message and exit
  <test_file>  Only this pytest file will be executed in pytest if given

Example usage:
./`basename $0` 'tests/test_abc/test_this.py'
This will only run pytest on tests/test_abc/test_this.py.
"


PYTEST_XML='reports/pytest_report.xml'
PYTEST_REPORT='reports/pytest_report.txt'
PYTEST_COV_REPORT_HTML='reports/pytest_cov_report'
PYTEST_COV_REPORT_XML='reports/pytest_cov_report.xml'

GREEN='\033[0;32m'
NO_COLOUR='\033[0m'
printf "${GREEN}RUNNING PYTEST${NO_COLOUR}\n"


if [ $# -eq 1 ]; then
    if [ "$1" == "-h" ]; then
        echo -e "$USAGE"
    else
        PYTEST_FILE="$1"
        python3 -m pytest $PYTEST_FILE \
        -v \
        -rsf \
        -W ignore::DeprecationWarning
    fi
    exit 0
fi

python3 -m pytest tests \
    --cov-config=tests/.coveragerc \
    --cov-report=term \
    --cov-report=html:$PYTEST_COV_REPORT_HTML \
    --cov-report=xml:$PYTEST_COV_REPORT_XML \
    --cov=. \
    -v \
    -rsf \
    -W ignore::DeprecationWarning \
    --junitxml $PYTEST_XML \
    | tee $PYTEST_REPORT

cd ..
echo "Saving pytest results in $PYTEST_XML and $PYTEST_REPORT"
echo ''