#!/usr/bin/env python3

import dyne.org.funtoo.metatools.pkgtools as pkgtools

async def generate(hub, **pkginfo):
	artifacts = {}
	version = "2.36.1"
	unmasked = True
	pkginfo["patchlevel"] = patchlevel = "3"
	if patchlevel:
		upstream_version = pkginfo["upstream_version"] = version
		version = pkginfo["version"] = f"{version}_p{patchlevel}"
	else:
		upstream_version = version
	pkg_blurb=f"Funtoo {{version}}"
	bugs_url="https://bugs.funtoo.org/"
	if "revision" in pkginfo and pkginfo["revision"]:
		pkginfo["version_and_rev"] = f"{version}-r{revision}"
	else:
		pkginfo["version_and_rev"] = version
	artifacts["binutils"] = pkgtools.ebuild.Artifact(url=f"https://ftp.gnu.org/gnu/binutils/binutils-{upstream_version}.tar.xz")
	if patchlevel:
		artifacts["patches"] = pkgtools.ebuild.Artifact(url=f"https://dev.gentoo.org/~dilfridge/distfiles/binutils-{upstream_version}-patches-{patchlevel}.tar.xz")
		pkg_blurb += f" patchset: {artifacts['patches'].url}"
	binutils = pkgtools.ebuild.BreezyBuild(artifacts=artifacts, bugs_url=bugs_url, pkg_blurb=pkg_blurb, unmasked=unmasked, **pkginfo)
	binutils.push()
	libs = pkgtools.ebuild.BreezyBuild(version=version, cat="sys-libs", name="binutils-libs", template_path=binutils.template_path, template="binutils-libs.tmpl", unmasked=unmasked, version_and_rev=pkginfo["version_and_rev"])
	libs.push()
# vim: ts=4 sw=4 noet
