From: Tao Ren <taoren@fb.com>
Date: Mon, 21 Oct 2019 12:48:17 -0700
Subject: [PATCH 1/4] ARM: dts: aspeed: add dtsi for Facebook AST2500 Network
 BMCs
In-Reply-To: <20191021194820.293556-1-taoren@fb.com>
References: <20191021194820.293556-1-taoren@fb.com>
Message-ID: <20191021194820.293556-2-taoren@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Introduce "facebook-netbmc-ast2500-common.dtsi" which is included by all
Facebook AST2500 Network BMC platforms. The major purpose is to minimize
duplicated device entries cross Facebook Network BMC dts files.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 .../dts/facebook-netbmc-ast2500-common.dtsi   | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 arch/arm/boot/dts/facebook-netbmc-ast2500-common.dtsi

diff --git a/arch/arm/boot/dts/facebook-netbmc-ast2500-common.dtsi b/arch/arm/boot/dts/facebook-netbmc-ast2500-common.dtsi
new file mode 100644
index 000000000000..7a395ba56512
--- /dev/null
+++ b/arch/arm/boot/dts/facebook-netbmc-ast2500-common.dtsi
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2019 Facebook Inc.
+
+#include "aspeed-g5.dtsi"
+
+/ {
+	memory at 80000000 {
+		reg = <0x80000000 0x40000000>;
+	};
+};
+
+/*
+ * Update reset type to "system" (full chip) to fix warm reboot hang issue
+ * when reset type is set to default ("soc", gated by reset mask registers).
+ */
+&wdt1 {
+	status = "okay";
+	aspeed,reset-type = "system";
+};
+
+&wdt2 {
+	status = "disabled";
+};
+
+&uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+		     &pinctrl_rxd1_default>;
+};
+
+&uart3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd3_default
+		     &pinctrl_rxd3_default>;
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+
+	fmc_flash0: flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "spi0.0";
+
+#include "facebook-bmc-flash-layout.dtsi"
+	};
+
+	fmc_flash1: flash at 1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "spi0.1";
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			flash1 at 0 {
+				reg = <0x0 0x2000000>;
+				label = "flash1";
+			};
+		};
+	};
+};
+
+&mac1 {
+	status = "okay";
+	no-hw-checksum;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&sdmmc {
+	status = "okay";
+};
+
+&sdhci1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sd2_default>;
+};
-- 
2.17.1

