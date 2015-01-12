from pip.req import parse_requirements
from setuptools import find_packages, setup


def get_version():
    import imp

    source_dir = 'rest_egg'

    with open('{}/_pkg_meta.py'.format(source_dir), 'rb') as fp:
        mod = imp.load_source('_pkg_meta', source_dir, fp)

    return mod.version


def read_file(filename, mode='rb'):
    with open(filename, mode) as fp:
        return fp.read()


def get_requirements(filename):
    reqs = parse_requirements(filename)
    return [str(r.req) for r in reqs]


readme = read_file('README.md')

setup_args = dict(
    name='gae-rest-egg-template',
    version=get_version(),
    description='GAE REST backend egg template',
    long_description='\n\n'.join([readme]),
    maintainer='Jason Zerbe',
    maintainer_email='jzerbe@vraidsys.com',
    url='https://github.com/jzerbe/gae-rest-egg-template',
    packages=find_packages(exclude=['tests', '*.tests', 'tests.*',
                                    '*.tests.*']),
    install_requires=get_requirements('requirements.txt'),
    tests_require=get_requirements('requirements_dev.txt'),
    classifiers=['Development Status :: 3 - Alpha',
                 'Intended Audience :: Developers',
                 'Topic :: Software Development :: Libraries',
                 'Programming Language :: Python :: 2',
                 'Programming Language :: Python :: 2.7']
)  # https://pypi.python.org/pypi?%3Aaction=list_classifiers


if __name__ == '__main__':
    setup(**setup_args)
