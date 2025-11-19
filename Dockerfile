# Dockerfile: R + Quarto + Pagedown + Chromium (sans Snap)

FROM rocker/r-ver:4.5.1

# Installer dépendances système

RUN apt-get update && apt-get install -y --no-install-recommends 
wget curl gdebi-core libcurl4-openssl-dev libssl-dev libxml2-dev zlib1g-dev 
git pandoc fonts-dejavu 
chromium 
xvfb 
&& rm -rf /var/lib/apt/lists/*

# Installer Quarto CLI

ENV QUARTO_VERSION=1.4.550
RUN wget -q [https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb](https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb) && 
gdebi --non-interactive quarto-${QUARTO_VERSION}-linux-amd64.deb && 
rm quarto-${QUARTO_VERSION}-linux-amd64.deb

# Installer packages R utiles

RUN install2.r --error --skipinstalled 
tidyverse 
rmarkdown 
quarto 
pagedown

# Installer TinyTeX pour Quarto PDF

RUN Rscript -e "install.packages('tinytex', repos = '[https://cloud.r-project.org](https://cloud.r-project.org)')" && 
curl -sL "[https://yihui.org/tinytex/install-bin-unix.sh](https://yihui.org/tinytex/install-bin-unix.sh)" | sh

# Ajouter TinyTeX et Chromium au PATH

ENV PATH="/root/.TinyTeX/bin/x86_64-linux:/usr/bin:${PATH}"

# Vérifications

RUN quarto --version 
&& Rscript -e "tinytex::is_tinytex()" 
&& which pdflatex 
&& which xelatex 
&& chromium --version

CMD ["R"]
