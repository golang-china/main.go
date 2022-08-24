default:
	mdbook serve

build:
	-rm docs
	mdbook build
	-rm docs/.gitignore
	-rm -rf docs/.git

clean:
