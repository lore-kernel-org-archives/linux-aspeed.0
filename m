From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Wed, 22 Sep 2021 18:31:14 +0800
Subject: [PATCH 08/10] arm: dts: ibm: Adjust clock phase parameter
In-Reply-To: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
Message-ID: <20210922103116.30652-9-chin-ting_kuo@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

- Add max-tap-delay property for eMMC controller.
- Change clock phase degree for AST2600 on IBM platforms.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 3 ++-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 3 ++-
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts  | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index 2efd70666738..eccb4749755a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -2824,6 +2824,7 @@
 
 &emmc_controller {
 	status = "okay";
+	max-tap-delay = <1253>;
 };
 
 &pinctrl_emmc_default {
@@ -2832,7 +2833,7 @@
 
 &emmc {
 	status = "okay";
-	clk-phase-mmc-hs200 = <210>, <228>;
+	clk-phase-mmc-hs200 = <1 124>, <1 141>;
 };
 
 &fsim0 {
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 6419c9762c0b..2138a8a10d6e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -299,6 +299,7 @@
 
 &emmc_controller {
 	status = "okay";
+	max-tap-delay = <1253>;
 };
 
 &pinctrl_emmc_default {
@@ -307,7 +308,7 @@
 
 &emmc {
 	status = "okay";
-	clk-phase-mmc-hs200 = <180>, <180>;
+	clk-phase-mmc-hs200 = <1 90>, <1 90>;
 };
 
 &fsim0 {
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index e39f310d55eb..7427809354cc 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -182,11 +182,12 @@
 
 &emmc_controller {
 	status = "okay";
+	max-tap-delay = <1253>;
 };
 
 &emmc {
 	status = "okay";
-	clk-phase-mmc-hs200 = <36>, <270>;
+	clk-phase-mmc-hs200 = <0 40>, <1 181>;
 };
 
 &fsim0 {
-- 
2.17.1

