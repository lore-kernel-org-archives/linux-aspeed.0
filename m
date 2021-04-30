From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 30 Apr 2021 14:00:00 -0500
Subject: [PATCH 4/4] ARM: dts: aspeed: Everest: Add directly controlled LEDs
In-Reply-To: <20210430190000.31646-1-eajames@linux.ibm.com>
References: <20210430190000.31646-1-eajames@linux.ibm.com>
Message-ID: <20210430190000.31646-5-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>

These LEDs are directly connected to the BMC's GPIO bank

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 33 ++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index 27af28c8847d..2ddd10e93a80 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -202,6 +202,35 @@ fan3-presence {
 			linux,code = <12>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		/* RTC battery fault LED at the back */
+		led-rtc-battery {
+			gpios = <&gpio0 ASPEED_GPIO(H, 0) GPIO_ACTIVE_LOW>;
+		};
+
+		/* BMC Card fault LED at the back */
+		led-bmc {
+			gpios = <&gpio0 ASPEED_GPIO(H, 1) GPIO_ACTIVE_LOW>;
+		};
+
+		/* Enclosure Identify LED at the back */
+		led-rear-enc-id0 {
+			gpios = <&gpio0 ASPEED_GPIO(H, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		/* Enclosure fault LED at the back */
+		led-rear-enc-fault0 {
+			gpios = <&gpio0 ASPEED_GPIO(H, 3) GPIO_ACTIVE_LOW>;
+		};
+
+		/* PCIE slot power LED */
+		led-pcieslot-power {
+			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &gpio0 {
@@ -214,7 +243,7 @@ &gpio0 {
 	/*F0-F7*/	"PIN_HOLE_RESET_IN_N","","",
 				"PIN_HOLE_RESET_OUT_N","","","","",
 	/*G0-G7*/	"","","","","","","","",
-	/*H0-H7*/	"","","","","","","","",
+	/*H0-H7*/	"led-rtc-battery","led-bmc","led-rear-enc-id0","led-rear-enc-fault0","","","","",
 	/*I0-I7*/	"","","","","","","","",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
@@ -222,7 +251,7 @@ &gpio0 {
 	/*M0-M7*/	"","","","","","","","",
 	/*N0-N7*/	"","","","","","","","",
 	/*O0-O7*/	"","","","","","","","",
-	/*P0-P7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","led-pcieslot-power","","","",
 	/*Q0-Q7*/	"","","","","","","","",
 	/*R0-R7*/	"","","","","","I2C_FLASH_MICRO_N","","",
 	/*S0-S7*/	"","","","","","","","",
-- 
2.27.0

