From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 10 Sep 2020 12:26:31 +0930
Subject: [PATCH v2 3/3] pinctrl: aspeed-g6: Add bias controls for 1.8V GPIO
 banks
In-Reply-To: <20200910025631.2996342-1-andrew@aj.id.au>
References: <20200910025631.2996342-1-andrew@aj.id.au>
Message-ID: <20200910025631.2996342-4-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These were skipped in the original patches adding pinconf support for
the AST2600.

Cc: Johnny Huang <johnny_huang@aspeedtech.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index 7efe6dbe4398..34803a6c7664 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -19,6 +19,7 @@
 
 #define SCU400		0x400 /* Multi-function Pin Control #1  */
 #define SCU404		0x404 /* Multi-function Pin Control #2  */
+#define SCU40C		0x40C /* Multi-function Pin Control #3  */
 #define SCU410		0x410 /* Multi-function Pin Control #4  */
 #define SCU414		0x414 /* Multi-function Pin Control #5  */
 #define SCU418		0x418 /* Multi-function Pin Control #6  */
@@ -2591,6 +2592,22 @@ static struct aspeed_pin_config aspeed_g6_configs[] = {
 	/* MAC4 */
 	{ PIN_CONFIG_POWER_SOURCE,   { F24, B24 }, SCU458, BIT_MASK(5)},
 	{ PIN_CONFIG_DRIVE_STRENGTH, { F24, B24 }, SCU458, GENMASK(3, 2)},
+
+	/* GPIO18E */
+	ASPEED_SB_PINCONF(PIN_CONFIG_BIAS_PULL_DOWN, Y1, Y4, SCU40C, 4),
+	ASPEED_SB_PINCONF(PIN_CONFIG_BIAS_DISABLE,   Y1, Y4, SCU40C, 4),
+	/* GPIO18D */
+	ASPEED_SB_PINCONF(PIN_CONFIG_BIAS_PULL_DOWN, AB4, AC5, SCU40C, 3),
+	ASPEED_SB_PINCONF(PIN_CONFIG_BIAS_DISABLE,   AB4, AC5, SCU40C, 3),
+	/* GPIO18C */
+	ASPEED_SB_PINCONF(PIN_CONFIG_BIAS_PULL_DOWN, E4, E1, SCU40C, 2),
+	ASPEED_SB_PINCONF(PIN_CONFIG_BIAS_DISABLE,   E4, E1, SCU40C, 2),
+	/* GPIO18B */
+	ASPEED_SB_PINCONF(PIN_CONFIG_BIAS_PULL_DOWN, B2, D3, SCU40C, 1),
+	ASPEED_SB_PINCONF(PIN_CONFIG_BIAS_DISABLE,   B2, D3, SCU40C, 1),
+	/* GPIO18A */
+	ASPEED_SB_PINCONF(PIN_CONFIG_BIAS_PULL_DOWN, C6, A2, SCU40C, 0),
+	ASPEED_SB_PINCONF(PIN_CONFIG_BIAS_DISABLE,   C6, A2, SCU40C, 0),
 };
 
 /**
-- 
2.25.1

