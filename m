From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 28 Feb 2022 07:02:42 +0700
Subject: [PATCH v1 5/5] ARM: dts: aspeed: mtjade: Move all adc sensors into
 iio-hwmon node
In-Reply-To: <20220228000242.1884-1-quan@os.amperecomputing.com>
References: <20220228000242.1884-1-quan@os.amperecomputing.com>
Message-ID: <20220228000242.1884-6-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Move adc14 and adc15 (battery sensor) into single iio-hwmon node to
correct label to be read by single application for all adc sensors.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
---
 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
index 60b0e650957a..1b2e7ad37566 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
@@ -339,17 +339,8 @@ iio-hwmon {
 			<&adc10mux 0>, <&adc10mux 1>,
 			<&adc11mux 0>, <&adc11mux 1>,
 			<&adc12mux 0>, <&adc12mux 1>,
-			<&adc13mux 0>, <&adc13mux 1>;
-	};
-
-	iio-hwmon-adc14 {
-		compatible = "iio-hwmon";
-		io-channels = <&adc 14>;
-	};
-
-	iio-hwmon-battery {
-		compatible = "iio-hwmon";
-		io-channels = <&adc 15>;
+			<&adc13mux 0>, <&adc13mux 1>,
+			<&adc 14>, <&adc 15>;
 	};
 };
 
-- 
2.28.0

