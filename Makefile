# femto Makefile

PYTHON=python

help:
	@echo "Available tasks:"
	@echo "help    -->  This help page"
	@echo "all     -->  clean, build, flake8, test"
	@echo "build   -->  Build the Python C extensions"
	@echo "clean   -->  Remove all the build files for a fresh start"
	@echo "test    -->  Run unit tests"
	@echo "flake8  -->  Check for pep8 errors"
	@echo "readme  -->  Update benchmark results in README.rst"
	@echo "bench   -->  Run performance benchmark"
	@echo "sdist   -->  Make source distribution"

all: clean build test flake8

build:
	${PYTHON} setup.py build_ext --inplace

test:
	${PYTHON} -c "import femto;femto.test()"

flake8:
	flake8 .

readme:
	PYTHONPATH=`pwd`:PYTHONPATH ${PYTHON} tools/update_readme.py

bench:
	${PYTHON} -c "import femto; femto.bench()"

sdist:
	rm -f MANIFEST
	${PYTHON} setup.py sdist
	git status

clean:
	rm -rf build dist femto.egg-info
	find . -name \*.pyc -delete
	rm -rf build
	rm -rf femto/sums.so
	rm -rf femto/src/sums.c
