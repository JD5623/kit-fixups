# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Nunavut's official Inuktitut font"
HOMEPAGE="http://www.ch.gov.nu.ca/en/ComputerTools.aspx"
SRC_URI="http://ch.gov.nu.ca/fonts/pigiarniq.zip -> ${P}.zip"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="*"

BDEPEND="app-arch/unzip"

FONT_SUFFIX="ttf"
