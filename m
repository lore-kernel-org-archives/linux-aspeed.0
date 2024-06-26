From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Wed, 26 Jun 2024 21:03:26 +0800
Subject: [PATCH v1 11/17] ARM: dts: aspeed: minerva: add tmp75 sensor
In-Reply-To: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
References: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
Message-ID: <20240626130332.929534-12-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Yang Chen <yang.chen@quantatw.com>

Add tmp75 sensor on the i2c bus connect to each fan board.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index fd769578f826..3d80993885b7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -231,6 +231,11 @@ power-sensor at 45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+
+			temperature-sensor at 4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 
 		imux17: i2c at 1 {
@@ -273,6 +278,11 @@ power-sensor at 45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+
+			temperature-sensor at 4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 
 		imux18: i2c at 2 {
@@ -315,6 +325,11 @@ power-sensor at 45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+
+			temperature-sensor at 4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 
 		imux19: i2c at 3 {
@@ -357,6 +372,11 @@ power-sensor at 45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+
+			temperature-sensor at 4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 
 		imux20: i2c at 4 {
@@ -399,6 +419,10 @@ power-sensor at 45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+			temperature-sensor at 4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 
 		imux21: i2c at 5 {
@@ -441,6 +465,10 @@ power-sensor at 45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+			temperature-sensor at 4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 	};
 };
-- 
2.34.1

