# ct-awscli-utils-dockerized

Various AWS utils (AWS CLI, aws-shell, awscli-login) in one Docker container.

## About

- Available via Docker Hub currently
  - Nothing sensitive in the container and makes pulling image and getting started more straight forward
- Repository Name: mikesprague/awscli-utils

### What's Included

This is a base Python 3.7 image that runs updates, sets timezone to Eastern,
and installs the following:

- [aws-cli](https://aws.amazon.com/cli/)
- [aws-shell](https://github.com/awslabs/aws-shell)
- [awscli-login](https://github.com/techservicesillinois/awscli-login)
- [jq](https://stedolan.github.io/jq/)
- [boto3](https://github.com/boto/boto3)
- [botocore](https://github.com/boto/botocore)
- [wheel](https://github.com/pypa/wheel)

## How to Use

- Pull this repository up and go into the directory

  ```bash
    git pull https://github.com/CU-CommunityApps/ct-awscli-utils-dockerized.git
    cd ct-awscli-utils-dockerized
  ```

### Recommended usage (via docker-compose)

This will set some environment variables and if you haven't already set up `awscli-login` it will create a default config

- Edit the `setup.env` file to set your preferences
  - Optionally disable `awscli-login` configuration - useful if using with a non-Cornell account where you'll connect with access keys and not use `awscli-login`
  - Optionally enable [`oh-my-zsh`](https://github.com/robbyrussell/oh-my-zsh/) and/or [`fx`](https://github.com/antonmedv/fx/) in the `setup.env` file
  - If enabled, container will start with a `zsh` shell versus a `bash` shell

- Bring container up

  ```bash
    docker-compose up --detach
  ```

- Attach to a bash shell

  ```bash
  docker-compose exec awscli-utils bash -c "./setup-awscli-login"
  ```

- _**Note:** Last 2 steps can be called together_

  ```bash
    docker-compose up --detach && docker-compose exec awscli-utils bash -c "./setup-awscli-login"
  ```

- _**Note:** The container will remain running unless you manually stop it (this is useful if you want to return to a session with your prior setup, bash history, etc.)_

- You should now be able to run any `aws` commands (including `aws login`) or the `aws-shell`

- _**Note:** Subsequent calls to a running container can be made using this command_

  ```bash
    docker-compose run --rm awscli-utils bash
  ```

- Stopping the container (after exiting it)

  ```bash
    docker-compose down
  ```

- Check if you have any running containers

  ```bash
    docker-compose ps
  ```

- Alternative command to bring up a container that removes itself on exit

  ```bash
    docker-compose run --rm awscli-utils bash -c "./setup-awscli-login"
  ```
