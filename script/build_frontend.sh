#!/bin/bash
set -o errexit

source .secrets # enthält die Variablen DOCKER_USERNAME, DOCKER_PASSWORD und GITHUB_TOKEN
export BRANCH="feature/containerization"
export APPLICATION="pos_frontend"
export USER="tieelo"

git clone --branch=${BRANCH} https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/${USER}/${APPLICATION}.git
cd ${APPLICATION}

export VERSION="$(grep -m 1 "^#" semver.txt | cut -c 2-)"
export TAG="${USER}/${APPLICATION}:${VERSION}"
export LATEST="${USER}/${APPLICATION}:latest"

#npm install
npm install
npm run build

echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
docker build -f Dockerfile --no-cache -t ${TAG} .
docker tag ${TAG} ${LATEST}
docker push ${LATEST}
docker push ${TAG}
docker logout

cd ..
rm -fr ${APPLICATION}/