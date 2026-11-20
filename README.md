# Taranis AI Website

This repository contains the website 'taranis.ai' which is the documentation for the OSINT tool [Taranis AI](https://github.com/taranis-ai/taranis-ai)


## Develop

> [!NOTE]
> This repository uses git-lfs

To be able to run local checks prior a commit,
[htmltest](https://github.com/wjdp/htmltest) and [prek](https://github.com/j178/prek) or [pre-commit](https://github.com/pre-commit/pre-commit) needs to be installed.

Commits need to be sigend off to be able to merge.
See [basecamp/gh-signoff](https://github.com/basecamp/gh-signoff/blob/main/README.md) for details.

### Requirements

* [go](https://go.dev/doc/install)
* [hugo-extended](https://github.com/gohugoio/hugo)

Run ```hugo mod get``` and ```hugo mod tidy``` to install & cleanup required modules.

Start the local server with

```bash
hugo server
```

### Documentation

The pages under `/docs/` are maintained in the application repository at
[`taranis-ai/docs/user`](https://github.com/taranis-ai/taranis-ai/tree/master/docs/user).
Hugo imports them as a module (see `[[module.imports]]` in `hugo.toml`), so every
build fetches the latest docs from `master`. Edit them there, not here.

To preview your local application checkout instead:

```bash
HUGO_MODULE_REPLACEMENTS="github.com/taranis-ai/taranis-ai -> $(realpath ../taranis-ai)" hugo server
```

Docs changes merged to `master` in the application repository trigger the
GitHub Pages deployment of this site.

Conference talks and publications are listed in `content/en/media/index.html`.
Store slide PDFs in `static/` and link them from the media page. Run
`./htmltest.sh` after updating the page to check the site and its links.

## Deploy

GitHub Actions publish master branch to GitHub Pages

### Info

Built with [Docsy](https://github.com/google/docsy)
