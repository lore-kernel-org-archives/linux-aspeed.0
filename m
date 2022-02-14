From: Potin Lai <potin.lai@quantatw.com>
Date: Mon, 14 Feb 2022 12:25:36 +0800
Subject: [PATCH v2 08/10] arch: arm: dts: bletchley: add INA230 sensor on each
 sled
In-Reply-To: <20220214042538.12132-1-potin.lai@quantatw.com>
References: <20220214042538.12132-1-potin.lai@quantatw.com>
Message-ID: <20220214042538.12132-9-potin.lai@quantatw.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

add INA230 node on each sled base on EVT HW

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 36 +++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 76c086ea7b71..8c8fbfcbb257 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -249,7 +249,11 @@
 
 &i2c0 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230 at 45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023 at 40 {
 		compatible = "mps,mp5023";
@@ -315,7 +319,11 @@
 
 &i2c1 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230 at 45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023 at 40 {
 		compatible = "mps,mp5023";
@@ -385,7 +393,11 @@
 
 &i2c2 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230 at 45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023 at 40 {
 		compatible = "mps,mp5023";
@@ -451,7 +463,11 @@
 
 &i2c3 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230 at 45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023 at 40 {
 		compatible = "mps,mp5023";
@@ -517,7 +533,11 @@
 
 &i2c4 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230 at 45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023 at 40 {
 		compatible = "mps,mp5023";
@@ -583,7 +603,11 @@
 
 &i2c5 {
 	status = "okay";
-	/* TODO: Add ADC INA230 */
+	ina230 at 45 {
+		compatible = "ti,ina230";
+		reg = <0x45>;
+		shunt-resistor = <2000>;
+	};
 
 	mp5023 at 40 {
 		compatible = "mps,mp5023";
-- 
2.17.1

