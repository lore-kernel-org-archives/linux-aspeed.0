From: Vijay Khemka <vijaykhemka@fb.com>
Date: Mon, 27 Jan 2020 17:17:28 -0800
Subject: [PATCH] ARM: dts: aspeed: tiogapass: Add IPMB device
Message-ID: <20200128011728.4092945-1-vijaykhemka@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Adding IPMB devices for facebook tiogapass platform.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index fb7f034d5db2..719c130a198c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -5,6 +5,7 @@
 
 #include "aspeed-g5.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
 
 / {
 	model = "Facebook TiogaPass BMC";
@@ -428,6 +429,11 @@
 &i2c4 {
 	status = "okay";
 	// BMC Debug Header
+	ipmb0 at 10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
 };
 
 &i2c5 {
@@ -509,6 +515,11 @@
 &i2c9 {
 	status = "okay";
 	//USB Debug Connector
+	ipmb0 at 10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
 };
 
 &pwm_tacho {
-- 
2.17.1

