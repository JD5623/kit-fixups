#!/usr/bin/env python3

import re

async def generate(hub, **pkginfo):
	github_user = "zerotier"
	github_repo = "ZeroTierOne"
	json_data = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/releases", is_json=True
	)
	for release in json_data:
		if release["draft"] is True or release["prerelease"] is True:
			continue
		tag_name = release["tag_name"]
		ver_find = re.match("([0-9.]+)", tag_name)
		if not ver_find:
			continue
		version = ver_find.groups()[0]
		break
	tag_data = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{github_user}/{github_repo}/tags", is_json=True
	)
	matching_tag = list(filter(lambda x: x["name"] == tag_name, tag_data))
	if len(matching_tag) > 1:
		raise hub.pkgtools.ebuild.BreezyError(f"Found more than one tag for zerotier {tag_name}")
	elif not len(matching_tag):
		raise hub.pkgtools.ebuild.BreezyError(f"Could not find matching tag for {tag_name}")
	matching_tag = matching_tag[0]
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		artifacts=[
			hub.pkgtools.ebuild.Artifact(
				url=matching_tag["tarball_url"],
				final_name=f"{github_user}-{tag_name}.tar.gz",
			)
		],
	)
	ebuild.push()


# vim: ts=4 sw=4 noet
