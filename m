From: Oskar Senft <osk@google.com>
Date: Tue, 30 Nov 2021 13:48:55 -0500
Subject: [PATCH] ARM: dts: aspeed: tyan-s7106: Add uart_routing and fix vuart
 config
Message-ID: <20211130184855.1779353-1-osk@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Configure the vuart in such a way that it does not inhibit the SuperIO's
UART from functioning correctly. This allows the same DTS to be used for
both configurations with SuperIO and VUART (depending on the BIOS
build). The decision on whether to actually enable VUART can then be
made at runtime.

This change also enables the new uart_routing driver for the SuperIO
case.

Signed-off-by: Oskar Senft <osk@google.com>
---
 arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
index 60ac6d3f03b5..aff27c1d4b06 100644
--- a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
@@ -3,6 +3,7 @@
 
 #include "aspeed-g5.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Tyan S7106 BMC";
@@ -127,8 +128,23 @@ &uart5 {
 	status = "okay";
 };
 
+&uart_routing {
+	status = "okay";
+};
+
 &vuart {
 	status = "okay";
+
+	/* We enable the VUART here, but leave it in a state that does
+	 * not interfere with the SuperIO. The goal is to have both the
+	 * VUART and the SuperIO available and decide at runtime whether
+	 * the VUART should actually be used. For that reason, configure
+	 * an "invalid" IO address and an IRQ that is not used by the
+	 * BMC.
+	 */
+
+	aspeed,lpc-io-reg = <0xffff>;
+	aspeed,lpc-interrupts = <15 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &lpc_ctrl {
-- 
2.34.0.rc2.393.gf8c9666880-goog

