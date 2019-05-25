#! /bin/bash

# Docker deploy versioning

version=`cat ci/deploy/VERSION`
username="colcolt"
docker_image="makefile_completer"

git add -A
git commit -m "version $version"
git tag -a "$version" -m "version $version"
git push
git push --tag

docker tag $username/$docker_image:latest $username/$docker_image:$version

docker push $username/$docker_image:$version
docker push $username/$docker_image:latest