#!/usr/bin/env python3

import re

def get_release(releases_data, target_asset):
	"""
	FL-8961 documents an issue where VSCodium had a release that did not include the x64 linux asset we use.
	To address this, this code was 'robustified' and will look in the assets in a release and only select it
	if it offers the asset we need.
	"""
	bad_versions = ["1.55.1"]
	for release in releases_data:
		if release["prerelease"] or release["draft"]:
			continue
		if release["tag_name"] in bad_versions:
			continue
		matching_asset = None
		version = None
		for asset in release["assets"]:
			found = re.match(target_asset, asset["name"])
			if found:
				return found.groups()[0], asset["url"], asset["name"]
	return None

async def generate(hub, **pkginfo):
	user = "VSCodium"
	name = pkginfo["name"]
	repo = name.rstrip("-bin")
	releases_data = await hub.pkgtools.fetch.get_page(
		f"https://api.github.com/repos/{user}/{repo}/releases", is_json=True
	)
	target_asset = f"{user}-linux-x64-([0-9.]+).tar.gz"
	result = get_release(releases_data, target_asset)
	if result is None:
		raise hub.pkgtools.ebuild.BreezyError(f"Can't find a suitable release of {repo}")
	version, asset_url, asset_name = result
	ass_data = await hub.pkgtools.fetch.get_page(asset_url, is_json=True)
	artifact_url = ass_data["browser_download_url"]
	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		version=version,
		artifacts=[
			hub.pkgtools.ebuild.Artifact(
				url=artifact_url,
				final_name=asset_name
			)
		],
	)
	ebuild.push()
