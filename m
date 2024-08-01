From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Fri,  2 Aug 2024 00:01:35 +0800
Subject: [PATCH v3 11/11] ARM: dts: aspeed: Harma: remove pca9546
In-Reply-To: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
References: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
Message-ID: <20240801160136.1281291-12-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove pca9546 device from i2c bus 9.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 4421822eb134..cf3f807a38fe 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -20,10 +20,6 @@ aliases {
 		i2c21 = &imux21;
 		i2c22 = &imux22;
 		i2c23 = &imux23;
-		i2c24 = &imux24;
-		i2c25 = &imux25;
-		i2c26 = &imux26;
-		i2c27 = &imux27;
 		i2c28 = &imux28;
 		i2c29 = &imux29;
 		i2c30 = &imux30;
@@ -409,33 +405,6 @@ gpio at 31 {
 		"","","","";
 	};
 
-	i2c-mux at 71 {
-		compatible = "nxp,pca9546";
-		reg = <0x71>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		imux24: i2c at 0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-		imux25: i2c at 1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-		imux26: i2c at 2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-		imux27: i2c at 3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-	};
 	// PTTV FRU
 	eeprom at 52 {
 		compatible = "atmel,24c64";
-- 
2.25.1

