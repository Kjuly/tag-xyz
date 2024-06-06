#!/bin/bash

set -e

VERSION_LEVEL=$1

version="$(git tag --sort=v:refname | tail -1)"
echo "version: $version, VERSION_LEVEL: $VERSION_LEVEL"

if [ -z "$version" ]; then
  echo "::error:: Invalid version: $version"
  exit 1
fi

IFS="." read -r -a version_comp <<< "$version" || 'true'

# Major Version (breaking changes)
if [ "$VERSION_LEVEL" == "x" ]; then
  latest_version="$((version_comp[0]+1)).0.0"
# Minor Version (features)
elif [ "$VERSION_LEVEL" == "y" ]; then
  latest_version="${version_comp[0]}.$((version_comp[1]+1)).0"
# Patch Version (bugfixes & hotfixes)
else
  latest_version="${version_comp[0]}.${version_comp[1]}.$((version_comp[2]+1))"
fi

echo "Update version from $version to $latest_version"
{
  echo "old_version=$version"
  echo "version=$latest_version"
} >> "$GITHUB_OUTPUT"
