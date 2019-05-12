FROM python:3.7

# run some updates;
# install a few common packages plus jq, zsh, and vim;
# set the timezone to eastern;
RUN apt-get clean && apt-get update && apt-get upgrade -qy \
    && apt-get install -qy locales tzdata apt-utils software-properties-common build-essential vim jq zsh groff \
    && locale-gen en_US.UTF-8 \
    && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata

# upgrade pip;
# install awscli, aws-shell, aws-sam-cli, awscli-login, pyjq, boto3, botocore, wheel;
RUN pip install --upgrade pip
RUN pip install awscli aws-shell aws-sam-cli awscli-login pyjq boto3 botocore wheel

# clean up after ourselves;
RUN apt-get remove -qy --purge software-properties-common \
    && apt-get autoclean -qy \
    && apt-get autoremove -qy --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD [ "/bin/bash" ]
