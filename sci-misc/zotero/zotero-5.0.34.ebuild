# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils
inherit xdg-utils

DESCRIPTION="Zotero [zoh-TAIR-oh] is a free, easy-to-use tool to help you collect, organize, cite, and share your research sources."
HOMEPAGE="https://www.zotero.org/"

SRC_URI="amd64? ( https://download.zotero.org/client/release/${PV}/Zotero-${PV}_linux-x86_64.tar.bz2 ) 
		x86? ( https://download.zotero.org/client/release/${PV}/Zotero-${PV}_linux-i686.tar.bz2 ) "

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"

RDEPEND="dev-libs/dbus-glib
		x11-libs/gtk+:2
		dev-libs/nss"


#if use amd64; then 
#	S=${WORKDIR}/${PN}_linux-x86_64
#elif use x86; then
#	S=${WORKDIR}/${PN}_linux-i686
#fi
S=${WORKDIR}/${PN}

src_unpack() {
	if use x86; then
		unpack Zotero-${PV}_linux-i686.tar.bz2
		mv Zotero_linux-i686 ${PN}
	fi
	if use amd64; then
		unpack Zotero-${PV}_linux-x86_64.tar.bz2
		mv Zotero_linux-x86_64 ${PN}
	fi

}

src_prepare() {
	sed -i 's/Exec=.*/Exec=zotero/g' ${S}/${PN}.desktop
	sed -i 's/Icon=zotero.ico/Icon=zotero/g' ${S}/${PN}.desktop
}

src_install() {
	# install zotero files to /opt/Zotero
	insinto /opt/${PN}
	doins -r ${S}/* || die "Installing files failed"

	for size in 16 32 48 256; do
		newicon -s ${size} chrome/icons/default/default${size}.png zotero.png
	done

	fperms +x /opt/${PN}/zotero /opt/${PN}/zotero-bin
	dosym /opt/${PN}/zotero /opt/bin/zotero
	
	domenu /opt/${PN}/${PN}.desktop
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}

