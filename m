From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 17 May 2021 11:00:34 +0700
Subject: [PATCH 1/3] ARM: dts: aspeed: mtjade: Enable OCP card support via
 NC-SI
In-Reply-To: <20210517040036.13667-1-quan@os.amperecomputing.com>
References: <20210517040036.13667-1-quan@os.amperecomputing.com>
Message-ID: <20210517040036.13667-2-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable OCP card support on Ampere's Mt. Jade BMC. The Mt. Jade BMC is an
ASPEED AST2500-based BMC for the Mt. Jade hardware reference platform
with Ampere's Altra Processor Family.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
Signed-off-by: Phong Vo <phong@os.amperecomputing.com>
Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
---
 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
index 8f5ec22e51c2..282e901092a6 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
@@ -332,6 +332,16 @@ &uart5 {
 	status = "okay";
 };
 
+&mac0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
+		 <&syscon ASPEED_CLK_MAC1RCLK>;
+	clock-names = "MACCLK", "RCLK";
+	use-ncsi;
+};
+
 &mac1 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -540,7 +550,8 @@ &gpio {
 	/*O0-O7*/	"","","","","","","","",
 	/*P0-P7*/	"","","","","","","","",
 	/*Q0-Q7*/	"","","","","","UID_BUTTON","","",
-	/*R0-R7*/	"","","BMC_EXT_HIGHTEMP_L","","","RESET_BUTTON","","",
+	/*R0-R7*/	"","","BMC_EXT_HIGHTEMP_L","OCP_AUX_PWREN",
+			"OCP_MAIN_PWREN","RESET_BUTTON","","",
 	/*S0-S7*/	"","","","","","","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","","",
-- 
2.28.0

