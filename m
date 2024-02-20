From: Andrew Geissler <geissonator@gmail.com>
Date: Tue, 20 Feb 2024 06:36:15 -0600
Subject: [PATCH] ipmi: kcs: Update OBF poll timeout to reduce latency
Message-ID: <20240220123615.963916-1-geissonator@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Geissler <geissonator@yahoo.com>

Commit f90bc0f97f2b ("ipmi: kcs: Poll OBF briefly to reduce OBE
latency") introduced an optimization to poll when the host has
read the output data register (ODR). Testing has shown that the 100us
timeout was not always enough. When we miss that 100us window, it
results in 10x the time to get the next message from the BMC to the
host. When you're sending 100's of messages between the BMC and Host,
this results in a server boot taking 50% longer for IBM P10 machines.

Started with 1000 and worked it down until the issue started to reoccur.
200 was the sweet spot in my testing. 150 showed the issue
intermittently.
Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index 72640da55380..af1eae6153f6 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -422,7 +422,7 @@ static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask,
 			 * missed the event.
 			 */
 			rc = read_poll_timeout_atomic(aspeed_kcs_inb, str,
-						      !(str & KCS_BMC_STR_OBF), 1, 100, false,
+						      !(str & KCS_BMC_STR_OBF), 1, 200, false,
 						      &priv->kcs_bmc, priv->kcs_bmc.ioreg.str);
 			/* Time for the slow path? */
 			if (rc == -ETIMEDOUT)
-- 
2.39.2

