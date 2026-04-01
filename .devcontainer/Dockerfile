FROM node:24-bookworm AS node_lts

FROM golang:1.25.8-bookworm

ARG TARGETARCH

COPY --from=node_lts /usr/local/bin/node /usr/local/bin/node
COPY --from=node_lts /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node_lts /usr/local/include/node /usr/local/include/node

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        protobuf-compiler \
        ffmpeg \
        make \
        rsync \
        zip \
        unzip \
        xz-utils \
        pkg-config \
        clang \
        gcc-mingw-w64-x86-64 \
    && ln -sf ../lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -sf ../lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx \
    && ln -sf ../lib/node_modules/corepack/dist/corepack.js /usr/local/bin/corepack \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://bun.sh/install | bash \
    && ln -sf /root/.bun/bin/bun /usr/local/bin/bun \
    && ln -sf /root/.bun/bin/bunx /usr/local/bin/bunx
