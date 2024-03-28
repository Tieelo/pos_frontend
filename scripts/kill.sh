#!/bin/bash
set -o errexit
cd "$(dirname "$(dirname "$0")")"

export APPLICATION="pos_frontend"
export VERSION=$(grep -m 1 "^#" semver.txt | cut -c 2-)
export TAG="${APPLICATION}:${VERSION}"

rm -rf node_modules/
rm -rf dist/
docker kill ${APPLICATION}
docker rm ${APPLICATION}
docker rmi ${TAG}