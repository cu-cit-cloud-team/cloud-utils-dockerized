# ct-cloud-utils-dockerized

Various cloud utils (AWS CLI, aws-shell, awscli-login, Azure CLI, Terraform) in one Docker container.

## About

- Available via Docker Hub (nothing sensitive in the container and makes pulling image and getting started more straight forward)
  - Name: [mikesprague/cloud-utils](https://hub.docker.com/r/mikesprague/cloud-utils)
  - URL: [https://hub.docker.com/r/mikesprague/cloud-utils](https://hub.docker.com/r/mikesprague/cloud-utils)

### What's Included

This is a base Python 3.7 base image that runs updates, sets timezone to Eastern,
and installs the following:

- [aws-cli](https://aws.amazon.com/cli/)
- [session-manager-plugin](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html)
- [aws-shell](https://github.com/awslabs/aws-shell)
- [awscli-login](https://github.com/techservicesillinois/awscli-login)
- [azure cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
- [terraform](https://www.terraform.io/)
- [jq](https://stedolan.github.io/jq/)
- [boto3](https://github.com/boto/boto3)
- [botocore](https://github.com/boto/botocore)
- [wheel](https://github.com/pypa/wheel)
- [groff](https://www.gnu.org/software/groff/)
- [vim](https://www.vim.org/)
- [zsh](https://www.zsh.org/)

**Optionally installed (added at runtime based on config):**

- [fx](https://github.com/antonmedv/fx)
- [nodejs](https://nodejs.org/)
- [npm](https://github.com/npm/cli)
- [oh-my-zsh](https://ohmyz.sh/)

## How to Use

- Clone this repository down and go into the directory:

  ```bash
    git clone https://github.com/CU-CommunityApps/ct-cloud-utils-dockerized.git
    cd ct-cloud-utils-dockerized
  ```

- _**Note:** If you have an existing folder with files you want to use this with, copy the `docker-compose.yml` file to your folder and then proceed_

### Recommended usage (via docker-compose)

This will set some environment variables and if you haven't already set up `awscli-login` it will create a default config

- Edit the `docker-compose.yml` file to set your preferences
  - Optionally disable `awscli-login` configuration - useful if using with a non-Cornell account where you'll connect with access keys and not use `awscli-login`
  - Optionally enable [`oh-my-zsh`](https://github.com/robbyrussell/oh-my-zsh/) and/or [`fx`](https://github.com/antonmedv/fx/)
  - If enabled, container will start with a `zsh` shell instead of a `bash` shell

- Bring a persistent container up:

  ```bash
    docker-compose up --detach
  ```

- Attach to a shell:

  ```bash
  docker-compose exec awscli-utils configure-cloud-utils
  ```

- _**Note:** Last 2 steps can be called together:_

  ```bash
    docker-compose up --detach && docker-compose exec awscli-utils configure-cloud-utils
  ```

- You should now be able to run commands from any of the installed utilities (including `aws`, `aws login`, `aws-shell`, `azure`, and `terraform`)

- _**Note:** The container will remain running unless you manually stop it (this is useful if you want to return to a session with your prior setup, bash history, etc.) - reaatch to it with the following command:_

  ```bash
    docker-compose exec awscli-utils bash
  ```

- Stopping the container (after exiting it):

  ```bash
    docker-compose down
  ```

- Check if you have any running containers:

  ```bash
    docker-compose ps
  ```

- Alternative command to bring up a container that removes itself on exit:

  ```bash
    docker-compose run --rm awscli-utils configure-cloud-utils
  ```

#### Using without docker-compose

- _**Note:** If you want your container to persist, remove the `--rm` flag from the commands below_

- This command will mount your current directory as the working directory in the container:

  ```bash
    docker run --rm -it \
      -e SETUP_AWSCLI_LOGIN=true \
      -e DUO_FACTOR="auto" \
      -e NETID="" \
      -e SETUP_OHMYZSH=true \
      -e SETUP_FX=false \
      -v $HOME/.aws:/root/.aws \
      -v $HOME/.aws-login:/root/.aws-login \
      -v $PWD:/mounted-home \
      -w /mounted-home \
      mikesprague/cloud-utils
  ```

- You can also alias the same command in your bash/zsh profile (bash via `~/.profile` or `~/.bashrc` or Zsh via `~/.zshrc`) to simplify reuse:

  ```bash
    alias cloud-utils="docker run --rm -it \
      -e SETUP_AWSCLI_LOGIN=true \
      -e DUO_FACTOR="auto" \
      -e NETID="" \
      -e SETUP_OHMYZSH=true \
      -e SETUP_FX=false \
      -v $HOME/.aws:/root/.aws \
      -v $HOME/.aws-login:/root/.aws-login \
      -v $PWD:/mounted-home \
      -w /mounted-home \
      mikesprague/cloud-utils"
  ```

- :point_up: The above snippet will make the command `cloud-utils` available in your shell and start the container in whatever directory you run the `cloud-utils` command
