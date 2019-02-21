# ct-awscli-utils-dockerized

Various AWS utils (AWS CLI, aws-shell, awscli-login) in one
Docker container. Also installs common dependencies used for things
like [account setup](https://github.com/CU-CommunityApps/aws-account-setup).

## About

:construction: WIP - documentation in progress

### What's Included

This is a base Python 3.7 image that runs updates, sets timezone to Eastern,
and installs the following:

- [aws-cli](https://aws.amazon.com/cli/)
- [aws-shell](https://github.com/awslabs/aws-shell)
- [awscli-login](https://github.com/techservicesillinois/awscli-login)
- [jq](https://stedolan.github.io/jq/)
- [pyyaml](https://pyyaml.org/) | [pyyaml github repo](https://github.com/yaml/pyyaml)
- [troposphere](https://github.com/cloudtools/troposphere)
- [awacs](https://github.com/cloudtools/awacs)
- [argcomplete](https://github.com/kislyuk/argcomplete)
- [boto3](https://github.com/boto/boto3)
- [botocore](https://github.com/boto/botocore)
- [jsonschema](https://github.com/Julian/jsonschema)
- [tabulate](https://bitbucket.org/astanin/python-tabulate)
- [jsonpatch](https://github.com/stefankoegl/python-json-patch)
- [futures](https://github.com/agronholm/pythonfutures)
