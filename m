From: Joel Stanley <joel@jms.id.au>
Date: Thu, 23 Jun 2022 19:17:17 +0930
Subject: [PATCH] ARM: dts: aspeed: ast2600-evb: Update I2C devices
Message-ID: <20220623094717.3873328-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2600A3 EVB has the following I2C devices:

 - ADT7490 at 0x2e
 - EEPROM at 0xa0
 - LM75 at 0x9a

The bus these devices appear on can be configured by jumpers. The device
tree is configured with the buses given by the default jumper settings.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 5a6063bd4508..9da70b873ab6 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -207,11 +207,6 @@ &uart5 {
 
 &i2c0 {
 	status = "okay";
-
-	temp at 2e {
-		compatible = "adi,adt7490";
-		reg = <0x2e>;
-	};
 };
 
 &i2c1 {
@@ -240,10 +235,26 @@ &i2c6 {
 
 &i2c7 {
 	status = "okay";
+
+	temp at 2e {
+		compatible = "adi,adt7490";
+		reg = <0x2e>;
+	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c08";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
 };
 
 &i2c8 {
 	status = "okay";
+
+	lm75 at 4d {
+		compatible = "national,lm75";
+		reg = <0x4d>;
+	};
 };
 
 &i2c9 {
-- 
2.35.1

