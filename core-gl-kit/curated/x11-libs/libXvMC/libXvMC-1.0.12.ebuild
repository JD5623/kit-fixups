# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

XORG_MULTILIB=yes
inherit xorg-2

DESCRIPTION="X.Org XvMC library"

KEYWORDS="*"
IUSE=""

RDEPEND="x11-base/xorg-proto
	>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
	>=x11-libs/libXext-1.3.2[${MULTILIB_USEDEP}]
	>=x11-libs/libXv-1.0.10[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
PDEPEND="app-eselect/eselect-xvmc"
