kramdown-make
=============

Renders Markdown files to PDF and HTML using [kramdown][], the same engine used by GitHub.

## Dependencies
To render to HTML, all you need is [kramdown][]. On Mac and Linux, you can get it by running `make deps` inside of the kramdown-make folder.

To render to PDF, you will need to install the appropriate version of LaTeX for your system. On Windows, use MiKTeX. On Mac, use MacTeX. On Linux, install TeXLive; usually the version in your package manager is out of date, so do a manual install instead.

It is also possible to render to PNG images using [imagemagick][]. If you can, use a package manager like [brew][] (on a Mac) or apt-get (Linux) to install it.

## Rendering
To get an idea of how this works, try running following (by default, they will render this README file): 

* `make` renders to PDF and opens it.
* `make html open` renders to HTML and opens it.
* `make png` renders to PNG image(s).

To change the source file, edit the Makefile:

* TARGET should be the name of the *.md source file without the extension. 
* SRCDIR should be the path to the folder where the source lives. If this is blank, the *.md source should be in the same folder as the Makefile.

## Changing the templates
The templates are stored in the kramdown-templates folder.


[kramdown]: http://kramdown.gettalong.org
[imagemagick]: http://www.imagemagick.org/
[brew]: http://brew.sh
