# Compile static OpenCV (Windows) executables using Docker

 - reproducible build environment thanks to Docker
 - includes opencv-contrib packages
 - no need for weird Windows Docker images thanks to crosscompile with mingw
 - CMakeLists example with:
    - OpenCV demo
    - UDP socket demo
 - based on [dockcross](https://github.com/dockcross/dockcross)
 - multistage Docker build to reduce final image size (still 2.6GB though)
 - tested on:
   - [Docker for Windows](https://www.docker.com/docker-windows)
   - [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)
   - [docker-tools](https://docs.docker.com/toolbox/toolbox_install_windows/), for Win7/Win8, see notes!
   

## Usage

```
# Pull image and extract the dockcross utility script
docker pull rknt/opencv-static-windows-buildenv-docker
docker tag rknt/opencv-static-windows-buildenv-docker buildenv
docker run --rm buildenv > ./dockcross
chmod +x ./dockcross

# Build executables in a separate build directory
./dockcross cmake -Bbuild -Hsrc -GNinja
./dockcross ninja -Cbuild
```

The latter two steps constitute `compile.sh`.

 - configure what gets built in `/src/CMakeLists.txt`
 - use `rm -r build` to build from a clean start
 - compiled .exe land in `/build`

If you need further libraries you can be lucky and they are part of the mingw install in the Docker image, or you'll have to cross-compile them in the docker image yourself.
The latter is what we did for OpenCV (see the buildenv-docker/Dockerfile).

## OpenCV

Change `ENV OPENCV_VERSION 3.3.1` in the Dockerfile to obtain your desired version.

Remove the `OPENCV_EXTRA_MODULES_PATH` line in the cmake section of the Dockerfile if you do not need opencv-contrib. If this is the case you can also remove the `ADD` line with opencv-contrib to skip downloading it.

## Docker on Windows 7 and 8
Docker for Windows only runs on Windows 10. For older versions you have to use [docker-tools](https://docs.docker.com/toolbox/toolbox_install_windows/) to install docker.

This version of docker handles filepast for volume mounts differently and this is not supported by the `dockcross` script so you have to insert the following under line `192` in the script.

`HOST_PWD=${HOST_PWD/c:/\/c}`

Otherwise Docker will complain about mounting /work due to the : behind the c in the path.

If you want to run this script on a drive other than C: you will probably have to mess around with the VirtualBox settings for docker.

## Acknowledgments

[dockcross](https://github.com/dockcross/dockcross) for crosscompiles using Docker.

Tobias Gerschner's example for static compiling of [OpenCV in dockcross](https://github.com/TobiG77/opencv-on-nerves) for ARM architectures.
