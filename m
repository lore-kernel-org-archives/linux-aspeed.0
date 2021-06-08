From: Steven Lee <steven_lee@aspeedtech.com>
Date: Tue, 8 Jun 2021 18:25:35 +0800
Subject: [PATCH v5 00/10] ASPEED sgpio driver enhancement.
Message-ID: <20210608102547.4880-1-steven_lee@aspeedtech.com>
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
- Update aspeed-g6 dtsi to support the enhanced sgpio.
- Define max number of gpio pins in ast2600 platform data. Old chip
  uses the original hardcoded value.
- Support muiltiple SGPIO master interfaces.
- Support up to 128 pins.
- Support wdt reset tolerance.
- Fix irq_chip issues which causes multiple sgpio devices use the same
  irq_chip data.
- Replace all of_*() APIs with device_*().

Changes from v4:
* Remove ngpios from dtsi
* Add ast2400 and ast2500 platform data.
* Remove unused macros.
* Add ngpios check in a separate patch.
* Fix coding style issues.

Changes from v3:
* Split dt-bindings patch to 2 patches
* Rename ast2600-sgpiom1 compatible with ast2600-sgiom-128
* Rename ast2600-sgpiom2 compatible with ast2600-sgiom-80
* Correct the typo in commit messages.
* Fix coding style issues.
* Replace all of_*() APIs with device_*().

Changes from v2:
* Remove maximum/minimum of ngpios from bindings.
* Remove max-ngpios from bindings and dtsi.
* Remove ast2400-sgpiom and ast2500-sgpiom compatibles from dts and
  driver.
* Add ast2600-sgpiom1 and ast2600-sgpiom2 compatibles as their max
  number of available gpio pins are different.
* Modify functions to pass aspeed_sgpio struct instead of passing
  max_ngpios.
* Split sgpio driver patch to 3 patches

Changes from v1:
* Fix yaml format issues.
* Fix issues reported by kernel test robot.

Please help to review.

Thanks,
Steven

Steven Lee (10):
  dt-bindings: aspeed-sgpio: Convert txt bindings to yaml.
  dt-bindings: aspeed-sgpio: Add ast2600 sgpio compatibles.
  ARM: dts: aspeed-g6: Add SGPIO node.
  ARM: dts: aspeed-g5: Remove ngpios from sgpio node.
  gpio: gpio-aspeed-sgpio: Add AST2600 sgpio support
  gpio: gpio-aspeed-sgpio: Add AST2400 and AST2500 platform data.
  gpio: gpio-aspeed-sgpio: Add set_config function
  gpio: gpio-aspeed-sgpio: Move irq_chip to aspeed-sgpio struct
  gpio: gpio-aspeed-sgpio: Use generic device property APIs
  gpio: gpio-aspeed-sgpio: Return error if ngpios is not multiple of 8.

 .../bindings/gpio/aspeed,sgpio.yaml           |  78 +++++++
 .../devicetree/bindings/gpio/sgpio-aspeed.txt |  46 ----
 arch/arm/boot/dts/aspeed-g5.dtsi              |   1 -
 arch/arm/boot/dts/aspeed-g6.dtsi              |  28 +++
 drivers/gpio/gpio-aspeed-sgpio.c              | 206 ++++++++++++------
 5 files changed, 248 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt

-- 
2.17.1

