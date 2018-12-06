# pda

Portable Digital Assistant

## Usage

1. Build the image: `docker build -t pda .`
1. Run a container: `docker run -it --mount src=code,dst=/home/src pda`

### Volumes

* `/home/src` - **Warning:** permissions will be modified!

Inspect them with `docker volume ls` and `docker volume inspect <name>`
