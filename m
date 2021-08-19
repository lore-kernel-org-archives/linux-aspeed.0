From: George Liu <liuxiwei1013@gmail.com>
Date: Thu, 19 Aug 2021 13:52:27 +0800
Subject: [PATCH] ARM: dts: fp5280g2: Enable KCS 3 for MCTP binding
Message-ID: <20210819055227.140980-1-liuxiwei@inspur.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: George Liu <liuxiwei@inspur.com>
---
 arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
index 1752f3250e44..d0c3acbf6c8c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
@@ -3,6 +3,7 @@
 #include "aspeed-g5.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
 #include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "FP5280G2 BMC";
@@ -902,4 +903,10 @@ fan at 7 {
 
 };
 
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+	aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+};
+
 #include "ibm-power9-dual.dtsi"
-- 
2.30.2

