# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake

DESCRIPTION="RabbitMQ C client"
HOMEPAGE="https://github.com/alanxz/rabbitmq-c"

SRC_URI="https://github.com/alanxz/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="*"

LICENSE="MIT"
SLOT="0/4"
IUSE="doc libressl test +ssl static-libs tools"

REQUIRED_USE="test? ( static-libs )"

RESTRICT="!test? ( test )"

RDEPEND="ssl? (
		libressl? ( dev-libs/libressl:= )
		!libressl? ( dev-libs/openssl:0= )
	)
	tools? ( dev-libs/popt )"
DEPEND="${DEPEND}
	doc? ( app-doc/doxygen )
	tools? ( app-text/xmlto )"
DOCS=( AUTHORS README.md THANKS TODO )

src_configure() {
	mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
		-DBUILD_API_DOCS=$(usex doc)
		-DBUILD_STATIC_LIBS=$(usex static-libs)
		-DBUILD_TESTS=$(usex test)
		-DBUILD_TOOLS=$(usex tools)
		-DBUILD_TOOLS_DOCS=$(usex tools)
		-DENABLE_SSL_SUPPORT=$(usex ssl)
	)
	cmake_src_configure
}

src_test() {
	pushd "${BUILD_DIR}" > /dev/null || die

	# Skip "basic" test which requires running local rabbitmq-server instance,
	# see https://github.com/alanxz/rabbitmq-c/issues/530
	ctest -v -E basic || die
}
