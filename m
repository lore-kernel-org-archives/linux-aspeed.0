From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 29 May 2019 13:10:06 -0500
Subject: [PATCH v3 6/8] drivers/soc: xdma: Add debugfs entries
In-Reply-To: <1559153408-31190-1-git-send-email-eajames@linux.ibm.com>
References: <1559153408-31190-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1559153408-31190-7-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add debugfs entries for the relevant XDMA engine registers and for
dumping the AST2500 reserved memory space.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/soc/aspeed/aspeed-xdma.c | 94 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
index ddd5e1e..ea42dbe 100644
--- a/drivers/soc/aspeed/aspeed-xdma.c
+++ b/drivers/soc/aspeed/aspeed-xdma.c
@@ -145,6 +145,12 @@ struct aspeed_xdma {
 
 	char pcidev[4];
 	struct miscdevice misc;
+	struct dentry *debugfs_dir;
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	struct debugfs_regset32 regset;
+	struct debugfs_reg32 regs[XDMA_NUM_DEBUGFS_REGS];
+#endif /* IS_ENABLED(CONFIG_DEBUG_FS) */
 };
 
 struct aspeed_xdma_client {
@@ -603,6 +609,90 @@ static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx, u32 conf)
 	return rc;
 }
 
+static ssize_t aspeed_xdma_debugfs_vga_read(struct file *file,
+					    char __user *buf, size_t len,
+					    loff_t *offset)
+{
+	int rc = -ENOMEM;
+	struct inode *inode = file_inode(file);
+	struct aspeed_xdma *ctx = inode->i_private;
+	loff_t offs = *offset;
+	void *tmp;
+	void __iomem *vga;
+
+	if (len + offs > ctx->vga_size) {
+		if (offs < ctx->vga_size)
+			len = ctx->vga_size - offs;
+		else
+			return 0;
+	}
+
+	vga = ioremap(ctx->vga_phys, ctx->vga_size);
+	if (!vga)
+		return rc;
+
+	tmp = kzalloc(len, GFP_KERNEL);
+	if (!tmp)
+		goto unmap;
+
+	memcpy_fromio(tmp, vga + offs, len);
+
+	rc = copy_to_user(buf, tmp, len);
+	if (rc)
+		goto free;
+
+	*offset = offs + len;
+	rc = len;
+
+free:
+	kfree(tmp);
+
+unmap:
+	iounmap(vga);
+
+	return rc;
+}
+
+static const struct file_operations aspeed_xdma_debugfs_vga_fops = {
+	.owner	= THIS_MODULE,
+	.llseek	= generic_file_llseek,
+	.read	= aspeed_xdma_debugfs_vga_read,
+};
+
+static void aspeed_xdma_init_debugfs(struct aspeed_xdma *ctx)
+{
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return;
+
+	ctx->debugfs_dir = debugfs_create_dir(DEVICE_NAME, NULL);
+	if (IS_ERR(ctx->debugfs_dir)) {
+		dev_warn(ctx->dev, "Failed to create debugfs directory.\n");
+		return;
+	}
+
+	debugfs_create_file("vga", 0444, ctx->debugfs_dir, ctx,
+			    &aspeed_xdma_debugfs_vga_fops);
+
+	ctx->regs[0].name = "addr";
+	ctx->regs[0].offset = XDMA_BMC_CMD_QUEUE_ADDR;
+	ctx->regs[1].name = "endp";
+	ctx->regs[1].offset = XDMA_BMC_CMD_QUEUE_ENDP;
+	ctx->regs[2].name = "writep";
+	ctx->regs[2].offset = XDMA_BMC_CMD_QUEUE_WRITEP;
+	ctx->regs[3].name = "readp";
+	ctx->regs[3].offset = XDMA_BMC_CMD_QUEUE_READP;
+	ctx->regs[4].name = "control";
+	ctx->regs[4].offset = XDMA_CTRL;
+	ctx->regs[5].name = "status";
+	ctx->regs[5].offset = XDMA_STATUS;
+
+	ctx->regset.regs = ctx->regs;
+	ctx->regset.nregs = XDMA_NUM_DEBUGFS_REGS;
+	ctx->regset.base = ctx->base;
+
+	debugfs_create_regset32("regs", 0444, ctx->debugfs_dir, &ctx->regset);
+}
+
 static int aspeed_xdma_change_pcie_conf(struct aspeed_xdma *ctx, u32 conf)
 {
 	int rc;
@@ -777,6 +867,8 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 
 	device_create_file(dev, &dev_attr_pcidev);
 
+	aspeed_xdma_init_debugfs(ctx);
+
 	return 0;
 }
 
@@ -784,6 +876,8 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
 {
 	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
 
+	debugfs_remove_recursive(ctx->debugfs_dir);
+
 	device_remove_file(ctx->dev, &dev_attr_pcidev);
 
 	misc_deregister(&ctx->misc);
-- 
1.8.3.1

