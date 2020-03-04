# Pandoc Eisvogel image

A docker image containing Pandoc and the EisVogel template to generate pdf files from markdown.

## Getting started

Using this image is as easy as:

1. Run `docker pull survivorbat/pandoc-eisvogel:latest`
1. Run `docker run --rm -e OUTPUT_PATH='my_compiled_document.pdf' -v <directory-you-want-to-compile>:/data survivorbat/pandoc-eisvogel:latest`

A few moments later the compiled pdf called my_compiled_document.pdf will appear in a new directory called `out`.

## Known quirks

- Embedding images is not as easy as it should be
