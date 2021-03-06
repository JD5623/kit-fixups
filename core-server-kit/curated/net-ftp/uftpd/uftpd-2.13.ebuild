# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The no nonsense TFTP/FTP server"
HOMEPAGE="https://github.com/troglobit/uftpd"
SRC_URI="https://github.com/troglobit/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND="
	>=dev-libs/libite-1.5
	>=dev-libs/libuev-2.2"

RDEPEND="
	${DEPEND}
	!net-misc/uftp
	!net-ftp/atftp"

src_install() {
	emake DESTDIR="${D}" install doc_DATA=README.md
}
