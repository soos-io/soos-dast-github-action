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
SOOS_TARGET_URL=${14}

echo $SOOS_TARGET_URL

PARAMS="--clientId=${SOOS_CLIENT_ID} --apiKey=${SOOS_API_KEY} --projectName=\"${SOOS_PROJECT_NAME}\" --scanMode=${SOOS_SCAN_MODE} --apiURL=${SOOS_API_BASE_URL}"

if [  "$SOOS_DEBUG" == "true" ]; then
    PARAMS+=" --debug"
fi
if [  "$SOOS_AJAX_SPIDER" == "true" ]; then
    PARAMS+=" --ajaxSpider"
fi
if [  "$SOOS_RULES" != "" ]; then
    PARAMS+=" --rules=\"$SOOS_RULES\""
fi
if [  "$SOOS_CONTEXT_FILE" != "" ]; then
    PARAMS+=" --contextFile=${SOOS_CONTEXT_FILE}"
fi
if [  "$SOOS_CONTEXT_USER" != "" ]; then
    PARAMS+=" --contextUser=${SOOS_CONTEXT_USER}"
fi
if [  "$SOOS_FULL_SCAN_MINUTES" != "" ]; then
    PARAMS+=" --fullScanMinutes=${SOOS_FULL_SCAN_MINUTES}"
fi
if [  "$SOOS_API_SCAN_FORMAT" != "" ]; then
    PARAMS+=" --apiScanFormat=${SOOS_API_SCAN_FORMAT}"
fi
if [  "$SOOS_LEVEL" != "" ]; then
    PARAMS+=" --level=${SOOS_LEVEL}"
fi

python3 main.py ${SOOS_TARGET_URL} ${PARAMS}
