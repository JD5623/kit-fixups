# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TEXLIVE_MODULE_CONTENTS="accfonts afm2pl dosepsbin epstopdf fontware lcdftypetools metatype1 ps2pk ps2eps psutils dvipsconfig fontinst fontools mf2pt1 t1utils collection-fontutils
"
TEXLIVE_MODULE_DOC_CONTENTS="accfonts.doc afm2pl.doc dosepsbin.doc epstopdf.doc fontware.doc lcdftypetools.doc ps2pk.doc ps2eps.doc psutils.doc fontinst.doc fontools.doc mf2pt1.doc t1utils.doc "
TEXLIVE_MODULE_SRC_CONTENTS="dosepsbin.source metatype1.source fontinst.source "
inherit  texlive-module
DESCRIPTION="TeXLive Graphics and font utilities"

LICENSE=" Artistic GPL-1 GPL-2 LPPL-1.3 public-domain TeX TeX-other-free "
SLOT="0"
KEYWORDS="*"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2020
"
RDEPEND="${DEPEND} "
TEXLIVE_MODULE_BINSCRIPTS="
	texmf-dist/scripts/accfonts/mkt1font
	texmf-dist/scripts/accfonts/vpl2ovp
	texmf-dist/scripts/accfonts/vpl2vpl
	texmf-dist/scripts/epstopdf/epstopdf.pl
	texmf-dist/scripts/fontools/afm2afm
	texmf-dist/scripts/fontools/autoinst
	texmf-dist/scripts/fontools/ot2kpx
	texmf-dist/scripts/mf2pt1/mf2pt1.pl
	texmf-dist/scripts/dosepsbin/dosepsbin.pl
	texmf-dist/scripts/texlive-extra/fontinst.sh
"
TEXLIVE_MODULE_BINLINKS="
	epstopdf:repstopdf
"
