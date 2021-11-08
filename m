From: jae.hyun.yoo@intel.com <jae.hyun.yoo@intel.com>
Date: Mon,  8 Nov 2021 11:01:57 -0800
Subject: [PATCH v3 3/6] ipmi: bt: add clock control logic
In-Reply-To: <20211108190200.290957-1-jae.hyun.yoo@intel.com>
References: <20211108190200.290957-1-jae.hyun.yoo@intel.com>
Message-ID: <20211108190200.290957-4-jae.hyun.yoo@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

If LPC BT driver is registered ahead of lpc-ctrl module, LPC BT
hardware block will be enabled without heart beating of LCLK until
lpc-ctrl enables the LCLK. This issue causes improper handling on
host interrupts when the host sends interrupts in that time frame.
Then kernel eventually forcibly disables the interrupt with
dumping stack and printing a 'nobody cared this irq' message out.

To prevent this issue, all LPC sub drivers should enable LCLK
individually so this patch adds clock control logic into the LPC
BT driver.

Note: dtsi change in this patch series should be applied along with,
and dtbs should be re-compiled after applying this series since
it's adding a new required property otherwise this driver will not
be probed correctly.

Fixes: 54f9c4d0778b ("ipmi: add an Aspeed BT IPMI BMC driver")
Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: C?dric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
v2 -> v3:
 * Simplified the -EPROBE_DEFER handling using dev_err_probe().

v1 -> v2:
 * No change.

 drivers/char/ipmi/bt-bmc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index 7450904e330a..f6547ddd7284 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -5,6 +5,7 @@
 
 #include <linux/atomic.h>
 #include <linux/bt-bmc.h>
+#include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -62,6 +63,7 @@ struct bt_bmc {
 	wait_queue_head_t	queue;
 	struct timer_list	poll_timer;
 	struct mutex		mutex;
+	struct clk		*clk;
 };
 
 static atomic_t open_count = ATOMIC_INIT(0);
@@ -423,6 +425,16 @@ static int bt_bmc_probe(struct platform_device *pdev)
 	if (IS_ERR(bt_bmc->base))
 		return PTR_ERR(bt_bmc->base);
 
+	bt_bmc->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(bt_bmc->clk))
+		return dev_err_probe(dev, PTR_ERR(bt_bmc->clk),
+				     "Unable to get clock\n");
+	rc = clk_prepare_enable(bt_bmc->clk);
+	if (rc) {
+		dev_err(dev, "Unable to enable clock\n");
+		return rc;
+	}
+
 	mutex_init(&bt_bmc->mutex);
 	init_waitqueue_head(&bt_bmc->queue);
 
@@ -433,7 +445,7 @@ static int bt_bmc_probe(struct platform_device *pdev)
 	rc = misc_register(&bt_bmc->miscdev);
 	if (rc) {
 		dev_err(dev, "Unable to register misc device\n");
-		return rc;
+		goto err;
 	}
 
 	bt_bmc_config_irq(bt_bmc, pdev);
@@ -457,6 +469,11 @@ static int bt_bmc_probe(struct platform_device *pdev)
 	clr_b_busy(bt_bmc);
 
 	return 0;
+
+err:
+	clk_disable_unprepare(bt_bmc->clk);
+
+	return rc;
 }
 
 static int bt_bmc_remove(struct platform_device *pdev)
@@ -466,6 +483,8 @@ static int bt_bmc_remove(struct platform_device *pdev)
 	misc_deregister(&bt_bmc->miscdev);
 	if (bt_bmc->irq < 0)
 		del_timer_sync(&bt_bmc->poll_timer);
+	clk_disable_unprepare(bt_bmc->clk);
+
 	return 0;
 }
 
-- 
2.25.1

