From: Konstantin Aladyshev <aladyshev22@gmail.com>
Date: Sat, 11 Jun 2022 12:58:27 +0300
Subject: [PATCH 3/4] ARM: dts: aspeed: ethanolx: Use correct driver for the FRU EEPROM
In-Reply-To: <20220611095828.1090-1-aladyshev22@gmail.com>
References: <20220611095828.1090-1-aladyshev22@gmail.com>
Message-ID: <20220611095828.1090-4-aladyshev22@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AMD EthanolX CRB uses 24LC128 chip as FRU EEPROM. To bind correct
driver for this device "24c128" compatible string should be used in DTS.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 0354a7d8f9f5..428fa9f673f9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -163,7 +163,7 @@ &i2c2 {
 &i2c3 {
 	status = "okay";
 	eeprom at 50 {
-		compatible = "atmel,24c256";
+		compatible = "atmel,24c128";
 		reg = <0x50>;
 		pagesize = <64>;
 	};
-- 
2.25.1

