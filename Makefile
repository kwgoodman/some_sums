# some_sums Makefile

PYTHON=python

srcdir := some_sums/

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
	@echo "doc     -->  Build Sphinx manual"

all: clean build test flake8

build:
	${PYTHON} setup.py build_ext --inplace

test:
	${PYTHON} -c "import some_sums;some_sums.test()"

flake8:
	flake8 .

readme:
	PYTHONPATH=`pwd`:PYTHONPATH ${PYTHON} tools/update_readme.py

bench:
	${PYTHON} -c "import some_sums; some_sums.bench()"

sdist:
	rm -f MANIFEST
	${PYTHON} setup.py sdist
	git status

# doc directory exists so use phony
.PHONY: doc
doc: clean build
	rm -rf build/sphinx
	${PYTHON} setup.py build_sphinx

clean:
	rm -rf build dist some_sums.egg-info
	find . -name \*.pyc -delete
	rm -rf ${srcdir}/*.html ${srcdir}/build
	rm -rf ${srcdir}/*.c
	rm -rf ${srcdir}/*.so
