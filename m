From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Thu, 28 Mar 2024 09:32:45 +0800
Subject: [PATCH v5 0/4] drivers: watchdog: ast2500 and ast2600 support bootstatus
Message-ID: <20240328013249.3609225-1-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2500/ast2600

Regarding the AST2600 specification, the WDTn Timeout Status Register
(WDT10) has bit 1 reserved. Bit 1 of the status register indicates
on ast2500 if the boot was from the second boot source.
It does not indicate that the most recent reset was triggered by
the watchdog. The code should just be changed to set WDIOF_CARDRESET
if bit 0 of the status register is set.

Include SCU register to veriy WDIOF_EXTERN1 in ast2600 SCU74 or
ast2500 SCU3C when bit1 is set.

v4 -> v5
  - Revert indentation. 

v3 -> v4
  - Add error handling for syscon_regmap_lookup_by_phandle and
  regmap_read.

v2 -> v3
  - Fixed WDIOF_CARDRESET status bit check and added support
  for WDIOF_EXTERN1 on ast2500 and ast2600.

v1 -> v2
  - Add comment and support WDIOF_CARDRESET in ast2600

v1
  - Patch 0001 - Add WDIOF_EXTERN1 bootstatus
---

Peter Yin (4):
  ARM: dts: aspeed: Add the AST2500 WDT with SCU register
  ARM: dts: aspeed: Add the AST2600 WDT with SCU register
  dt-bindings: watchdog: aspeed-wdt: Add aspeed,scu
  drivers: watchdog: ast2500 and ast2600 support bootstatus

 .../bindings/watchdog/aspeed-wdt.txt          |  4 +++
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi       |  3 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  4 +++
 drivers/watchdog/aspeed_wdt.c                 | 34 ++++++++++++++++---
 4 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.25.1

