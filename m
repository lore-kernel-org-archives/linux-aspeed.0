From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Tue, 12 Mar 2024 14:15:53 +0800
Subject: [PATCH v6 21/22] ARM: dts: aspeed: yosemite4: support NIC eeprom
In-Reply-To: <20240312061556.496605-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240312061556.496605-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20240312061556.496605-22-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add NIC eeprom devicetree config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index db195213a848..c2d184b21567 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1330,6 +1330,11 @@ temperature-sensor at 3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux25: i2c at 1 {
@@ -1346,6 +1351,11 @@ temperature-sensor at 3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux26: i2c at 2 {
@@ -1362,6 +1372,11 @@ temperature-sensor at 3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux27: i2c at 3 {
@@ -1378,6 +1393,11 @@ temperature-sensor at 3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 	};
 };
-- 
2.25.1

