ARG alpine_version=3.11.3

FROM alpine:${alpine_version} AS pandoc

ARG gid=1000
ARG uid=1000
ARG pandoc_version=2.9.1.1

WORKDIR /data

RUN wget https://github.com/jgm/pandoc/releases/download/${pandoc_version}/pandoc-${pandoc_version}-linux-amd64.tar.gz -O pandoc.tar.gz \
 && tar -xvzf pandoc.tar.gz --strip-components 1 -C /usr/local \

 # Users
 && addgroup -g ${gid} pandoc \
 && adduser -u ${uid} -s /bin/sh -S pandoc \
 && chown -R pandoc:pandoc /data \

 # TexLive
 && apk add --no-cache \
    texlive \
    texlive-luatex \
    texmf-dist-bibtexextra \
    texmf-dist-fontsextra \
    texmf-dist-lang \
    texmf-dist-latexextra

FROM pandoc AS eisvogel

ARG eisvogel_version=1.4.0

# Get template
RUN mkdir -p /templates/eisvogel \
 && wget https://github.com/Wandmalfarbe/pandoc-latex-template/releases/download/v${eisvogel_version}/Eisvogel-${eisvogel_version}.tar.gz -O /templates/eisvogel/eisvogel.tar.gz \
 && tar -xvzC /templates/eisvogel -f /templates/eisvogel/eisvogel.tar.gz \
 && mv /templates/eisvogel/eisvogel.tex /templates/eisvogel.tex \
 && rm -rf /templates/eisvogel

COPY ./entrypoint /entrypoint

RUN chown -R pandoc:pandoc /entrypoint /templates

ENV OUTPUT_PATH='result.pdf'

USER pandoc

ENTRYPOINT [ "/entrypoint" ]

CMD [ "--number-sections" ]
