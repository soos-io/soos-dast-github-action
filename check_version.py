import requests
import os

try:
    print('-' * 106)
    print("Checking if your current version is up to date.")
    r = requests.get(
        'https://api.github.com/repos/soos-io/soos-dast-github-action/releases/latest')
    latest_tag = r.json()['tag_name']
    latest_tag_major = int(latest_tag.split('.')[0].lstrip('v'))
    current_tag = os.environ['GITHUB_ACTION_REF'].split('/')[-1]
    current_tag_major = int(current_tag.split('.')[0].lstrip('v'))

    print(
        f"Your current version is: {current_tag}, The latest version is: {latest_tag}")

    if current_tag == latest_tag:
        print('This action is up to date.')
    elif current_tag_major < latest_tag_major:
        raise Exception(
            f'This action is outdated. Please update to a version not older than @v{latest_tag_major}.')
    else:
        print('Your version is up to date with the latest major release.')

except requests.exceptions.RequestException as e:
    print('Network error while checking for updates. Please check manually.')
except KeyError:
    print('Error parsing JSON response. Please check manually.')

print('-' * 106)
