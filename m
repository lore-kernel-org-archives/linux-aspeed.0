From: Eddie James <eajames@linux.ibm.com>
Date: Thu,  9 Jan 2020 14:58:59 -0600
Subject: [PATCH v5 08/12] soc: aspeed: xdma: Add reset ioctl
In-Reply-To: <20200109205903.27036-1-eajames@linux.ibm.com>
References: <20200109205903.27036-1-eajames@linux.ibm.com>
Message-ID: <20200109205903.27036-9-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Users of the XDMA engine need a way to reset it if something goes wrong.
Problems on the host side, or user error, such as incorrect host
address, may result in the DMA operation never completing and no way to
determine what went wrong. Therefore, add an ioctl to reset the engine
so that users can recover in this situation.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/soc/aspeed/aspeed-xdma.c | 36 ++++++++++++++++++++++++++++++++
 include/uapi/linux/aspeed-xdma.h |  4 ++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
index 4950068a6ff5..8c6408ff253b 100644
--- a/drivers/soc/aspeed/aspeed-xdma.c
+++ b/drivers/soc/aspeed/aspeed-xdma.c
@@ -619,6 +619,41 @@ static __poll_t aspeed_xdma_poll(struct file *file,
 	return mask;
 }
 
+static long aspeed_xdma_ioctl(struct file *file, unsigned int cmd,
+			      unsigned long param)
+{
+	unsigned long flags;
+	struct aspeed_xdma_client *client = file->private_data;
+	struct aspeed_xdma *ctx = client->ctx;
+
+	switch (cmd) {
+	case ASPEED_XDMA_IOCTL_RESET:
+		spin_lock_irqsave(&ctx->reset_lock, flags);
+		if (ctx->in_reset) {
+			spin_unlock_irqrestore(&ctx->reset_lock, flags);
+			return 0;
+		}
+
+		ctx->in_reset = true;
+		spin_unlock_irqrestore(&ctx->reset_lock, flags);
+
+		if (ctx->current_client)
+			dev_warn(ctx->dev,
+				 "User reset with transfer in progress.\n");
+
+		mutex_lock(&ctx->start_lock);
+
+		aspeed_xdma_reset(ctx);
+
+		mutex_unlock(&ctx->start_lock);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void aspeed_xdma_vma_close(struct vm_area_struct *vma)
 {
 	int rc;
@@ -712,6 +747,7 @@ static const struct file_operations aspeed_xdma_fops = {
 	.owner			= THIS_MODULE,
 	.write			= aspeed_xdma_write,
 	.poll			= aspeed_xdma_poll,
+	.unlocked_ioctl		= aspeed_xdma_ioctl,
 	.mmap			= aspeed_xdma_mmap,
 	.open			= aspeed_xdma_open,
 	.release		= aspeed_xdma_release,
diff --git a/include/uapi/linux/aspeed-xdma.h b/include/uapi/linux/aspeed-xdma.h
index 2efaa6067c39..3a3646fd1e9e 100644
--- a/include/uapi/linux/aspeed-xdma.h
+++ b/include/uapi/linux/aspeed-xdma.h
@@ -4,8 +4,12 @@
 #ifndef _UAPI_LINUX_ASPEED_XDMA_H_
 #define _UAPI_LINUX_ASPEED_XDMA_H_
 
+#include <linux/ioctl.h>
 #include <linux/types.h>
 
+#define __ASPEED_XDMA_IOCTL_MAGIC	0xb7
+#define ASPEED_XDMA_IOCTL_RESET		_IO(__ASPEED_XDMA_IOCTL_MAGIC, 0)
+
 /*
  * aspeed_xdma_direction
  *
-- 
2.24.0

