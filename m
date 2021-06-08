From: Sudeep Holla <sudeep.holla@arm.com>
Date: Tue,  8 Jun 2021 23:02:47 +0100
Subject: [PATCH] ARM: dts: aspeed: Drop wrong and inconsistent "sdhci"
 compatible
Message-ID: <20210608220247.2237139-1-sudeep.holla@arm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

As per mmc/aspeed,sdhci.yaml, "sdhci" is not a valid compatible. In fact,
it is not documented at all(including old txt bindings). Also it is
pretty inconsistent within the same dtsi. Once instance of controller
refers to it while the other doesn't.

Fix it by dropping the wrong "sdhci" compatible.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index f96607b7b4e2..3488e8ba9df8 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -541,7 +541,7 @@ sdc: sdc at 1e740000 {
 				status = "disabled";
 
 				sdhci0: sdhci at 1e740100 {
-					compatible = "aspeed,ast2600-sdhci", "sdhci";
+					compatible = "aspeed,ast2600-sdhci";
 					reg = <0x100 0x100>;
 					interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 					sdhci,auto-cmd12;
@@ -550,7 +550,7 @@ sdhci0: sdhci at 1e740100 {
 				};
 
 				sdhci1: sdhci at 1e740200 {
-					compatible = "aspeed,ast2600-sdhci", "sdhci";
+					compatible = "aspeed,ast2600-sdhci";
 					reg = <0x200 0x100>;
 					interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 					sdhci,auto-cmd12;
-- 
2.25.1

