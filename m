From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 17 Sep 2024 11:21:00 -0500
Subject: [PATCH] ARM: dts: aspeed: Fix Rainier and Blueridge GPIO LED names
Message-ID: <20240917162100.1386130-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Blueridge LED names to include the "led-" prefix as is proper.
Rainier should match for ease of application design. In addition,
the gpio line name ought to match.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts |  5 +++--
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts  | 12 ++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
index dfe5cc3edb52..9e6bfaef3840 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
@@ -207,7 +207,8 @@ &gpio0 {
 	/*F0-F7*/	"","","rtc-battery-voltage-read-enable","reset-cause-pinhole","","",
 			"factory-reset-toggle","",
 	/*G0-G7*/	"","","","","","","","",
-	/*H0-H7*/	"","bmc-ingraham0","rear-enc-id0","rear-enc-fault0","","","","",
+	/*H0-H7*/	"","led-bmc-ingraham0","led-rear-enc-id0","led-rear-enc-fault0","","","",
+			"",
 	/*I0-I7*/	"","","","","","","bmc-secure-boot","",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
@@ -215,7 +216,7 @@ &gpio0 {
 	/*M0-M7*/	"","","","","","","","",
 	/*N0-N7*/	"","","","","","","","",
 	/*O0-O7*/	"","","","usb-power","","","","",
-	/*P0-P7*/	"","","","","pcieslot-power","","","",
+	/*P0-P7*/	"","","","","led-pcieslot-power","","","",
 	/*Q0-Q7*/	"cfam-reset","","regulator-standby-faulted","","","","","",
 	/*R0-R7*/	"bmc-tpm-reset","power-chassis-control","power-chassis-good","","","","",
 			"",
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
index 0776b72c2199..a4aec3010456 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
@@ -109,22 +109,22 @@ leds {
 		compatible = "gpio-leds";
 
 		/* BMC Card fault LED at the back */
-		bmc-ingraham0 {
+		led-bmc-ingraham0 {
 			gpios = <&gpio0 ASPEED_GPIO(H, 1) GPIO_ACTIVE_LOW>;
 		};
 
 		/* Enclosure ID LED at the back */
-		rear-enc-id0 {
+		led-rear-enc-id0 {
 			gpios = <&gpio0 ASPEED_GPIO(H, 2) GPIO_ACTIVE_LOW>;
 		};
 
 		/* Enclosure fault LED at the back */
-		rear-enc-fault0 {
+		led-rear-enc-fault0 {
 			gpios = <&gpio0 ASPEED_GPIO(H, 3) GPIO_ACTIVE_LOW>;
 		};
 
 		/* PCIE slot power LED */
-		pcieslot-power {
+		led-pcieslot-power {
 			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_LOW>;
 		};
 	};
@@ -203,7 +203,7 @@ &gpio0 {
 	/*E0-E7*/	"","","","","","","","",
 	/*F0-F7*/	"","","rtc-battery-voltage-read-enable","reset-cause-pinhole","","","factory-reset-toggle","",
 	/*G0-G7*/	"","","","","","","","",
-	/*H0-H7*/	"","bmc-ingraham0","rear-enc-id0","rear-enc-fault0","","","","",
+	/*H0-H7*/	"","led-bmc-ingraham0","led-rear-enc-id0","led-rear-enc-fault0","","","","",
 	/*I0-I7*/	"","","","","","","bmc-secure-boot","",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
@@ -211,7 +211,7 @@ &gpio0 {
 	/*M0-M7*/	"","","","","","","","",
 	/*N0-N7*/	"","","","","","","","",
 	/*O0-O7*/	"","","","usb-power","","","","",
-	/*P0-P7*/	"","","","","pcieslot-power","","","",
+	/*P0-P7*/	"","","","","led-pcieslot-power","","","",
 	/*Q0-Q7*/	"cfam-reset","","regulator-standby-faulted","","","","","",
 	/*R0-R7*/	"bmc-tpm-reset","power-chassis-control","power-chassis-good","","","","","",
 	/*S0-S7*/	"presence-ps0","presence-ps1","presence-ps2","presence-ps3",
-- 
2.43.0

