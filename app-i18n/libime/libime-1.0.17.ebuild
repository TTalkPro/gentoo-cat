# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake gnome2-utils xdg-utils

SRC_URI="https://download.fcitx-im.org/fcitx5/libime/libime-${PV}_dict.tar.xz"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Fcitx5 Next generation of fcitx "
HOMEPAGE="https://fcitx-im.org/ https://gitlab.com/fcitx/libime"

LICENSE="BSD-1 GPL-2+ LGPL-2+ MIT"
SLOT="5"
IUSE=""
REQUIRED_USE=""

RDEPEND="app-i18n/fcitx5"
DEPEND="${RDEPEND}
	dev-libs/boost
	kde-frameworks/extra-cmake-modules:5
	virtual/pkgconfig"

src_prepare() {
	cmake_src_prepare
	xdg_environment_reset
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
	)
	cmake_src_configure
}

src_install(){
	cmake_src_install
}
