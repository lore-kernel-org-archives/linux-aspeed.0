From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:48 -0500
Subject: [PATCH v4 16/40] fsi: aspeed: Remove cfam reset sysfs file in error path and remove
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-17-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This fixes a duplicate sysfs warning on device re-probe.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-aspeed.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index a67f185bb8814..29932037c9866 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -437,6 +437,7 @@ static int setup_cfam_reset(struct fsi_master_aspeed *aspeed)
 
 	rc = device_create_file(dev, &dev_attr_cfam_reset);
 	if (rc) {
+		aspeed->cfam_reset_gpio = NULL;
 		devm_gpiod_put(dev, gpio);
 		return rc;
 	}
@@ -615,6 +616,9 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 err_regmap:
 	regmap_exit(aspeed->master.map);
 err_release:
+	if (aspeed->cfam_reset_gpio)
+		device_remove_file(aspeed->dev, &dev_attr_cfam_reset);
+
 	clk_disable_unprepare(aspeed->clk);
 err_free_aspeed:
 	kfree(aspeed);
@@ -625,6 +629,9 @@ static int fsi_master_aspeed_remove(struct platform_device *pdev)
 {
 	struct fsi_master_aspeed *aspeed = platform_get_drvdata(pdev);
 
+	if (aspeed->cfam_reset_gpio)
+		device_remove_file(aspeed->dev, &dev_attr_cfam_reset);
+
 	fsi_master_unregister(&aspeed->master);
 	clk_disable_unprepare(aspeed->clk);
 
-- 
2.39.3

