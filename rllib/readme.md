# Instruction

## Build Image
Use the command to build the image
```bash
# For gpu machine (default):
docker build --build-arg MACHINE_TYPE=gpu -t pytorch-rllib:22.08 .
# For cpu machine:
docker build --build-arg MACHINE_TYPE=cpu -t pytorch-rllib:22.08 .
```

## Run Container

Recommended command for GPU node:
```bash
docker run -it \
    --name=rllib \
    -v=<workspace>:/root/workspace \
    --gpus=all \
    -P \
    pytorch-rllib:22.08
```

Then enable the ssh server and change the password
```bash
docker exec rllib service ssh start
docker exec -it rllib passwd
```