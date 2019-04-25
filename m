From: Patrick Venture <venture@google.com>
Date: Thu, 25 Apr 2019 13:23:47 -0700
Subject: [PATCH] fixup! drivers/misc: Add Aspeed P2A control driver
Message-ID: <20190425202347.83880-1-venture@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fixup compiler warnings:
 - 108 warning: ISO C90 forbids mixed declarations and code
 - 264 warning: unused variable 'value'
 - 335 warning: unused variable 'res'

Signed-off-by: Patrick Venture <venture@google.com>
---
 drivers/misc/aspeed-p2a-ctrl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/aspeed-p2a-ctrl.c b/drivers/misc/aspeed-p2a-ctrl.c
index c0521b2ffc6a..9736821972ef 100644
--- a/drivers/misc/aspeed-p2a-ctrl.c
+++ b/drivers/misc/aspeed-p2a-ctrl.c
@@ -99,13 +99,14 @@ static void aspeed_p2a_disable_bridge(struct aspeed_p2a_ctrl *p2a_ctrl)
 
 static int aspeed_p2a_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	unsigned long vsize;
 	struct aspeed_p2a_user *priv = file->private_data;
 	struct aspeed_p2a_ctrl *ctrl = priv->parent;
 
 	if (ctrl->mem_base == 0 && ctrl->mem_size == 0)
 		return -EINVAL;
 
-	unsigned long vsize = vma->vm_end - vma->vm_start;
+	vsize = vma->vm_end - vma->vm_start;
 	pgprot_t prot = vma->vm_page_prot;
 
 	if (vma->vm_pgoff + vsize > ctrl->mem_base + ctrl->mem_size)
@@ -261,7 +262,6 @@ static int aspeed_p2a_open(struct inode *inode, struct file *file)
 static int aspeed_p2a_release(struct inode *inode, struct file *file)
 {
 	int i;
-	u32 value;
 	u32 bits = 0;
 	bool open_regions = false;
 	struct aspeed_p2a_user *priv = file->private_data;
@@ -332,7 +332,7 @@ static int aspeed_p2a_ctrl_probe(struct platform_device *pdev)
 {
 	struct aspeed_p2a_ctrl *misc_ctrl;
 	struct device *dev;
-	struct resource *res, resm;
+	struct resource resm;
 	struct device_node *node;
 	int rc = 0;
 
-- 
2.21.0.593.g511ec345e18-goog

