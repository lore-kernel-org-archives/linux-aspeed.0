From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 17 May 2021 11:00:35 +0700
Subject: [PATCH 2/3] ARM: dts: aspeed: mtjade: Add PSU support
In-Reply-To: <20210517040036.13667-1-quan@os.amperecomputing.com>
References: <20210517040036.13667-1-quan@os.amperecomputing.com>
Message-ID: <20210517040036.13667-3-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable PSU support on Ampere's Mt. Jade BMC. The Mt. Jade BMC is an
ASPEED AST2500-based BMC for the Mt. Jade hardware reference platform
with Ampere's Altra Processor Family.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
Signed-off-by: Phong Vo <phong@os.amperecomputing.com>
Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
---
 .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 42 ++++++++++++++++++-
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
index 282e901092a6..364293e6ca76 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
@@ -110,6 +110,30 @@ id_button {
 			linux,code = <ASPEED_GPIO(Q, 5)>;
 		};
 
+		psu1_vin_good {
+			label = "PSU1_VIN_GOOD";
+			gpios = <&gpio ASPEED_GPIO(H, 4) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(H, 4)>;
+		};
+
+		psu2_vin_good {
+			label = "PSU2_VIN_GOOD";
+			gpios = <&gpio ASPEED_GPIO(H, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(H, 5)>;
+		};
+
+		psu1_present {
+			label = "PSU1_PRESENT";
+			gpios = <&gpio ASPEED_GPIO(I, 0) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(I, 0)>;
+		};
+
+		psu2_present {
+			label = "PSU2_PRESENT";
+			gpios = <&gpio ASPEED_GPIO(I, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(I, 1)>;
+		};
+
 	};
 
 	gpioA0mux: mux-controller {
@@ -436,6 +460,19 @@ &i2c9 {
 	status = "okay";
 };
 
+&i2c10 {
+	status = "okay";
+	adm1278 at 10 {
+		compatible = "adi,adm1278";
+		reg = <0x10>;
+	};
+
+	adm1278 at 11 {
+		compatible = "adi,adm1278";
+		reg = <0x11>;
+	};
+};
+
 &gfx {
 	status = "okay";
 	memory-region = <&gfx_memory>;
@@ -539,8 +576,9 @@ &gpio {
 			"S1_DDR_SAVE","","",
 	/*G0-G7*/	"S0_FW_BOOT_OK","SHD_REQ_L","","S0_OVERTEMP_L","","",
 			"","",
-	/*H0-H7*/	"","","","","","","","",
-	/*I0-I7*/	"","","S1_BMC_SPECIAL_BOOT","","","","","",
+	/*H0-H7*/	"","","","","PSU1_VIN_GOOD","PSU2_VIN_GOOD","","",
+	/*I0-I7*/	"PSU1_PRESENT","PSU2_PRESENT","S1_BMC_SPECIAL_BOOT",
+			"","","","","",
 	/*J0-J7*/	"S0_HIGHTEMP_L","S0_FAULT_L","S0_SCP_AUTH_FAIL_L","",
 			"","","","",
 	/*K0-K7*/	"","","","","","","","",
-- 
2.28.0

