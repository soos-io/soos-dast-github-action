# [SOOS DAST](https://soos.io/dast-product/)

SOOS is an independent software security company, located in Winooski, VT USA, building security software for your team. [SOOS, Software security, simplified](https://soos.io).

Use SOOS to scan your software for [vulnerabilities](https://app.soos.io/research/vulnerabilities) and [open source license](https://app.soos.io/research/licenses) issues with [SOOS Core SCA](https://soos.io/sca-product). [Generate SBOMs](https://kb.soos.io/help/generating-a-software-bill-of-materials-sbom). Govern your open source dependencies. Run the [SOOS DAST vulnerability scanner](https://soos.io/dast-product) against your web apps or APIs.

[Demo SOOS](https://app.soos.io/demo) or [Register for a Free Trial](https://app.soos.io/register).

If you maintain an Open Source project, sign up for the Free as in Beer [SOOS Community Edition](https://soos.io/products/community-edition).

## How to use it:

You can use the Action as follows:

- Update the `.github/workflow/main.yml`file to include a step like this
``` yaml
on: [push]

jobs:
  soos_dast_analysis_example:
    name: SOOS DAST Analysis Example
    runs-on: ubuntu-latest
    steps:
      - name: Run SOOS DAST Analysis
        uses: soos-io/soos-dast-github-action@v1.2.5
        with:
          client_id: ${{ secrets.SOOS_CLIENT_ID }}
          api_key: ${{ secrets.SOOS_API_KEY }}
          project_name: "DAST-GitHub-Action-Test"
          scan_mode: "baseline"
          api_url: "https://api.soos.io/api/"
          target_url: "https://www.example.com/"
```

You can choose between three Jobs:
- [Baseline Analysis](#baseline-analysis)
- [Full Analysis](#full-analysis)
- [API Analysis](#api-analysis)

The `soos-io/soos-dast-github-action` Action has properties which are passed to the action using `with`.

| Property                         | Default                    | Description                                                                                                                                                                                                                                   |
|----------------------------------|----------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| client_id                         | [none] | The Client Id provided to you when subscribing to SOOS services.                                                                                                                                                                           |
| api_key                         | [none] | The Api Key provided to you when subscribing to SOOS services.                                                                                                                                                                           |
| api_url                         | "https://api.soos.io/api/" | The API BASE URI provided to you when subscribing to SOOS services.                                                                                                                                                                           |
| project_name                     | [none]                     | REQUIRED. A custom project name that will present itself as a collection of test results within your soos.io dashboard. For SARIF Report, it should be `{repository_owner}/{repository_name}`                                                 |
| scan_mode                     | baseline                     | SOOS DAST scan mode. Values available: baseline (Default), fullscan, and apiscan.                                                 |                                          
| on_failure                     | continue_on_failure                     | Action to perform when the scan fails. Values available: fail_the_build, continue_on_failure.                                                |                                          
| target_url                     | [none]                     | Target URL to perform the scan against.                                                 |
| debug                     | false                     | Show debug messages.       
| ajax_spider                     | false                     | Enable the Ajax spider in addition to the traditional one.    
| rules                     | [none]                     | Rules file to use to INFO, IGNORE or FAIL warnings.    
| context_file                     | [none]                     | Context file which will be loaded prior to scanning the target
| context_user                     | [none]                    | Username to use for authenticated scans - must be defined in the given context file.    
| disable_rules                     | [none]                    | Comma separated list of ZAP rules IDs to disable. List for reference https://www.zaproxy.org/docs/alerts/. (e.g. 10001,10002)    
| full_scan_minutes                     | [none]                    | The number of minutes for spider to run (required if scanmode is fullScan).    
| api_scan_format                     | [none]                     | Target API format: openapi, soap, or graphql. Required for scan_mode: apiscan.    
| level                     | INFO                     | Log level to show: DEBUG, INFO, WARN, ERROR, CRITICAL
| branch_uri                       | [none]                     | The URI to the branch from the SCM System                                                                                                                                                                                                     |
| build_version                    | [none]                     | Version of application build artifacts                                                                                                                                                                                                        |
| build_uri                        | [none]                     | URI to CI build info                                                                                                                                                                                                                          |
| operating_environment            | [none]                     | System info regarding operating system, etc.                                                                                                                                                                                                  |
| output_format                            | [none]                      | Output in which the vulnerability report will be generated, only sarif is supported at the moment                       |                                                                                                                                                                          
| zap_options                     | [none]                     | ZAP Additional Options.  
| request_header                     | [none]                     | Set extra header requests.    
| request_cookies                     | [none]                     | Set Cookie values for the requests to the target URL.    
| report_request_headers                     | True                     | Include request/response headers data in report.
| bearer_token                     | [none]                     | Bearer token to include as authorization header in every request.    
| auth_form_type                     | [none]                     | simple (all fields are displayed at once), wait_for_password (Password field is displayed only after username is filled), or multi_page (Password field is displayed only after username is filled and submit is clicked).  
| auth_username                     | [none]                     | Username to use in auth apps.    
| auth_password                     | [none]                     | Password to use in auth apps.
| auth_login_url                     | [none]                     | Login url to use in auth apps.  
| auth_username_field                     | [none]                     | Username input id to use in auth apps.    
| auth_password_field                     | [none]                     | Password input id to use in auth apps.
| auth_submit_field                     | [none]                     | Submit button id to use in auth apps.   
| auth_second_submit_field                     | [none]                     | Second submit button id to use in auth apps (for multi-page forms).  
| auth_delay_time                     | [none]                     | Delay time in seconds to wait for the page to load after performing actions in the form. (Used only on authFormType: wait_for_password and multi_page) 
| auth_submit_action                     | [none]                     | Submit action to perform on form filled. Possible values are click or submit. 
| oauth_token_url                     | [none]                     | The fully qualified authentication URL that grants the access_token.    
| oauth_parameters                     | [none]                     | Parameters to be added to the oauth token request needs to be comma delimited. (eg: client_id:value, client_secret:value, grant_type:value).  

#### Baseline Analysis
It runs the [ZAP](https://www.zaproxy.org/) spider against the specified target for (by default) 1 minute and then waits for the passive scanning to complete before reporting the results.

This means that the script doesn't perform any actual ‘attacks’ and will run for a relatively short period of time (a few minutes at most).

By default, it reports all alerts as WARNings but you can specify a config file which can change any rules to `FAIL` or `IGNORE`.

This mode is intended to be ideal to run in a `CI/CD` environment, even against production sites.

#### Full Analysis
It runs the [ZAP](https://www.zaproxy.org/) spider against the specified target (by default with no time limit) followed by an optional ajax spider scan and then a full active scan before reporting the results.

This means that the script does perform actual ‘attacks’ and can potentially run for a long period of time.

By default, it reports all alerts as WARNings but you can specify a config file which can change any rules to FAIL or IGNORE. The configuration works in a very similar way as the [Baseline Analysis](#baseline-analysis)

#### API Analysis
It is tuned for performing scans against APIs defined by `OpenAPI`, `SOAP`, or `GraphQL` via a URL where the spec file is publicly available.

It imports the definition that you specify and then runs an `Active Scan` against the URLs found. The `Active Scan` is tuned to APIs, so it doesn't bother looking for things like `XSSs`.

It also includes 2 scripts that:
- Raise alerts for any HTTP Server Error response codes
- Raise alerts for any URLs that return content types that are not usually associated with APIs

## Authenticated scans

### Using bearer token

If you need to run a scan against url that needs authorization and the only thing needed is to set an authorization header in the form of `authorization: Bearer token-value` then this is the most straight forward workflow (note that for this method you should have the bearer token value beforehand).

example workflow:

``` yaml
on: [push]
jobs:
  synchronous-analysis-with-blocking-result:
    name: SOOS DAST Scan
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Run SOOS DAST Baseline Analysis performing bearer token authentication
      uses: soos-io/soos-dast-github-action@v1.2.5
      with:
        client_id: ${{ secrets.SOOS_CLIENT_ID }}
        api_key: ${{ secrets.SOOS_API_KEY }}
        project_name: "DAST-bearer-token"
        scan_mode: "baseline"
        bearer_token: "token-value"
        api_url: "https://api.soos.io/api/"
        target_url: "https://www.example.com/"
```

### Authenticate throughout a login form and get the auth token.

Using this option there will be an automated login form authentication performed before running the DAST scan to get the bearer token that will be then added to every request as the authorization header.

This is how a example workflow will look like:

``` yaml

on: [push]

jobs:
  synchronous-analysis-with-blocking-result:
    name: SOOS DAST Scan
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Run SOOS DAST Baseline Analysis performing form authentication
      uses: soos-io/soos-dast-github-action@v1.2.5
      with:
        client_id: ${{ secrets.SOOS_CLIENT_ID }}
        api_key: ${{ secrets.SOOS_API_KEY }}
        project_name: "DAST-login-form"
        scan_mode: "baseline"
        api_url: "https://api.soos.io/api/"
        target_url: "https://example.com/"
        auth_login_url: "https://example.com/login"
        auth_username: "username-to-fill-field"
        auth_password: "password-to-fill-field"
        auth_username_field: "username-html-input-id"
        auth_password_field: "password-html-input-id"
        auth_submit_field: "submit-html-input-id"

```

### Authenticate against an OAuth token url.

In case you need to perform a DAST analysis against an OAuth application this is the workflow that you should follow. In this scenario the DAST tool will perform a request to get the `access_token` before doing any analysis.

Workflow example:

``` yaml
on: [push]

jobs:
  synchronous-analysis-with-blocking-result:
    name: SOOS DAST Scan
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Run SOOS DAST Baseline Analysis performing OAuth
      uses: soos-io/soos-dast-github-action@v1.2.5
      with:
        client_id: ${{ secrets.SOOS_CLIENT_ID }}
        api_key: ${{ secrets.SOOS_API_KEY }}
        project_name: "DAST-OAuth"
        scan_mode: "baseline"
        api_url: "https://api.soos.io/api/"
        target_url: "https://example.com/"
        oauth_token_url: "https://example.com/token"
        oauth_parameters: "client_secret:value ,client_id:value , grant_type:value"
```


## References
 - [ZAP](https://www.zaproxy.org/)


