From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Mon, 7 Oct 2024 14:34:04 +0800
Subject: [PATCH 0/4] [PATCH 0/4] Update ASPEED WDT bootstatus
Message-ID: <20241007063408.2360874-1-chin-ting_kuo@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series inherits the patch submitted by Peter.
https://patchwork.kernel.org/project/linux-watchdog/patch/20240430143114.1323686-2-peteryin.openbmc at gmail.com/
Besides, the boot status modififed in the WDT driver
obeys the rules proposed in the OpenBMC.
https://github.com/openbmc/docs/blob/master/designs/bmc-reboot-cause-update.md#proposed-design
Moreover, WDT SW reset is supported since AST2600 platform
and is also included in this patch series.

Chin-Ting Kuo (4):
  dt-bindings: watchdog: aspeed: Add property for WDT SW reset
  ARM: dts: aspeed: Add WDT controller into alias field
  watchdog: aspeed: Update bootstatus handling
  watchdog: aspeed: Add support for SW restart

 .../bindings/watchdog/aspeed,ast2400-wdt.yaml |  11 ++
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi       |   2 +
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi       |   3 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   4 +
 drivers/watchdog/aspeed_wdt.c                 | 149 ++++++++++++++++--
 5 files changed, 160 insertions(+), 9 deletions(-)

-- 
2.34.1

