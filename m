From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 13:55:17 +0930
Subject: [PATCH 0/7] ARM: dts: aspeed: Miscellaneous devicetree cleanups
Message-ID: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

As mentioned elsewhere the Aspeed devicetrees are in a bit of a sad
state. This series is a collection of fixes that make them a little
less so.

If there no concerns raised in the near future I'll queue them up for
the BMC tree.

Andrew

---
Andrew Jeffery (7):
      ARM: dts: aspeed: Fix coprocessor interrupt controller node name
      ARM: dts: aspeed: Specify correct generic compatible for CVIC
      ARM: dts: aspeed: Specify required properties for sram node
      ARM: dts: aspeed: Remove undocumented XDMA nodes
      ARM: dts: aspeed: Clean up AST2500 pinctrl properties
      ARM: dts: aspeed-g6: Use generic 'ethernet' for ftgmac100 nodes
      ARM: dts: aspeed-g6: Drop cells properties from ethernet nodes

 .../boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |  4 ---
 .../aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts  |  4 ---
 .../boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  |  4 ---
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts |  5 ----
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts |  5 ----
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts |  5 ----
 .../boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts |  4 ---
 .../boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dts |  4 ---
 .../boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dts   |  4 ---
 .../arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts |  4 ---
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts |  4 ---
 .../arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts |  4 ---
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts  |  4 ---
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts |  5 ----
 .../boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts |  9 -------
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts  |  2 --
 .../dts/aspeed/aspeed-bmc-supermicro-x11spi.dts    |  4 ---
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi            |  7 ++++--
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi            | 18 ++++----------
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            | 29 +++-------------------
 20 files changed, 14 insertions(+), 115 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240802-dt-warnings-bmc-dts-cleanups-e6b67b9a2017

Best regards,
-- 
Andrew Jeffery <andrew@codeconstruct.com.au>

