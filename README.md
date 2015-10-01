# thesis-template using pandoc

## build

`make`

- the process is as follows:
    - `pandoc` converts the markdown files of the main chapter to latex
    - in a next step the latex files are rendered to pdf using xelatex

## notes

- set KOMAScript option `draft` to false in the documentclass of `doc/thesis.tex` before building a release version
- add newlines to the end of your markdown chapters, otherwise pandoc will escape the `#` of the following chapter

## notes specific to University of Leipzig

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

`Ich versichere, dass ich die vorliegende Arbeit selbständig und nur unter
 Verwendung der angegebenen Quellen und Hilfsmittel angefertigt habe,
insbesondere sind wörtliche oder sinngemäße Zitate als solche gekennzeichnet.
Mir ist bekannt, dass Zuwiderhandlung auch nachträglich zur Aberkennung
des Abschlusses führen kann`

## Further Reading

- [Stanford-Thesis Writing Tips](http://web.stanford.edu/~pmcmahon/ThesisWritingTips.pdf)
