From: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
Date: Tue, 6 Sep 2022 16:42:23 +0530
Subject: [PATCH v1] Update for Facebook yosemite V2 BMC.
Message-ID: <20220906111223.GA1779@hcl-ThinkPad-T495>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Removed NIC EEPROM driver IPMB-12 channel and keeping it as
"status ok".

Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
index 8864e9c312a8..2293f10e94d6 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -207,12 +207,6 @@
 
 &i2c12 {
 	status = "okay";
-	//MEZZ_FRU
-	eeprom at 51 {
-		compatible = "atmel,24c64";
-		reg = <0x51>;
-		pagesize = <32>;
-	};
 };
 
 &pwm_tacho {
-- 
2.17.1

