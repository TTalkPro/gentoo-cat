# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg


SRC_URI="https://download.fcitx-im.org/fcitx5/fcitx5-chinese-addons/fcitx5-chinese-addons-${PV}_dict.tar.xz"
KEYWORDS="amd64 x86"


DESCRIPTION="Addons related to Chinese, including IME previous bundled inside fcitx4."
HOMEPAGE="https://github.com/fcitx/fcitx5-chinese-addons"

LICENSE="BSD-1 GPL-2+ LGPL-2+ MIT"
SLOT="5"
IUSE="+opencc +gui +lua browser test"
REQUIRED_USE=""

RDEPEND="app-i18n/fcitx5
	>=app-i18n/libime-1.0.17
	lua? ( >=app-i18n/fcitx5-lua-5.0.10 )
	opencc? ( app-i18n/opencc:= )
	gui? (
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtconcurrent:5
		app-i18n/fcitx5-qt[qt5,-only_plugin]
		browser? (
			dev-qt/qtwebengine:5
		)
	)"
DEPEND="${RDEPEND}
	kde-frameworks/extra-cmake-modules:5
	virtual/pkgconfig"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DENABLE_GUI=$(usex gui)
		-DENABLE_OPENCC=$(usex opencc)
		-DENABLE_BROWSER=$(usex browser)
		-DUSE_WEBKIT=no
	)
	cmake_src_configure
}
