# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TEXLIVE_MODULE_CONTENTS="babel-belarusian babel-bulgarian babel-russian babel-serbian babel-serbianc babel-ukrainian churchslavonic cmcyr cyrillic cyrillic-bin cyrplain disser eskd eskdx gost hyphen-belarusian hyphen-bulgarian hyphen-churchslavonic hyphen-mongolian hyphen-russian hyphen-serbian hyphen-ukrainian lcyw lh lhcyr lshort-bulgarian lshort-mongol lshort-russian lshort-ukr mongolian-babel montex mpman-ru numnameru pst-eucl-translation-bg ruhyphen russ serbian-apostrophe serbian-date-lat serbian-def-cyr serbian-lig t2 texlive-ru texlive-sr ukrhyph xecyrmongolian collection-langcyrillic
"
TEXLIVE_MODULE_DOC_CONTENTS="babel-belarusian.doc babel-bulgarian.doc babel-russian.doc babel-serbian.doc babel-serbianc.doc babel-ukrainian.doc churchslavonic.doc cmcyr.doc cyrillic.doc cyrillic-bin.doc disser.doc eskd.doc eskdx.doc gost.doc lcyw.doc lh.doc lshort-bulgarian.doc lshort-mongol.doc lshort-russian.doc lshort-ukr.doc mongolian-babel.doc montex.doc mpman-ru.doc numnameru.doc pst-eucl-translation-bg.doc russ.doc serbian-apostrophe.doc serbian-date-lat.doc serbian-def-cyr.doc serbian-lig.doc t2.doc texlive-ru.doc texlive-sr.doc ukrhyph.doc xecyrmongolian.doc "
TEXLIVE_MODULE_SRC_CONTENTS="babel-belarusian.source babel-bulgarian.source babel-russian.source babel-serbian.source babel-serbianc.source babel-ukrainian.source cyrillic.source disser.source eskd.source gost.source lcyw.source lh.source lhcyr.source mongolian-babel.source ruhyphen.source xecyrmongolian.source "
inherit  texlive-module
DESCRIPTION="TeXLive Cyrillic"

LICENSE=" GPL-1 GPL-2 LPPL-1.3 LPPL-1.3c MIT public-domain TeX-other-free "
SLOT="0"
KEYWORDS="*"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2020
>=dev-texlive/texlive-latex-2020
"
RDEPEND="${DEPEND} "
TEXLIVE_MODULE_BINSCRIPTS="
	texmf-dist/scripts/texlive-extra/rumakeindex.sh
	texmf-dist/scripts/texlive-extra/rubibtex.sh
	"
