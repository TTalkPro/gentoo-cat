# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg

SRC_URI="https://download.fcitx-im.org/fcitx5/fcitx5/fcitx5-${PV}_dict.tar.xz"

KEYWORDS="amd64 x86"
DESCRIPTION="Fcitx5 Next generation of fcitx "
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5"

LICENSE="BSD-1 GPL-2+ LGPL-2+ MIT"
SLOT="5"
IUSE="+enchant test coverage doc presage systemd wayland +X"
REQUIRED_USE="
	|| ( wayland X )
	coverage? ( test )
"

RDEPEND="dev-libs/glib:2
	sys-apps/dbus
	dev-libs/json-c
	dev-libs/libfmt
	sys-apps/util-linux
	virtual/libiconv
	virtual/libintl
	x11-libs/libxkbcommon[X?]
	wayland? (
		dev-libs/wayland
		dev-libs/wayland-protocols
	)
	X? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXrender
		x11-libs/libXinerama
		x11-libs/libxkbfile
		>=x11-libs/xcb-imdkit-1.0.5
	)
	x11-misc/xkeyboard-config
	x11-libs/cairo[X?]
	x11-libs/pango
	media-libs/fontconfig
	enchant? ( app-text/enchant:= )
	systemd? ( sys-apps/systemd )
	app-text/iso-codes
	app-i18n/unicode-cldr
	dev-libs/libxml2
	dev-libs/libevent
	x11-libs/gdk-pixbuf:2
"
DEPEND="${RDEPEND}
	kde-frameworks/extra-cmake-modules:5
	virtual/pkgconfig
"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DENABLE_TEST=$(usex test)
		-DENABLE_COVERAGE=$(usex coverage)
		-DENABLE_ENCHANT=$(usex enchant)
		-DENABLE_PRESAGE=$(usex presage)
		-DENABLE_WAYLAND=$(usex wayland)
		-DENABLE_X11=$(usex X)
		-DENABLE_DOC=$(usex doc)
		-DUSE_SYSTEMD=$(usex systemd)
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst

	elog
	elog "Follow the instrcutions of https://wiki.gentoo.org/wiki/Fcitx#Using_Fcitx"
	elog "and change the fcitx to fcitx5"
	elog
}
