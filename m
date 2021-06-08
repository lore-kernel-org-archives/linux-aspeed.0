From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  8 Jun 2021 20:17:51 +0930
Subject: [PATCH v4 10/16] ipmi: kcs_bmc: Enable IBF on open
In-Reply-To: <20210608104757.582199-1-andrew@aj.id.au>
References: <20210608104757.582199-1-andrew@aj.id.au>
Message-ID: <20210608104757.582199-11-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This way devices don't get delivered IRQs when no-one is interested.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/char/ipmi/kcs_bmc.c         | 25 ++++++++++---------------
 drivers/char/ipmi/kcs_bmc_aspeed.c  |  3 +--
 drivers/char/ipmi/kcs_bmc_npcm7xx.c |  3 +--
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index 91eb43746cef..03d02a848f3a 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -55,24 +55,12 @@ EXPORT_SYMBOL(kcs_bmc_update_status);
 irqreturn_t kcs_bmc_handle_event(struct kcs_bmc_device *kcs_bmc)
 {
 	struct kcs_bmc_client *client;
-	irqreturn_t rc;
+	irqreturn_t rc = IRQ_NONE;
 
 	spin_lock(&kcs_bmc->lock);
 	client = kcs_bmc->client;
-	if (client) {
+	if (client)
 		rc = client->ops->event(client);
-	} else {
-		u8 status;
-
-		status = kcs_bmc_read_status(kcs_bmc);
-		if (status & KCS_BMC_STR_IBF) {
-			/* Ack the event by reading the data */
-			kcs_bmc_read_data(kcs_bmc);
-			rc = IRQ_HANDLED;
-		} else {
-			rc = IRQ_NONE;
-		}
-	}
 	spin_unlock(&kcs_bmc->lock);
 
 	return rc;
@@ -87,7 +75,10 @@ int kcs_bmc_enable_device(struct kcs_bmc_device *kcs_bmc, struct kcs_bmc_client
 	if (kcs_bmc->client) {
 		rc = -EBUSY;
 	} else {
+		u8 mask = KCS_BMC_EVENT_TYPE_IBF;
+
 		kcs_bmc->client = client;
+		kcs_bmc_update_event_mask(kcs_bmc, mask, mask);
 		rc = 0;
 	}
 	spin_unlock_irq(&kcs_bmc->lock);
@@ -99,8 +90,12 @@ EXPORT_SYMBOL(kcs_bmc_enable_device);
 void kcs_bmc_disable_device(struct kcs_bmc_device *kcs_bmc, struct kcs_bmc_client *client)
 {
 	spin_lock_irq(&kcs_bmc->lock);
-	if (client == kcs_bmc->client)
+	if (client == kcs_bmc->client) {
+		u8 mask = KCS_BMC_EVENT_TYPE_IBF | KCS_BMC_EVENT_TYPE_OBE;
+
+		kcs_bmc_update_event_mask(kcs_bmc, mask, 0);
 		kcs_bmc->client = NULL;
+	}
 	spin_unlock_irq(&kcs_bmc->lock);
 }
 EXPORT_SYMBOL(kcs_bmc_disable_device);
diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index 5bf8d013e4ae..43994688dc8a 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -416,8 +416,7 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	aspeed_kcs_irq_mask_update(kcs_bmc, (KCS_BMC_EVENT_TYPE_IBF | KCS_BMC_EVENT_TYPE_OBE),
-				   KCS_BMC_EVENT_TYPE_IBF);
+	aspeed_kcs_irq_mask_update(kcs_bmc, (KCS_BMC_EVENT_TYPE_IBF | KCS_BMC_EVENT_TYPE_OBE), 0);
 	aspeed_kcs_enable_channel(kcs_bmc, true);
 
 	rc = kcs_bmc_add_device(&priv->kcs_bmc);
diff --git a/drivers/char/ipmi/kcs_bmc_npcm7xx.c b/drivers/char/ipmi/kcs_bmc_npcm7xx.c
index ef81a715f88a..7961fec56476 100644
--- a/drivers/char/ipmi/kcs_bmc_npcm7xx.c
+++ b/drivers/char/ipmi/kcs_bmc_npcm7xx.c
@@ -202,8 +202,7 @@ static int npcm7xx_kcs_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	npcm7xx_kcs_irq_mask_update(kcs_bmc, (KCS_BMC_EVENT_TYPE_IBF | KCS_BMC_EVENT_TYPE_OBE),
-				    KCS_BMC_EVENT_TYPE_IBF);
+	npcm7xx_kcs_irq_mask_update(kcs_bmc, (KCS_BMC_EVENT_TYPE_IBF | KCS_BMC_EVENT_TYPE_OBE), 0);
 	npcm7xx_kcs_enable_channel(kcs_bmc, true);
 
 	rc = kcs_bmc_add_device(kcs_bmc);
-- 
2.30.2

