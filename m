From: Tao Ren <taoren@fb.com>
Date: Thu, 1 Aug 2019 17:54:27 -0700
Subject: [PATCH] ARM: dts: aspeed: Add Facebook Wedge40 BMC
Message-ID: <20190802005427.467841-1-taoren@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add initial version of device tree for Facebook Wedge40 AST2400 BMC
platform.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/aspeed-bmc-facebook-wedge40.dts  | 141 ++++++++++++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 39a05a10a2a2..dfc1011eb3f2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1273,6 +1273,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-cmm.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
+	aspeed-bmc-facebook-wedge40.dtb \
 	aspeed-bmc-facebook-yamp.dtb \
 	aspeed-bmc-intel-s2600wf.dtb \
 	aspeed-bmc-inspur-fp5280g2.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
new file mode 100644
index 000000000000..764633964ac1
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2018 Facebook Inc.
+/dts-v1/;
+
+#include "aspeed-g4.dtsi"
+
+/ {
+	model = "Facebook Wedge 40 BMC";
+	compatible = "facebook,wedge40-bmc", "aspeed,ast2400";
+
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
+	chosen {
+		stdout-path = &uart3;
+		bootargs = "debug console=ttyS2,9600n8 root=/dev/ram rw";
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
+&wdt2 {
+	status = "disabled";
+};
+
+&fmc {
+	status = "okay";
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "fmc0";
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
+		     &pinctrl_rxd4_default>;
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&mac1 {
+	status = "okay";
+	no-hw-checksum;
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
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
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
+&i2c13 {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
-- 
2.17.1

