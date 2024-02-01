From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed, 31 Jan 2024 20:25:54 -0800
Subject: [PATCH] ARM: dts: aspeed: asrock: Use MAC address from FRU EEPROM
Message-ID: <20240201042559.29795-2-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Like the more recently added ASRock BMC platforms, e3c246d4i and
romed8hm3 also have the BMC's MAC address available in the baseboard
FRU EEPROM, so let's add support for using it.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts | 9 +++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
index c4b2efbfdf56..bb2e6ef609af 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
@@ -83,6 +83,9 @@ &mac0 {
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
+
+	nvmem-cells = <&eth0_macaddress>;
+	nvmem-cell-names = "mac-address";
 };
 
 &i2c1 {
@@ -103,6 +106,12 @@ eeprom at 57 {
 		compatible = "st,24c128", "atmel,24c128";
 		reg = <0x57>;
 		pagesize = <16>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		eth0_macaddress: macaddress at 3f80 {
+			reg = <0x3f80 6>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
index 4554abf0c7cd..f8a1764a4424 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
@@ -71,6 +71,9 @@ &mac0 {
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
+
+	nvmem-cells = <&eth0_macaddress>;
+	nvmem-cell-names = "mac-address";
 };
 
 &i2c0 {
@@ -131,6 +134,12 @@ eeprom at 50 {
 		compatible = "st,24c128", "atmel,24c128";
 		reg = <0x50>;
 		pagesize = <16>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		eth0_macaddress: macaddress at 3f80 {
+			reg = <0x3f80 6>;
+		};
 	};
 };
 
-- 
2.43.0

