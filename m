From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 13 Sep 2019 11:35:09 -0500
Subject: [PATCH 1/2] i2c: Aspeed: Add AST2600 compatible
In-Reply-To: <1568392510-866-1-git-send-email-eajames@linux.ibm.com>
References: <1568392510-866-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1568392510-866-2-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The driver default behavior works with the AST2600. We need a new
compatible though to make sure the driver doesn't enable AST2400 or
AST2500 behavior.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index fa66951..c2a6e5a 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -938,6 +938,10 @@ static int aspeed_i2c_reset(struct aspeed_i2c_bus *bus)
 		.compatible = "aspeed,ast2500-i2c-bus",
 		.data = aspeed_i2c_25xx_get_clk_reg_val,
 	},
+	{
+		.compatible = "aspeed,ast2600-i2c-bus",
+		.data = aspeed_i2c_25xx_get_clk_reg_val,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, aspeed_i2c_bus_of_table);
-- 
1.8.3.1

