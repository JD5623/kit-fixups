# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PLOCALES="af ar ca cs da de eo es et eu fr hr hu id it ja kn ko nb nl pl pt pt_BR ru sl sr_Cyrl sv uk vi zh_CN zh_HK"

inherit l10n perl-module

DESCRIPTION="Tools to ease the translation of documentation"
HOMEPAGE="https://po4a.org/"
SRC_URI="https://github.com/mquinson/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="app-text/opensp
	dev-libs/libxslt
	dev-perl/Locale-gettext
	dev-perl/SGMLSpm
	dev-perl/TermReadKey
	dev-perl/Text-WrapI18N
	dev-perl/Unicode-LineBreak
	dev-perl/YAML-Tiny
	sys-devel/gettext
	>virtual/perl-Pod-Parser-1.630.0-r4
"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/docbook-xsl-stylesheets
	dev-perl/Module-Build
	test? (
		app-text/docbook-sgml-dtd:4.1
		dev-perl/Test-Pod
		virtual/latex-base
	)"

PATCHES=( "${FILESDIR}"/${PN}-0.60-man.patch )

DIST_TEST="do"

src_prepare() {
	l10n_find_plocales_changes "${S}/po/bin" '' '.po'

	rm_locale() {
		PERL_RM_FILES+=( po/{bin,pod}/${1}.po )
	}
	l10n_for_each_disabled_locale_do rm_locale

	perl-module_src_prepare
}
