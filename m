From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 23 Jun 2022 09:24:28 +0200
Subject: [PATCH] ARM: dts: aspeed: centriq2400: drop the board
Message-ID: <20220623072428.33697-1-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The board is unmaintained and unused, according to Joel, so simply let's
remove it.

Link: https://lore.kernel.org/all/CACPK8XfxXi8kQr+vxta8rD6SBgxLf_oBjAH0UkPBacQta552YQ at mail.gmail.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/Makefile                    |   1 -
 .../dts/aspeed-bmc-arm-centriq2400-rep.dts    | 225 ------------------
 2 files changed, 226 deletions(-)
 delete mode 100644 arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 03f5b3a15415..6c36b7610c57 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1556,7 +1556,6 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2600-evb.dtb \
 	aspeed-bmc-amd-ethanolx.dtb \
 	aspeed-bmc-ampere-mtjade.dtb \
-	aspeed-bmc-arm-centriq2400-rep.dtb \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
 	aspeed-bmc-asrock-e3c246d4i.dtb \
 	aspeed-bmc-asrock-romed8hm3.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
deleted file mode 100644
index 3395de96ee11..000000000000
--- a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
+++ /dev/null
@@ -1,225 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/dts-v1/;
-
-#include "aspeed-g5.dtsi"
-#include <dt-bindings/gpio/aspeed-gpio.h>
-
-/ {
-	model = "Qualcomm Centriq 2400  REP AST2520";
-	compatible = "qualcomm,centriq2400-rep-bmc", "aspeed,ast2500";
-
-	chosen {
-		stdout-path = &uart5;
-		bootargs = "console=ttyS4,115200 earlycon";
-	};
-
-	memory at 80000000 {
-		reg = <0x80000000 0x40000000>;
-	};
-
-	iio-hwmon {
-		compatible = "iio-hwmon";
-		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
-                        <&adc 4>, <&adc 5>, <&adc 6>, <&adc 8>;
-	};
-
-	iio-hwmon-battery {
-		compatible = "iio-hwmon";
-		io-channels = <&adc 7>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		uid_led {
-			label = "UID_LED";
-			gpios = <&gpio ASPEED_GPIO(Q, 5) GPIO_ACTIVE_LOW>;
-		};
-
-		ras_error_led {
-			label = "RAS_ERROR_LED";
-			gpios = <&gpio ASPEED_GPIO(F, 6) GPIO_ACTIVE_LOW>;
-		};
-
-		system_fault {
-			label = "System_fault";
-			gpios = <&gpio ASPEED_GPIO(A, 1) GPIO_ACTIVE_LOW>;
-		};
-	};
-};
-
-&fmc {
-	status = "okay";
-	flash at 0 {
-		status = "okay";
-		m25p,fast-read;
-		label = "bmc";
-#include "openbmc-flash-layout.dtsi"
-	};
-};
-
-&spi1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spi1_default>;
-	flash at 0 {
-		status = "okay";
-	};
-};
-
-&spi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spi2ck_default
-			&pinctrl_spi2miso_default
-			&pinctrl_spi2mosi_default
-			&pinctrl_spi2cs0_default>;
-};
-
-&uart3 {
-	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd3_default &pinctrl_rxd3_default>;
-	current-speed = <115200>;
-};
-
-&uart5 {
-	status = "okay";
-};
-
-&mac0 {
-	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
-};
-
-&i2c0 {
-	status = "okay";
-};
-
-&i2c1 {
-	status = "okay";
-
-	tmp421 at 1e {
-		compatible = "ti,tmp421";
-		reg = <0x1e>;
-	};
-	tmp421 at 2a {
-		compatible = "ti,tmp421";
-		reg = <0x2a>;
-	};
-	tmp421 at 4e {
-		compatible = "ti,tmp421";
-		reg = <0x4e>;
-	};
-	tmp421 at 1c {
-		compatible = "ti,tmp421";
-		reg = <0x1c>;
-	};
-};
-
-&i2c2 {
-	status = "okay";
-};
-
-&i2c3 {
-	status = "okay";
-};
-
-&i2c4 {
-	status = "okay";
-};
-
-&i2c5 {
-	status = "okay";
-};
-
-&i2c6 {
-	status = "okay";
-
-	tmp421 at 1d {
-		compatible = "ti,tmp421";
-		reg = <0x1d>;
-	};
-	tmp421 at 1f {
-		compatible = "ti,tmp421";
-		reg = <0x1f>;
-	};
-	tmp421 at 4d {
-		compatible = "ti,tmp421";
-		reg = <0x4d>;
-	};
-	tmp421 at 4f {
-		compatible = "ti,tmp421";
-		reg = <0x4f>;
-	};
-	nvt210 at 4c {
-		compatible = "nvt210";
-		reg = <0x4c>;
-	};
-	eeprom at 50 {
-		compatible = "atmel,24c128";
-		reg = <0x50>;
-		pagesize = <128>;
-	};
-};
-
-&i2c7 {
-	status = "okay";
-};
-
-&i2c8 {
-	status = "okay";
-
-	pca9641 at 70 {
-		compatible = "nxp,pca9641";
-		reg = <0x70>;
-		i2c-arb {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			tmp421 at 1d {
-				compatible = "tmp421";
-				reg = <0x1d>;
-			};
-			adm1278 at 12 {
-				compatible = "adi,adm1278";
-				reg = <0x12>;
-				Rsense = <500>;
-			};
-			eeprom at 50 {
-				compatible = "atmel,24c02";
-				reg = <0x50>;
-			};
-			ds1100 at 58 {
-				compatible = "ds1100";
-				reg = <0x58>;
-			};
-		};
-	};
-};
-
-&i2c9 {
-	status = "okay";
-};
-
-&vuart {
-	status = "okay";
-};
-
-&gfx {
-	status = "okay";
-};
-
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
-&gpio {
-	pin_gpio_c7 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(C, 7) GPIO_ACTIVE_HIGH>;
-		output;
-		line-name = "BIOS_SPI_MUX_S";
-	};
-};
-- 
2.34.1

