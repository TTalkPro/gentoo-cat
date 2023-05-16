# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ "${PV}" =~ (^|\.)9999$ ]]; then
	inherit git-r3
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/fcitx/fcitx5-skk"
else
	KEYWORDS="amd64 x86"
fi

inherit xdg cmake

SRC_URI="https://download.fcitx-im.org/fcitx5/fcitx5-skk/fcitx5-skk-${PV}.tar.xz"

DESCRIPTION="Japanese SKK input engine for Fcitx5"
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5-skk"

LICENSE="GPL-3+"
SLOT="5"

BDEPEND="kde-frameworks/extra-cmake-modules:5
		virtual/pkgconfig"

RDEPEND="app-i18n/fcitx5
		app-i18n/libskk
		dev-qt/qtcore:5
		app-i18n/fcitx5-qt[qt5,-only_plugin]
		app-i18n/skk-jisyo
		!app-i18n/fcitx-skk"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
	)
	cmake_src_configure
}
