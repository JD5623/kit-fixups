# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font font-ebdftopcf

DESCRIPTION="Linux Font Project variable-width fonts"
HOMEPAGE="https://sourceforge.net/projects/xfonts/"
SRC_URI="mirror://sourceforge/xfonts/${PN}-src-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="*"
IUSE=""

S="${WORKDIR}/${PN}-src"

FONT_S="${S}/src"

DOCS="${S}/doc/*"

# Only installs fonts
RESTRICT="strip binchecks"
