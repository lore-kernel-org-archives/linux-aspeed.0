From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 28 Feb 2022 07:02:39 +0700
Subject: [PATCH v1 2/5] ARM: dts: aspeed: mtjade: Update
 rtc-battery-voltage-read-enable pin
In-Reply-To: <20220228000242.1884-1-quan@os.amperecomputing.com>
References: <20220228000242.1884-1-quan@os.amperecomputing.com>
Message-ID: <20220228000242.1884-3-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update the output pin name that enables reading RTC battery voltage.

Link: https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md#rtc-battery-voltage-read-enable
Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
---
 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
index 934bb54b193a..c2b5b3dfeb85 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
@@ -876,7 +876,7 @@ &gpio {
 	/*Q0-Q7*/	"","","","","","UID_BUTTON","","",
 	/*R0-R7*/	"","","BMC_EXT_HIGHTEMP_L","OCP_AUX_PWREN",
 			"OCP_MAIN_PWREN","RESET_BUTTON","","",
-	/*S0-S7*/	"","","","","RTC_BAT_SEN_EN","","","",
+	/*S0-S7*/	"","","","","rtc-battery-voltage-read-enable","","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","","",
 	/*V0-V7*/	"","","","","","","","",
-- 
2.28.0

