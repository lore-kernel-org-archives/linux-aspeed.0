From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 10 Oct 2019 12:37:56 +1030
Subject: [PATCH v2 3/3] net: ftgmac100: Ungate RCLK for RMII on ASPEED MACs
In-Reply-To: <20191010020756.4198-1-andrew@aj.id.au>
References: <20191010020756.4198-1-andrew@aj.id.au>
Message-ID: <20191010020756.4198-4-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 50MHz RCLK has to be enabled before the RMII interface will function.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
v2: Mainly a rework of error case handling, some changes to comments

 drivers/net/ethernet/faraday/ftgmac100.c | 50 +++++++++++++++++++-----
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 9b7af94a40bb..824310253099 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -90,6 +90,9 @@ struct ftgmac100 {
 	struct mii_bus *mii_bus;
 	struct clk *clk;
 
+	/* AST2500/AST2600 RMII ref clock gate */
+	struct clk *rclk;
+
 	/* Link management */
 	int cur_speed;
 	int cur_duplex;
@@ -1718,20 +1721,41 @@ static void ftgmac100_ncsi_handler(struct ncsi_dev *nd)
 		   nd->link_up ? "up" : "down");
 }
 
-static void ftgmac100_setup_clk(struct ftgmac100 *priv)
+static int ftgmac100_setup_clk(struct ftgmac100 *priv)
 {
-	priv->clk = devm_clk_get(priv->dev, NULL);
-	if (IS_ERR(priv->clk))
-		return;
+	struct clk *clk;
+	int rc;
 
-	clk_prepare_enable(priv->clk);
+	clk = devm_clk_get(priv->dev, NULL /* MACCLK */);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	priv->clk = clk;
+	rc = clk_prepare_enable(priv->clk);
+	if (rc)
+		return rc;
 
 	/* Aspeed specifies a 100MHz clock is required for up to
 	 * 1000Mbit link speeds. As NCSI is limited to 100Mbit, 25MHz
 	 * is sufficient
 	 */
-	clk_set_rate(priv->clk, priv->use_ncsi ? FTGMAC_25MHZ :
-			FTGMAC_100MHZ);
+	rc = clk_set_rate(priv->clk, priv->use_ncsi ? FTGMAC_25MHZ :
+			  FTGMAC_100MHZ);
+	if (rc)
+		goto cleanup_clk;
+
+	/* RCLK is for RMII, typically used for NCSI. Optional because its not
+	 * necessary if it's the AST2400 MAC, or the MAC is configured for
+	 * RGMII, or the controller is not an ASPEED-based controller.
+	 */
+	priv->rclk = devm_clk_get_optional(priv->dev, "RCLK");
+	rc = clk_prepare_enable(priv->rclk);
+	if (!rc)
+		return 0;
+
+cleanup_clk:
+	clk_disable_unprepare(priv->clk);
+
+	return rc;
 }
 
 static int ftgmac100_probe(struct platform_device *pdev)
@@ -1853,8 +1877,11 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			goto err_setup_mdio;
 	}
 
-	if (priv->is_aspeed)
-		ftgmac100_setup_clk(priv);
+	if (priv->is_aspeed) {
+		err = ftgmac100_setup_clk(priv);
+		if (err)
+			goto err_ncsi_dev;
+	}
 
 	/* Default ring sizes */
 	priv->rx_q_entries = priv->new_rx_q_entries = DEF_RX_QUEUE_ENTRIES;
@@ -1886,8 +1913,10 @@ static int ftgmac100_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_ncsi_dev:
 err_register_netdev:
+	clk_disable_unprepare(priv->rclk);
+	clk_disable_unprepare(priv->clk);
+err_ncsi_dev:
 	ftgmac100_destroy_mdio(netdev);
 err_setup_mdio:
 	iounmap(priv->base);
@@ -1909,6 +1938,7 @@ static int ftgmac100_remove(struct platform_device *pdev)
 
 	unregister_netdev(netdev);
 
+	clk_disable_unprepare(priv->rclk);
 	clk_disable_unprepare(priv->clk);
 
 	/* There's a small chance the reset task will have been re-queued,
-- 
2.20.1

