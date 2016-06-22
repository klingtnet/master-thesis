# Master Thesis - Andreas Linz

[![Build Status](https://travis-ci.com/klingtnet/master-thesis.svg?token=drwE1YPs35oqracubtuf&branch=master)](https://travis-ci.com/klingtnet/master-thesis)

## Build

There are prebuild versions of the document available in the [release section](https://github.com/klingtnet/master-thesis/releases).

- dependencies
- build:
	- texlive
	- [Fira Mono](https://github.com/tonsky/FiraCode)
	- [Biolinum](http://www.linuxlibertine.org/index.php?id=86&L=1)
	- xelatex
	- [biber](http://biblatex-biber.sourceforge.net/)
	- [pandoc](http://pandoc.org/)

```sh
$ make
```

- the process is as follows:
    - `pandoc` converts the markdown files of the main chapter to latex
    - in a next step the latex files are rendered to pdf using xelatex

## Notes

- set KOMAScript option `draft` to false in the documentclass of `doc/thesis.tex` before building a release version
- add newlines to the end of your markdown chapters, otherwise pandoc will escape the `#` of the following chapter

## Notes Specific to University of Leipzig

- 3 copies
- paper format: DIN A4
- publish one copy on the [electronic document server](http://lips.informatik.uni-leipzig.de/)
- how to arrange the parts of the master thesis:

    1. title-page
    1. table of contents
    1. text
    1. abstract
    1. bibliography
    1. appendix
    1. statement of originality:

```
Ich versichere, dass ich die vorliegende Arbeit selbständig und nur unter Verwendung der angegebenen Quellen und Hilfsmittel angefertigt habe, insbesondere sind wörtliche oder sinngemäße Zitate als solche gekennzeichnet. Mir ist bekannt, dass Zuwiderhandlung auch nachträglich zur Aberkennung des Abschlusses führen kann.
```

## Further Reading

- [Stanford-Thesis Writing Tips](http://web.stanford.edu/~pmcmahon/ThesisWritingTips.pdf)

## Example

- see [this](//github.com/klingtnet/thesis-template/raw/master/out/thesis.pdf)
