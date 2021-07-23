From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 23 Jul 2021 17:28:55 +0930
Subject: [RFC PATCH 3/6] leds: pca955x: Relocate chipdef-related descriptors
In-Reply-To: <20210723075858.376378-1-andrew@aj.id.au>
References: <20210723075858.376378-1-andrew@aj.id.au>
Message-ID: <20210723075858.376378-4-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Reduce code-motion noise when implementing pinctrl.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/leds/leds-pca955x.c | 76 ++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index 7087ca4592fc..6614291b288e 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -75,44 +75,6 @@ struct pca955x_chipdef {
 	int			slv_addr_shift;	/* Number of bits to ignore */
 };
 
-static struct pca955x_chipdef pca955x_chipdefs[] = {
-	[pca9550] = {
-		.bits		= 2,
-		.slv_addr	= /* 110000x */ 0x60,
-		.slv_addr_shift	= 1,
-	},
-	[pca9551] = {
-		.bits		= 8,
-		.slv_addr	= /* 1100xxx */ 0x60,
-		.slv_addr_shift	= 3,
-	},
-	[pca9552] = {
-		.bits		= 16,
-		.slv_addr	= /* 1100xxx */ 0x60,
-		.slv_addr_shift	= 3,
-	},
-	[ibm_pca9552] = {
-		.bits		= 16,
-		.slv_addr	= /* 0110xxx */ 0x30,
-		.slv_addr_shift	= 3,
-	},
-	[pca9553] = {
-		.bits		= 4,
-		.slv_addr	= /* 110001x */ 0x62,
-		.slv_addr_shift	= 1,
-	},
-};
-
-static const struct i2c_device_id pca955x_id[] = {
-	{ "pca9550", pca9550 },
-	{ "pca9551", pca9551 },
-	{ "pca9552", pca9552 },
-	{ "ibm-pca9552", ibm_pca9552 },
-	{ "pca9553", pca9553 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, pca955x_id);
-
 struct pca955x {
 	struct mutex lock;
 	struct pca955x_led *leds;
@@ -415,6 +377,44 @@ pca955x_get_pdata(struct i2c_client *client, struct pca955x_chipdef *chip)
 	return pdata;
 }
 
+static struct pca955x_chipdef pca955x_chipdefs[] = {
+	[pca9550] = {
+		.bits		= 2,
+		.slv_addr	= /* 110000x */ 0x60,
+		.slv_addr_shift	= 1,
+	},
+	[pca9551] = {
+		.bits		= 8,
+		.slv_addr	= /* 1100xxx */ 0x60,
+		.slv_addr_shift	= 3,
+	},
+	[pca9552] = {
+		.bits		= 16,
+		.slv_addr	= /* 1100xxx */ 0x60,
+		.slv_addr_shift	= 3,
+	},
+	[ibm_pca9552] = {
+		.bits		= 16,
+		.slv_addr	= /* 0110xxx */ 0x30,
+		.slv_addr_shift	= 3,
+	},
+	[pca9553] = {
+		.bits		= 4,
+		.slv_addr	= /* 110001x */ 0x62,
+		.slv_addr_shift	= 1,
+	},
+};
+
+static const struct i2c_device_id pca955x_id[] = {
+	{ "pca9550", pca9550 },
+	{ "pca9551", pca9551 },
+	{ "pca9552", pca9552 },
+	{ "ibm-pca9552", ibm_pca9552 },
+	{ "pca9553", pca9553 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pca955x_id);
+
 static const struct of_device_id of_pca955x_match[] = {
 	{ .compatible = "nxp,pca9550", .data = (void *)pca9550 },
 	{ .compatible = "nxp,pca9551", .data = (void *)pca9551 },
-- 
2.30.2

