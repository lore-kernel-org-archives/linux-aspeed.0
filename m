From: Steven Lee <steven_lee@aspeedtech.com>
Date: Thu, 6 May 2021 18:03:07 +0800
Subject: [PATCH v3 0/5] mmc: sdhci-of-aspeed: Support toggling SD bus signal
Message-ID: <20210506100312.1638-1-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

AST2600-A2 EVB has the reference design for enabling SD bus
power and toggling SD bus signal voltage between 3.3v and 1.8v by
GPIO regulators.
This patch series provides the example for enabling regulators and
supporting SDR104 mode on AST2600-A2 EVB.
The description of the reference design of AST2600-A2 EVB is added
in the dts file.

This patch also include a helper for updating AST2600 sdhci capability
registers, and assert/deassert the reset signal for cleaning up AST2600
eMMC controller before eMMC is probed.

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

Steven Lee (5):
  dt-bindings: mmc: sdhci-of-aspeed: Add an example for AST2600-A2 EVB
  ARM: dts: aspeed: ast2600evb: Add comment for gpio regulator of sdhci
  ARM: dts: aspeed: ast2600evb: Add phase correction for emmc
    controller.
  mmc: sdhci-of-aspeed: Add a helper for updating capability register.
  mmc: sdhci-of-aspeed: Assert/Deassert reset signal before probing eMMC

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 101 ++++++++++++++++-
 arch/arm/boot/dts/aspeed-ast2600-evb.dts      |  18 ++-
 drivers/mmc/host/sdhci-of-aspeed.c            | 106 ++++++++++++++++--
 3 files changed, 211 insertions(+), 14 deletions(-)

-- 
2.17.1

