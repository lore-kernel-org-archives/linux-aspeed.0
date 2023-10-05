From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Thu,  5 Oct 2023 10:55:20 +0700
Subject: [PATCH 2/7] ARM: dts: aspeed: mtjade, mtmitchell: Add new gpio-line-names
In-Reply-To: <20231005035525.19036-1-chanh@os.amperecomputing.com>
References: <20231005035525.19036-1-chanh@os.amperecomputing.com>
Message-ID: <20231005035525.19036-3-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add new gpio-line-names from the Mt.Jade and Mt.Mitchell
HW schematic.

Mt.Jade
  GPIOB5: presence-cpu0
  GPIOF0: ps0-pgood
  GPIOF1: ps1-pgood
  GPIOG2: host0-shd-ack-n
  GPIOH0: uart1-mode1
  GPIOH1: uart2-mode1
  GPIOH2: uart3-mode1
  GPIOH3: uart4-mode1
  GPIOH7: i2c6-reset-n
  GPIOH3: host0-reboot-ack-n
  GPIOM4: s0-i2c9-alert-n
  GPIOM5: s1-i2c9-alert-n
  GPIOQ6: led-identify
  GPIOS0: s0-vr-hot-n
  GPIOS1: s1-vr-hot-n
  GPIOS5: vr-pmbus-sel-n
  GPIOY3: bmc-vga-en-n
  GPIOZ3: s0-rtc-lock
  GPIOAC2: spi0-program-sel
  GPIOAC3: spi0-backup-sel

Mt.Mitchell:
  GPIOC3: bmc-debug-mode
  GPIOE1: eth-phy-int-n
  GPIOH0: jtag-program-sel
  GPIOH1: fpga-program-b
  GPIOW3: s1-pcp-pgood

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
 .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   | 42 +++++++++----------
 .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   |  9 ++--
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
index e57efcc8522a..c87be433bdd0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
@@ -762,42 +762,42 @@
 	gpio-line-names =
 	/*A0-A7*/	"","","","host0-special-boot","","","","",
 	/*B0-B7*/	"i2c-backup-sel","","","",
-			"power-button","","","",
+			"power-button","presence-cpu0","","",
 	/*C0-C7*/	"","","","","","","","",
 	/*D0-D7*/	"","","","","","","","",
 	/*E0-E7*/	"","","","","","","","",
-	/*F0-F7*/	"","","power-chassis-control","s0-ddr-save","power-chassis-good",
-			"s1-ddr-save","","",
-	/*G0-G7*/	"host0-ready","host0-shd-req-n","","s0-overtemp-n","","",
-			"","",
-	/*H0-H7*/	"","","","","ps0-vin-good","ps1-vin-good","","",
-	/*I0-I7*/	"presence-ps0","presence-ps1","s1-special-boot",
-				"","","","","",
-	/*J0-J7*/	"s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n","",
-			"","","","",
+	/*F0-F7*/	"ps0-pgood","ps1-pgood","power-chassis-control","s0-ddr-save",
+			"power-chassis-good", "s1-ddr-save","","",
+	/*G0-G7*/	"host0-ready","host0-shd-req-n","host0-shd-ack-n",
+			"s0-overtemp-n","","","","",
+	/*H0-H7*/	"uart1-mode1","uart2-mode1","uart3-mode1","uart4-mode1",
+			"ps0-vin-good","ps1-vin-good","","i2c6-reset-n",
+	/*I0-I7*/	"presence-ps0","presence-ps1","s1-special-boot","","","","","",
+	/*J0-J7*/	"s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n",
+			"host0-reboot-ack-n","","","","",
 	/*K0-K7*/	"","","","","","","","",
 	/*L0-L7*/	"","","","host0-sysreset-n","s0-spi-auth-fail-n","","","",
-	/*M0-M7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","s0-i2c9-alert-n","s1-i2c9-alert-n","","",
 	/*N0-N7*/	"","","","","","","","",
 	/*O0-O7*/	"","","","","","","","",
 	/*P0-P7*/	"","","","","","","","",
