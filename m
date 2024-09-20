From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 20 Sep 2024 17:55:52 +0800
Subject: [PATCH] ARM: dts: aspeed: catalina: add i2c-mux-idle-disconnect to
 all mux
Message-ID: <20240920-catalina-i2c-mux-fix-2-v1-1-66cce7c54188@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the `i2c-mux-idle-disconnect` property to all i2c-mux nodes to
ensure proper behavior when switching between multiple I2C buses.
This avoids potential confusion caused by device addresses appearing on
multiple buses when they are not actively selected.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Add the i2c-mux-idle-disconnect property to all i2c-mux nodes to
ensure proper behavior when switching between multiple I2C buses.
This avoids potential confusion caused by device addresses appearing on
multiple buses when they are not actively selected.
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 82835e96317d..fa0921a4afe2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -185,6 +185,7 @@ i2c-mux at 71 {
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
 
 		i2c0mux0ch0: i2c at 0 {
 			#address-cells = <1>;
@@ -213,6 +214,7 @@ i2c-mux at 72 {
 		reg = <0x72>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
 
 		i2c0mux1ch0: i2c at 0 {
 			#address-cells = <1>;
@@ -247,6 +249,7 @@ i2c-mux at 70 {
 				reg = <0x70>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
 
 				i2c30mux0ch0: i2c at 0 {
 					#address-cells = <1>;
@@ -328,6 +331,7 @@ i2c-mux at 73 {
 		reg = <0x73>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
 
 		i2c0mux2ch0: i2c at 0 {
 			#address-cells = <1>;
@@ -356,6 +360,7 @@ i2c-mux at 75 {
 		reg = <0x75>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
 
 		i2c0mux3ch0: i2c at 0 {
 			#address-cells = <1>;
@@ -384,6 +389,7 @@ i2c-mux at 76 {
 		reg = <0x76>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
 
 		i2c0mux4ch0: i2c at 0 {
 			#address-cells = <1>;
@@ -426,6 +432,7 @@ i2c-mux at 77 {
 		reg = <0x77>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
 
 		i2c0mux5ch0: i2c at 0 {
 			#address-cells = <1>;

---
base-commit: baeb9a7d8b60b021d907127509c44507539c15e5
change-id: 20240920-catalina-i2c-mux-fix-2-6dc48827a20a

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>

