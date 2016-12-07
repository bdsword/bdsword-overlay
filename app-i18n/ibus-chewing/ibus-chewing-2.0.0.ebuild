# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils
inherit git-r3
inherit gnome2-utils

MY_P=${PN}-2.0.0

DESCRIPTION="The Chewing IMEngine for IBus Framework"
HOMEPAGE="https://github.com/definite/ibus-chewing"

EGIT_SUBMODULES=( '*' )
EGIT_REPO_URI="https://github.com/definite/ibus-chewing.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="x11-libs/libXtst
	>=app-i18n/ibus-1.3
	>=dev-libs/libchewing-0.3.3
	x11-libs/gtk+:2
	dev-util/gob:2
	dev-vcs/git"
DEPEND="${RDEPEND}
	gnome-base/gconf
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

CMAKE_IN_SOURCE_BUILD=1

DOCS="AUTHORS ChangeLog README.md RELEASE-NOTES.txt USER-GUIDE"
GNOME2_ECLASS_GLIB_SCHEMAS="force"

src_configure() {
	local mycmakeargs=(
		-DPRJ_DOC_DIR=/usr/share/doc/${PF}
		)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_make all translations
}

pkg_postinst() {
	gnome2_schemas_update
}
