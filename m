From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Thu, 23 Jul 2020 16:05:39 -0700
Subject: [PATCH v2 3/3] ARM: dts: aspeed: wedge40: enable pwm_tacho device
In-Reply-To: <20200723230539.17860-1-rentao.bupt@gmail.com>
References: <20200723230539.17860-1-rentao.bupt@gmail.com>
Message-ID: <20200723230539.17860-4-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Enable pwm_tacho device for fan control and monitoring in Wedge40.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
   - Nothing changed. Resending the patch just in case the previous
     email was not delivered.

 .../boot/dts/aspeed-bmc-facebook-wedge40.dts  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
index 1049cfa80ac2..8ac23ff6b09e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -135,3 +135,32 @@
 &adc {
 	status = "okay";
 };
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default
+		     &pinctrl_pwm1_default
+		     &pinctrl_pwm6_default
+		     &pinctrl_pwm7_default>;
+
+	fan at 0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00 0x01>;
+	};
+
+	fan at 1 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02 0x03>;
+	};
+
+	fan at 6 {
+		reg = <0x06>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04 0x05>;
+	};
+
+	fan at 7 {
+		reg = <0x07>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x06 0x07>;
+	};
+};
-- 
2.17.1

