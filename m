From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:51 -0500
Subject: [PATCH v4 19/40] fsi: aspeed: Only read result register for successful read
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-20-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

No reason to read the result in the error path, and remove the
null pointer check on the output, as it should never be null.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-aspeed.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index f840c7c4a56b9..10ca23cf58c2e 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -181,8 +181,6 @@ static int __opb_read(struct fsi_master_aspeed *aspeed, uint32_t addr,
 	writel(OPB0_XFER_ACK_EN, base + OPB_IRQ_STATUS);
 	status = readl(base + OPB0_STATUS);
 
-	result = readl(base + OPB0_FSI_DATA_R);
-
 	/* Return error when poll timed out */
 	if (ret) {
 		trace_fsi_master_aspeed_timeout(reg, status, true);
@@ -193,21 +191,20 @@ static int __opb_read(struct fsi_master_aspeed *aspeed, uint32_t addr,
 	if (status & STATUS_ERR_ACK)
 		return -EIO;
 
-	if (out) {
-		switch (transfer_size) {
-		case XFER_BYTE:
-			*(u8 *)out = result;
-			break;
-		case XFER_HALFWORD:
-			*(u16 *)out = result;
-			break;
-		case XFER_FULLWORD:
-			*(u32 *)out = result;
-			break;
-		default:
-			return -EINVAL;
-		}
+	result = readl(base + OPB0_FSI_DATA_R);
 
+	switch (transfer_size) {
+	case XFER_BYTE:
+		*(u8 *)out = result;
+		break;
+	case XFER_HALFWORD:
+		*(u16 *)out = result;
+		break;
+	case XFER_FULLWORD:
+		*(u32 *)out = result;
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	trace_fsi_master_aspeed_opb_xfer(addr, transfer_size + 1, result, true);
-- 
2.39.3

