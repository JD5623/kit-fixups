# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE='threads(+)'
inherit python-any-r1 waf-utils

DESCRIPTION="A library to make the use of LV2 plugins as simple as possible for applications"
HOMEPAGE="http://wiki.drobilla.net/SLV2"
SRC_URI="http://download.drobilla.net/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="doc jack"

RDEPEND=">=dev-libs/redland-1.0.6
	jack? ( virtual/jack )
	media-libs/lv2"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

src_prepare() {
	epatch "${FILESDIR}"/ldconfig.patch
	epatch "${FILESDIR}"/${P}-raptor2-link.patch
	sed -i -e 's/lv2core/lv2/' wscript || die "Sed failed!"
}

src_configure() {
	waf-utils_src_configure \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--htmldir=/usr/share/doc/${PF}/html \
		$(use doc && echo --build-docs) \
		$(use jack || echo --no-jack)
}
