FROM rocker/r-ver:4.4.1

RUN apt-get update -qq && \
    apt-get install -y -qq --no-install-recommends \
        libz-dev \
        libpoppler-cpp-dev \
        pandoc \
        curl

RUN curl -L http://bit.ly/google-chrome-stable -o chrome.deb && \
    apt-get -y install ./chrome.deb && \
    rm chrome.deb

COPY Renviron /.Renviron
COPY google-chrome /usr/local/bin/
