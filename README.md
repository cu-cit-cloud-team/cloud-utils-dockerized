# ct-awscli-utils-dockerized

Various AWS utils (AWS CLI, aws-shell, awscli-login) in one Docker container. Also installs common dependencies used for things like [account setup](https://github.com/CU-CommunityApps/aws-account-setup).

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
- [pyjq](https://github.com/doloopwhile/pyjq))
- [boto3](https://github.com/boto/boto3)
- [botocore](https://github.com/boto/botocore)
- [wheel](https://github.com/pypa/wheel)

## How to Use

### Recommended usage (via `docker-compose`)

This will set some environment variables and if you haven't already set up `awscli-login` it will create a default config

- Pull this repository up and go into the directory

  ```bash
    git pull https://github.com/CU-CommunityApps/ct-awscli-utils-dockerized.git
    cd ct-awscli-utils-dockerized
  ```

- Edit the `setup.env` file to set your preferences

- Bring container up

  ```bash
    docker-compose up --detach
  ```

- Attach to a bash shell

  ```bash
  docker-compose exec awscli-utils zsh -c "./setup-awscli-login"
  ```

- _**Note:** Last 2 steps can be called together_

  ```bash
    docker-compose up --detach && docker-compose exec awscli-utils zsh -c "./setup-awscli-login"
  ```

- You should now be able to run any `aws` commands (including `aws login`) or the `aws-shell`

- Stopping the container (after exiting it)

  ```bash
    docker-compose down
  ```

- Alternative command to bring up container that removes itself on exit

```bash
  docker-compose run --rm awscli-utils bash -c "./setup-awscli-login"
```
