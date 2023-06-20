From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Tue, 20 Jun 2023 16:25:36 +0700
Subject: [PATCH v3 2/3] ARM: dts: aspeed: mtmitchell: Update ADC sensors for Mt.Mitchell DVT systems
In-Reply-To: <20230620092537.20007-1-chanh@os.amperecomputing.com>
References: <20230620092537.20007-1-chanh@os.amperecomputing.com>
Message-ID: <20230620092537.20007-3-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Change to use I2C ADC controller (ltc2497) for Mt.Mitchell DVT and
later hardware.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
Changes in v3:
  - None
Changes in v2:
  - None
---
 .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 107 +++++++++++-------
 1 file changed, 66 insertions(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
index e79f56208b89..d3c7e7c0fd25 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
@@ -65,174 +65,192 @@
 
 	adc0mux: adc0mux {
 		compatible = "io-channel-mux";
-		io-channels = <&adc0 0>;
+		io-channels = <&adc_i2c_0 0>;
 		#io-channel-cells = <1>;
 		io-channel-names = "parent";
 		mux-controls = <&gpioI5mux>;
+		settle-time-us = <10000>;
 		channels = "s0", "s1";
 	};
 
 	adc1mux: adc1mux {
 		compatible = "io-channel-mux";
-		io-channels = <&adc0 1>;
+		io-channels = <&adc_i2c_0 1>;
 		#io-channel-cells = <1>;
 		io-channel-names = "parent";
 		mux-controls = <&gpioI5mux>;
+		settle-time-us = <10000>;
 		channels = "s0", "s1";
 	};
 
 	adc2mux: adc2mux {
 		compatible = "io-channel-mux";
-		io-channels = <&adc0 2>;
+		io-channels = <&adc_i2c_0 2>;
 		#io-channel-cells = <1>;
 		io-channel-names = "parent";
 		mux-controls = <&gpioI5mux>;
+		settle-time-us = <10000>;
 		channels = "s0", "s1";
 	};
 
 	adc3mux: adc3mux {
 		compatible = "io-channel-mux";
-		io-channels = <&adc0 3>;
+		io-channels = <&adc_i2c_0 3>;
 		#io-channel-cells = <1>;
 		io-channel-names = "parent";
 		mux-controls = <&gpioI5mux>;
+		settle-time-us = <10000>;
 		channels = "s0", "s1";
 	};
 
 	adc4mux: adc4mux {
 		compatible = "io-channel-mux";
-		io-channels = <&adc0 4>;
+		io-channels = <&adc_i2c_0 4>;
 		#io-channel-cells = <1>;
 		io-channel-names = "parent";
 		mux-controls = <&gpioI5mux>;
+		settle-time-us = <10000>;
 		channels = "s0", "s1";
 	};
 
 	adc5mux: adc5mux {
 		compatible = "io-channel-mux";
-		io-channels = <&adc0 5>;
+		io-channels = <&adc_i2c_0 5>;
 		#io-channel-cells = <1>;
 		io-channel-names = "parent";
 		mux-controls = <&gpioI5mux>;
+		settle-time-us = <10000>;
 		channels = "s0", "s1";
 	};
 
 	adc6mux: adc6mux {
 		compatible = "io-channel-mux";
-		io-channels = <&adc0 6>;
+		io-channels = <&adc_i2c_0 6>;
 		#io-channel-cells = <1>;
 		io-channel-names = "parent";
 		mux-controls = <&gpioI5mux>;
+		settle-time-us = <10000>;
 		channels = "s0", "s1";
 	};
 
 	adc7mux: adc7mux {
 		compatible = "io-channel-mux";
-		io-channels = <&adc0 7>;
+		io-channels = <&adc_i2c_0 7>;
 		#io-channel-cells = <1>;
 		io-channel-names = "parent";
 		mux-controls = <&gpioI5mux>;
+		settle-time-us = <10000>;
 		channels = "s0", "s1";
 	};
 
 	adc8mux: adc8mux {
 		compatible = "io-channel-mux";
-		io-channels = <&adc1 0>;
+		io-channels = <&adc_i2c_0 8>;
 		#io-channel-cells = <1>;
 		io-channel-names = "parent";
 		mux-controls = <&gpioI5mux>;
+		settle-time-us = <10000>;
 		channels = "s0", "s1";
 	};
 
 	adc9mux: adc9mux {
 		compatible = "io-channel-mux";
-		io-channels = <&adc1 1>;
+		io-channels = <&adc_i2c_0 9>;
 		#io-channel-cells = <1>;
 		io-channel-names = "parent";
 		mux-controls = <&gpioI5mux>;
+		settle-time-us = <10000>;
 		channels = "s0", "s1";
 	};
 
 	adc10mux: adc10mux {
 		compatible = "io-channel-mux";
-		io-channels = <&adc1 2>;
+		io-channels = <&adc_i2c_0 10>;
 		#io-channel-cells = <1>;
 		io-channel-names = "parent";
 		mux-controls = <&gpioI5mux>;
+		settle-time-us = <10000>;
 		channels = "s0", "s1";
 	};
 
 	adc11mux: adc11mux {
 		compatible = "io-channel-mux";
-		io-channels = <&adc1 3>;
+		io-channels = <&adc_i2c_0 11>;
 		#io-channel-cells = <1>;
 		io-channel-names = "parent";
 		mux-controls = <&gpioI5mux>;
+		settle-time-us = <10000>;
 		channels = "s0", "s1";
 	};
 
 	adc12mux: adc12mux {
 		compatible = "io-channel-mux";
-		io-channels = <&adc1 4>;
+		io-channels = <&adc_i2c_0 12>;
 		#io-channel-cells = <1>;
 		io-channel-names = "parent";
 		mux-controls = <&gpioI5mux>;
+		settle-time-us = <10000>;
 		channels = "s0", "s1";
 	};
 
 	adc13mux: adc13mux {
 		compatible = "io-channel-mux";
-		io-channels = <&adc1 5>;
+		io-channels = <&adc_i2c_0 13>;
 		#io-channel-cells = <1>;
 		io-channel-names = "parent";
 		mux-controls = <&gpioI5mux>;
+		settle-time-us = <10000>;
 		channels = "s0", "s1";
 	};
 
 	adc14mux: adc14mux {
 		compatible = "io-channel-mux";
-		io-channels = <&adc1 6>;
+		io-channels = <&adc_i2c_0 14>;
 		#io-channel-cells = <1>;
 		io-channel-names = "parent";
 		mux-controls = <&gpioI5mux>;
+		settle-time-us = <10000>;
 		channels = "s0", "s1";
 	};
 
 	adc15mux: adc15mux {
 		compatible = "io-channel-mux";
-		io-channels = <&adc1 7>;
+		io-channels = <&adc_i2c_0 15>;
 		#io-channel-cells = <1>;
 		io-channel-names = "parent";
 		mux-controls = <&gpioI5mux>;
+		settle-time-us = <10000>;
 		channels = "s0", "s1";
 	};
 
 	iio-hwmon {
 		compatible = "iio-hwmon";
-		io-channels = <&adc0mux 0>, <&adc0mux 1>,
-			<&adc1mux 0>, <&adc1mux 1>,
-			<&adc2mux 0>, <&adc2mux 1>,
-			<&adc3mux 0>, <&adc3mux 1>,
-			<&adc4mux 0>, <&adc4mux 1>,
-			<&adc5mux 0>, <&adc5mux 1>,
-			<&adc6mux 0>, <&adc6mux 1>,
-			<&adc7mux 0>, <&adc7mux 1>,
-			<&adc8mux 0>, <&adc8mux 1>,
-			<&adc9mux 0>, <&adc9mux 1>,
-			<&adc10mux 0>, <&adc10mux 1>,
-			<&adc11mux 0>, <&adc11mux 1>,
-			<&adc12mux 0>, <&adc12mux 1>,
-			<&adc13mux 0>, <&adc13mux 1>,
-			<&adc14mux 0>, <&adc14mux 1>,
-			<&adc15mux 0>, <&adc15mux 1>,
-			<&adc_i2c 0>, <&adc_i2c 1>,
-			<&adc_i2c 2>, <&adc_i2c 3>,
-			<&adc_i2c 4>, <&adc_i2c 5>,
-			<&adc_i2c 6>, <&adc_i2c 7>,
-			<&adc_i2c 8>, <&adc_i2c 9>,
-			<&adc_i2c 10>, <&adc_i2c 11>,
-			<&adc_i2c 12>, <&adc_i2c 13>,
-			<&adc_i2c 14>, <&adc_i2c 15>;
+		io-channels =	<&adc0mux 0>, <&adc0mux 1>,
+				<&adc1mux 0>, <&adc1mux 1>,
+				<&adc2mux 0>, <&adc2mux 1>,
+				<&adc3mux 0>, <&adc3mux 1>,
+				<&adc4mux 0>, <&adc4mux 1>,
+				<&adc5mux 0>, <&adc5mux 1>,
+				<&adc6mux 0>, <&adc6mux 1>,
+				<&adc7mux 0>, <&adc7mux 1>,
+				<&adc8mux 0>, <&adc8mux 1>,
+				<&adc9mux 0>, <&adc9mux 1>,
+				<&adc10mux 0>, <&adc10mux 1>,
+				<&adc11mux 0>, <&adc11mux 1>,
+				<&adc12mux 0>, <&adc12mux 1>,
+				<&adc13mux 0>, <&adc13mux 1>,
+				<&adc14mux 0>, <&adc14mux 1>,
+				<&adc15mux 0>, <&adc15mux 1>,
+				<&adc_i2c_1 0>, <&adc_i2c_1 1>,
+				<&adc_i2c_1 2>, <&adc_i2c_1 3>,
+				<&adc_i2c_1 4>, <&adc_i2c_1 5>,
+				<&adc_i2c_1 6>, <&adc_i2c_1 7>,
+				<&adc_i2c_1 8>, <&adc_i2c_1 9>,
+				<&adc_i2c_1 10>, <&adc_i2c_1 11>,
+				<&adc_i2c_1 12>, <&adc_i2c_1 13>,
+				<&adc_i2c_1 14>, <&adc_i2c_1 15>,
+				<&adc0 0>, <&adc0 1>,
+				<&adc0 2>;
 	};
 };
 
@@ -353,7 +371,14 @@
 &i2c4 {
 	status = "okay";
 
-	adc_i2c: adc at 16 {
+	adc_i2c_0: adc at 14 {
+		compatible = "lltc,ltc2497";
+		reg = <0x14>;
+		vref-supply = <&voltage_mon_reg>;
+		#io-channel-cells = <1>;
+	 };
+
+	adc_i2c_1: adc at 16 {
 		compatible = "lltc,ltc2497";
 		reg = <0x16>;
 		vref-supply = <&voltage_mon_reg>;
-- 
2.17.1

