# Taranis AI Website

This repository contains the website 'taranis.ai' which is the documentation for the OSINT tool [Taranis AI](https://github.com/taranis-ai/taranis-ai)


## Develop

> [!NOTE]
> This repository uses git-lfs

To be able to run local checks prior a commit,
[htmltest](https://github.com/wjdp/htmltest) and [prek](https://github.com/j178/prek) or [pre-commit](https://github.com/pre-commit/pre-commit) needs to be installed.

Commits need to be sigend off to be able to merge.

### Requirements

* [go](https://go.dev/doc/install)
* [hugo-extended](https://github.com/gohugoio/hugo)

Run ```hugo mod get``` and ```hugo mod tidy``` to install & cleanup required modules.

Start the local server with

```bash
hugo server
```



## Deploy

GitHub Actions publish master branch to GitHub Pages

### Info

Built with [Docsy](https://github.com/google/docsy)
