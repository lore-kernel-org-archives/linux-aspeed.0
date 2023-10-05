From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Thu,  5 Oct 2023 10:55:24 +0700
Subject: [PATCH 6/7] ARM: dts: aspeed: mtmitchell: Remove redundant ADC configurations
In-Reply-To: <20231005035525.19036-1-chanh@os.amperecomputing.com>
References: <20231005035525.19036-1-chanh@os.amperecomputing.com>
Message-ID: <20231005035525.19036-7-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Mt.Mitchell DVT and later hardware do not use adc1. It only uses
adc0 with channels 0, 1 and 2. This commit removes redundant ADC
configurations.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
 .../dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
index c676172f0dbf..eb8d5e367276 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
@@ -564,20 +564,7 @@
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
-		&pinctrl_adc2_default &pinctrl_adc3_default
-		&pinctrl_adc4_default &pinctrl_adc5_default
-		&pinctrl_adc6_default &pinctrl_adc7_default>;
-};
-
-&adc1 {
-	ref_voltage = <2500>;
-	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
-		&pinctrl_adc10_default &pinctrl_adc11_default
-		&pinctrl_adc12_default &pinctrl_adc13_default
-		&pinctrl_adc14_default &pinctrl_adc15_default>;
+		&pinctrl_adc2_default>;
 };
 
 &vhub {
-- 
2.17.1

