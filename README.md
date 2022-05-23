# SOOS DAST

The affordable no limit web vulnerability scanner.

Use **SOOS DAST** to:

1. Scan web apps and APIs defined by **OpenAPI**, **SOAP**, or **GraphQL**
2. Containerized solution runs in your environment
3. Manage issues via single-pane web dashboard shared with [SOOS SCA](https://github.com/marketplace/actions/soos-sca-github-action)
4. Track tickets in Jira or GitHub Issues


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
        uses: soos-io/soos-dast-github-action@v1.0.1
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
| target_url                     | [none]                     | Target URL to perform the scan against.                                                 |
| debug                     | false                     | Show debug messages.       
| ajax_spider                     | false                     | Enable the Ajax spider in addition to the traditional one.    
| rules                     | [none]                     | Rules file to use to INFO, IGNORE or FAIL warnings.    
| context_file                     | [none]                     | Context file which will be loaded prior to scanning the target
| context_user                     | [none]                    | Username to use for authenticated scans - must be defined in the given context file.    
| full_scan_minutes                     | [none]                    | The number of minutes for spider to run (required if scanmode is fullScan).    
| api_scan_format                     | [none]                     | Target API format: openapi, soap, or graphql. Required for scan_mode: apiscan.    
| active_scan_level                     | PASS                     | Minimum level to show: PASS (Default), IGNORE, INFO, WARN or FAIL.    
| branch_uri                       | [none]                     | The URI to the branch from the SCM System                                                                                                                                                                                                     |
| build_version                    | [none]                     | Version of application build artifacts                                                                                                                                                                                                        |
| build_uri                        | [none]                     | URI to CI build info                                                                                                                                                                                                                          |
| operating_environment            | [none]                     | System info regarding operating system, etc.                                                                                                                                                                                                  |
| sarif                            | false                      | Enable Uploading the SARIF Report to GitHub.                                                                                                                                                                                                  |
| gpat                             | [none]                     | GitHub Personal Access Token. Required to upload SARIF Report                                                                                                                                                                           
| zap_options                     | [none]                     | ZAP Additional Options.  
| request_header                     | [none]                     | Set extra header requests.    
| request_cookies                     | [none]                     | Set Cookie values for the requests to the target URL.    


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
It is tuned for performing scans against APIs defined by `OpenAPI`, `SOAP`, or `GraphQL` via either a local file or a URL.

It imports the definition that you specify and then runs an `Active Scan` against the URLs found. The `Active Scan` is tuned to APIs, so it doesn't bother looking for things like `XSSs`.

It also includes 2 scripts that:
- Raise alerts for any HTTP Server Error response codes
- Raise alerts for any URLs that return content types that are not usually associated with APIs

## References
 - [ZAP](https://www.zaproxy.org/)


