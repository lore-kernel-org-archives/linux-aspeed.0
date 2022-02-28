From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 28 Feb 2022 07:02:40 +0700
Subject: [PATCH v1 3/5] ARM: dts: aspeed: mtjade: Update host0-ready pin
In-Reply-To: <20220228000242.1884-1-quan@os.amperecomputing.com>
References: <20220228000242.1884-1-quan@os.amperecomputing.com>
Message-ID: <20220228000242.1884-4-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update the input GPIO that indicates Host ready.

Link: https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md#host-ready
Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
---
 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
index c2b5b3dfeb85..a823571f8f4b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
@@ -860,7 +860,7 @@ &gpio {
 	/*E0-E7*/	"","","","","","","","",
 	/*F0-F7*/	"","","BMC_SYS_PSON_L","S0_DDR_SAVE","PGOOD",
 			"S1_DDR_SAVE","","",
-	/*G0-G7*/	"S0_FW_BOOT_OK","SHD_REQ_L","","S0_OVERTEMP_L","","",
+	/*G0-G7*/	"host0-ready","SHD_REQ_L","","S0_OVERTEMP_L","","",
 			"","",
 	/*H0-H7*/	"","","","","PSU1_VIN_GOOD","PSU2_VIN_GOOD","","",
 	/*I0-I7*/	"PSU1_PRESENT","PSU2_PRESENT","S1_BMC_SPECIAL_BOOT",
-- 
2.28.0

