From: Neal Liu <neal_liu@aspeedtech.com>
Date: Fri, 24 Feb 2023 10:05:21 +0800
Subject: [PATCH v2] crypto: aspeed: add error handling if dmam_alloc_coherent() failed
Message-ID: <20230224020521.3158285-1-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since the acry_dev->buf_addr may be NULL, add error handling to
prevent any additional access to avoid potential issues.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
Change since v1: remove memzero_explicit() as dmam_alloc_coherent()
returns memory that's already zeroed.

 drivers/crypto/aspeed/aspeed-acry.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
index 1f77ebd73489..eb30649ea7b3 100644
--- a/drivers/crypto/aspeed/aspeed-acry.c
+++ b/drivers/crypto/aspeed/aspeed-acry.c
@@ -782,7 +782,10 @@ static int aspeed_acry_probe(struct platform_device *pdev)
 	acry_dev->buf_addr = dmam_alloc_coherent(dev, ASPEED_ACRY_BUFF_SIZE,
 						 &acry_dev->buf_dma_addr,
 						 GFP_KERNEL);
-	memzero_explicit(acry_dev->buf_addr, ASPEED_ACRY_BUFF_SIZE);
+	if (!acry_dev->buf_addr) {
+		rc = -ENOMEM;
+		goto err_engine_rsa_start;
+	}
 
 	aspeed_acry_register(acry_dev);
 
-- 
2.25.1

