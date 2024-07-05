FROM mcr.microsoft.com/devcontainers/ruby:1-3.3-bullseye

ADD https://github.com/Enter-tainer/typstyle/releases/download/v0.11.28/typstyle-linux-arm64 /usr/bin/typstyle
RUN chmod +x /usr/bin/typstyle

RUN apt-get update && apt-get install -y --no-install-recommends \
    fswatch && \
    rm -rf /var/lib/apt/lists/*