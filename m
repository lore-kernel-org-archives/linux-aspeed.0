From: Vijay Khemka <vijaykhemka@fb.com>
Date: Thu, 25 Jul 2019 10:45:11 -0700
Subject: [PATCH] ARM: dts: aspeed: tiogapass: Move battery sensor
Message-ID: <20190725174512.1380735-1-vijaykhemka@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Moved adc7 hwmon battery sensor to correct label to be read
by single applications for all adc sensors.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index d0c823e8fce5..682f729ea25e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -46,13 +46,9 @@
 	iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
-					<&adc 4>, <&adc 5>, <&adc 6>;
+			      <&adc 4>, <&adc 5>, <&adc 6>, <&adc 7>;
 	};
 
-	iio-hwmon-battery {
-		compatible = "iio-hwmon";
-		io-channels = <&adc 7>;
-	};
 };
 
 &fmc {
-- 
2.17.1

