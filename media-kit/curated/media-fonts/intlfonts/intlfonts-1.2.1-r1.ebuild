# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="International X11 fixed fonts"
HOMEPAGE="https://www.gnu.org/directory/intlfonts.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="public-domain HPND non-free? ( free-noncomm )"
SLOT="0"
KEYWORDS="*"
IUSE="bdf non-free"

DEPEND="x11-apps/bdftopcf
	>=x11-apps/mkfontscale-1.2.0"

DOCS=( ChangeLog NEWS README Emacs.ap )

src_prepare() {
	default
	# Tibetan fonts have a non-commercial restriction
	use non-free || rm Asian/tib*.bdf || die
}

src_configure() {
	local myconf=(
		--with-fontdir=/usr/share/fonts/${PN}
		--enable-compress='gzip -9'
		$(use_with bdf)
	)
	econf "${myconf[@]}"
}

src_install() {
	emake install fontdir="${ED}/usr/share/fonts/${PN}"
	einstalldocs
	font_xfont_config
}
