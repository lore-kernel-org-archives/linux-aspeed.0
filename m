From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 24 Jul 2019 17:43:10 +0930
Subject: [PATCH 0/3] ARM: dts: aspeed: Deprecate g[45]-style compatibles
Message-ID: <20190724081313.12934-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

Joel and I decided that going forward we're not going to name compatibles along
the lines of SoC generations, so discourage any further attempts by removing
the remaining instances.

It's probably best if we push the three patches all through one tree rather
than fragmenting. Is everyone happy if Joel applies them to the aspeed tree?

Cheers,

Andrew

Andrew Jeffery (3):
  dts: ARM: aspeed: Migrate away from aspeed,g[45].* compatibles
  pinctrl: aspeed: Document existence of deprecated compatibles
  dt-bindings: aspeed: Remove mention of deprecated compatibles

 Documentation/devicetree/bindings/mfd/aspeed-scu.txt         | 2 --
 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt   | 2 --
 .../devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml  | 5 +----
 .../devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml  | 4 +---
 arch/arm/boot/dts/aspeed-g4.dtsi                             | 2 +-
 arch/arm/boot/dts/aspeed-g5.dtsi                             | 2 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c                   | 4 ++++
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c                   | 4 ++++
 8 files changed, 12 insertions(+), 13 deletions(-)

-- 
2.20.1

