From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Tue,  8 Dec 2020 11:36:58 +0700
Subject: [PATCH 0/2] ARM: dts: aspeed: Add Ampere Mt. Jade BMC device
Message-ID: <20201208043700.23098-1-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The Mt. Jade BMC is an ASPEED AST2500-based BMC for the Mt. Jade
hardware reference platform with Ampere's Altra Processor Family.

Quan Nguyen (2):
  dt-bindings: vendor-prefixes: Add an entry for AmpereComputing.com
  ARM: dts: aspeed: Add device tree for Ampere's Mt. Jade BMC

 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 558 ++++++++++++++++++
 3 files changed, 561 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts

-- 
2.28.0

