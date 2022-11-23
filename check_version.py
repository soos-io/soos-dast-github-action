import requests
import sys
import os

ACTION_BASE_PATH = "/home/runner/work/_actions/soos-io/soos-dast-github-action"

# get the latest release
r = requests.get('https://api.github.com/repos/soos-io/soos-dast-github-action/releases/latest')
latest_tag = r.json()['tag_name']
commit_hash = r.json()['target_commitish']

# print directory structure of ACTION_BASE_PATH
for root, dirs, files in os.walk(ACTION_BASE_PATH):
    for file in files:
        if file.endswith(".js"):
            file_path = os.path.join(root, file)
            with open(file_path, 'r') as f:
                content = f.read()
                if latest_tag not in content:
                    print("The latest release tag is not present in the file: " + file_path)
                    sys.exit(1)
                if commit_hash not in content:
                    print("The latest commit hash is not present in the file: " + file_path)
                    sys.exit(1)

# compare
if os.path.exists(f"{ACTION_BASE_PATH}/{commit_hash}") or os.path.exists(f"{ACTION_BASE_PATH}/{latest_tag}"):
    print('This action is outdated. Please update to the latest version: ' + latest_tag)
    sys.exit(1)
else:
    print('This action is up to date.')
    sys.exit(0)
