From: Neal Liu <neal_liu@aspeedtech.com>
Date: Wed, 1 Mar 2023 11:32:05 +0800
Subject: [PATCH] crypto: aspeed: fix uninitialized symbol 'idx' warning
Message-ID: <20230301033205.2137450-1-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

'idx' is not initialized if it's not EXP_MODE nor MOD_MODE.
Use "else" instead to fix it.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202302261052.CVFRyq6F-lkp at intel.com/

---
 drivers/crypto/aspeed/aspeed-acry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
index 1f77ebd73489..828dc3ae1b5f 100644
--- a/drivers/crypto/aspeed/aspeed-acry.c
+++ b/drivers/crypto/aspeed/aspeed-acry.c
@@ -289,7 +289,7 @@ static int aspeed_acry_rsa_ctx_copy(struct aspeed_acry_dev *acry_dev, void *buf,
 
 			if (mode == ASPEED_RSA_EXP_MODE)
 				idx = acry_dev->exp_dw_mapping[j - 1];
-			else if (mode == ASPEED_RSA_MOD_MODE)
+			else /* mode == ASPEED_RSA_MOD_MODE */
 				idx = acry_dev->mod_dw_mapping[j - 1];
 
 			dw_buf[idx] = cpu_to_le32(data);
-- 
2.25.1

