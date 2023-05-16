# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake

DESCRIPTION="Rime Support for Fcitx5"
HOMEPAGE="https://github.com/fcitx/fcitx5-rime"


SRC_URI="https://download.fcitx-im.org/fcitx5/fcitx5-rime/fcitx5-rime-${PV}.tar.xz"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="5"
IUSE=""

RDEPEND="app-i18n/fcitx5
	>=app-i18n/librime-1.0
	>=app-i18n/rime-data-0.3.0
	x11-libs/libnotify
	!app-i18n/fcitx-rime"

DEPEND="${RDEPEND}"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"

	)
	cmake_src_configure
}
