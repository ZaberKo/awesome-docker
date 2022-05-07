# LEDE Compiler System

Based on Ubuntu 20.04 LTS

## Build the image from Dockerfile

```bash
docker build -t lede --rm .
```

The default user is `fubuki`, you can change the name in Dockerfile with `ARG USERNAME=xxx`

## Start the system

Initialize the container

```bash
docker run -it --name=lede  -v /your/host/path:/home/fubuki/lede lede /bin/bash
```

Note: `/your/host/path` must be in a case-sensitive file system. That is to say, you cannot set it to a NTFS drive or some HFS/APFS without case-sensitive feature.



Then use git to pull the lede repo (in the container):

```bash
git clone https://github.com/coolsnowwolf/lede ~/lede
```



If you want use `sudo` in the container, you need to change the password of `fubuki` by

```bash
docker exec -u root -it lede passwd fubuki
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

