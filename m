From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Wed, 26 Jun 2024 21:03:18 +0800
Subject: [PATCH v1 03/17] ARM: dts: aspeed: minerva: add eeprom on i2c bus
In-Reply-To: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
References: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
Message-ID: <20240626130332.929534-4-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Yang Chen <yang.chen@quantatw.com>

Add eeprom on the i2c-9 address 0x50 and i2c-15 address 0x56.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index ca3e417d2c7e..60002b8cffc6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -303,6 +303,11 @@ &i2c8 {
 
 &i2c9 {
 	status = "okay";
+
+	eeprom at 50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
 };
 
 &i2c10 {
@@ -339,6 +344,11 @@ eeprom at 50 {
 		compatible = "atmel,24c128";
 		reg = <0x50>;
 	};
+
+	eeprom at 56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+	};
 };
 
 &adc0 {
-- 
2.34.1

