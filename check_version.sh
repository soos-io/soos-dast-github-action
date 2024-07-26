#!/bin/bash
response=$(curl -s https://api.github.com/repos/soos-io/soos-dast-github-action/releases/latest)
if [ $? -eq 0 ]; then
  latest_tag=$(echo "$response" | grep -oP '"tag_name": "\K(.*)(?=")')
  current_tag=$(echo "$GITHUB_ACTION_REF" | awk -F'/' '{print $NF}')
  latest_tag_major=$(echo "$latest_tag" | awk -F'.' '{print $1}')
  
  echo "Your current version is: $current_tag, The latest version is: $latest_tag_major"
  
  if [[ "$current_tag" != "$latest_tag_major"* ]]; then
    echo "This action is outdated or using a commit reference. Please update to use the latest major version tag: $latest_tag_major"
  elif [[ "$current_tag" == "$latest_tag" ]]; then
    echo "It is recommended to use the major version tag, $latest_tag_major when referencing this action."
  elif [[ "$current_tag" != "$latest_tag_major" ]]; then
    echo "This action is out of date. It is recommended to use the major version tag, $latest_tag_major."
  fi
elif 
  echo "Can't check version."
fi
