From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Mon, 7 Mar 2022 16:31:36 -0800
Subject: [PATCH] pinctrl: aspeed: Add FWQSPI pinmux
Message-ID: <20220308003136.3930466-1-quic_jaehyoo@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Johnny Huang <johnny_huang@aspeedtech.com>

AST2600 FW SPI quad mode only need to set AE12 and AF12, no need
to set Y1~Y4. FW SPI cs, clk, mosi and miso pins are dedicated.

Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index 54064714d73f..80838dc54b3a 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -1236,12 +1236,17 @@ FUNC_GROUP_DECL(SALT8, AA12);
 FUNC_GROUP_DECL(WDTRST4, AA12);
 
 #define AE12 196
+SIG_EXPR_LIST_DECL_SESG(AE12, FWSPIQ2, FWQSPI, SIG_DESC_SET(SCU438, 4));
 SIG_EXPR_LIST_DECL_SESG(AE12, GPIOY4, GPIOY4);
-PIN_DECL_(AE12, SIG_EXPR_LIST_PTR(AE12, GPIOY4));
+PIN_DECL_(AE12, SIG_EXPR_LIST_PTR(AE12, FWSPIQ2),
+	  SIG_EXPR_LIST_PTR(AE12, GPIOY4));
 
 #define AF12 197
+SIG_EXPR_LIST_DECL_SESG(AF12, FWSPIQ3, FWQSPI, SIG_DESC_SET(SCU438, 5));
 SIG_EXPR_LIST_DECL_SESG(AF12, GPIOY5, GPIOY5);
-PIN_DECL_(AF12, SIG_EXPR_LIST_PTR(AF12, GPIOY5));
+PIN_DECL_(AF12, SIG_EXPR_LIST_PTR(AF12, FWSPIQ3),
+	  SIG_EXPR_LIST_PTR(AF12, GPIOY5));
+FUNC_GROUP_DECL(FWQSPI, AE12, AF12);
 
 #define AC12 198
 SSSF_PIN_DECL(AC12, GPIOY6, FWSPIABR, SIG_DESC_SET(SCU438, 6));
@@ -1911,6 +1916,7 @@ static const struct aspeed_pin_group aspeed_g6_groups[] = {
 	ASPEED_PINCTRL_GROUP(FSI2),
 	ASPEED_PINCTRL_GROUP(FWSPIABR),
 	ASPEED_PINCTRL_GROUP(FWSPID),
+	ASPEED_PINCTRL_GROUP(FWQSPI),
 	ASPEED_PINCTRL_GROUP(FWSPIWP),
 	ASPEED_PINCTRL_GROUP(GPIT0),
 	ASPEED_PINCTRL_GROUP(GPIT1),
@@ -2152,6 +2158,7 @@ static const struct aspeed_pin_function aspeed_g6_functions[] = {
 	ASPEED_PINCTRL_FUNC(FSI2),
 	ASPEED_PINCTRL_FUNC(FWSPIABR),
 	ASPEED_PINCTRL_FUNC(FWSPID),
+	ASPEED_PINCTRL_FUNC(FWQSPI),
 	ASPEED_PINCTRL_FUNC(FWSPIWP),
 	ASPEED_PINCTRL_FUNC(GPIT0),
 	ASPEED_PINCTRL_FUNC(GPIT1),
-- 
2.25.1

