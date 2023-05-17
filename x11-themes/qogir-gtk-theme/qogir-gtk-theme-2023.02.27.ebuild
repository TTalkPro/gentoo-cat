# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# To update icon cache
inherit xdg-utils

DESCRIPTION="A flat colorful design icon theme for linux desktops"
HOMEPAGE="https://github.com/vinceliuice/Qogir-theme"
SRC_URI="https://github.com/vinceliuice/Qogir-theme/archive/refs/tags/2023.02.27.tar.gz"

# Extract to a non-default name
S=${WORKDIR}/Qogir-theme-2023-02-27

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

# No binaries are installed so we don't need these portage features
RESTRICT="binchecks strip"

# Unsure about dependencies
RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare() {
	eapply_user

	# Don't install the ubuntu/manjaro variants
	sed -i 's:THEME_VARIANTS=.*:THEME_VARIANTS="":' \
		install.sh || die "Sed failed to remove theme variants!"
}

src_install() {
	"${S}"/install.sh -d "${D}/usr/share/themes"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}