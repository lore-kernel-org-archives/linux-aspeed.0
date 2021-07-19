From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Sun, 18 Jul 2021 17:17:24 -0700
Subject: [PATCH 4/4] ARM: dts: aspeed: wedge100: Enable ADC channels
In-Reply-To: <20210719001724.6410-1-rentao.bupt@gmail.com>
References: <20210719001724.6410-1-rentao.bupt@gmail.com>
Message-ID: <20210719001724.6410-5-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Enable the ADC voltage sensoring channels used by Wedge100.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
index 39c6be91d53f..584efa528450 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
@@ -12,6 +12,11 @@
 		stdout-path = &uart3;
 		bootargs = "console=ttyS2,9600n8 root=/dev/ram rw";
 	};
+
+	ast-adc-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>;
+	};
 };
 
 &wdt2 {
-- 
2.17.1

