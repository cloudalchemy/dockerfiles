#!/bin/bash

# Script searches for Dockerfiles, builds images from them, and uses directory
# structure to create a tag. For example if Dockerfile lives in
# './distro/version/Dockerfile' script will create tag: 'distro-version'
# Next tag is added to `repo` variable and pushed to remote rpository

repo="quay.io/paulfantom/molecule-systemd"

for path in $(find . -name Dockerfile); do
	tag=$(dirname $path | sed 's|./||' | sed 's|/|-|')
	image="$repo:$tag"
	docker build --load -t "$image" "$(dirname "$path")"
	docker push "$image"
done
