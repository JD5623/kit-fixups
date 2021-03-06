# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Old Standard - font with wide range of Latin, Greek and Cyrillic characters"
HOMEPAGE="http://www.thessalonica.org.ru/en/fonts.html"
SRC_URI="http://www.thessalonica.org.ru/downloads/${P}.otf.zip
	http://www.thessalonica.org.ru/downloads/${P}.ttf.zip"

LICENSE="OFL"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}
FONT_S=${WORKDIR}
FONT_SUFFIX="otf ttf"
DOCS=( OFL.txt OFL-FAQ.txt FONTLOG.txt )
