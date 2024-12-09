#!/bin/bash
set -o errexit
cd "$(dirname "$0")" && cd ..

export TOKEN=""
export BRANCH="feature/containerization"
export APPLICATION="pos_fronted"
export USER="Tieelo"


export APPLICATION="pos_frontend"
export VERSION="$(grep -m 1 "^#" semver.txt | cut -c 2-)"
export TAG="${APPLICATION}:${VERSION}"

git clone --branch=${BRANCH} https://${USER}:${TOKEN}@github.com/${USER}/${APPLICATION}.git
cd ${APPLICATION}

#npm install
npm ci
npm run build

docker build -f Dockerfile --no-cache -t ${TAG}
docker run -d --name ${APPLICATION} -p 8080:8080 ${TAG}
docker logs -f ${APPLICATION}