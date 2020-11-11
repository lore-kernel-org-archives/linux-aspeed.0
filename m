From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Wed, 11 Nov 2020 15:23:27 -0800
Subject: [PATCH 1/4] ARM: dts: aspeed: Common dtsi for Facebook AST2400
 Network BMCs
In-Reply-To: <20201111232330.30843-1-rentao.bupt@gmail.com>
References: <20201111232330.30843-1-rentao.bupt@gmail.com>
Message-ID: <20201111232330.30843-2-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

This common descirption is included by all Facebook AST2400 Network BMC
platforms to minimize duplicated device entries across Facebook Network
BMC device trees.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../dts/ast2400-facebook-netbmc-common.dtsi   | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi

diff --git a/arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi
new file mode 100644
index 000000000000..73a5503be78c
--- /dev/null
+++ b/arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2020 Facebook Inc.
+/dts-v1/;
+
+#include "aspeed-g4.dtsi"
+
+/ {
+	aliases {
+		/*
+		 * Override the default uart aliases to avoid breaking
+		 * the legacy applications.
+		 */
+		serial0 = &uart5;
+		serial1 = &uart1;
+		serial2 = &uart3;
+		serial3 = &uart4;
+	};
+
+	memory at 40000000 {
+		reg = <0x40000000 0x20000000>;
+	};
+};
+
+&wdt1 {
+	status = "okay";
+	aspeed,reset-type = "system";
+};
+
+&fmc {
+	status = "okay";
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "spi0.0";
+#include "facebook-bmc-flash-layout.dtsi"
+	};
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
+&uart4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd4_default
+		     &pinctrl_rxd4_default
+		     &pinctrl_ndts4_default>;
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&mac1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
-- 
2.17.1

