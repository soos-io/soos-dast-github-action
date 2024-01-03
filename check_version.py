import requests
import os
import re
import sys


def is_version_number(string):
    """Check if a string is a semantic version number."""
    return re.match(r'^v?\d+\.\d+\.\d+$', string) is not None


try:
    print('-' * 106)
    print("Checking if your current version is up to date.")
    latest_release = requests.get(
        'https://api.github.com/repos/soos-io/soos-dast-github-action/releases/latest')
    action_tags = requests.get(
        'https://api.github.com/repos/soos-io/soos-dast-github-action/tags')

    starter_version = next(
        (tag for tag in action_tags.json() if tag['name'] == 'starter_version'), None)

    latest_tag = latest_release.json()['tag_name']
    latest_tag_major = int(latest_tag.split('.')[0].lstrip('v'))
    current_tag = os.environ['GITHUB_ACTION_REF'].split('/')[-1]

    print(
        f"Your current version is: {current_tag}, The latest version is: {latest_tag}")

    if current_tag == starter_version['commit']['sha']:
        print('This action matches the starter version. Exiting...')
        sys.exit(1)
    elif is_version_number(current_tag):
        current_tag_major = int(current_tag.split('.')[0].lstrip('v'))
        if current_tag == latest_tag:
            print('This action is up to date.')
        elif current_tag_major < latest_tag_major:
            print(
                f'This action is outdated. Please update to a version not older than @v{latest_tag_major}.')
        else:
            print('Your version is up to date with the latest major release.')
    else:
        print('Current tag does not represent a version number, likely a branch name. Skipping version check.')

except requests.exceptions.RequestException as e:
    print('Network error while checking for updates. Please check manually.')
except KeyError:
    print('Error parsing JSON response. Please check manually.')

print('-' * 106)
