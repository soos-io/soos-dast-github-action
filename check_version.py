import requests
import os
import sys

try:
    print('-' * 106)
    print("Checking if your current version is up to date.")

    response = requests.get(
        'https://api.github.com/repos/soos-io/soos-dast-github-action/releases/latest')

    latest_tag = response.json()['tag_name']
    current_tag = os.environ['GITHUB_ACTION_REF'].split('/')[-1]

    latest_tag_major = latest_tag.split('.')[0]

    print(
        f"Your current version is: {current_tag}, The latest version is: {latest_tag_major}")

    if not current_tag.startswith(latest_tag_major):
        print(
            f"This action is outdated. Please update to the latest version: {latest_tag_major}")
        sys.exit(1)

    if current_tag == latest_tag:
        print('This action is up to date.')
    else:
        print(
            f"This action is outdated. Please update to the latest version: {latest_tag}")

except requests.exceptions.RequestException as e:
    print(f'Failed to check for updates due to a network error: {e}')
except Exception as error:
    print(f'An error occurred: {error}')

print('-' * 106)
