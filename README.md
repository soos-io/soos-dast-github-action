# SOOS DAST Analysis GitHub Actions

The SOOS DAST Analysis for GitHub implements the SOOS DAST Analysis's integration for CircleCI.

## How to Use

Currently, you can integrate the SOOS DAST Analysis with CircleCI using the [SOOS DAST Analysis CircleCI Orb](https://circleci.com/developer/orbs) in your workflow file. 

### Parameters
| Name              | Required                    | Description                                                                                          |
|-------------------|-----------------------------|------------------------------------------------------------------------------------------------------|
| `client_id`       | Yes                         | SOOS client id                                                                                       |
| `api_key`         | Yes                         | SOOS API key                                                                                         |
| `project_name`    | Yes                         | SOOS project name                                                                                    |
| `scan_mode`       | Yes                         | SOOS DAST scan mode. Values: `baseline` (Default), `fullscan`, or `apiscan`                          |
| `api_url`         | Yes                         | SOOS API URL. By Default: `https://api.soos.io/api/`                                                 |
| `debug`           |                             | show debug messages                                                                                  |
| `ajax_spider`     |                             | use the Ajax spider in addition to the traditional one                                               |
| `rules`           |                             | rules file to use for `INFO`, `IGNORE` or `FAIL` warnings                                            |
| `context_file`    |                             | context file which will be loaded prior to scanning the target. Required for authenticated URLs      |
| `context_user`    |                             | username to use for authenticated scans - must be defined in the given context file                  |
| `fullscan_minutes`| Required by `Full Analysis` | the number of minutes for spider to run                                                              |
| `apiscan_format`  | Required by `API Analysis`  | target API format: `openapi`, `soap`, or `graphql`                                                   |
| `level`           |                             | minimum level to show: `PASS`, `IGNORE`, `INFO`, `WARN` or `FAIL`                                    |
| `target_url`      | Yes                         | target URL including the protocol, eg https://www.example.com                                        |


### Example
``` yaml
on: [push]

jobs:
  soos_dast_analysis_example:
    name: SOOS DAST Analysis Example
    runs-on: ubuntu-latest
    steps:
      - name: Run SOOS DAST Analysis
        uses: soos-io/dast@v1
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


