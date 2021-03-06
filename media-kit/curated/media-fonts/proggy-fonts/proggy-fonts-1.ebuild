# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="A set of monospaced bitmap programming fonts"
HOMEPAGE="http://upperbounds.net/ https://proggyfonts.net/"
SRC_URI="https://dev.gentoo.org/~jstein/dist/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

S="${WORKDIR}/${PN}"

FONT_S="${S}"
FONT_SUFFIX="pcf.gz"
