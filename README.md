# pda

Portable Development Assistant

## Usage

1. Build the image: `docker build -t pda .`
1. Run a container: `docker run -it --mount src=code,dst=/home/src pda`

### Volumes

- `/home/src`

### Commands

- `vi` - edit a file
- `http google.com` - make an http request
