# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools bash-completion-r1 linux-info flag-o-matic pam readme.gentoo-r1

DESCRIPTION="A userspace interface for the Linux kernel containment features"
HOMEPAGE="https://linuxcontainers.org/ https://github.com/lxc/lxc"
SRC_URI="https://linuxcontainers.org/downloads/lxc/${P}.tar.gz"

KEYWORDS="*"

LICENSE="LGPL-3"
SLOT="0"
IUSE="apparmor +caps doc man pam selinux +ssl +tools"

RDEPEND="app-misc/pax-utils
	sys-apps/util-linux
	sys-libs/libcap
	sys-libs/libseccomp
	virtual/awk
	caps? ( sys-libs/libcap )
	pam? ( sys-libs/pam )
	selinux? ( sys-libs/libselinux )
	ssl? (
		dev-libs/openssl:0=
	)"
DEPEND="${RDEPEND}
	>=sys-kernel/linux-headers-4
	apparmor? ( sys-apps/apparmor )"
BDEPEND="doc? ( app-doc/doxygen )
	man? ( app-text/docbook-sgml-utils )"

CONFIG_CHECK="~!NETPRIO_CGROUP
	~CGROUPS
	~CGROUP_CPUACCT
	~CGROUP_DEVICE
	~CGROUP_FREEZER

	~CGROUP_SCHED
	~CPUSETS
	~IPC_NS
	~MACVLAN

	~MEMCG
	~NAMESPACES
	~NET_NS
	~PID_NS

	~POSIX_MQUEUE
	~USER_NS
	~UTS_NS
	~VETH"

ERROR_CGROUP_FREEZER="CONFIG_CGROUP_FREEZER: needed to freeze containers"
ERROR_MACVLAN="CONFIG_MACVLAN: needed for internal (inter-container) networking"
ERROR_MEMCG="CONFIG_MEMCG: needed for memory resource control in containers"
ERROR_NET_NS="CONFIG_NET_NS: needed for unshared network"
ERROR_POSIX_MQUEUE="CONFIG_POSIX_MQUEUE: needed for lxc-execute command"
ERROR_UTS_NS="CONFIG_UTS_NS: needed to unshare hostnames and uname info"
ERROR_VETH="CONFIG_VETH: needed for internal (host-to-container) networking"

DOCS=( AUTHORS CONTRIBUTING MAINTAINERS NEWS README doc/FAQ.txt )

pkg_setup() {
	linux-info_pkg_setup
}

PATCHES=(
	"${FILESDIR}"/${PV}/${PN}-4.0.9-handle-kernels-with-CAP_SETFCAP.patch # bug 789012
	"${FILESDIR}"/${PV}/${PN}-3.0.0-bash-completion.patch
	"${FILESDIR}"/${PV}/${PN}-2.0.5-omit-sysconfig.patch # bug 558854
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	append-flags -fno-strict-aliasing

	local myeconfargs=(
		--bindir=/usr/bin
		--localstatedir=/var
		--sbindir=/usr/bin

		--with-config-path=/var/lib/lxc
		--with-distro=gentoo
		--with-rootfs-path=/var/lib/lxc/rootfs
		--with-runtime-path=/run

		--disable-coverity-build
		--disable-dlog
		--disable-fuzzers
		--disable-mutex-debugging
		--disable-no-undefined
		--disable-rpath
		--disable-sanitizers
		--disable-tests
		--disable-werror

		--enable-bash
		--enable-commands
		--enable-memfd-rexec
		--enable-seccomp
		--enable-thread-safety

		$(use_enable apparmor)
		$(use_enable caps capabilities)
		$(use_enable doc api-docs)
		$(use_enable doc examples)
		$(use_enable man doc)
		$(use_enable pam)
		$(use_enable selinux)
		$(use_enable ssl openssl)
		$(use_enable tools)

		$(use_with pam pamdir $(getpam_mod_dir))
	)

	econf "${myeconfargs[@]}"
}

src_install() {
	default

	mv "${ED}"/usr/share/bash-completion/completions/${PN} "${ED}"/$(get_bashcompdir)/${PN}-start || die
	bashcomp_alias ${PN}-start \
		${PN}-{attach,cgroup,copy,console,create,destroy,device,execute,freeze,info,monitor,snapshot,stop,unfreeze,wait}

	keepdir /etc/lxc /var/lib/lxc/rootfs /var/log/lxc
	rmdir "${D}"/var/cache/lxc "${D}"/var/cache || die "rmdir failed"

	find "${D}" -name '*.la' -delete -o -name '*.a' -delete || die

	# Gentoo-specific additions!
	newinitd "${FILESDIR}/${PV}/${PN}.initd" ${PN}

	DOC_CONTENTS="
		For openrc, there is an init script provided with the package.
		You should only need to symlink /etc/init.d/lxc to
		/etc/init.d/lxc.configname to start the container defined in
		/etc/lxc/configname.conf.

		Correspondingly, for systemd a service file lxc@.service is installed.
		Enable and start lxc@configname in order to start the container defined
		in /etc/lxc/configname.conf."
	DISABLE_AUTOFORMATTING=true
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog

	elog "Please run 'lxc-checkconfig' to see optional kernel features."
	elog
	elog "Though not strictly required, some features are enabled at run-time"
	elog "when the relevant helper programs are detected:"
	elog "- app-emulation/lxc-templates"
	elog "- dev-util/debootstrap"
	elog "- sys-process/criu"
	elog
}
