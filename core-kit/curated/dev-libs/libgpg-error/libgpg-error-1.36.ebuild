# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools libtool multilib-minimal toolchain-funcs prefix

DESCRIPTION="Contains error handling functions used by GnuPG software"
HOMEPAGE="http://www.gnupg.org/related_software/libgpg-error"
SRC_URI="mirror://gnupg/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="common-lisp nls static-libs"

RDEPEND="nls? ( >=virtual/libintl-0-r1[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}"
BDEPEND="nls? ( sys-devel/gettext )"

MULTILIB_CHOST_TOOLS=(
	/usr/bin/gpg-error-config
)
MULTILIB_WRAPPED_HEADERS=(
	/usr/include/gpg-error.h
	/usr/include/gpgrt.h
)

PATCHES=( "${FILESDIR}/${PN}-1.36-gawk5-support.patch" )

src_prepare() {
	default
	# only necessary for as long as we run eautoreconf, configure.ac
	# uses ./autogen.sh to generate PACKAGE_VERSION, but autogen.sh is
	# not a pure /bin/sh script, so it fails on some hosts
	hprefixify -w 1 autogen.sh
	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(multilib_is_native_abi || echo --disable-languages) \
		$(use_enable common-lisp languages) \
		$(use_enable nls) \
		$(use_enable static-libs static) \
		--enable-threads \
		CC_FOR_BUILD="$(tc-getBUILD_CC)" \
		$("${S}/configure" --help | grep -- '--without-.*-prefix' | sed -e 's/^ *\([^ ]*\) .*/\1/g')
}

multilib_src_install_all() {
	einstalldocs
	find "${D}" -name '*.la' -delete || die
}
