# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
XORG_MULTILIB=yes
inherit xorg-2

EGIT_REPO_URI="https://anongit.freedesktop.org/git/pixman.git"
DESCRIPTION="Low-level pixel manipulation routines"
KEYWORDS="*"
IUSE="altivec iwmmxt loongson2f cpu_flags_x86_mmxext neon cpu_flags_x86_sse2 cpu_flags_x86_ssse3"

src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable cpu_flags_x86_mmxext mmx)
		$(use_enable cpu_flags_x86_sse2 sse2)
		$(use_enable cpu_flags_x86_ssse3 ssse3)
		$(use_enable altivec vmx)
		$(use_enable neon arm-neon)
		$(use_enable iwmmxt arm-iwmmxt)
		$(use_enable loongson2f loongson-mmi)
		--disable-gtk
		--disable-libpng
	)
	xorg-2_src_configure
}
