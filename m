From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 15 Jan 2020 15:29:46 -0600
Subject: [PATCH v6 08/12] soc: aspeed: xdma: Add reset ioctl
In-Reply-To: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1579123790-6894-9-git-send-email-eajames@linux.ibm.com>
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
 drivers/soc/aspeed/aspeed-xdma.c | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/aspeed-xdma.h |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
index 1b81a08..361daca 100644
--- a/drivers/soc/aspeed/aspeed-xdma.c
+++ b/drivers/soc/aspeed/aspeed-xdma.c
@@ -615,6 +615,37 @@ static __poll_t aspeed_xdma_poll(struct file *file,
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
+		spin_lock_irqsave(&ctx->engine_lock, flags);
+		if (ctx->in_reset) {
+			spin_unlock_irqrestore(&ctx->engine_lock, flags);
+			return 0;
+		}
+
+		ctx->in_reset = true;
+		spin_unlock_irqrestore(&ctx->engine_lock, flags);
+
+		if (READ_ONCE(ctx->current_client))
+			dev_warn(ctx->dev,
+				 "User reset with transfer in progress.\n");
+
+		aspeed_xdma_reset(ctx);
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
@@ -708,6 +739,7 @@ static int aspeed_xdma_release(struct inode *inode, struct file *file)
 	.owner			= THIS_MODULE,
 	.write			= aspeed_xdma_write,
 	.poll			= aspeed_xdma_poll,
+	.unlocked_ioctl		= aspeed_xdma_ioctl,
 	.mmap			= aspeed_xdma_mmap,
 	.open			= aspeed_xdma_open,
 	.release		= aspeed_xdma_release,
diff --git a/include/uapi/linux/aspeed-xdma.h b/include/uapi/linux/aspeed-xdma.h
index 2efaa60..3a3646f 100644
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
1.8.3.1

