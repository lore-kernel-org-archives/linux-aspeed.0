From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Thu, 23 Jul 2020 16:05:38 -0700
Subject: [PATCH v2 2/3] ARM: dts: aspeed: wedge40: enable adc device
In-Reply-To: <20200723230539.17860-1-rentao.bupt@gmail.com>
References: <20200723230539.17860-1-rentao.bupt@gmail.com>
Message-ID: <20200723230539.17860-3-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Enable adc controller and corresponding voltage sensoring channels for
Wedge40.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
   - Nothing changed. Resending the patch just in case the previous
     email was not delivered.

 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
index aea23c313088..1049cfa80ac2 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -27,6 +27,11 @@
 	memory at 40000000 {
 		reg = <0x40000000 0x20000000>;
 	};
+
+	ast-adc-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>;
+	};
 };
 
 &wdt1 {
@@ -126,3 +131,7 @@
 &vhub {
 	status = "okay";
 };
+
+&adc {
+	status = "okay";
+};
-- 
2.17.1

