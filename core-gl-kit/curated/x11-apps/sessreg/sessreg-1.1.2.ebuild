# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit xorg-2

DESCRIPTION="manage utmp/wtmp entries for non-init clients"

KEYWORDS="*"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	x11-base/xorg-proto"
