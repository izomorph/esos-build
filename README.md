# esos 
Build ESOS Images using Docker

## Installation
To build ESOS using Docker, clone repo and then, while in the repo folder, create the container. Begin by executing:

```console
# docker build --rm -t esos:2.x.x .
```

After succesfull build, run the container using docker-compose (if you do not have it, install it first, by using your system package manager, or pip).
```console
# docker-compose up -d
```

After the build is finished, the container exits and you should have two files in ths esos build folder.
esos-git_commit.img.bz2
esos-git-commit.zip

The first one is a compressed flashable image, the second one is a distribution package, you can use to make a custom installation (for example add RAID utilities for your controller).

## Integration with CI/CD
If you want to integrate this builder into your CI/CD pipeline (for example Jenkins), you can do so by making Jenkins trigger the build, when an new tag is commited on the ESOS git repo.

In that case the Jenkins script can run something like this:
```console
# cd esos-build-folder
# docker-compose up -d
# cp $(BUILD_DIR)/{esos-*.img.bz2,esos-*.zip} /path/to/upload/folder
```
