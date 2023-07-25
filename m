From: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Date: Tue, 25 Jul 2023 09:16:06 -0500
Subject: [PATCH 1/1] ARM: dts: aspeed: Rainier: Remove TPM device
In-Reply-To: <20230725141606.1641080-1-lakshmiy@us.ibm.com>
References: <20230725141606.1641080-1-lakshmiy@us.ibm.com>
Message-ID: <20230725141606.1641080-2-lakshmiy@us.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

TPM is disabled in Rainier, remove TPM device.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
index 7162e65b8115..8dd94cd478fc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
@@ -2092,11 +2092,6 @@ eeprom at 51 {
 &i2c12 {
 	status = "okay";
 
-	tpm at 2e {
-		compatible = "nuvoton,npct75x";
-		reg = <0x2e>;
-	};
-
 	eeprom at 50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
-- 
2.37.2

