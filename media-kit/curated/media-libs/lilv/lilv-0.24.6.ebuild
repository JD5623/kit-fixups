# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2+ )
PYTHON_REQ_USE='threads(+)'

inherit python-any-r1 waf-utils bash-completion-r1 multilib-build multilib-minimal

DESCRIPTION="Library to make the use of LV2 plugins as simple as possible for applications"
HOMEPAGE="http://drobilla.net/software/lilv/"
SRC_URI="http://download.drobilla.net/${P}.tar.bz2"

LICENSE="ISC"
SLOT="0"
KEYWORDS="*"
IUSE="doc +dyn-manifest static-libs test"

RDEPEND="
	>=dev-libs/serd-0.28.0-r1[${MULTILIB_USEDEP}]
	>=dev-libs/sord-0.16.0-r1[${MULTILIB_USEDEP}]
	media-libs/libsndfile
	>=media-libs/lv2-1.14.0-r1[${MULTILIB_USEDEP}]
	>=media-libs/sratom-0.6.0-r1[${MULTILIB_USEDEP}]
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	doc? ( app-doc/doxygen )
	virtual/pkgconfig[${MULTILIB_USEDEP}]
"

PATCHES=( "${FILESDIR}/includedir.patch" )

src_prepare() {
	default
	sed -i -e 's/^.*run_ldconfig/#\0/' wscript || die
	multilib_copy_sources
}

multilib_src_configure() {
	waf-utils_src_configure \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--no-bash-completion \
		$(multilib_native_usex doc --docs "") \
		$(usex test --test "") \
		$(usex static-libs --static "") \
		$(usex dyn-manifest --dyn-manifest "")
}

multilib_src_test() {
	./waf test || die
}

multilib_src_install() {
	waf-utils_src_install
}

multilib_src_install_all() {
	newbashcomp utils/lilv.bash_completion ${PN}
	dodir /etc/env.d
	echo "LV2_PATH=${EPREFIX}/usr/$(get_libdir)/lv2" > "${ED}/etc/env.d/60lv2"
}