-	/*Q0-Q7*/	"","","","","","identify-button","","",
-	/*R0-R7*/	"","","ext-hightemp-n","",
-			"ocp-main-pwren","reset-button","","",
-	/*S0-S7*/	"","","","","rtc-battery-voltage-read-enable","","","",
+	/*Q0-Q7*/	"","","","","","identify-button","led-identify","",
+	/*R0-R7*/	"","","ext-hightemp-n","","ocp-main-pwren","reset-button","","",
+	/*S0-S7*/	"s0-vr-hot-n","s1-vr-hot-n","","",
+			"rtc-battery-voltage-read-enable","vr-pmbus-sel-n","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","","",
 	/*V0-V7*/	"","","","","","","","",
 	/*W0-W7*/	"","","","","","","","",
 	/*X0-X7*/	"","","","","","","","",
-	/*Y0-Y7*/	"","","","","","","","",
-	/*Z0-Z7*/	"s0-plimit","s1-fault-alert","s1-fw-boot-ok","","",
+	/*Y0-Y7*/	"","","","bmc-vga-en-n","","","","",
+	/*Z0-Z7*/	"s0-plimit","s1-fault-alert","s1-fw-boot-ok","s0-rtc-lock","",
 			"s1-sys-auth-failure-n","s1-overtemp-n","",
 	/*AA0-AA7*/	"","","","","","","","",
-	/*AB0-AB7*/	"s1-hightemp-n","s1-plimit","s0-ddr-addr",
-			"s1-ddr-addr","","","","",
-	/*AC0-AC7*/	"sys-pwr-gd","","","","","","presence-cpu1",
-			"ocp-pgood";
+	/*AB0-AB7*/	"s1-hightemp-n","s1-plimit","s0-ddr-addr","s1-ddr-addr","","",
+			"","",
+	/*AC0-AC7*/	"sys-pwr-gd","","spi0-program-sel","spi0-backup-sel","bmc-ok",
+			"","presence-cpu1","ocp-pgood";
 
 	i2c4-o-en-hog {
 		gpio-hog;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
index 2f571b43106d..b7c4f7cfad07 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
@@ -575,16 +575,17 @@
 	gpio-line-names =
 	/*A0-A7*/	"","","","","","i2c2-reset-n","i2c6-reset-n","i2c4-reset-n",
 	/*B0-B7*/	"","","","","host0-sysreset-n","host0-pmin-n","","",
-	/*C0-C7*/	"s0-vrd-fault-n","s1-vrd-fault-n","","",
+	/*C0-C7*/	"s0-vrd-fault-n","s1-vrd-fault-n","bmc-debug-mode","",
 			"irq-n","","vrd-sel","spd-sel",
 	/*D0-D7*/	"presence-ps0","presence-ps1","hsc-12vmain-alt2-n","ext-high-temp-n",
 			"","bmc-ncsi-txen","","",
-	/*E0-E7*/	"","","clk50m-bmc-ncsi","","","","","",
+	/*E0-E7*/	"","eth-phy-int-n","clk50m-bmc-ncsi","","","","","",
 	/*F0-F7*/	"s0-pcp-oc-warn-n","s1-pcp-oc-warn-n","power-chassis-control",
 			"cpu-bios-recover","s0-heartbeat","hs-csout-prochot",
 			"s0-vr-hot-n","s1-vr-hot-n",
 	/*G0-G7*/	"","","hsc-12vmain-alt1-n","","","","","",
-	/*H0-H7*/	"","","wd-disable-n","power-chassis-good","","","","",
+	/*H0-H7*/	"jtag-program-sel","fpga-program-b","wd-disable-n",
+			"power-chassis-good","","","","",
 	/*I0-I7*/	"","","","","","adc-sw","power-button","rtc-battery-voltage-read-enable",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
@@ -605,7 +606,7 @@
 	/*V0-V7*/	"s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n",
 			"host0-reboot-ack-n","s0-fw-boot-ok","host0-shd-req-n",
 			"host0-shd-ack-n","s0-overtemp-n",
-	/*W0-W7*/	"","ocp-main-pwren","ocp-pgood","",
+	/*W0-W7*/	"ocp-aux-pwren","ocp-main-pwren","ocp-pgood","s1-pcp-pgood",
 			"bmc-ok","bmc-ready","spi0-program-sel","spi0-backup-sel",
 	/*X0-X7*/	"i2c-backup-sel","s1-fault-alert","s1-fw-boot-ok",
 			"s1-hightemp-n","s0-spi-auth-fail-n","s1-sys-auth-failure-n",
-- 
2.17.1

