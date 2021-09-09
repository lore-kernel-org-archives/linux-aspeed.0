From: Konstantin Aladyshev <aladyshev22@gmail.com>
Date: Thu,  9 Sep 2021 16:20:48 +0300
Subject: [PATCH] ARM: dts: aspeed: amd-ethanolx: Add FRU EEPROM
Message-ID: <20210909132053.3919-1-aladyshev22@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

AMD EthanolX CRB uses 24LC128 EEPROM chip to store its FRU information.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 79d17841b3d7..6406a0f080ee 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -159,6 +159,11 @@ &i2c2 {
 //24LC128 EEPROM
 &i2c3 {
 	status = "okay";
+	eeprom at 50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+		pagesize = <64>;
+	};
 };
 
 //P0 Power regulators
-- 
2.25.1

