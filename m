From: Vijay Khemka <vijaykhemka@fb.com>
Date: Wed, 1 May 2019 15:38:36 -0700
Subject: [PATCH] misc: aspeed-lpc-ctrl: Correct return values
Message-ID: <20190501223836.1670096-1-vijaykhemka@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Corrected some of return values with appropriate meanings.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 drivers/misc/aspeed-lpc-ctrl.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
index 332210e06e98..97ae341109d5 100644
--- a/drivers/misc/aspeed-lpc-ctrl.c
+++ b/drivers/misc/aspeed-lpc-ctrl.c
@@ -68,7 +68,6 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
 		unsigned long param)
 {
 	struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
-	struct device *dev = file->private_data;
 	void __user *p = (void __user *)param;
 	struct aspeed_lpc_ctrl_mapping map;
 	u32 addr;
@@ -93,8 +92,8 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
 
 		/* If memory-region is not described in device tree */
 		if (!lpc_ctrl->mem_size) {
-			dev_err(dev, "Didn't find reserved memory\n");
-			return -EINVAL;
+			pr_err("aspeed_lpc_ctrl: ioctl: Didn't find reserved memory\n");
+			return -ENXIO;
 		}
 
 		map.size = lpc_ctrl->mem_size;
@@ -134,16 +133,16 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
 
 		if (map.window_type == ASPEED_LPC_CTRL_WINDOW_FLASH) {
 			if (!lpc_ctrl->pnor_size) {
-				dev_err(dev, "Didn't find host pnor flash\n");
-				return -EINVAL;
+				pr_err("aspeed_lpc_ctrl: ioctl: Didn't find host pnor flash\n");
+				return -ENXIO;
 			}
 			addr = lpc_ctrl->pnor_base;
 			size = lpc_ctrl->pnor_size;
 		} else if (map.window_type == ASPEED_LPC_CTRL_WINDOW_MEMORY) {
 			/* If memory-region is not described in device tree */
 			if (!lpc_ctrl->mem_size) {
-				dev_err(dev, "Didn't find reserved memory\n");
-				return -EINVAL;
+				pr_err("aspeed_lpc_ctrl: ioctl: Didn't find reserved memory\n");
+				return -ENXIO;
 			}
 			addr = lpc_ctrl->mem_base;
 			size = lpc_ctrl->mem_size;
@@ -239,7 +238,7 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 		of_node_put(node);
 		if (rc) {
 			dev_err(dev, "Couldn't address to resource for reserved memory\n");
-			return -ENOMEM;
+			return -ENXIO;
 		}
 
 		lpc_ctrl->mem_size = resource_size(&resm);
-- 
2.17.1

