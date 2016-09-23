FILE=vonLaszewski-vcluster
VIEW=vonLaszewski-vcluster

#FILE-xsede=vonLaszewski-tas-xsede
#FILE-cluster=vonLaszewski-tas-cluster

SKIM=/Applications/Skim.app/Contents/MacOS/Skim

all:
	pdflatex ${FILE}
	bibtex ${FILE}
	pdflatex ${FILE}
	pdflatex ${FILE}

google:
	time google docs get --title "${FILE}.tex" ${FILE}.txt

real-clean: clean
	rm -rf *.pdf

clean:
	rm -rf *~ *.aux *.bbl *.dvi *.log *.out *.blg *.toc *.fdb_latexmk *.fls *.tdo

view:
	open ${VIEW}.pdf

skim:
	${SKIM} ${VIEW}.pdf

# all dependce tracking taking care of by Latexmk
fast:
	latexmk -pdf ${FILE}

watch:
	latexmk -pvc -view=pdf ${VIEW}

.PHONY: all clean view fast watch

pull:
	git pull

up:
	git commit -a
	git push

publish:
	@echo "==============================================================="
	@echo "publish ${FILE}.pdf -> http://cyberaide.github.io/papers/${FILE}.pdf" 
	@echo "==============================================================="
	cp ${FILE}.pdf /tmp
	cd ..; git checkout gh-pages
	cp /tmp/${FILE}.pdf .
	git add ${FILE}.pdf
	git commit -m "adding new version of ${FILE}.pdf" ${FILE}.pdf
	git push
	cd bigdata
	git checkout master
