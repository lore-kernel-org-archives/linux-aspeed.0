From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 10 Jul 2019 23:45:00 +0930
Subject: [PATCH 0/3] ARM: dts: aspeed: Enable SD controllers
Message-ID: <20190710141503.21026-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This series describes the ASPEED SD controller in relevant devicetree files,
enabling the MMC slots on the AST2500 EVB and Swift machines.

Please review!

Andrew

Andrew Jeffery (2):
  ARM: dts: aspeed: Describe SD controller in DTSIs
  ARM: dts: aspeed: Enable both MMC slots on AST2500 EVB

Joel Stanley (1):
  ARM: dts: aspeed: Enable both MMC slots on Swift

 arch/arm/boot/dts/aspeed-ast2500-evb.dts      | 18 +++++++++++
 .../boot/dts/aspeed-bmc-opp-witherspoon.dts   | 18 +++++++++++
 arch/arm/boot/dts/aspeed-g4.dtsi              | 30 +++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi              | 30 +++++++++++++++++++
 4 files changed, 96 insertions(+)

-- 
2.20.1

