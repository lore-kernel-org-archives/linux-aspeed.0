From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 11 Jul 2019 13:49:36 +0930
Subject: [PATCH 0/6] pinctrl: aspeed: Add AST2600 pinmux support
Message-ID: <20190711041942.23202-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello!

This series adds pinmux support for the AST2600. Some more rework was required
on top of the previous cleanup series, but this rework was focussed on
supporting features of the AST2600 pinmux rather than fixing issues with the
existing infrastructure for the ASPEED drivers. Due to the dependences it's
based on top of pinctrl/devel, so should avoid any more SPDX issues.

ASPEED have been testing the patches on hardware, so even for an initial pass
there's some confidence in the implementation.

Please review!

Andrew

Andrew Jeffery (6):
  dt-bindings: pinctrl: aspeed: Document AST2600 pinmux
  pinctrl: aspeed: Rename pin declaration macros
  pinctrl: aspeed: Add PIN_DECL_3() helper
  pinctrl: aspeed: Add multiple pin group support for functions
  pinctrl: aspeed: Add SIG_DESC_CLEAR() helper
  pinctrl: aspeed: Add AST2600 pinmux support

 .../pinctrl/aspeed,ast2600-pinctrl.yaml       |  128 +
 drivers/pinctrl/aspeed/Kconfig                |    8 +
 drivers/pinctrl/aspeed/Makefile               |    1 +
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c    | 1821 +++++++------
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c    | 1865 +++++++------
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c    | 2395 +++++++++++++++++
 drivers/pinctrl/aspeed/pinmux-aspeed.h        |  227 +-
 7 files changed, 4643 insertions(+), 1802 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
 create mode 100644 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c

-- 
2.20.1

