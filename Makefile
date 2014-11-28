# REQUIREMENTS
#   latex   (use MacTeX, MikTeX, etc)
#	imagemagick (install using brew, etc.)

SHELL=bash

TARGET=README

# in case source Markdown is in different folder
SRCDIR=

LATEX_TEMPLATE=kramdown-templates/latex.erb
HTML_TEMPLATE=kramdown-templates/html.erb

all: pdf open cleanlogs
verbose: pdf open openlog
clean: cleantemps cleanlogs cleanoutput


PLATFORM=$(shell ([[ -n "$(OSTYPE)" ]] && echo $(OSTYPE) || echo $(OS) ) | grep -o '[^0-9\-]\+')
ifeq ($(PLATFORM), Windows_NT)
	PLATFORM=cygwin
endif
ifeq ($(PLATFORM), cygwin)
	OPEN=$(shell cygstart --version &>/dev/null && echo cygstart -o || echo start)
else
	OPEN=$(shell xdg-open --version &>/dev/null && echo xdg-open || echo open)
endif

$(TARGET).tex: $(SRCDIR)$(TARGET).md
	kramdown -o latex --template $(LATEX_TEMPLATE) $(SRCDIR)$(TARGET).md > $(TARGET).tex

$(TARGET).pdf: $(TARGET).tex
	xelatex $(TARGET).tex

$(TARGET).html:
	kramdown -o html --template $(HTML_TEMPLATE) $(SRCDIR)$(TARGET).md > $(TARGET).html

pdf: $(TARGET).pdf cleantemps
	touch $(TARGET).pdf

# produces a series of pngs if multipage document
png: pdf
	convert -background white -flatten -density 300 $(TARGET).pdf $(TARGET).png

html: $(TARGET).html
	touch $(TARGET).html

# opens the most-recently generated or touched output file
open:
	$(OPEN) $(shell ls -t $(TARGET).{pdf,html} 2>/dev/null | head -n1)

openlog: $(TARGET).log
	$(OPEN) $(TARGET).log

cleantemps:
	rm -f *.aux *.out *.synctex.gz
	rm -f *.tex

cleanlogs:
	rm -rf *.log

cleanoutput:
	rm -rf *.pdf *.png *.html

deps:
	gem --version &>/dev/null ||\ 
		brew install ruby ||\
		sudo apt-get install ruby ||\
		echo "Missing ruby!" > /dev/stderr
	gem install prawn prawn-table   # pdf support for kramdown
	gem install kramdown

remove-deps:
	gem uninstall kramdown
	gem uninstall prawn prawn-table
	
.PHONY: all verbose run pdf png html open openlog clean cleantemps cleanlogs cleanoutput deps remove-deps
