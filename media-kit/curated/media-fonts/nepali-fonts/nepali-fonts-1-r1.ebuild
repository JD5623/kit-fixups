# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="a collection of fonts for Nepali users"
HOMEPAGE="http://www.mpp.org.np/ http://www.nepali.info/ http://www.nepalipost.com/ http://www.moics.gov.np/download/fonts.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="*"

S="${WORKDIR}/${PN}"
FONT_S=${S}
FONT_SUFFIX="ttf"
