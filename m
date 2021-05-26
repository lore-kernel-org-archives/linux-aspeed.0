From: Steven Lee <steven_lee@aspeedtech.com>
Date: Wed, 26 May 2021 17:46:04 +0800
Subject: [PATCH v1 0/4] ASPEED sgpio driver enhancement.
Message-ID: <20210526094609.14068-1-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

AST2600 SoC has 2 SGPIO master interfaces one with 128 pins another one
with 80 pins, AST2500/AST2400 SoC has 1 SGPIO master interface that
supports up to 80 pins.
In the current driver design, the max number of sgpio pins is hardcoded
in macro MAX_NR_HW_SGPIO and the value is 80.

For supporting sgpio master interfaces of AST2600 SoC, the patch series
contains the following enhancement:
- Convert txt dt-bindings to yaml.
- Update aspeed dtsi to support the enhanced sgpio.
- Get the max number of sgpio that SoC supported from dts.
- Support muiltiple SGPIO master interfaces.
- Support up to 128 pins.

Please help to review.

Thanks,
Steven


Steven Lee (4):
  dt-bindings: aspeed-sgpio: Convert txt bindings to yaml.
  ARM: dts: aspeed-g6: Add SGPIO node.
  ARM: dts: aspeed-g5: Modify sgpio node for the enhanced sgpio driver.
  gpio: gpio-aspeed-sgpio: Add AST2600 sgpio support

 .../bindings/gpio/aspeed,sgpio.yaml           |  91 +++++++++
 .../devicetree/bindings/gpio/sgpio-aspeed.txt |  46 -----
 arch/arm/boot/dts/aspeed-g5.dtsi              |   3 +-
 arch/arm/boot/dts/aspeed-g6.dtsi              |  32 +++
 drivers/gpio/gpio-aspeed-sgpio.c              | 193 ++++++++++++------
 5 files changed, 250 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt

-- 
2.17.1

