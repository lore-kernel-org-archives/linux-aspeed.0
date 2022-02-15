From: Potin Lai <potin.lai@quantatw.com>
Date: Wed, 16 Feb 2022 00:31:42 +0800
Subject: [PATCH v3 01/10] ARM: dts: aspeed: bletchley: switch sled numbering
 to 1-based
In-Reply-To: <20220215163151.32252-1-potin.lai@quantatw.com>
References: <20220215163151.32252-1-potin.lai@quantatw.com>
Message-ID: <20220215163151.32252-2-potin.lai@quantatw.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Switch sled to 1-based to meet OpenBMC multi-host numbering rule

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 128 +++++++++---------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index f973ea883b97..e77736ed5c4c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -101,16 +101,6 @@
 			default-state = "off";
 			gpios = <&fan_ioexp 15 GPIO_ACTIVE_HIGH>;
 		};
-		sled0_amber {
-			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled0_leds 0 GPIO_ACTIVE_LOW>;
-		};
-		sled0_blue {
-			retain-state-shutdown;
-			default-state = "off";
-			gpios = <&sled0_leds 1 GPIO_ACTIVE_LOW>;
-		};
 		sled1_amber {
 			retain-state-shutdown;
 			default-state = "off";
@@ -161,6 +151,16 @@
 			default-state = "off";
 			gpios = <&sled5_leds 1 GPIO_ACTIVE_LOW>;
 		};
+		sled6_amber {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&sled6_leds 0 GPIO_ACTIVE_LOW>;
+		};
+		sled6_blue {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&sled6_leds 1 GPIO_ACTIVE_LOW>;
+		};
 	};
 };
 
@@ -219,7 +219,7 @@
 		reg = <0x4f>;
 	};
 
-	sled0_ioexp: pca9539 at 76 {
+	sled1_ioexp: pca9539 at 76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -228,13 +228,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"SLED0_MS_DETECT1","SLED0_VBUS_BMC_EN","SLED0_INA230_ALERT","SLED0_P12V_STBY_ALERT",
-		"SLED0_SSD_ALERT","SLED0_MS_DETECT0","SLED0_RST_CCG5","SLED0_FUSB302_INT",
-		"SLED0_MD_STBY_RESET","SLED0_MD_IOEXP_EN_FAULT","SLED0_MD_DIR","SLED0_MD_DECAY",
-		"SLED0_MD_MODE1","SLED0_MD_MODE2","SLED0_MD_MODE3","power-host0";
+		"SLED1_MS_DETECT1","SLED1_VBUS_BMC_EN","SLED1_INA230_ALERT","SLED1_P12V_STBY_ALERT",
+		"SLED1_SSD_ALERT","SLED1_MS_DETECT0","SLED1_RST_CCG5","SLED1_FUSB302_INT",
+		"SLED1_MD_STBY_RESET","SLED1_MD_IOEXP_EN_FAULT","SLED1_MD_DIR","SLED1_MD_DECAY",
+		"SLED1_MD_MODE1","SLED1_MD_MODE2","SLED1_MD_MODE3","power-host1";
 	};
 
