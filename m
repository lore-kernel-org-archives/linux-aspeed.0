From: Colin King <colin.king@canonical.com>
Date: Wed, 16 Jun 2021 17:29:13 +0100
Subject: [PATCH][next] ipmi: kcs_bmc_aspeed: Fix less than zero comparison of
 a unsigned int
Message-ID: <20210616162913.15259-1-colin.king@canonical.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Colin Ian King <colin.king@canonical.com>

The comparisons of the unsigned int hw_type to less than zero always
false because it is unsigned. Fix this by using an int for the
assignment and less than zero check.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 9d2df9a0ad80 ("ipmi: kcs_bmc_aspeed: Implement KCS SerIRQ configuration")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index 0401089f8895..92a37b33494c 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -301,13 +301,15 @@ static inline int aspeed_kcs_map_serirq_type(u32 dt_type)
 static int aspeed_kcs_config_upstream_irq(struct aspeed_kcs_bmc *priv, u32 id, u32 dt_type)
 {
 	unsigned int mask, val, hw_type;
+	int ret;
 
 	if (id > 15)
 		return -EINVAL;
 
-	hw_type = aspeed_kcs_map_serirq_type(dt_type);
-	if (hw_type < 0)
-		return hw_type;
+	ret = aspeed_kcs_map_serirq_type(dt_type);
+	if (ret < 0)
+		return ret;
+	hw_type = ret;
 
 	priv->upstream_irq.mode = aspeed_kcs_irq_serirq;
 	priv->upstream_irq.id = id;
-- 
2.31.1

