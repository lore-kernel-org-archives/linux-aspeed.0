From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Wed, 11 Nov 2020 15:23:30 -0800
Subject: [PATCH 4/4] ARM: dts: aspeed: Add Facebook Galaxy100 (AST2400) BMC
In-Reply-To: <20201111232330.30843-1-rentao.bupt@gmail.com>
References: <20201111232330.30843-1-rentao.bupt@gmail.com>
Message-ID: <20201111232330.30843-5-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Add initial version of device tree for Facebook Galaxy100 (AST2400) BMC.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/Makefile                    |  1 +
 .../dts/aspeed-bmc-facebook-galaxy100.dts     | 57 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 21477ef5c5c9..1917cd47204a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1383,6 +1383,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
 	aspeed-bmc-bytedance-g220a.dtb \
 	aspeed-bmc-facebook-cmm.dtb \
+	aspeed-bmc-facebook-galaxy100.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
 	aspeed-bmc-facebook-wedge40.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts
new file mode 100644
index 000000000000..dcf213472749
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2020 Facebook Inc.
+/dts-v1/;
+
+#include "ast2400-facebook-netbmc-common.dtsi"
+
+/ {
+	model = "Facebook Galaxy 100 BMC";
+	compatible = "facebook,galaxy100-bmc", "aspeed,ast2400";
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw";
+	};
+
+	ast-adc-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 3>, <&adc 4>, <&adc 8>, <&adc 9>;
+	};
+};
+
+&wdt2 {
+	status = "okay";
+	aspeed,reset-type = "system";
+};
+
+&fmc {
+	flash at 1 {
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
+
+&i2c9 {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&adc {
+	status = "okay";
+};
-- 
2.17.1

