#!/bin/bash
set -o errexit
cd "$(dirname "$0")" && cd ..

export APPLICATION="pos_frontend"
export VERSION="$(grep -m 1 "^#" semver.txt | cut -c 2-)"
export TAG="${APPLICATION}:${VERSION}"

#npm install
#npm ci
npm run build

docker build -f Dockerfile --no-cache -t ${TAG} .
docker run -d --name ${APPLICATION} -p 8080:8080 ${TAG}
docker logs -f ${APPLICATION}