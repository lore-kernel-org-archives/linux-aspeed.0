From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:23:05 -0500
Subject: [PATCH v4 33/40] fsi: hub master: Reset hub master after errors
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-34-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The hub master driver wasn't clearing errors after accessing remote
slaves. Perform the standard master reset procedure to clear errors
to fully recover.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-hub.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index 4dbc542500bbd..1bd53b1e52a91 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -49,24 +49,34 @@ static int hub_master_read(struct fsi_master *master, int link,
 			uint8_t id, uint32_t addr, void *val, size_t size)
 {
 	struct fsi_master_hub *hub = to_fsi_master_hub(master);
+	int rc;
 
 	if (id != 0)
 		return -EINVAL;
 
 	addr += hub->addr + (link * FSI_HUB_LINK_SIZE);
-	return fsi_slave_read(hub->upstream->slave, addr, val, size);
+	rc = fsi_slave_read(hub->upstream->slave, addr, val, size);
+	if (rc)
+		fsi_master_error(master, link);
+
+	return rc;
 }
 
 static int hub_master_write(struct fsi_master *master, int link,
 			uint8_t id, uint32_t addr, const void *val, size_t size)
 {
 	struct fsi_master_hub *hub = to_fsi_master_hub(master);
+	int rc;
 
 	if (id != 0)
 		return -EINVAL;
 
 	addr += hub->addr + (link * FSI_HUB_LINK_SIZE);
-	return fsi_slave_write(hub->upstream->slave, addr, val, size);
+	rc = fsi_slave_write(hub->upstream->slave, addr, val, size);
+	if (rc)
+		fsi_master_error(master, link);
+
+	return rc;
 }
 
 static int hub_master_break(struct fsi_master *master, int link)
-- 
2.39.3

