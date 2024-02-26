ARG PY_VERSION=3.11

FROM python:$PY_VERSION as base
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
# create non-root user (primarily for devcontainer)
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

WORKDIR /app
COPY . /app/
RUN chown -R $USERNAME /app

FROM base AS hatch
RUN pip3 install hatch
USER $USERNAME
ENTRYPOINT hatch run

FROM base AS dev
RUN pip3 install hatch $(find requirements -name 'requirement*.txt' -exec echo -n '-r {} ' \;)
RUN hatch build
USER $USERNAME

FROM base AS prod
COPY --from=dev /app/dist/*.whl /tmp
RUN pip3 install /tmp/*.whl
USER $USERNAME