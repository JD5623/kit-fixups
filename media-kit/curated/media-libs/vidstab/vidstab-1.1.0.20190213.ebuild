# Distributed under the terms of the GNU General Public License v2

EAPI=7

: ${CMAKE_MAKEFILE_GENERATOR:=ninja}

inherit cmake-multilib toolchain-funcs

DESCRIPTION="Video stabilization library"
HOMEPAGE="http://public.hronopik.de/vid.stab/"

KEYWORDS="*"
LICENSE="GPL-2+"
SLOT="0"
IUSE="openmp cpu_flags_x86_sse2"

GITHUB_REPO="vid.stab"
GITHUB_USER="georgmartius"
GITHUB_TAG="aeabc8d"
SRC_URI="https://www.github.com/${GITHUB_USER}/${GITHUB_REPO}/tarball/${GITHUB_TAG} -> ${PN}-${GITHUB_TAG}.tar.gz"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${GITHUB_USER}-${GITHUB_REPO}"-??????? "${S}" || die
}

src_prepare() {
	# USE=cpu_flags_x86_sse2 instead
	sed -E 's#include (FindSSE)##' -i CMakeLists.txt || die
	sed -E 's#include (FindSSE)##' -i tests/CMakeLists.txt || die
	# strip some CFLAGS
	for FILE_TO_PATCH in {,transcode/,tests/}CMakeLists.txt; do
		sed -E 's#(add_definitions.* )-g #\1#' -i ${FILE_TO_PATCH} || die
		sed -E 's#(add_definitions.* )-O3 #\1#' -i ${FILE_TO_PATCH} || die
	done
	cmake-utils_src_prepare
	default
}

src_configure() {
	use openmp && tc-check-openmp
	local mycmakeargs=(
		-DUSE_OMP="$(usex openmp)"
		-DSSE2_FOUND="$(usex cpu_flags_x86_sse2)"
	)
	cmake-multilib_src_configure
}

multilib_src_test() {
	local mycmakeargs=(
		-DUSE_OMP="$(usex openmp)"
		-DSSE2_FOUND="$(usex cpu_flags_x86_sse2)"
	)
	local CMAKE_USE_DIR="${CMAKE_USE_DIR}/tests"
	local BUILD_DIR="${BUILD_DIR}/tests"
	cmake-utils_src_configure
	cmake-utils_src_make
	"${BUILD_DIR}"/tests || die
}
