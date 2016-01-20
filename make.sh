# Vlna - to add unbreakable spaces in front of the one syllable Czech prepositions
# http://ftp.linux.cz/pub/tex/local/cstug/olsak/vlna/
# vlna -l -m -n -v KkSsVvZzOoUuAaIi introduction/uvod.tex
# vlna -l -m -n -v KkSsVvZzOoUuAaIi introduction/historie.tex
# vlna -l -m -n -v KkSsVvZzOoUuAaIi introduction/instructions.tex
# vlna -l -m -n -v KkSsVvZzOoUuAaIi letters.tex

# Clean directory
rm main.bbl main.blg main.run.xml main.toc main.aux main.bcf main.out main.log
rm figures.ind figures.idx style.xdy

# First run to generate the index file and mal/style
pdflatex main

# First we convert the *.idx encoding to UTF8
texlua iec2utf.lua < figures.idx | \
  xindy -M texindy -M mal-icelandic-min -M style -o figures.ind
# then we pipe the result to xindy that sets it with our modules

# Standard bibliography compilation
biber main

# Finishing runs
pdflatex main
pdflatex main

# Copy and rename pdf file and open it
file='ICSS'
end='.pdf'
cdate=`date +%Y-%m-%d`
cp main.pdf $file-$cdate$end
evince $file-$cdate$end

#evince main.pdf
