From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 28 Feb 2022 07:02:41 +0700
Subject: [PATCH v1 4/5] ARM: dts: aspeed: mtjade: Rename GPIO hog nodes to
 match schema.
In-Reply-To: <20220228000242.1884-1-quan@os.amperecomputing.com>
References: <20220228000242.1884-1-quan@os.amperecomputing.com>
Message-ID: <20220228000242.1884-5-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

GPIO hog nodes must have a "hog-" prefix or "-hog" suffix according to
the DT schema. Rename the node to pass dtbs_check.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
index a823571f8f4b..60b0e650957a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
@@ -891,7 +891,7 @@ &gpio {
 	/*AC0-AC7*/	"SYS_PWR_GD","","","","","BMC_READY","SLAVE_PRESENT_L",
 			"BMC_OCP_PG";
 
-	i2c4_o_en {
+	i2c4-o-en-hog {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(Y, 2) GPIO_ACTIVE_HIGH>;
 		output-high;
-- 
2.28.0

