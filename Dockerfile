FROM python:3.7

# run some updates;
# install a few common packages plus jq, zsh, and vim;
# set the timezone to eastern;
RUN apt-get clean && apt-get update && apt-get upgrade -qy \
    && apt-get install -qy locales tzdata apt-utils apt-transport-https lsb-release gnupg software-properties-common build-essential vim jq zsh groff \
    && locale-gen en_US.UTF-8 \
    && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata

## install azure-cli
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null \
    && curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null \
    && AZ_REPO=$(lsb_release -cs) \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list \
    && apt-get update \
    && apt-get install -qy azure-cli

RUN wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip \
    && unzip ./terraform_0.11.13_linux_amd64.zip \
    && mv ./terraform /usr/bin

# upgrade pip;
# install awscli, aws-shell, aws-sam-cli, awscli-login, boto3, botocore, wheel, urllib;
RUN pip install --upgrade pip
RUN pip install awscli aws-shell aws-sam-cli awscli-login boto3 botocore wheel urllib3==1.24.3

# install aws systems manager session manager plugin
RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" \
    && dpkg -i session-manager-plugin.deb

COPY [ "./configure-cloud-utils", "/usr/local/bin/configure-cloud-utils" ]

# clean up after ourselves;
RUN apt-get remove -qy --purge software-properties-common \
    && apt-get autoclean -qy \
    && apt-get autoremove -qy --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm /session-manager-plugin.deb \
    && rm -rf /usr/lib/node_modules

CMD [ "/bin/zsh" ]
