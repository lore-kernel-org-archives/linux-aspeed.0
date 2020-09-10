From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 10 Sep 2020 10:18:40 -0500
Subject: [PATCH 4/4] fsi: Aspeed master: Set bus frequency from devicetree
In-Reply-To: <20200910151840.25333-1-eajames@linux.ibm.com>
References: <20200910151840.25333-1-eajames@linux.ibm.com>
Message-ID: <20200910151840.25333-5-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Set the FSI bus frequency based on the value encoded in the
devicetree. The default value is 166MHz, which is the highest
frequency some FSI slaves can accept.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-master-aspeed.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index c006ec008a1a..be19fee0bece 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -515,6 +515,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	struct fsi_master_aspeed *aspeed;
 	struct resource *res;
 	int rc, links, reg;
+	u32 bus_freq = 166666666;
 	__be32 raw;
 
 	rc = tacoma_cabled_fsi_fixup(&pdev->dev);
@@ -539,6 +540,10 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 		dev_err(aspeed->dev, "couldn't get clock\n");
 		return PTR_ERR(aspeed->clk);
 	}
+
+	of_property_read_u32(pdev->dev.of_node, "bus-frequency", &bus_freq);
+	clk_set_rate(aspeed->clk, bus_freq);
+
 	rc = clk_prepare_enable(aspeed->clk);
 	if (rc) {
 		dev_err(aspeed->dev, "couldn't enable clock\n");
-- 
2.26.2

