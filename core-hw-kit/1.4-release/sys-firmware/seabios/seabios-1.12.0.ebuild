# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3+ )

inherit eutils toolchain-funcs python-any-r1

# SeaBIOS maintainers sometimes don't release stable tarballs or stable
# binaries to generate the stable tarball the following is necessary:
# git clone git://git.seabios.org/seabios.git && cd seabios
# git archive --output seabios-${PV}.tar.gz --prefix seabios-${PV}/ rel-${PV}

KEYWORDS="*"

	# Binary versions taken from fedora:
	# http://download.fedoraproject.org/pub/fedora/linux/development/rawhide/Everything/x86_64/os/Packages/s/
	#   seabios-bin-1.12.1-2.fc31.noarch.rpm
	#   seavgabios-bin-1.12.1-2.fc31.noarch.rpm
	SRC_URI="
		!binary? ( https://code.coreboot.org/p/seabios/downloads/get/${P}.tar.gz )
		binary? ( https://dev.gentoo.org/~tamiko/distfiles/${P}-bin.tar.xz )"

DESCRIPTION="Open Source implementation of a 16-bit x86 BIOS"
HOMEPAGE="https://www.seabios.org/"

LICENSE="LGPL-3 GPL-3"
SLOT="0"
IUSE="+binary debug +seavgabios"

REQUIRED_USE="debug? ( !binary )
	!amd64? ( !x86? ( binary ) )"

# The amd64/x86 check is needed to workaround #570892.
SOURCE_DEPEND="
	>=sys-power/iasl-20060912
	${PYTHON_DEPS}"
DEPEND="
	!binary? (
		amd64? ( ${SOURCE_DEPEND} )
		x86? ( ${SOURCE_DEPEND} )
	)"
RDEPEND=""

pkg_pretend() {
	if ! use binary; then
		ewarn "You have decided to compile your own SeaBIOS. This is not"
		ewarn "supported by upstream unless you use their recommended"
		ewarn "toolchain (which you are not)."
		elog
		ewarn "If you are intending to use this build with QEMU, realize"
		ewarn "you will not receive any support if you have compiled your"
		ewarn "own SeaBIOS. Virtual machines subtly fail based on changes"
		ewarn "in SeaBIOS."
	fi
}

pkg_setup() {
	use binary || python-any-r1_pkg_setup
}

src_unpack() {
	default

	# This simplifies the logic between binary & source builds.
	mkdir -p "${S}"
}

src_prepare() {
	default

	# Ensure precompiled iasl files are never used
	find "${WORKDIR}" -name '*.hex' -delete || die
}

src_configure() {
	use binary && return

	tc-ld-disable-gold #438058

	if use debug ; then
		echo "CONFIG_DEBUG_LEVEL=8" >.config
	fi
	_emake config
}

_emake() {
	LANG=C \
	emake V=1 \
		CC="$(tc-getCC)" \
		LD="$(tc-getLD)" \
		AR="$(tc-getAR)" \
		AS="$(tc-getAS)" \
		OBJCOPY="$(tc-getOBJCOPY)" \
		RANLIB="$(tc-getRANLIB)" \
		OBJDUMP="$(tc-getOBJDUMP)" \
		HOST_CC="$(tc-getBUILD_CC)" \
		VERSION="Gentoo/${EGIT_COMMIT:-${PVR}}" \
		"$@"
}

src_compile() {
	use binary && return

	cp "${FILESDIR}/seabios/config.seabios-256k" .config || die
	_emake oldnoconfig
	_emake iasl
	_emake out/bios.bin
	mv out/bios.bin ../bios-256k.bin || die

	if use seavgabios ; then
		local config t targets=(
			cirrus
			isavga
			qxl
			stdvga
			virtio
			vmware
		)
		for t in "${targets[@]}" ; do
			emake clean distclean
			cp "${FILESDIR}/seavgabios/config.vga-${t}" .config || die
			_emake oldnoconfig
			_emake out/vgabios.bin
			cp out/vgabios.bin ../vgabios-${t}.bin || die
		done
	fi
}

src_install() {
	insinto /usr/share/seabios
	use binary && doins ../bios.bin
	doins ../bios-256k.bin

	if use seavgabios ; then
		insinto /usr/share/seavgabios
		doins ../vgabios*.bin
	fi
}
