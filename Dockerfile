FROM alpine:3.18

RUN apk add --no-cache \
    python3 \
    py3-pip \
    git \
    curl \
    build-base \
    libffi-dev \
    py3-lxml \
    tini \
    su-exec \
    bash

RUN git clone https://github.com/searxng/searxng.git /searxng
WORKDIR /searxng

RUN pip install --upgrade pip && pip install -e . && pip install uvicorn uvloop

COPY ./settings.yml /etc/searxng/settings.yml

EXPOSE 8080
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["searxng", "run"]
