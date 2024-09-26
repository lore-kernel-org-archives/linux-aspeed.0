From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Thu, 26 Sep 2024 11:28:18 +0800
Subject: [PATCH v1 2/5] ARM: dts: aspeed: yosemite4: remove led gpio pca9552 on fan boards
In-Reply-To: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20240926032821.4171466-3-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Remove led gpio contorller: pca9552 on fan boards since there is
no binding document for pca9552 currently.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 04f6378c2b5f..430c28bdd314 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -525,15 +525,6 @@ eeprom at 52 {
 				compatible = "atmel,24c128";
 				reg = <0x52>;
 			};
-
-			gpio at 61 {
-				compatible = "nxp,pca9552";
-				reg = <0x61>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				gpio-controller;
-				#gpio-cells = <2>;
-			};
 		};
 
 		imux31: i2c at 1 {
@@ -577,15 +568,6 @@ eeprom at 52 {
 				compatible = "atmel,24c128";
 				reg = <0x52>;
 			};
-
-			gpio at 61 {
-				compatible = "nxp,pca9552";
-				reg = <0x61>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				gpio-controller;
-				#gpio-cells = <2>;
-			};
 		};
 	};
 };
-- 
2.25.1

