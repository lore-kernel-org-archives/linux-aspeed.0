From: Steven Lee <steven_lee@aspeedtech.com>
Date: Mon, 24 May 2021 15:32:52 +0800
Subject: [PATCH v5 0/4] mmc: sdhci-of-aspeed: Support toggling SD bus signal
Message-ID: <20210524073308.9328-1-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

AST2600-A2 EVB has the reference design for enabling SD bus
power and toggling SD bus signal voltage between 3.3v and 1.8v by
GPIO regulators.
This patch series adds sdhci node and gpio regulators in a new dts file
for AST2600-A2 EVB.
The description of the reference design of AST2600-A2 EVB is added
in the new dts file.

This patch also include a helper for updating AST2600 sdhci capability
registers.

Changes from v4:
* Move sdhci node and gpio regulator from aspeed-ast2600-evb-a2.dts
  to aspeed-ast2600-evb.dts. Now aspeed-ast2600-evb.dts only supports
  A2(or newer) evbs.
* Remove aspeed-ast2600-evb-a2.dts since sdhci nodes were moved to
  aspeed-ast2600-evb.dts.
* Add aspeed-ast2600-evb-a1.dts for A1 and A0 evbs.

Changes from v3:
* Remove the example of gpio regulator from dt-bindings.
* Add sdhci node and gpio regulators to a new dts file.
* Move the comment of the reference design to the new
  dts file.
* Modify commit message of sdhci-of-aspeed.c.
* Fix coding style issues of sdhci-of-aspeed.c.
* Remove the implementation of eMMC resetc since it has no relevance to
  the goal that this patch series want to achieve and it may needs further
  discussion about the design of reset behavior.

Changes from v2:
* Move the comment of the reference design from dt-bindings to device tree.
* Add clk-phase binding for eMMC controller.
* Reimplement aspeed_sdc_set_slot_capability().
* Separate the implementation of eMMC reset to another patch file.
* Fix yaml document error per the report of dt_binding_check and
  dtbs_check.

Changes from v1:
* Add the device tree example for AST2600 A2 EVB in dt-bindings
  document
* Add timing-phase for eMMC controller.
* Remove power-gpio and power-switch-gpio from sdhci driver, they should
  be handled by regulator.
* Add a helper to update capability registers in the driver.
* Sync sdhci settings from device tree to SoC capability registers.
* Sync timing-phase from device tree to SoC Clock Phase Control
  register

Please help to review.

Regards,
Steven

Steven Lee (4):
  ARM: dts: aspeed: ast2600evb: Add sdhci node and gpio regulator for A2
    evb.
  ARM: dts: aspeed: ast2600evb: Add phase correction for emmc
    controller.
  ARM: dts: aspeed: ast2600evb: Add dts file for A1 and A0.
  mmc: sdhci-of-aspeed: Configure the SDHCIs as specified by the
    devicetree.

 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts | 15 ++++
 arch/arm/boot/dts/aspeed-ast2600-evb.dts    | 87 ++++++++++++++++++++-
 drivers/mmc/host/sdhci-of-aspeed.c          | 48 ++++++++++++
 3 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts

-- 
2.17.1

