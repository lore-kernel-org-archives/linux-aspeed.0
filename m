From: Rob Herring <robh@kernel.org>
Date: Fri,  6 Oct 2023 16:39:17 -0500
Subject: [PATCH] crypto: aspeed-hace: Use device_get_match_data()
Message-ID: <20231006213917.333702-1-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/crypto/aspeed/aspeed-hace.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace.c b/drivers/crypto/aspeed/aspeed-hace.c
index 8f7aab82e1d8..d9da04fb816e 100644
--- a/drivers/crypto/aspeed/aspeed-hace.c
+++ b/drivers/crypto/aspeed/aspeed-hace.c
@@ -12,11 +12,9 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #ifdef CONFIG_CRYPTO_DEV_ASPEED_DEBUG
 #define HACE_DBG(d, fmt, ...)	\
@@ -101,7 +99,6 @@ static const struct of_device_id aspeed_hace_of_matches[] = {
 static int aspeed_hace_probe(struct platform_device *pdev)
 {
 	struct aspeed_engine_crypto *crypto_engine;
-	const struct of_device_id *hace_dev_id;
 	struct aspeed_engine_hash *hash_engine;
 	struct aspeed_hace_dev *hace_dev;
 	int rc;
@@ -111,14 +108,13 @@ static int aspeed_hace_probe(struct platform_device *pdev)
 	if (!hace_dev)
 		return -ENOMEM;
 
-	hace_dev_id = of_match_device(aspeed_hace_of_matches, &pdev->dev);
-	if (!hace_dev_id) {
+	hace_dev->version = (uintptr_t)device_get_match_data(&pdev->dev);
+	if (!hace_dev->version) {
 		dev_err(&pdev->dev, "Failed to match hace dev id\n");
 		return -EINVAL;
 	}
 
 	hace_dev->dev = &pdev->dev;
-	hace_dev->version = (unsigned long)hace_dev_id->data;
 	hash_engine = &hace_dev->hash_engine;
 	crypto_engine = &hace_dev->crypto_engine;
 
-- 
2.40.1

