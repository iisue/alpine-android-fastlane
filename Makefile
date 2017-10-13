default: docker_build

docker_build:
	@docker build \
		-t iisue/alpine-android-fastlane \
		--build-arg VCS_REF=`git rev-parse --short HEAD` .
