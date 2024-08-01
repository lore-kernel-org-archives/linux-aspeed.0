From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Fri,  2 Aug 2024 00:01:24 +0800
Subject: [PATCH v3 00/11] Revise Meta(Facebook) Harma BMC(AST2600)
Message-ID: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on: https://lore.kernel.org/all/CAPSyxFRj0twCJG6Lr5UZpznrUHyd_L0Reo=kZSFwCw3FNQ+x+A at mail.gmail.com/

Change log:
v2 -> v3
  - fixed dtb_check warning base on https://lore.kernel.org/all/20240801153429.1277378-1-peteryin.openbmc at gmail.com/
  - Patch 0011 - remove pca9546 from i2c9

v1 -> v2
  - Patch 0007  - add fru device
  - Patch 0008  - add temperature device
  - Patch 0009  - enable mctp controller
  - Patch 0010 - fixed dtb_check warning

v1
  - Patch 0001 - revise hsc chip
  - Patch 0002 - add VR device
  - Patch 0003 - add sgpio name
  - Patch 0004 - add ina238
  - Patch 0005 - add power monitor xdp710
  - Patch 0006 - remove multi-host property
  - Patch 0007 - remove pca9546

Peter Yin (11):
  ARM: dts: aspeed: Harma: revise hsc chip
  ARM: dts: aspeed: Harma: add VR device
  ARM: dts: aspeed: Harma: add sgpio name
  ARM: dts: aspeed: Harma: add ina238
  ARM: dts: aspeed: Harma: add power monitor xdp710
  ARM: dts: aspeed: Harma: remove multi-host property
  ARM: dts: aspeed: Harma: add fru device
  ARM: dts: aspeed: Harma: add temperature device
  ARM: dts: aspeed: Harma: enable mctp controller
  ARM: dts: aspeed: Harma: fixed dtb_check warning
  ARM: dts: aspeed: Harma: remove pca9546

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 177 +++++++++++++-----
 1 file changed, 132 insertions(+), 45 deletions(-)

-- 
2.25.1

