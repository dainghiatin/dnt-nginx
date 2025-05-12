#!/bin/bash

# Check if tag parameter is provided
if [ -z "$1" ]; then
  echo "Error: Tag parameter is required"
  echo "Usage: ./build-and-push.sh <tag>"
  exit 1
fi

# Set the tag from the first parameter
TAG=$1

# Navigate to the directory containing the Dockerfile (if needed)
# cd "$(dirname "$0")"

# Build the Docker image
echo "Building Docker image: jeyluu/nginx:${TAG}"
docker build -t jeyluu/nginx:${TAG} .

# Check if build was successful
if [ $? -ne 0 ]; then
  echo "Error: Docker build failed"
  exit 1
fi

echo "Docker image built successfully"

# Login to Docker Hub (you'll be prompted for credentials)
echo "Logging in to Docker Hub"
docker login

# Check if login was successful
if [ $? -ne 0 ]; then
  echo "Error: Docker Hub login failed"
  exit 1
fi

# Push the image to Docker Hub
echo "Pushing image to Docker Hub: jeyluu/nginx:${TAG}"
docker push jeyluu/nginx:${TAG}

# Check if push was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to push image to Docker Hub"
  exit 1
fi

echo "Image successfully pushed to Docker Hub: jeyluu/nginx:${TAG}"