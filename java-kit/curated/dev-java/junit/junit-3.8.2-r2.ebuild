# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"
MAVEN_ID="junit:junit:${PV}"

inherit java-pkg-2 java-pkg-simple

MY_P=${P/-/}

DESCRIPTION="Simple framework to write repeatable tests"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"
HOMEPAGE="http://www.junit.org/"
LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="*"

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

DOCS=( README.html cpl-v10.html )

JAVA_SRC_DIR="${PN}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}" || die
	unzip src.jar || die
}

src_prepare() {
	default
	java-pkg_clean
}

src_install() {
	java-pkg-simple_src_install
	einstalldocs
}
