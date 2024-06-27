ARG PY_VERSION=3.12

FROM python:$PY_VERSION as base
# create non-root user (primarily for devcontainer)
RUN groupadd --gid 1000 vscode \
    && useradd --uid 1000 --gid 1000 -m vscode

WORKDIR /app
COPY . /app/
RUN chown -R vscode /app
USER vscode

FROM base AS hatch
RUN pip3 install hatch
RUN hatch build
ENV HATCH_ENV=default
ENTRYPOINT ["hatch", "run"]

FROM base AS prod
COPY --from=hatch /app/dist/*.whl /tmp
RUN pip3 install /tmp/*.whl

FROM base AS dev
RUN pip3 install hatch 
RUN find requirements -name 'requirement*.txt' | while read requirement; do \
        pip3 install -r "$requirement"; \
    done
RUN pip3 install -r requirements.txt
