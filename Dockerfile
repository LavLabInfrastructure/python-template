ARG PY_VERSION=3.11
FROM python:$PY_VERSION AS prod

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

WORKDIR /app
COPY . /app/

# Install Hatch and use it to install the default environment dependencies
RUN pip3 install --no-cache-dir hatch && hatch env install default

RUN chown -R $USERNAME /app 
USER $USERNAME

FROM prod AS dev

USER root
RUN hatch env install dev
USER $USERNAME

FROM prod
