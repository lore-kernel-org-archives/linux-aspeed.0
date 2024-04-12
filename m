From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Fri, 12 Apr 2024 17:15:58 +0800
Subject: [PATCH v5 10/12] ARM: dts: aspeed: Harma: Revise node name
In-Reply-To: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
References: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
Message-ID: <20240412091600.2534693-11-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Revise max31790 and delta_brick node name.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 7dd48c384a4d..530f69005857 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -192,7 +192,7 @@ &kcs3 {
 &i2c0 {
 	status = "okay";
 
-	max31790 at 5e{
+	pwm at 5e{
 		compatible = "max31790";
 		reg = <0x5e>;
 		#address-cells = <1>;
@@ -218,7 +218,7 @@ eeprom at 50 {
 &i2c2 {
 	status = "okay";
 
-	max31790 at 5e{
+	pwm at 5e{
 		compatible = "max31790";
 		reg = <0x5e>;
 		#address-cells = <1>;
@@ -262,7 +262,7 @@ eeprom at 52 {
 		reg = <0x52>;
 	};
 
-	delta_brick at 69 {
+	power-monitor at 69 {
 		compatible = "pmbus";
 		reg = <0x69>;
 	};
-- 
2.25.1

