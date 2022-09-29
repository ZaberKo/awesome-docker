# Instruction

Use the command to build the image
```bash
# For gpu machine (default):
docker build --build-arg MACHINE_TYPE=gpu -t pytorch-rllib:22.08 .
# For cpu machine:
docker build --build-arg MACHINE_TYPE=cpu -t pytorch-rllib:22.08 .
```