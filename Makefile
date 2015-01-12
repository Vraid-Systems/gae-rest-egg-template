.PHONY: clean-build clean-pyc

PYTHON_SITE_PACKAGES_PATH := \
	$(shell python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")

clean: clean-build clean-pyc

clean-build:
	rm -fr build
	rm -fr dist
	rm -fr *.egg
	rm -fr *.egg-info

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

install: clean-build clean-pyc install_python_packages install_python_dev_packages install_python_gae_pth

install_python_packages: build/install_python_packages.out

install_python_dev_packages: build/install_python_dev_packages.out

install_python_gae_pth: $(PYTHON_SITE_PACKAGES_PATH)/gae.pth

test: install lint unit

lint:
	flake8 .

unit:
	nosetests --with-xunit

$(PYTHON_SITE_PACKAGES_PATH)/gae.pth:
	@echo "/usr/local/google_appengine" > $@
	@python -c "import dev_appserver; print '\n'.join(dev_appserver.EXTRA_PATHS)" >> $@
	@echo $@:
	@cat $@ 2>&1 | sed 's/^/  /'

build/install_python_packages.out: requirements.txt setup.py
	@mkdir -p build
	pip install -Ur $< && touch $@

build/install_python_dev_packages.out: requirements_dev.txt
	@mkdir -p build
	pip install -Ur $< && touch $@

sdist: clean
	python setup.py sdist
	ls -l dist
