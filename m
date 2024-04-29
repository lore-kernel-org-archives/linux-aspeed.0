From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Apr 2024 16:01:31 -0500
Subject: [PATCH v4 17/17] fsi: scom: Update compatible string to match documentation
In-Reply-To: <20240429210131.373487-1-eajames@linux.ibm.com>
References: <20240429210131.373487-1-eajames@linux.ibm.com>
Message-ID: <20240429210131.373487-18-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use p9-scom instead of fsi2pib.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-scom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index 61dbda9dbe2b..18ca213fdc7e 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -589,7 +589,7 @@ static int scom_remove(struct device *dev)
 }
 
 static const struct of_device_id scom_of_ids[] = {
-	{ .compatible = "ibm,fsi2pib" },
+	{ .compatible = "ibm,p9-scom" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, scom_of_ids);
-- 
2.39.3

