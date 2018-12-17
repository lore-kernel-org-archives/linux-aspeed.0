From: Vijay Khemka <vijaykhemka@fb.com>
Date: Mon, 17 Dec 2018 12:04:02 -0800
Subject: [PATCH v2 1/4] ARM: dts: aspeed: Add sensors devices for Facebook
Message-ID: <20181217200405.2904551-1-vijaykhemka@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Added ADC and other sensor devices in Facebook Tiogapass device tree.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 .../dts/aspeed-bmc-facebook-tiogapass.dts     | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index f8e7b71af7e6..64039dddd853 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -21,6 +21,17 @@
 	memory at 80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
+					<&adc 4>, <&adc 5>, <&adc 6>;
+	};
+
+	iio-hwmon-battery {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 7>;
+	};
 };
 
 &fmc {
@@ -64,6 +75,10 @@
 	use-ncsi;
 };
 
+&adc {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 	//Airmax Conn B, CPU0 PIROM, CPU1 PIROM
@@ -122,6 +137,10 @@
 
 &i2c8 {
 	status = "okay";
+	tmp421 at 1f {
+		compatible = "ti,tmp421";
+		reg = <0x1f>;
+	};
 	//Mezz Sensor SMBus
 };
 
@@ -140,7 +159,7 @@
 	};
 
 	fan at 1 {
-		reg = <0x00>;
-		aspeed,fan-tach-ch = /bits/ 8 <0x01>;
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
 	};
 };
-- 
2.17.1

