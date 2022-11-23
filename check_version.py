import requests
import os


try:
    r = requests.get('https://api.github.com/repos/soos-io/soos-dast-github-action/releases/latest')
    latest_tag = r.json()['tag_name']
    current_tag = os.environ['GITHUB_ACTION_REF'].split('/')[-1]
    print('-' * 106)
    print(f"Checking if your current version is up to date. Current version: {current_tag}, Latest version: {latest_tag}")
    # compare
    if current_tag == latest_tag:
        print('This action is up to date.')
    else:
        print('This action is outdated. Please update to the latest version: ' + latest_tag)
except Exception as error:
    print('Failed to check for updates. Please check manually.')

print('-' * 106)
