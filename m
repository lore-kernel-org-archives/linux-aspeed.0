From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:54 -0500
Subject: [PATCH v4 22/40] fsi: aspeed: Use common master error handler
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-23-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This will do the correct mmode manipulation to do the master
reset.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-aspeed.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index c9f6d84e1a372..eecd64bc29512 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -226,27 +226,6 @@ static int opb_readb(struct fsi_master_aspeed *aspeed, uint32_t addr, u8 *out)
 	return __opb_read(aspeed, addr, XFER_BYTE, (void *)out);
 }
 
-static int check_errors(struct fsi_master_aspeed *aspeed, int err)
-{
-	int ret;
-
-	if (err == -EIO) {
-		/* Check MAEB (0x70) ? */
-
-		/* Then clear errors in master */
-		ret = opb_writel(aspeed, ctrl_base + FSI_MRESP0,
-				cpu_to_be32(FSI_MRESP_RST_ALL_MASTER));
-		if (ret) {
-			/* TODO: log? return different code? */
-			return ret;
-		}
-		/* TODO: confirm that 0x70 was okay */
-	}
-
-	/* This will pass through timeout errors */
-	return err;
-}
-
 static int aspeed_master_read(struct fsi_master *master, int link,
 			uint8_t id, uint32_t addr, void *val, size_t size)
 {
@@ -277,7 +256,8 @@ static int aspeed_master_read(struct fsi_master *master, int link,
 		goto done;
 	}
 
-	ret = check_errors(aspeed, ret);
+	if (ret == -EIO)
+		fsi_master_error(&aspeed->master, link);
 done:
 	spin_unlock_irqrestore(&aspeed->lock, flags);
 	return ret;
@@ -313,7 +293,8 @@ static int aspeed_master_write(struct fsi_master *master, int link,
 		goto done;
 	}
 
-	ret = check_errors(aspeed, ret);
+	if (ret == -EIO)
+		fsi_master_error(&aspeed->master, link);
 done:
 	spin_unlock_irqrestore(&aspeed->lock, flags);
 	return ret;
-- 
2.39.3

