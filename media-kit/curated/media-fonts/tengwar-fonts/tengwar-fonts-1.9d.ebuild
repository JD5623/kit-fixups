# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Tengwar - the Elvish letters, created by Feanor and described by J.R.R.Tolkien)"
HOMEPAGE="http://www.tengwar.art.pl/ktt/en/download.php"
SRC_URI="
	http://www.tengwar.art.pl/zip/tengq19d.zip
	http://www.tengwar.art.pl/zip/tengs19d.zip
	http://www.tengwar.art.pl/zip/tengn19d.zip
	http://www.tengwar.art.pl/zip/parmaite12b.zip
	http://www.tengwar.art.pl/zip/tcurs100.zip"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="*"

BDEPEND="app-arch/unzip"

S="${WORKDIR}"

DOCS="*.txt *.TXT *.rtf *.pdf"
FONT_S="${S}"
FONT_SUFFIX="ttf TTF"
