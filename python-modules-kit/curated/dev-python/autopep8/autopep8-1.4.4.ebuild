# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} pypy{,3} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="Automatically formats Python code to conform to the PEP 8 style guide"
HOMEPAGE="https://github.com/hhatto/autopep8 https://pypi.org/project/autopep8/"
if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/hhatto/${PN}.git"
	inherit git-r3
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86 ~amd64-linux ~x86-linux"
fi

LICENSE="MIT"
SLOT="0"
IUSE="test"

RDEPEND="
	>=dev-python/pep8-1.7.0[${PYTHON_USEDEP}]
	>=dev-python/pycodestyle-2.5.0[${PYTHON_USEDEP}]"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		>=dev-python/pydiff-0.2.0[${PYTHON_USEDEP}]
	)"

python_prepare_all() {
	# Prevent UnicodeDecodeError with LANG=C
	sed -e "/é/d" -i MANIFEST.in || die
	distutils-r1_python_prepare_all
}

python_test() {
	esetup.py test
}
