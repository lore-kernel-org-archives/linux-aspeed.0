From: Zev Weiss <zev@bewilderbeest.net>
Date: Fri, 16 Apr 2021 02:51:13 -0500
Subject: [PATCH] ARM: dts: aspeed: update e3c246d4i vuart properties
Message-ID: <20210416075113.18047-1-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This device-tree was merged with a provisional vuart IRQ-polarity
property that was still under review and ended up taking a somewhat
different form.  This patch updates it to match the final form of the
new vuart properties, which additionally allow specifying the SIRQ
number and LPC address.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---

The relevant aspeed-vuart patches [0] have been merged into Greg KH's
tty-next tree, so I figure it's probably okay to proceed with the
corresponding dts adjustments now.

[0] https://lore.kernel.org/openbmc/20210412034712.16778-1-zev at bewilderbeest.net/

 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
index dcab6e78dfa4..8be40c8283af 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
@@ -4,6 +4,7 @@
 #include "aspeed-g5.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
 #include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 /{
 	model = "ASRock E3C246D4I BMC";
@@ -73,7 +74,8 @@ &uart5 {
 
 &vuart {
 	status = "okay";
-	aspeed,sirq-active-high;
+	aspeed,lpc-io-reg = <0x2f8>;
+	aspeed,lpc-interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &mac0 {
-- 
2.31.1

