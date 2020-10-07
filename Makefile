all: update

update: 
	./rezip.sh tags
	wsk -i action update /guest/sharelatex/tags tags.zip --kind  nodejs:10 --web raw


