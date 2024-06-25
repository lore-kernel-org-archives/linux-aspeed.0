From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 25 Jun 2024 20:18:30 +0800
Subject: [PATCH 12/17] ARM: dts: aspeed: minerva: add tmp75 sensor
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
Message-ID: <20240625121835.751013-13-yangchen.openbmc@gmail.com>
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
index 830616663387..7f6df8750953 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -252,6 +252,11 @@ power-sensor at 45 {
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
@@ -294,6 +299,11 @@ power-sensor at 45 {
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
@@ -336,6 +346,11 @@ power-sensor at 45 {
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
@@ -378,6 +393,11 @@ power-sensor at 45 {
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
@@ -420,6 +440,10 @@ power-sensor at 45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+			temperature-sensor at 4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 
 		imux21: i2c at 5 {
@@ -462,6 +486,10 @@ power-sensor at 45 {
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

