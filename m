From: Eddie James <eajames@linux.ibm.com>
Date: Thu,  9 Jul 2020 14:17:43 -0500
Subject: [PATCH] fsi: aspeed: Enable 23-bit addressing
Message-ID: <20200709191743.11224-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In order to access more than the second hub link, 23-bit addressing is
required. The core provides the highest two bits of address as the slave
ID to the master.

OpenBMC-Staging-Count: 1
Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-master-aspeed.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index f49742b310c2..b49dccf14315 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -241,9 +241,10 @@ static int aspeed_master_read(struct fsi_master *master, int link,
 	struct fsi_master_aspeed *aspeed = to_fsi_master_aspeed(master);
 	int ret;
 
-	if (id != 0)
+	if (id > 0x3)
 		return -EINVAL;
 
+	addr |= id << 21;
 	addr += link * FSI_HUB_LINK_SIZE;
 
 	switch (size) {
@@ -273,9 +274,10 @@ static int aspeed_master_write(struct fsi_master *master, int link,
 	struct fsi_master_aspeed *aspeed = to_fsi_master_aspeed(master);
 	int ret;
 
-	if (id != 0)
+	if (id > 0x3)
 		return -EINVAL;
 
+	addr |= id << 21;
 	addr += link * FSI_HUB_LINK_SIZE;
 
 	switch (size) {
-- 
2.24.0

