FROM python:3.7

# run some updates and set the timezone to eastern
# also install jq json viewer (https://stedolan.github.io/jq/)
RUN apt-get clean && apt-get update && apt-get -qy upgrade \
    && apt-get -qy install locales tzdata apt-utils software-properties-common build-essential python3 \
    && locale-gen en_US.UTF-8 \
    && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get -qy install jq groff

# install aws-cli, aws-shell, awscli-login,
# pyyml, pyjq, troposhphere, awacs, argcomplete, boto3,
# botocore, jsonschema, tabulate, jsonpatch, futures
RUN pip install --upgrade pip \
    && pip install awscli aws-shell awscli-login \
    && pip install pyyaml pyjq troposphere awacs argcomplete boto3 botocore jsonschema tabulate jsonpatch futures

COPY ["./setup-awscli-login", "/usr/local/bin/setup-awscli-login"]

# clean up after ourselves
RUN apt-get remove -qy --purge software-properties-common \
    && apt-get autoclean -qy \
    && apt-get autoremove -qy --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD [ "/bin/bash" ]
