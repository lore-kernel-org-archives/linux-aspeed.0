From: John Wang <wangzqbj@inspur.com>
Date: Thu, 17 Jan 2019 06:56:40 -0000
Subject: [PATCH] ARM:dts:aspeed Add Inspur on5263m5 BMC
Message-ID: <1547708191-8721-1-git-send-email-wangzqbj@inspur.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add initial version of device tree file for on5263m5 ast2500bmc

Signed-off-by: John Wang <wangzqbj@inspur.com>
---
 arch/arm/boot/dts/aspeed-bmc-inspur-on5263m5.dts | 146 +++++++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-inspur-on5263m5.dts

diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-on5263m5.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-on5263m5.dts
new file mode 100644
index 0000000..064ae30
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-inspur-on5263m5.dts
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Inspur Corporation
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "ON5263M5 BMC";
+	compatible = "inspur,on5263m5-bmc", "aspeed,ast2500";
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "earlyprintk";
+	};
+
+	memory {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		vga_memory: framebuffer at 9f000000 {
+			no-map;
+			reg = <0x9f000000 0x01000000>;
+		};
+	};
+	
+	leds {
+	    compatible = "gpio-leds";
+	    
+	    bmc_alive {
+	        label = "bmc_alive";
+		gpios = <&gpio ASPEED_GPIO(I, 1) GPIO_ACTIVE_LOW>;
+		linux,default-trigger = "timer";
+	    };
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
+			<&adc 4>, <&adc 5>, <&adc 6>, <&adc 7>;
+	};
+
+};
+
+&fmc {
+	status = "okay";
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+	};
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	use-ncsi;
+};
+
+&mac1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
+};
+
+&i2c6 {
+	status = "okay";
+
+	tmp421 at 4e {
+	        compatible = "ti,tmp421";
+		reg = <0x4e>;
+	};
+
+	tmp112 at 48 {
+		compatible = "ti,tmp112";
+		reg = <0x48>;
+	};
+	
+	eeprom at 54 {
+		compatible = "atmel,24c64";
+    		reg = <0x54>; 
+		pagesize = <32>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+
+	adm1278 at 11 {
+		  compatible = "adi,adm1278";
+		  reg = <0x11>;
+	};
+};
+
+&gfx {
+	status = "okay";
+};
+
+&pinctrl {
+	aspeed,external-nodes = <&gfx &lhc>;
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
+
+	fan at 0 {
+   		reg = <0x00>;
+   		aspeed,fan-tach-ch = /bits/ 8 <0x00 0x01>;  
+ 	};
+
+ 	fan at 1 {
+   		reg = <0x01>;
+   		aspeed,fan-tach-ch = /bits/ 8 <0x02 0x03>;
+ 	};
+};
+
+&adc {
+	status = "okay";
+};
-- 
2.7.4

