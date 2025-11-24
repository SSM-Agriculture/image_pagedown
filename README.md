# 🐳 ssmagr/pagedown

Image Docker basée sur [R](https://www.r-project.org/) avec [pagedown](https://github.com/rstudio/pagedown) préinstallé, prête pour la génération de documents PDF depuis R Markdown via Chrome headless.

## 📦 Contenu de l'image

- **R 4.4.1** (base `rocker/r-ver`)
- **Google Chrome** (stable) pour le rendu PDF
- **Pagedown** (package R) pour la conversion HTML → PDF
- **Pandoc** pour le traitement des documents
- **Wrapper Chrome** configuré avec `--no-sandbox` pour Docker

## 🚀 Utilisation

### Pull depuis Docker Hub

```bash
docker pull ssmagr/pagedown:latest
```

### Exemple : Générer un PDF avec pagedown

```bash
docker run --rm -v $(pwd):/workspace -w /workspace ssmagr/pagedown:latest \
  Rscript -e "pagedown::chrome_print('mon_document.Rmd')"
```

### Utiliser dans un Dockerfile

```dockerfile
FROM ssmagr/pagedown:latest

COPY mon_script.R .
RUN Rscript mon_script.R
```

## 🔧 Configuration technique

L'image intègre la solution décrite dans [cet article r-bloggers](https://www.r-bloggers.com/2021/05/using-pagedown-in-docker/) pour contourner les problèmes de sandbox Chrome dans Docker :

- **`google-chrome` wrapper** : Script bash dans `/usr/local/bin/` qui ajoute automatiquement `--no-sandbox`
- **`Renviron`** : Configure le PATH pour que R trouve le wrapper en priorité

