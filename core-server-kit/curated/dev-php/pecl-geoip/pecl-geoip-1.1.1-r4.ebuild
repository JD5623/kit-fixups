# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PHP_EXT_NAME="geoip"
DOCS="README ChangeLog"
USE_PHP="php7-4 php7-2 php7-3"

inherit php-ext-pecl-r3

KEYWORDS="*"

DESCRIPTION="PHP extension to map IP address to geographic places"
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="dev-libs/geoip"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/fix-failing-tests-1.1.1.patch" )
