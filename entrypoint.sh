#!/bin/bash -l

# check version of the action first

python3 check_version.py

cd /zap/

SOOS_CLIENT_ID=$1
SOOS_API_KEY=$2
SOOS_PROJECT_NAME=$3
SOOS_SCAN_MODE=$4
SOOS_ON_FAILURE=${34}
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
SOOS_OUTPUT_FORMAT=${21}

SOOS_TARGET_URL=${22}

SOOS_REPORT_REQUEST_HEADERS=${23}
SOOS_BEARER_TOKEN=${24}
SOOS_AUTH_USERNAME=${25}
SOOS_AUTH_PASSWORD=${26}
SOOS_AUTH_LOGIN_URL=${27}
SOOS_AUTH_USERNAME_FIELD=${28}
SOOS_AUTH_PASSWORD_FIELD=${29}
SOOS_AUTH_SUBMIT_FIELD=${30}
SOOS_AUTH_SUBMIT_ACTION=${31}
SOOS_OAUTH_TOKEN_URL=${32}
SOOS_OAUTH_PARAMETERS=${33}

SOOS_INTEGRATION_NAME="GitHub"
SOOS_INTEGRATION_TYPE="Plugin"

PARAMS="--clientId ${SOOS_CLIENT_ID} --apiKey ${SOOS_API_KEY} --projectName ${SOOS_PROJECT_NAME} --scanMode ${SOOS_SCAN_MODE} --onFailure ${SOOS_ON_FAILURE} --apiURL ${SOOS_API_BASE_URL} --integrationName ${SOOS_INTEGRATION_NAME} --integrationType ${SOOS_INTEGRATION_TYPE} --commitHash ${GITHUB_SHA} --branchName ${GITHUB_REF} --checkoutDir ${GITHUB_WORKSPACE}" 

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
    PARAMS+=" --requestHeaders ${SOOS_REQUEST_HEADERS}"
fi
if [ -n "$SOOS_OUTPUT_FORMAT" ]; then
    PARAMS+=" --outputFormat ${SOOS_OUTPUT_FORMAT}"
fi
if [ -n "$SOOS_REPORT_REQUEST_HEADERS"]; then
    PARAMS+=" --reportRequestHeaders  ${SOOS_REPORT_REQUEST_HEADERS}"
fi
if [ -n "$SOOS_BEARER_TOKEN" ]; then
    PARAMS+=" --bearerToken ${SOOS_BEARER_TOKEN}"
fi
if [ -n "$SOOS_AUTH_USERNAME" ]; then
    PARAMS+=" --authUsername ${SOOS_AUTH_USERNAME}"
fi
if [ -n "$SOOS_AUTH_PASSWORD" ]; then
    PARAMS+=" --authPassword ${SOOS_AUTH_PASSWORD}"
fi
if [ -n "$SOOS_AUTH_LOGIN_URL" ]; then
    PARAMS+=" --authLoginURL ${SOOS_AUTH_LOGIN_URL}"
fi
if [ -n "$SOOS_AUTH_USERNAME_FIELD" ]; then
    PARAMS+=" --authUsernameField ${SOOS_AUTH_USERNAME_FIELD}"
fi
if [ -n "$SOOS_AUTH_PASSWORD_FIELD" ]; then
    PARAMS+=" --authPasswordField ${SOOS_AUTH_PASSWORD_FIELD}"
fi
if [ -n "$SOOS_AUTH_SUBMIT_FIELD" ]; then
    PARAMS+=" --authSubmitField ${SOOS_AUTH_SUBMIT_FIELD}"
fi
if [ -n "$SOOS_AUTH_SUBMIT_ACTION" ]; then
    PARAMS+=" --authSubmitAction ${SOOS_AUTH_SUBMIT_ACTION}"
fi
if [ -n "$SOOS_OAUTH_TOKEN_URL" ]; then
    PARAMS+=" --oauthTokenUrl ${SOOS_OAUTH_TOKEN_URL}"
fi
if [ -n "$SOOS_OAUTH_PARAMETERS" ]; then
    PARAMS+=" --oauthParameters ${SOOS_OAUTH_PARAMETERS}"
fi

python3 main.py ${SOOS_TARGET_URL} ${PARAMS}
