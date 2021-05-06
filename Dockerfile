FROM python:3.9.5-slim-buster
# run some updates
# install some common packages plus jq, zsh, and vim
# set the timezone to eastern
RUN apt-get clean && apt-get update \
    && apt-get install --no-install-recommends -qy locales tzdata apt-utils apt-transport-https lsb-release gnupg software-properties-common build-essential vim jq zsh groff git curl wget zip unzip \
    && locale-gen en_US.UTF-8 \
    && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /.cache/*

# upgrade pip
# install awscli, aws-shell, awscli-login, boto3, botocore, wheel, urllib
RUN pip install --upgrade pip \
    && pip install --no-cache-dir awscli aws-shell boto3 botocore wheel urllib3 awscli-login

## install azure-cli, aws systems manager session manager plugin, and terraform
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null \
    && AZ_REPO=$(lsb_release -cs) \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list \
    && apt-get update \
    && apt-get install --no-install-recommends -qy azure-cli \
    # install aws systems manager session manager plugin
    && curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" \
    && dpkg -i session-manager-plugin.deb \
    # install terraform
    # && TERRAFORM_VERSION=0.12.23 \
    && TERRAFORM_VERSION=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'` \
    && wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip ./terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && mv ./terraform /usr/bin \
    && rm ./terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# clean up after ourselves
RUN apt-get remove -qy --purge software-properties-common \
    && apt-get autoclean -qy \
    && apt-get autoremove -qy --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /.cache/* \
    && rm /session-manager-plugin.deb \
    && rm -rf /usr/lib/node_modules

COPY [ "./configure-cloud-utils", "/usr/local/bin/configure-cloud-utils" ]

CMD [ "/bin/zsh" ]
