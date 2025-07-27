#!/bin/bash
set -e

if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo "❌ .env file not found!"
  exit 1
fi

docker pull $DOCKERHUB_USERNAME/$IMAGE_NAME:$DOCKER_TAG

docker-compose down
docker-compose up -d

echo "✅ Deployment successful."
