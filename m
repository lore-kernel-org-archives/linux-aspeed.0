From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 21 Sep 2021 14:09:36 +0930
Subject: [PATCH 2/2] leds: pca955x: Allow zero LEDs to be specified
In-Reply-To: <20210921043936.468001-1-andrew@aj.id.au>
References: <20210921043936.468001-1-andrew@aj.id.au>
Message-ID: <20210921043936.468001-3-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

It's valid to use the PCA955x devices just for GPIOs and not for LEDs.
In this case, as PCA955X_TYPE_GPIO is now equivalent to
PCA955X_TYPE_NONE, remove the test for whether we have any child nodes
specified in the devicetree.

A consequence of this is it's now possible to bind the driver to a
PCA955x device when dynamically instantiated through the I2C subsystem's
`new_device` interface.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/leds/leds-pca955x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index 77c0f461ab95..81aaf21212d7 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -429,7 +429,7 @@ pca955x_get_pdata(struct i2c_client *client, struct pca955x_chipdef *chip)
 	int count;
 
 	count = device_get_child_node_count(&client->dev);
-	if (!count || count > chip->bits)
+	if (count > chip->bits)
 		return ERR_PTR(-ENODEV);
 
 	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
-- 
2.30.2

