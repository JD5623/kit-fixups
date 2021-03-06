# Distributed under the terms of the GNU General Public License v2

EAPI=7

# jython depends on java-config, so don't add it or things will break
PYTHON_COMPAT=( python3+ )
DISTUTILS_USE_SETUPTOOLS=no

inherit distutils-r1

DESCRIPTION="Java environment configuration query tool"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Java"
SRC_URI="https://gitweb.gentoo.org/proj/${PN}.git/snapshot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="*"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="test? ( sys-apps/portage[${PYTHON_USEDEP}] )"

# baselayout-java is added as a dep till it can be added to eclass.
RDEPEND="
	!dev-java/java-config-wrapper
	sys-apps/baselayout-java
	sys-apps/portage[${PYTHON_USEDEP}]"

python_install_all() {
	distutils-r1_python_install_all

	# This replaces the file installed by java-config-wrapper.
	dosym java-config-2 /usr/bin/java-config
}

python_test() {
	esetup.py test
}
