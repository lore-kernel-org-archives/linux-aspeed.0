From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  8 Oct 2019 15:11:49 +1030
Subject: [PATCH 3/7] pinctrl: aspeed-g6: Fix I2C14 SDA description
In-Reply-To: <20191008044153.12734-1-andrew@aj.id.au>
References: <20191008044153.12734-1-andrew@aj.id.au>
Message-ID: <20191008044153.12734-4-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The I2C function the pin participated in was incorrectly named SDA14
which lead to a failure to mux:

[    6.884344] No function I2C14 found on pin 7 (7). Found signal(s) MACLINK4, SDA14, GPIOA7 for function(s) MACLINK4, SDA14, GPIOA7

Fixes: 58dc52ad00a0 ("pinctrl: aspeed: Add AST2600 pinmux support")
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index ff208b7c75a8..9079655cc818 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -87,7 +87,7 @@ FUNC_GROUP_DECL(MACLINK3, L23);
 
 #define K25 7
 SIG_EXPR_LIST_DECL_SESG(K25, MACLINK4, MACLINK4, SIG_DESC_SET(SCU410, 7));
-SIG_EXPR_LIST_DECL_SESG(K25, SDA14, SDA14, SIG_DESC_SET(SCU4B0, 7));
+SIG_EXPR_LIST_DECL_SESG(K25, SDA14, I2C14, SIG_DESC_SET(SCU4B0, 7));
 PIN_DECL_2(K25, GPIOA7, MACLINK4, SDA14);
 FUNC_GROUP_DECL(MACLINK4, K25);
 
-- 
2.20.1

