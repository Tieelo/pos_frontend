#!/bin/bash
cd "$(dirname "$0")" && cd ..

pwd
#rm -rf node_modules/
#rm -rf dist/

export APPLICATION="pos_frontend"
export VERSION=$(grep -m 1 "^#" semver.txt | cut -c 2-)
export TAG="${APPLICATION}:${VERSION}"

docker kill ${APPLICATION}
docker rm ${APPLICATION}
docker rmi ${TAG}