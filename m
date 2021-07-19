From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Sun, 18 Jul 2021 17:17:22 -0700
Subject: [PATCH 2/4] ARM: dts: aspeed: wedge40: Remove redundant ADC device
In-Reply-To: <20210719001724.6410-1-rentao.bupt@gmail.com>
References: <20210719001724.6410-1-rentao.bupt@gmail.com>
Message-ID: <20210719001724.6410-3-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Remove ADC device from wedge40 device tree because the device is already
enabled in "ast2400-facebook-netbmc-common.dtsi".

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
index 2dcfeae3c92a..6624855d8ebd 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -23,10 +23,6 @@
 	status = "disabled";
 };
 
-&adc {
-	status = "okay";
-};
-
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.17.1

