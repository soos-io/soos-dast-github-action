#!/bin/bash -l

python3 /check_version.py

SOOS_APP_VERSION=${GITHUB_ACTION_REF}

cd /zap/

SOOS_INTEGRATION_NAME="GitHub"
SOOS_INTEGRATION_TYPE="Plugin"

SOOS_BRANCH_NAME=${SOOS_BRANCH_NAME:-${GITHUB_REF}}

PARAMS=(
    "--clientId ${SOOS_CLIENT_ID}"
    "--apiKey ${SOOS_API_KEY}"
    "--projectName" "${SOOS_PROJECT_NAME}"
    "--scanMode ${SOOS_SCAN_MODE}"
    "--onFailure ${SOOS_ON_FAILURE}"
    "--apiURL ${SOOS_API_URL}"
    "--integrationName ${SOOS_INTEGRATION_NAME}"
    "--integrationType ${SOOS_INTEGRATION_TYPE}"
    "--commitHash ${GITHUB_SHA}"
    "--branchName ${SOOS_BRANCH_NAME}"
    "--checkoutDir ${GITHUB_WORKSPACE}"
    "--appVersion ${SOOS_APP_VERSION}"
    ${SOOS_DEBUG:+--debug}
    ${SOOS_AJAX_SPIDER:+--ajaxSpider}
    ${SOOS_CONTEXT_FILE:+--contextFile ${SOOS_CONTEXT_FILE}}
    ${SOOS_CONTEXT_USER:+--contextUser ${SOOS_CONTEXT_USER}}
    ${SOOS_FULL_SCAN_MINUTES:+--fullScanMinutes ${SOOS_FULL_SCAN_MINUTES}}
    ${SOOS_API_SCAN_FORMAT:+--apiScanFormat ${SOOS_API_SCAN_FORMAT}}
    ${SOOS_LOG_LEVEL:+--logLevel ${SOOS_LOG_LEVEL}}
    ${SOOS_BRANCH_URI:+--branchUri ${SOOS_BRANCH_URI}}
    ${SOOS_BUILD_URI:+--buildUri ${SOOS_BUILD_URI}}
    ${SOOS_BUILD_VERSION:+--buildVersion ${SOOS_BUILD_VERSION}}
    ${SOOS_OPERATING_ENVIRONMENT:+--operatingEnvironment ${SOOS_OPERATING_ENVIRONMENT}}
    ${SOOS_ZAP_OPTIONS:+--zapOptions ${SOOS_ZAP_OPTIONS}}
    ${SOOS_REQUEST_COOKIES:+--requestCookies ${SOOS_REQUEST_COOKIES}}
    ${SOOS_REQUEST_HEADERS:+--requestHeaders ${SOOS_REQUEST_HEADERS}}
    ${SOOS_OUTPUT_FORMAT:+--outputFormat ${SOOS_OUTPUT_FORMAT}}
    ${SOOS_BEARER_TOKEN:+--bearerToken ${SOOS_BEARER_TOKEN}}
    ${SOOS_AUTH_USERNAME:+--authUsername ${SOOS_AUTH_USERNAME}}
    ${SOOS_AUTH_PASSWORD:+--authPassword ${SOOS_AUTH_PASSWORD}}
    ${SOOS_AUTH_LOGIN_URL:+--authLoginURL ${SOOS_AUTH_LOGIN_URL}}
    ${SOOS_AUTH_USERNAME_FIELD:+--authUsernameField ${SOOS_AUTH_USERNAME_FIELD}}
    ${SOOS_AUTH_PASSWORD_FIELD:+--authPasswordField ${SOOS_AUTH_PASSWORD_FIELD}}
    ${SOOS_AUTH_SUBMIT_FIELD:+--authSubmitField ${SOOS_AUTH_SUBMIT_FIELD}}
    ${SOOS_AUTH_SUBMIT_ACTION:+--authSubmitAction ${SOOS_AUTH_SUBMIT_ACTION}}
    ${SOOS_OAUTH_TOKEN_URL:+--oauthTokenUrl ${SOOS_OAUTH_TOKEN_URL}}
    ${SOOS_OAUTH_PARAMETERS:+--oauthParameters ${SOOS_OAUTH_PARAMETERS}}
    ${SOOS_AUTH_SECOND_SUBMIT_FIELD:+--authSecondSubmitField ${SOOS_AUTH_SECOND_SUBMIT_FIELD}}
    ${SOOS_AUTH_FORM_TYPE:+--authFormType ${SOOS_AUTH_FORM_TYPE}}
    ${SOOS_AUTH_DELAY_TIME:+--authDelayTime ${SOOS_AUTH_DELAY_TIME}}
    ${SOOS_AUTH_VERIFICATION_URL:+--authVerificationURL ${SOOS_AUTH_VERIFICATION_URL}}
    ${SOOS_DISABLE_RULES:+--disableRules ${SOOS_DISABLE_RULES}}
    ${SOOS_VERBOSE:+--verbose}
    ${SOOS_OTHER_OPTIONS:+--otherOptions ${SOOS_OTHER_OPTIONS}}
)


node dist/index.js "${SOOS_TARGET_URL}" ${PARAMS[@]}