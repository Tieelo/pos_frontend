#!/bin/bash
set -o errexit

source .secrets # enthält die Variablen DOCKER_USERNAME, DOCKER_PASSWORD und GITHUB_TOKEN
export BRANCH="feature/containerization"
export APPLICATION="pos_fronted"
export USER="Tieelo"

git clone --branch=${BRANCH} https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/${USER}/${APPLICATION}.git
cd ${APPLICATION}

export VERSION="$(grep -m 1 "^#" semver.txt | cut -c 2-)"
export TAG="${APPLICATION}:${VERSION}"

git clone --branch=${BRANCH} https://${USER}:${TOKEN}@github.com/${USER}/${APPLICATION}.git
cd ${APPLICATION}

#npm install
npm ci
npm run build

echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
docker build -f Dockerfile --no-cache -t ${TAG}
docker push ${DOCKER_USERNAME}/${APPLICATION}:latest
docker push ${DOCKER_USERNAME}/${TAG}

cd ..
rm -fr ${APPLICATION}