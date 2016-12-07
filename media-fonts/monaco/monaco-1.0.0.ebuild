EAPI=6

inherit git-r3
inherit font


DESCRIPTION="A ebuild to install monaco font to the gentoo system."
SLOT="0"


HOMEPAGE="https://github.com/bdsword/my-gentoo-portage"
LICENSE="MIT"


EGIT_REPO_URI="https://github.com/todylu/monaco.ttf.git"
DEPEND="dev-vcs/git"


S="${WORKDIR}"
FONT_S="${S}/${P}"
FONT_SUFFIX="ttf"
