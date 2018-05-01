# retrocompetition
Contender for the OpenAI Retro Competition!

# Environment Scripts

`aws.sh`: this script helps manage the AWS environment including spinning up an instance, setting the instance up, and connecting

`docker.sh`: this script helps manage the Docker environment including building a new Docker for submission to OpenAI and pushing the Docker

# Abbreviated Setup Instructions

Here are simplified instructions to get up and runnning with the Gym environment

## Install Software

1. **Install Lua 5.1:** see [these instructions](https://github.com/openai/retro) for the Homebrew version or below if you want to skip Homebrew

2. **Install Docker:** simply install the app [for Mac](https://www.docker.com/docker-mac)

3. **Install Steam:** download the installer [here](https://store.steampowered.com/about/)

4. **Install PyTorch:** run with `pip install torch torchvision` (make sure you have torch 0.40 or some code may not run)

## Download Packages / Code

1. **Clone Our Repo:** `git pull git@github.com:theforager/retrocompetition.git`

2. **Install gym-retro:** `pip install gym-retro`

3. **Clone Retro Competition Repo:** `git clone --recursive https://github.com/openai/retro-contest.git`

4. **Install Retro Competition:** `pip install -e "retro-contest/support[docker,rest]"` (you can remove the brackets to also install the gym_remote package, which I think is preferable but isn't stated in instructions for some reason)

## Buy Sonic on Steam and Import

1. **Buy Sonic on Steam:** Sonic the Hedgehog 1 is $5 on Steam

2. **Import Sonic into Retro Gym:** run this code `python -m retro.import.sega_classics` (you can leave the SteamGuard field empty if you're already logged in on this computer)

## Setup Dockers

1. **Pull Remote Environment for Testing:** pull the Docker `docker pull openai/retro-env` and then tag it `docker tag openai/retro-env remote-env`

2. **Login to Remote Docker:** run `docker login retrocontestajvidhoekmrcpqzt.azurecr.io --username retrocontestajvidhoekmrcpqzt  --password 9zqhOlFc=EohEXrXfWi6mKbR9wMAXTB4` to connect to our remote docker environment using our team username and password

## Add AWS Environment Variables (Skip if Not Using AWS)

1. **Export Environment Variables:** add the following lines to your shell setup script of choice, e.g. `~/.bash_profile` on Mac, to define environment variables needed for AWS in the `aws.sh` script and Ansible:

`export AWS_ACCESS_KEY_ID=...` : secret access ID from EC2 console

`export AWS_SECRET_ACCESS_KEY=...` : secret key password from EC2 console

`export AWS_KEY_NAME=...` : name of SSH key without .pem (located at `~/.ssh/**$AWS_KEY_NAME**.pem`)


## Test It Out!

1. **Run It Locally:** with `python random-agent/random-agent-contest.py local`

2. **Test Building the Docker:** with `./docker.sh build random-agent v1`

3. **Test Run the Docker:** with `./docker.sh test random-agent v1`



## Skipping Homebrew
I don't like Homebrew because of all the permissions changes, so I worked around the dynamic library thing with this code:

```
sudo make macosx install
```

Then add this code to the bottom of the `src/Makefile`:

```
liblua.5.1.dylib: $(CORE_O) $(LIB_O)
        $(CC) -dynamiclib -o $@ $^ $(LIBS) -arch x86_64 -compatibility_version 5.1.5 -current_version 5.1.5 -install_name @rpath/$@
```

Remaining commands:

```
make -C src liblua.5.1.dylib
sudo mv src/liblua.5.1.dylib /usr/local/lib/
sudo mkdir -p /usr/local/opt/lua@5.1/lib/

sudo ln -s /usr/local/lib/liblua.5.1.dylib /usr/local/opt/lua@5.1/lib/liblua.5.1.dylib
```
