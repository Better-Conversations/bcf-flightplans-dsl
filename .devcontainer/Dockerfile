FROM mcr.microsoft.com/devcontainers/ruby:1-3.3-bullseye

ADD https://github.com/Enter-tainer/typstyle/releases/download/v0.11.28/typstyle-linux-arm64 /usr/bin/typstyle
RUN chmod +x /usr/bin/typstyle

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        fontconfig \
        fswatch \
    && rm -rf /var/lib/apt/lists/*

# Add Source Sans Pro font
# Adpated from https://gist.github.com/jacksonpradolima/840b4a20c617204a65b15da61e124bf6
# The RUN <<EOF set -e ... EOF has the effect of chaining all the commands together, so that if one fails, the whole RUN
# command fails, but only one layer is created.
RUN <<EOF
set -e

cd $(mktemp -d)
TEMP_DIR=$(pwd)

wget https://github.com/adobe-fonts/source-sans-pro/archive/2.020R-ro/1.075R-it.zip
unzip 1.075R-it.zip
cp source-sans-2.020R-ro-1.075R-it/OTF/*.otf /usr/local/share/fonts

fc-cache -f -v
rm -rf $TEMP_DIR
EOF