# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Extra raster fonts for jsmath, light version"
HOMEPAGE="http://www.math.union.edu/~dpvc/jsMath/download/extra-fonts/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

RDEPEND="media-fonts/jsmath
	!media-fonts/jsmath-extra-dark"

FONT_SUFFIX="ttf"
