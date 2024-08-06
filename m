From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Tue,  6 Aug 2024 07:18:05 +0000
Subject: [PATCH v2 4/5] ARM: dts: aspeed: mtmitchell: Enable i2c10 and i2c15
In-Reply-To: <20240806071806.1666550-1-chanh@os.amperecomputing.com>
References: <20240806071806.1666550-1-chanh@os.amperecomputing.com>
Message-ID: <20240806071806.1666550-5-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable the BMC I2C10.
Enable the BMC I2C15 and add the GPIO Expander as a child node.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
Changes in v2:
  - None
---
 .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
index 4d2f6e5348ce..3111f23e56dc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
@@ -890,6 +890,10 @@ nvme_m2_1: i2c at 1 {
 	};
 };
 
+&i2c10 {
+	status = "okay";
+};
+
 &i2c11 {
 	status = "okay";
 	ssif-bmc at 10 {
@@ -912,6 +916,25 @@ bmc_ast2600_cpu: temperature-sensor at 35 {
 	};
 };
 
+&i2c15 {
+	status = "okay";
+	gpio_expander1: gpio-expander at 22 {
+		compatible = "nxp,pca9535";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"fan-fault","psu-fault",
+			"","",
+			"","",
+			"","",
+			"","",
+			"","",
+			"","",
+			"","";
+	};
+};
+
 &adc0 {
 	status = "okay";
 
-- 
2.43.0

