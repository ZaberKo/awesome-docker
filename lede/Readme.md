# LEDE Compiler System

Based on Ubuntu 20.04 LTS

## Build the image from Dockerfile

```bash
docker build -t lede:20.04 .
```

The default user is `fubuki`, you can change the username at **building time** by changing the Dockerfile with `ENV USERNAME=<xxx>`

## Start the system

Initialize the container

```bash
docker run -it --name=lede  -v /your/host/path:/openwrt lede:20.04 /bin/bash
```
You can specify your host user uid and gid by injecting env vars: `-e UID=$(id -u)` and `-e GID=$(id -g)`. This is helpful when using bind mounts.

Note: `/your/host/path` must be in a case-sensitive file system. That is to say, you cannot set it to a NTFS drive or some HFS/APFS without case-sensitive feature.

Then use git to pull the lede repo (in the container):

```bash
git clone https://github.com/coolsnowwolf/lede
```






## Compile the LEDE

The following instructions are executed in the container.



Update and install the 3rd party plugins

```bash
./scripts/feeds update -a
./scripts/feeds install -a
```



Config the LEDE system compile parameters

```bash
make menuconfig
```



Download the `dl`

```bash
make -j$(nproc) download V=s
```



Finally start the compiling

```bash
make -j$(($(nproc) + 1)) V=s
```

