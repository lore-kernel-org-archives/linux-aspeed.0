From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Thu,  3 Aug 2023 16:03:23 -0700
Subject: [PATCH 2/3] ARM: dts: aspeed: wedge400: Enable more ADC channels
In-Reply-To: <20230803230324.731268-1-rentao.bupt@gmail.com>
References: <20230803230324.731268-1-rentao.bupt@gmail.com>
Message-ID: <20230803230324.731268-3-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Enable ASPEED-ADC channels 5-8 to support voltage monitoring of all the
Wedge400 hardware revisions.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
index ed305948386f..5c55afed946f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
@@ -59,7 +59,8 @@ chosen {
 
 	ast-adc-hwmon {
 		compatible = "iio-hwmon";
-		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>;
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
+			      <&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>;
 	};
 
 	/*
-- 
2.40.1

