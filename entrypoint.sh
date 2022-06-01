#!/bin/bash -l

cd /zap/

SOOS_CLIENT_ID=$1
SOOS_API_KEY=$2
SOOS_PROJECT_NAME=$3
SOOS_SCAN_MODE=$4
SOOS_DEBUG=$5
SOOS_AJAX_SPIDER=$6
SOOS_API_BASE_URL=$7
SOOS_RULES=$8
SOOS_CONTEXT_FILE=$9
SOOS_CONTEXT_USER=${10}
SOOS_FULL_SCAN_MINUTES=${11}
SOOS_API_SCAN_FORMAT=${12}
SOOS_LEVEL=${13}

SOOS_BRANCH_URI=${14}
SOOS_BUILD_VERSION=${15}
SOOS_BUILD_URI=${16}
SOOS_OPERATING_ENVIRONMENT=${17}

SOOS_ZAP_OPTIONS=${18}
SOOS_REQUEST_COOKIES=${19}
SOOS_REQUEST_HEADERS=${20}
SOOS_GENERATE_SARIF_REPORT=${21}
SOOS_GITHUB_PAT=${22}

SOOS_TARGET_URL=${23}

SOOS_INTEGRATION_NAME="GitHub Actions"

PARAMS="--clientId ${SOOS_CLIENT_ID} --apiKey ${SOOS_API_KEY} --projectName ${SOOS_PROJECT_NAME} --scanMode ${SOOS_SCAN_MODE} --apiURL ${SOOS_API_BASE_URL} --integrationName ${SOOS_INTEGRATION_NAME} --commitHash ${GITHUB_SHA} --branchName ${GITHUB_REF}"

if [  "$SOOS_DEBUG" == "true"]; then
    PARAMS+=" --debug True"
fi
if [  "$SOOS_AJAX_SPIDER" == "true" ]; then
    PARAMS+=" --ajaxSpider True"
fi
if [ -n "$SOOS_RULES" ]; then
    PARAMS+=" --rules ${SOOS_RULES}"
fi
if [ -n "$SOOS_CONTEXT_FILE" ]; then
    PARAMS+=" --contextFile ${SOOS_CONTEXT_FILE}"
fi
if [ -n "$SOOS_CONTEXT_USER" ]; then
    PARAMS+=" --contextUser ${SOOS_CONTEXT_USER}"
fi
if [  -n "$SOOS_FULL_SCAN_MINUTES" ]; then
    PARAMS+=" --fullScanMinutes ${SOOS_FULL_SCAN_MINUTES}"
fi
if [  -n "$SOOS_API_SCAN_FORMAT" ]; then
    PARAMS+=" --apiScanFormat ${SOOS_API_SCAN_FORMAT}"
fi
if [  -n "$SOOS_LEVEL" ]; then
    PARAMS+=" --level ${SOOS_LEVEL}"
fi
if [  -n "$SOOS_BRANCH_URI" ]; then
    PARAMS+=" --branchUri ${SOOS_BRANCH_URI}"
fi
if [  -n "$SOOS_BUILD_URI" ]; then
    PARAMS+=" --buildUri ${SOOS_BUILD_URI}"
fi
if [  -n "$SOOS_BUILD_VERSION" ]; then
    PARAMS+=" --buildVersion ${SOOS_BUILD_VERSION}"
fi
if [  -n "$SOOS_OPERATING_ENVIRONMENT" ]; then
    PARAMS+=" --operatingEnvironment ${SOOS_OPERATING_ENVIRONMENT}"
fi
if [  -n "$SOOS_ZAP_OPTIONS" ]; then
    PARAMS+=" --zapOptions ${SOOS_ZAP_OPTIONS}"
fi
if [  -n "$SOOS_REQUEST_COOKIES"  ]; then
    PARAMS+=" --requestCookies ${SOOS_REQUEST_COOKIES}"
fi
if [  -n "$SOOS_REQUEST_HEADERS" ]; then
    PARAMS+=" --requestHeader ${SOOS_REQUEST_HEADERS}"
fi
if [  "$SOOS_GENERATE_SARIF_REPORT" == "true" ]; then
    PARAMS+=" --sarif=true"
fi
if [ -n "${SOOS_GITHUB_PAT}" ]; then
    PARAMS+=" --gpat ${SOOS_GITHUB_PAT}"
fi

python3 main.py ${SOOS_TARGET_URL} ${PARAMS}