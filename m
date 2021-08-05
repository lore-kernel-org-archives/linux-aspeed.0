From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Thu,  5 Aug 2021 15:28:15 -0700
Subject: [PATCH v2 3/6] ARM: dts: aspeed: Common dtsi for Facebook AST2600
 Network BMCs
In-Reply-To: <20210805222818.8391-1-rentao.bupt@gmail.com>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
Message-ID: <20210805222818.8391-4-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

This common descirption is included by all Facebook AST2600 Network BMC
platforms to minimize duplicated device entries across Facebook Network
BMC device trees.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
  - "mac3" is removed from the dtsi (moved to platform dts files).

 .../dts/ast2600-facebook-netbmc-common.dtsi   | 169 ++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi

diff --git a/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
new file mode 100644
index 000000000000..051de5bec345
--- /dev/null
+++ b/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2020 Facebook Inc.
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	aliases {
+		mmc0 = &emmc;
+		spi1 = &spi1;
+		spi2 = &spi_gpio;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw vmalloc=640M";
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	/*
+	 * GPIO-based SPI Master is required to access SPI TPM, because
+	 * full-duplex SPI transactions are not supported by ASPEED SPI
+	 * Controllers.
+	 */
+	spi_gpio: spi-gpio {
+		status = "okay";
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+
+		tpmdev at 0 {
+			compatible = "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
+};
+
+&fmc {
+	status = "okay";
+
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "spi0.0";
+
+#include "facebook-bmc-flash-layout-128.dtsi"
+	};
+
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
+				reg = <0x0 0x8000000>;
+				label = "flash1";
+			};
+		};
+	};
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&wdt1 {
+	status = "okay";
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
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+
+	non-removable;
+	max-frequency = <25000000>;
+	bus-width = <4>;
+};
+
+&rtc {
+	status = "okay";
+};
-- 
2.17.1

