From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Tue, 10 Sep 2024 15:53:56 +0800
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Add power module and ADC on Medusa Board
Message-ID: <20240910075357.3531211-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add RTQ6056 as 2nd source ADC sensor on Medusa Board.
Add power sensors on Medusa board:
- Add XDP710 as 2nd source HSC to monitor P48V PSU power.
- Add MP5023 as P12V efuse (Driver exists but un-documented).
- Add PMBUS sensors as P12V Delta Module.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 45 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..e486b9d78f61 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -284,15 +284,25 @@ &i2c10 {
 &i2c11 {
 	status = "okay";
 	power-sensor at 10 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x10>;
 	};
 
+	power-sensor at 11 {
+		compatible = "infineon,xdp710";
+		reg = <0x11>;
+	};
+
 	power-sensor at 12 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
+	power-sensor at 13 {
+		compatible = "infineon,xdp710";
+		reg = <0x13>;
+	};
+
 	gpio at 20 {
 		compatible = "nxp,pca9555";
 		reg = <0x20>;
@@ -321,6 +331,17 @@ gpio at 23 {
 		#gpio-cells = <2>;
 	};
 
+	power-sensor at 40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
+	adc at 41 {
+		compatible = "richtek,rtq6056";
+		reg = <0x41>;
+		#io-channel-cells = <1>;
+	};
+
 	temperature-sensor at 48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
@@ -345,6 +366,26 @@ eeprom at 54 {
 		compatible = "atmel,24c256";
 		reg = <0x54>;
 	};
+
+	power-sensor at 62 {
+		compatible = "pmbus";
+		reg = <0x62>;
+	};
+
+	power-sensor at 64 {
+		compatible = "pmbus";
+		reg = <0x64>;
+	};
+
+	power-sensor at 65 {
+		compatible = "pmbus";
+		reg = <0x65>;
+	};
+
+	power-sensor at 68 {
+		compatible = "pmbus";
+		reg = <0x68>;
+	};
 };
 
 &i2c12 {
-- 
2.25.1