-	sled0_leds: pca9552 at 67 {
+	sled1_leds: pca9552 at 67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -243,13 +243,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled0-amber","led-sled0-blue","SLED0_RST_IOEXP","",
+		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled0_fusb302: typec-portc at 22 {
+	sled1_fusb302: typec-portc at 22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -282,7 +282,7 @@
 		reg = <0x4f>;
 	};
 
-	sled1_ioexp: pca9539 at 76 {
+	sled2_ioexp: pca9539 at 76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -291,13 +291,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"SLED1_MS_DETECT1","SLED1_VBUS_BMC_EN","SLED1_INA230_ALERT","SLED1_P12V_STBY_ALERT",
-		"SLED1_SSD_ALERT","SLED1_MS_DETECT0","SLED1_RST_CCG5","SLED1_FUSB302_INT",
-		"SLED1_MD_STBY_RESET","SLED1_MD_IOEXP_EN_FAULT","SLED1_MD_DIR","SLED1_MD_DECAY",
-		"SLED1_MD_MODE1","SLED1_MD_MODE2","SLED1_MD_MODE3","power-host1";
+		"SLED2_MS_DETECT1","SLED2_VBUS_BMC_EN","SLED2_INA230_ALERT","SLED2_P12V_STBY_ALERT",
+		"SLED2_SSD_ALERT","SLED2_MS_DETECT0","SLED2_RST_CCG5","SLED2_FUSB302_INT",
+		"SLED2_MD_STBY_RESET","SLED2_MD_IOEXP_EN_FAULT","SLED2_MD_DIR","SLED2_MD_DECAY",
+		"SLED2_MD_MODE1","SLED2_MD_MODE2","SLED2_MD_MODE3","power-host2";
 	};
 
-	sled1_leds: pca9552 at 67 {
+	sled2_leds: pca9552 at 67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -306,13 +306,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","",
+		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled1_fusb302: typec-portc at 22 {
+	sled2_fusb302: typec-portc at 22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -349,7 +349,7 @@
 		reg = <0x4f>;
 	};
 
-	sled2_ioexp: pca9539 at 76 {
+	sled3_ioexp: pca9539 at 76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -358,13 +358,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"SLED2_MS_DETECT1","SLED2_VBUS_BMC_EN","SLED2_INA230_ALERT","SLED2_P12V_STBY_ALERT",
-		"SLED2_SSD_ALERT","SLED2_MS_DETECT0","SLED2_RST_CCG5","SLED2_FUSB302_INT",
-		"SLED2_MD_STBY_RESET","SLED2_MD_IOEXP_EN_FAULT","SLED2_MD_DIR","SLED2_MD_DECAY",
-		"SLED2_MD_MODE1","SLED2_MD_MODE2","SLED2_MD_MODE3","power-host2";
+		"SLED3_MS_DETECT1","SLED3_VBUS_BMC_EN","SLED3_INA230_ALERT","SLED3_P12V_STBY_ALERT",
+		"SLED3_SSD_ALERT","SLED3_MS_DETECT0","SLED3_RST_CCG5","SLED3_FUSB302_INT",
+		"SLED3_MD_STBY_RESET","SLED3_MD_IOEXP_EN_FAULT","SLED3_MD_DIR","SLED3_MD_DECAY",
+		"SLED3_MD_MODE1","SLED3_MD_MODE2","SLED3_MD_MODE3","power-host3";
 	};
 
-	sled2_leds: pca9552 at 67 {
+	sled3_leds: pca9552 at 67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -373,13 +373,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","",
+		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled2_fusb302: typec-portc at 22 {
+	sled3_fusb302: typec-portc at 22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -412,7 +412,7 @@
 		reg = <0x4f>;
 	};
 
-	sled3_ioexp: pca9539 at 76 {
+	sled4_ioexp: pca9539 at 76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -421,13 +421,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"SLED3_MS_DETECT1","SLED3_VBUS_BMC_EN","SLED3_INA230_ALERT","SLED3_P12V_STBY_ALERT",
-		"SLED3_SSD_ALERT","SLED3_MS_DETECT0","SLED3_RST_CCG5","SLED3_FUSB302_INT",
-		"SLED3_MD_STBY_RESET","SLED3_MD_IOEXP_EN_FAULT","SLED3_MD_DIR","SLED3_MD_DECAY",
-		"SLED3_MD_MODE1","SLED3_MD_MODE2","SLED3_MD_MODE3","power-host3";
+		"SLED4_MS_DETECT1","SLED4_VBUS_BMC_EN","SLED4_INA230_ALERT","SLED4_P12V_STBY_ALERT",
+		"SLED4_SSD_ALERT","SLED4_MS_DETECT0","SLED4_RST_CCG5","SLED4_FUSB302_INT",
+		"SLED4_MD_STBY_RESET","SLED4_MD_IOEXP_EN_FAULT","SLED4_MD_DIR","SLED4_MD_DECAY",
+		"SLED4_MD_MODE1","SLED4_MD_MODE2","SLED4_MD_MODE3","power-host4";
 	};
 
-	sled3_leds: pca9552 at 67 {
+	sled4_leds: pca9552 at 67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -436,13 +436,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","",
+		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled3_fusb302: typec-portc at 22 {
+	sled4_fusb302: typec-portc at 22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -475,7 +475,7 @@
 		reg = <0x4f>;
 	};
 
-	sled4_ioexp: pca9539 at 76 {
+	sled5_ioexp: pca9539 at 76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -484,13 +484,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"SLED4_MS_DETECT1","SLED4_VBUS_BMC_EN","SLED4_INA230_ALERT","SLED4_P12V_STBY_ALERT",
-		"SLED4_SSD_ALERT","SLED4_MS_DETECT0","SLED4_RST_CCG5","SLED4_FUSB302_INT",
-		"SLED4_MD_STBY_RESET","SLED4_MD_IOEXP_EN_FAULT","SLED4_MD_DIR","SLED4_MD_DECAY",
-		"SLED4_MD_MODE1","SLED4_MD_MODE2","SLED4_MD_MODE3","power-host4";
+		"SLED5_MS_DETECT1","SLED5_VBUS_BMC_EN","SLED5_INA230_ALERT","SLED5_P12V_STBY_ALERT",
+		"SLED5_SSD_ALERT","SLED5_MS_DETECT0","SLED5_RST_CCG5","SLED5_FUSB302_INT",
+		"SLED5_MD_STBY_RESET","SLED5_MD_IOEXP_EN_FAULT","SLED5_MD_DIR","SLED5_MD_DECAY",
+		"SLED5_MD_MODE1","SLED5_MD_MODE2","SLED5_MD_MODE3","power-host5";
 	};
 
-	sled4_leds: pca9552 at 67 {
+	sled5_leds: pca9552 at 67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -499,13 +499,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","",
+		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled4_fusb302: typec-portc at 22 {
+	sled5_fusb302: typec-portc at 22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -538,7 +538,7 @@
 		reg = <0x4f>;
 	};
 
-	sled5_ioexp: pca9539 at 76 {
+	sled6_ioexp: pca9539 at 76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
 		#address-cells = <1>;
@@ -547,13 +547,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"SLED5_MS_DETECT1","SLED5_VBUS_BMC_EN","SLED5_INA230_ALERT","SLED5_P12V_STBY_ALERT",
-		"SLED5_SSD_ALERT","SLED5_MS_DETECT0","SLED5_RST_CCG5","SLED5_FUSB302_INT",
-		"SLED5_MD_STBY_RESET","SLED5_MD_IOEXP_EN_FAULT","SLED5_MD_DIR","SLED5_MD_DECAY",
-		"SLED5_MD_MODE1","SLED5_MD_MODE2","SLED5_MD_MODE3","power-host5";
+		"SLED6_MS_DETECT1","SLED6_VBUS_BMC_EN","SLED6_INA230_ALERT","SLED6_P12V_STBY_ALERT",
+		"SLED6_SSD_ALERT","SLED6_MS_DETECT0","SLED6_RST_CCG5","SLED6_FUSB302_INT",
+		"SLED6_MD_STBY_RESET","SLED6_MD_IOEXP_EN_FAULT","SLED6_MD_DIR","SLED6_MD_DECAY",
+		"SLED6_MD_MODE1","SLED6_MD_MODE2","SLED6_MD_MODE3","power-host6";
 	};
 
-	sled5_leds: pca9552 at 67 {
+	sled6_leds: pca9552 at 67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
 		#address-cells = <1>;
@@ -562,13 +562,13 @@
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","",
+		"led-sled6-amber","led-sled6-blue","SLED6_RST_IOEXP","",
 		"","","","",
 		"","","","",
 		"","","","";
 	};
 
-	sled5_fusb302: typec-portc at 22 {
+	sled6_fusb302: typec-portc at 22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
@@ -702,17 +702,17 @@
 	/*F0-F7*/	"","","","","","","","",
 	/*G0-G7*/	"","SWITCH_FRU_MUX","","","","","","",
 	/*H0-H7*/	"presence-riser1","presence-riser2",
-			"presence-sled0","presence-sled1",
-			"presence-sled2","presence-sled3",
-			"presence-sled4","presence-sled5",
+			"presence-sled1","presence-sled2",
+			"presence-sled3","presence-sled4",
+			"presence-sled5","presence-sled6",
 	/*I0-I7*/	"REV_ID0","","REV_ID1","REV_ID2",
 			"","","","",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
 	/*L0-L7*/	"","","","","","","","",
-	/*M0-M7*/	"ALERT_SLED0","ALERT_SLED1",
-			"ALERT_SLED2","ALERT_SLED3",
-			"ALERT_SLED4","ALERT_SLED5",
+	/*M0-M7*/	"ALERT_SLED1","ALERT_SLED2",
+			"ALERT_SLED3","ALERT_SLED4",
+			"ALERT_SLED5","ALERT_SLED6",
 			"P12V_AUX_ALERT1","",
 	/*N0-N7*/	"","","","","","","","",
 	/*O0-O7*/	"","","","",
-- 
2.17.1

