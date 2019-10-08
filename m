From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  8 Oct 2019 15:11:50 +1030
Subject: [PATCH 4/7] pinctrl: aspeed-g6: Fix I3C3/I3C4 pinmux configuration
In-Reply-To: <20191008044153.12734-1-andrew@aj.id.au>
References: <20191008044153.12734-1-andrew@aj.id.au>
Message-ID: <20191008044153.12734-5-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Johnny Huang <johnny_huang@aspeedtech.com>

The documentation to configure I3C3/FSI1 and I3C4/FSI2 was initially
unclear.

Fixes: 58dc52ad00a0 ("pinctrl: aspeed: Add AST2600 pinmux support")
Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
[AJ: Tweak commit message, resolve rebase conflicts]
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 24 ++++++++--------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index 9079655cc818..68b066594461 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -1513,18 +1513,14 @@ FUNC_GROUP_DECL(VB, Y1, Y2, Y3, Y4);
  * following 4 pins
  */
 #define AF25 244
-SIG_EXPR_LIST_DECL_SEMG(AF25, I3C3SCL, I3C3, I3C3, SIG_DESC_SET(SCU438, 20),
-			SIG_DESC_SET(SCU4D8, 20));
-SIG_EXPR_LIST_DECL_SESG(AF25, FSI1CLK, FSI1, SIG_DESC_CLEAR(SCU438, 20),
-			SIG_DESC_SET(SCU4D8, 20));
+SIG_EXPR_LIST_DECL_SEMG(AF25, I3C3SCL, I3C3, I3C3, SIG_DESC_SET(SCU438, 20));
+SIG_EXPR_LIST_DECL_SESG(AF25, FSI1CLK, FSI1, SIG_DESC_SET(SCU4D8, 20));
 PIN_DECL_(AF25, SIG_EXPR_LIST_PTR(AF25, I3C3SCL),
 	  SIG_EXPR_LIST_PTR(AF25, FSI1CLK));
 
 #define AE26 245
-SIG_EXPR_LIST_DECL_SEMG(AE26, I3C3SDA, I3C3, I3C3, SIG_DESC_SET(SCU438, 21),
-			SIG_DESC_SET(SCU4D8, 21));
-SIG_EXPR_LIST_DECL_SESG(AE26, FSI1DATA, FSI1, SIG_DESC_CLEAR(SCU438, 21),
-			SIG_DESC_SET(SCU4D8, 21));
+SIG_EXPR_LIST_DECL_SEMG(AE26, I3C3SDA, I3C3, I3C3, SIG_DESC_SET(SCU438, 21));
+SIG_EXPR_LIST_DECL_SESG(AE26, FSI1DATA, FSI1, SIG_DESC_SET(SCU4D8, 21));
 PIN_DECL_(AE26, SIG_EXPR_LIST_PTR(AE26, I3C3SDA),
 	  SIG_EXPR_LIST_PTR(AE26, FSI1DATA));
 
@@ -1533,18 +1529,14 @@ FUNC_DECL_2(I3C3, HVI3C3, I3C3);
 FUNC_GROUP_DECL(FSI1, AF25, AE26);
 
 #define AE25 246
-SIG_EXPR_LIST_DECL_SEMG(AE25, I3C4SCL, I3C4, I3C4, SIG_DESC_SET(SCU438, 22),
-			SIG_DESC_SET(SCU4D8, 22));
-SIG_EXPR_LIST_DECL_SESG(AE25, FSI2CLK, FSI2, SIG_DESC_CLEAR(SCU438, 22),
-			SIG_DESC_SET(SCU4D8, 22));
+SIG_EXPR_LIST_DECL_SEMG(AE25, I3C4SCL, I3C4, I3C4, SIG_DESC_SET(SCU438, 22));
+SIG_EXPR_LIST_DECL_SESG(AE25, FSI2CLK, FSI2, SIG_DESC_SET(SCU4D8, 22));
 PIN_DECL_(AE25, SIG_EXPR_LIST_PTR(AE25, I3C4SCL),
 	  SIG_EXPR_LIST_PTR(AE25, FSI2CLK));
 
 #define AF24 247
-SIG_EXPR_LIST_DECL_SEMG(AF24, I3C4SDA, I3C4, I3C4, SIG_DESC_SET(SCU438, 23),
-			SIG_DESC_SET(SCU4D8, 23));
-SIG_EXPR_LIST_DECL_SESG(AF24, FSI2DATA, FSI2, SIG_DESC_CLEAR(SCU438, 23),
-			SIG_DESC_SET(SCU4D8, 23));
+SIG_EXPR_LIST_DECL_SEMG(AF24, I3C4SDA, I3C4, I3C4, SIG_DESC_SET(SCU438, 23));
+SIG_EXPR_LIST_DECL_SESG(AF24, FSI2DATA, FSI2, SIG_DESC_SET(SCU4D8, 23));
 PIN_DECL_(AF24, SIG_EXPR_LIST_PTR(AF24, I3C4SDA),
 	  SIG_EXPR_LIST_PTR(AF24, FSI2DATA));
 
-- 
2.20.1

