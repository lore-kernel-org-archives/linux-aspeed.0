From: Joe Wang <joe_wang@aspeedtech.com>
Date: Wed, 20 Sep 2023 18:33:32 +0800
Subject: [PATCH] pinctrl: pinctrl-aspeed-g6: Add more settings for USB2AHP function
Message-ID: <20230920103332.274151-1-joe_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

AST2600 USB2AHP (USB PortA: PCIe EHCI to PHY) function needs to set the
register SCUC20[16]. Set it to enable the PCIe EHCI device on PCIe bus.
Besides, also add USB2AHP signal expressions into pin declarations.

Signed-off-by: Joe Wang <joe_wang@aspeedtech.com>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index 80838dc54b3a..d376fa7114d1 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -1592,9 +1592,10 @@ SIG_EXPR_LIST_DECL_SEMG(A4, USB2ADPDP, USBA, USB2ADP, USB2ADP_DESC,
 			SIG_DESC_SET(SCUC20, 16));
 SIG_EXPR_LIST_DECL_SEMG(A4, USB2ADDP, USBA, USB2AD, USB2AD_DESC);
 SIG_EXPR_LIST_DECL_SEMG(A4, USB2AHDP, USBA, USB2AH, USB2AH_DESC);
-SIG_EXPR_LIST_DECL_SEMG(A4, USB2AHPDP, USBA, USB2AHP, USB2AHP_DESC);
+SIG_EXPR_LIST_DECL_SEMG(A4, USB2AHPDP, USBA, USB2AHP, USB2AHP_DESC,
+			SIG_DESC_SET(SCUC20, 16));
 PIN_DECL_(A4, SIG_EXPR_LIST_PTR(A4, USB2ADPDP), SIG_EXPR_LIST_PTR(A4, USB2ADDP),
-	  SIG_EXPR_LIST_PTR(A4, USB2AHDP));
+	  SIG_EXPR_LIST_PTR(A4, USB2AHDP), SIG_EXPR_LIST_PTR(A4, USB2AHPDP));
 
 #define B4 253
 SIG_EXPR_LIST_DECL_SEMG(B4, USB2ADPDN, USBA, USB2ADP, USB2ADP_DESC);
@@ -1602,7 +1603,7 @@ SIG_EXPR_LIST_DECL_SEMG(B4, USB2ADDN, USBA, USB2AD, USB2AD_DESC);
 SIG_EXPR_LIST_DECL_SEMG(B4, USB2AHDN, USBA, USB2AH, USB2AH_DESC);
 SIG_EXPR_LIST_DECL_SEMG(B4, USB2AHPDN, USBA, USB2AHP, USB2AHP_DESC);
 PIN_DECL_(B4, SIG_EXPR_LIST_PTR(B4, USB2ADPDN), SIG_EXPR_LIST_PTR(B4, USB2ADDN),
-	  SIG_EXPR_LIST_PTR(B4, USB2AHDN));
+	  SIG_EXPR_LIST_PTR(B4, USB2AHDN), SIG_EXPR_LIST_PTR(B4, USB2AHPDN));
 
 GROUP_DECL(USBA, A4, B4);
 
-- 
2.34.1

