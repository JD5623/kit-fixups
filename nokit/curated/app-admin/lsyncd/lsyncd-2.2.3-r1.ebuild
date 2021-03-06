# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

CMAKE_IN_SOURCE_BUILD="YES_PLEASE_OMG"
inherit cmake-utils

DESCRIPTION="Live Syncing (Mirror) Daemon"
HOMEPAGE="https://github.com/axkibe/lsyncd"
SRC_URI="https://github.com/axkibe/lsyncd/archive/release-${PV}.tar.gz -> ${P}.tar.gz"
# lua version used
LUA_VERS="5.2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

CDEPEND="dev-lua/lua:${LUA_VERS}[deprecated]"
DEPEND="${CDEPEND}
	app-text/asciidoc
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	net-misc/rsync"

PATCHES=(
        "${FILESDIR}"/${PN}-2.3.3-mandir.patch
)

S=${WORKDIR}/${PN}-release-${PV}

src_configure() {
	local mycmakeargs

mycmakeargs=(
		-DLUA_INCLUDE_DIR="/usr/include/lua${LUA_VERS}"
		-DLUA_COMPILER="/usr/bin/luac${LUA_VERS}"
	)

	cmake-utils_src_configure
}
