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
    -v=$HOME/workspace:/root/workspace \
    -v=$HOME/.mujoco:/root/.mujoco \
    -v=$HOME/ray_results:/root/ray_results \
    --gpus=all \
    --shm-size=8g \
    -P \
    pytorch-rllib:22.08
```
Or use the `docker-compose.yaml` file in the folder.

## Post Initialization
Then enable the ssh server and change the password
```bash
docker exec rllib service ssh start
docker exec -it rllib passwd
```

Create a new shell to operate the container, or connect the container through ssh.
```bash
docker exec -it rllib /bin/bash
```

Finally, install gym-mujoco in the **container**:
```bash
pip install "gym[mujoco]"
```