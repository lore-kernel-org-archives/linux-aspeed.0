From: Konstantin Aladyshev <aladyshev22@gmail.com>
Date: Wed, 11 Jan 2023 14:32:08 +0300
Subject: [PATCH] ARM: dts: ethanolx: Correct EEPROM device name
Message-ID: <20230111113208.964-1-aladyshev22@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

BMC on the EthanolX board uses 24LC128 EEPROM chip for the
configuration settings. The correct compatible string for this
chip is "atmel,24c128".

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 889b2fdd19cf..8d84dcc06221 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -161,7 +161,7 @@ &i2c2 {
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

