PROJECT_NAME=delivery_hospital_report

## Packages
PDF_GEN=pdflatex
BIB_GEN=bibtex
PDF_VIWER=okular 
PDF_PS=pdftops
PDF_HTML=htlatex

all: pdf view

pdf:
	rm -rf build/
	mkdir -p build
	$(PDF_GEN) -output-directory=build $(PROJECT_NAME).tex
	$(BIB_GEN) build/$(PROJECT_NAME).aux
	$(PDF_GEN) -output-directory=build $(PROJECT_NAME).tex
	$(PDF_GEN) -output-directory=build $(PROJECT_NAME).tex
	mv build/$(PROJECT_NAME).pdf $(PROJECT_NAME).pdf

clean:
	rm -rf build/

view:
	$(PDF_VIWER) $(PROJECT_NAME).pdf

ps:
	$(PDF_PS) $(PROJECT_NAME).pdf

html:
	$(PDF_HTML) -output-directory=build $(PROJECT_NAME).tex "html,word,charset=utf8" " -utf8"

.PHONY: pdf clean view ps html