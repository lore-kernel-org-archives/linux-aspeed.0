From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 26 Jun 2019 16:44:22 +0930
Subject: [PATCH 0/8] pinctrl: aspeed: Preparation for AST2600
Message-ID: <20190626071430.28556-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello!

The ASPEED AST2600 is in the pipeline, and we have enough information to start
preparing to upstream support for it. This series lays some ground work;
splitting the bindings and dicing the implementation up a little further to
facilitate differences between the 2600 and previous SoC generations.

I've added a bit more documentation to the private header to help outline the
structures that are generated from the jungle of macros. There will be some
tweaks to their behaviour in the future series to support multiple pin groups
per function while maintaining the property that improperly describing the
pin/signal/group/function relationships causes a failure to compile.

Regarding the bindings this is my first attempt at using the json-schema
approach. It has previously bugged me that there was no way to enforce the
documented bindings on the devicetree, so I think this is an interesting
development. Hopefully I've done an okay job there. I think I could better
exploit the schema to constrain the function and group names used in the DTS,
but I think that can be left as future work.

Finally I've added myself in MAINTAINERS as the PoC for the drivers to make
sure anyone unfortunate enough to stare at the implementations can ping me
about them.

Please review!

Andrew

Andrew Jeffery (8):
  dt-bindings: pinctrl: aspeed: Split bindings document in two
  dt-bindings: pinctrl: aspeed: Convert AST2400 bindings to json-schema
  dt-bindings: pinctrl: aspeed: Convert AST2500 bindings to json-schema
  MAINTAINERS: Add entry for ASPEED pinctrl drivers
  pinctrl: aspeed: Correct comment that is no longer true
  pinctrl: aspeed: Clarify comment about strapping W1C
  pinctrl: aspeed: Split out pinmux from general pinctrl
  pinctrl: aspeed: Add implementation-related documentation

 .../pinctrl/aspeed,ast2400-pinctrl.yaml       |  73 ++
 .../pinctrl/aspeed,ast2500-pinctrl.yaml       | 124 +++
 .../bindings/pinctrl/pinctrl-aspeed.txt       | 172 ----
 MAINTAINERS                                   |   9 +
 drivers/pinctrl/aspeed/Makefile               |   2 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c    |  94 ++-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c    | 123 ++-
 drivers/pinctrl/aspeed/pinctrl-aspeed.c       | 250 +-----
 drivers/pinctrl/aspeed/pinctrl-aspeed.h       | 549 +------------
 drivers/pinctrl/aspeed/pinmux-aspeed.c        |  96 +++
 drivers/pinctrl/aspeed/pinmux-aspeed.h        | 735 ++++++++++++++++++
 11 files changed, 1294 insertions(+), 933 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
 create mode 100644 drivers/pinctrl/aspeed/pinmux-aspeed.c
 create mode 100644 drivers/pinctrl/aspeed/pinmux-aspeed.h

-- 
2.20.1

