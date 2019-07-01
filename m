From: Eddie James <eajames@linux.ibm.com>
Date: Mon,  1 Jul 2019 14:53:57 -0500
Subject: [PATCH v4 6/8] drivers/soc: xdma: Add debugfs entries
In-Reply-To: <1562010839-1113-1-git-send-email-eajames@linux.ibm.com>
References: <1562010839-1113-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1562010839-1113-7-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add debugfs entries for the relevant XDMA engine registers and for
dumping the AST2500 reserved memory space.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/soc/aspeed/aspeed-xdma.c | 128 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
index 72b4c4b..08128ce 100644
--- a/drivers/soc/aspeed/aspeed-xdma.c
+++ b/drivers/soc/aspeed/aspeed-xdma.c
@@ -172,6 +172,12 @@ struct aspeed_xdma {
 
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
@@ -614,6 +620,126 @@ static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx, u32 conf)
 	return 0;
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
+
+	if (len + offs > ctx->vga_size) {
+		if (offs < ctx->vga_size)
+			len = ctx->vga_size - offs;
+		else
+			return 0;
+	}
+
+	tmp = kzalloc(len, GFP_KERNEL);
+	if (!tmp)
+		return rc;
+
+	memcpy_fromio(tmp, ctx->vga_virt + offs, len);
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
+	ctx->regs[0].name = "host_q_addr31";
+	ctx->regs[0].offset = XDMA_HOST_CMD_QUEUE_ADDR0;
+	ctx->regs[1].name = "host_q_addr63";
+	ctx->regs[1].offset = XDMA_HOST_CMD_QUEUE_ADDR1;
+	ctx->regs[2].name = "host_q_endp";
+	ctx->regs[2].offset = XDMA_HOST_CMD_QUEUE_ENDP;
+	ctx->regs[3].name = "host_q_writep";
+	ctx->regs[3].offset = XDMA_HOST_CMD_QUEUE_WRITEP;
+	ctx->regs[4].name = "host_q_readp";
+	ctx->regs[4].offset = XDMA_HOST_CMD_QUEUE_READP;
+	ctx->regs[5].name = "bmc_q_addr";
+	ctx->regs[5].offset = XDMA_BMC_CMD_QUEUE_ADDR;
+	ctx->regs[6].name = "bmc_q_endp";
+	ctx->regs[6].offset = XDMA_BMC_CMD_QUEUE_ENDP;
+	ctx->regs[7].name = "bmc_q_writep";
+	ctx->regs[7].offset = XDMA_BMC_CMD_QUEUE_WRITEP;
+	ctx->regs[8].name = "bmc_q_readp";
+	ctx->regs[8].offset = XDMA_BMC_CMD_QUEUE_READP;
+	ctx->regs[9].name = "control";
+	ctx->regs[9].offset = XDMA_CTRL;
+	ctx->regs[10].name = "status";
+	ctx->regs[10].offset = XDMA_STATUS;
+	ctx->regs[11].name = "ds_frame_size";
+	ctx->regs[11].offset = XDMA_DS_FRAME_SIZE;
+	ctx->regs[12].name = "probe_ds_pcie";
+	ctx->regs[12].offset = XDMA_PROBE_DS_PCIE;
+	ctx->regs[13].name = "probe_us_pcie";
+	ctx->regs[13].offset = XDMA_PROBE_US_PCIE;
+	ctx->regs[14].name = "inprg_ds1";
+	ctx->regs[14].offset = XDMA_INPRG_DS_CMD1;
+	ctx->regs[15].name = "inprg_ds2";
+	ctx->regs[15].offset = XDMA_INPRG_DS_CMD2;
+	ctx->regs[16].name = "inprg_us031";
+	ctx->regs[16].offset = XDMA_INPRG_US_CMD00;
+	ctx->regs[17].name = "inprg_us063";
+	ctx->regs[17].offset = XDMA_INPRG_US_CMD01;
+	ctx->regs[18].name = "inprg_us131";
+	ctx->regs[18].offset = XDMA_INPRG_US_CMD10;
+	ctx->regs[19].name = "inprg_us163";
+	ctx->regs[19].offset = XDMA_INPRG_US_CMD11;
+	ctx->regs[20].name = "inprg_us231";
+	ctx->regs[20].offset = XDMA_INPRG_US_CMD20;
+	ctx->regs[21].name = "inprg_us263";
+	ctx->regs[21].offset = XDMA_INPRG_US_CMD21;
+	ctx->regs[22].name = "vga_q_addr31";
+	ctx->regs[22].offset = XDMA_VGA_CMD_QUEUE_ADDR0;
+	ctx->regs[23].name = "vga_q_addr63";
+	ctx->regs[23].offset = XDMA_VGA_CMD_QUEUE_ADDR1;
+	ctx->regs[24].name = "vga_q_endp";
+	ctx->regs[24].offset = XDMA_VGA_CMD_QUEUE_ENDP;
+	ctx->regs[25].name = "vga_q_writep";
+	ctx->regs[25].offset = XDMA_VGA_CMD_QUEUE_WRITEP;
+	ctx->regs[26].name = "vga_q_readp";
+	ctx->regs[26].offset = XDMA_VGA_CMD_QUEUE_READP;
+	ctx->regs[27].name = "vga_cmd_status";
+	ctx->regs[27].offset = XDMA_VGA_CMD_STATUS;
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
@@ -785,6 +911,7 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 	}
 
 	device_create_file(dev, &dev_attr_pcidev);
+	aspeed_xdma_init_debugfs(ctx);
 
 	return 0;
 }
@@ -793,6 +920,7 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
 {
 	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
 
+	debugfs_remove_recursive(ctx->debugfs_dir);
 	device_remove_file(ctx->dev, &dev_attr_pcidev);
 
 	misc_deregister(&ctx->misc);
-- 
1.8.3.1

