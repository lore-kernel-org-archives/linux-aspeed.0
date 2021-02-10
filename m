From: Joel Stanley <joel@jms.id.au>
Date: Wed, 10 Feb 2021 22:16:51 +1030
Subject: [PATCH] soc: aspeed: socinfo: Add new systems
Message-ID: <20210210114651.334324-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Aspeed's u-boot sdk has been updated with the SoC IDs for the AST2605
variant, as well as A2 and A3 variants of the 2600 family.

From u-boot's arch/arm/mach-aspeed/ast2600/scu_info.c:

    SOC_ID("AST2600-A0", 0x0500030305000303),
    SOC_ID("AST2600-A1", 0x0501030305010303),
    SOC_ID("AST2620-A1", 0x0501020305010203),
    SOC_ID("AST2600-A2", 0x0502030305010303),
    SOC_ID("AST2620-A2", 0x0502020305010203),
    SOC_ID("AST2605-A2", 0x0502010305010103),
    SOC_ID("AST2600-A3", 0x0503030305030303),
    SOC_ID("AST2620-A3", 0x0503020305030203),
    SOC_ID("AST2605-A3", 0x0503010305030103),

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/soc/aspeed/aspeed-socinfo.c | 33 ++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index 773930e0cb10..e3215f826d17 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -25,6 +25,7 @@ static struct {
 	/* AST2600 */
 	{ "AST2600", 0x05000303 },
 	{ "AST2620", 0x05010203 },
+	{ "AST2605", 0x05030103 },
 };
 
 static const char *siliconid_to_name(u32 siliconid)
@@ -43,14 +44,30 @@ static const char *siliconid_to_name(u32 siliconid)
 static const char *siliconid_to_rev(u32 siliconid)
 {
 	unsigned int rev = (siliconid >> 16) & 0xff;
-
-	switch (rev) {
-	case 0:
-		return "A0";
-	case 1:
-		return "A1";
-	case 3:
-		return "A2";
+	unsigned int gen = (siliconid >> 24) & 0xff;
+
+	if (gen < 0x5) {
+		/* AST2500 and below */
+		switch (rev) {
+		case 0:
+			return "A0";
+		case 1:
+			return "A1";
+		case 3:
+			return "A2";
+		}
+	} else {
+		/* AST2600 */
+		switch (rev) {
+		case 0:
+			return "A0";
+		case 1:
+			return "A1";
+		case 2:
+			return "A2";
+		case 3:
+			return "A3";
+		}
 	}
 
 	return "??";
-- 
2.30.0

