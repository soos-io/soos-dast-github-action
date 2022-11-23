import requests
import sys
import os


# get the latest release
r = requests.get('https://api.github.com/repos/soos-io/soos-dast-github-action/releases/latest')
latest_tag = r.json()['tag_name']
commit_hash = r.json()['target_commitish']

# find if path exists
os.system("find / -type d -name soos-dast-github-action")


# compare
if False:
    print('This action is up to date.')
    sys.exit(0)
else:
    print('This action is outdated. Please update to the latest version: ' + latest_tag)
    sys.exit(1)
