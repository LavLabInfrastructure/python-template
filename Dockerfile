ARG PY_VERSION=3.11
FROM python:$PY_VERSION AS base

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

WORKDIR /app
COPY . /app/

USER $USERNAME

FROM base AS dev

USER root
RUN pip3 install --no-cache-dir hatch build
RUN hatch install dev

# Build the wheel for the default environment
RUN python3 -m build --wheel --outdir dist

USER $USERNAME

FROM base AS prod

# Install the built wheel from the dev stage
COPY --from=dev /app/dist/*.whl /tmp/
RUN pip3 install --no-cache-dir /tmp/*.whl

USER $USERNAME
