#!/bin/bash
set -e

if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo "❌ .env file not found!"
  exit 1
fi

docker build -t $IMAGE_NAME .

docker tag $IMAGE_NAME $DOCKERHUB_USERNAME/$IMAGE_NAME:$DOCKER_TAG

echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin

docker push $DOCKERHUB_USERNAME/$IMAGE_NAME:$DOCKER_TAG

echo "✅ Image pushed to DockerHub."

