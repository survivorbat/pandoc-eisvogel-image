ARG alpine_version=3.11.3

FROM alpine:${alpine_version}

ARG gid=1000
ARG uid=1000
ARG pandoc_version=2.9.1.1

WORKDIR /data

RUN wget https://github.com/jgm/pandoc/releases/download/${pandoc_version}/pandoc-${pandoc_version}-linux-amd64.tar.gz -O pandoc.tar.gz \
 && tar -xvzf pandoc.tar.gz --strip-components 1 -C /usr/local \
 && addgroup -g ${gid} pandoc \
 && adduser -u ${uid} -s /bin/sh -S pandoc \
 && chown -R pandoc:pandoc /data \
 && apk add --update --no-cache \
    texlive \
    texlive-luatex \
    texmf-dist-bibtexextra \
    texmf-dist-fontsextra \
    texmf-dist-lang \
    texmf-dist-latexextra

USER pandoc

ENTRYPOINT [ "pandoc" ]
