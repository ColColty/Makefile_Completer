#! /bin/bash

# Docker deploy versioning

version=`cat ci/deploy/VERSION`
username="colcolt"
docker_image="makefile_completer"

docker tag $username/$docker_image:latest $username/$docker_image:$version

docker push $username/$docker_image:$version
docker push $username/$docker_image:latest