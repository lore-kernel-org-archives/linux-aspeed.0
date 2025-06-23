Return-Path: <linux-aspeed+bounces-1539-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4157DC7EE2A
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Jun 2025 02:45:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bQXWQ64CRz2xS9;
	Mon, 23 Jun 2025 12:45:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750646738;
	cv=none; b=L3CIqYEkmOtZmw07q8NAEcy5FO/y0O+ggKF6tMSITqohmLYYSSyJN2Z3qNCR6LTsgZAKE5FNwO3Qsc467eiYt9ogGYWG1Aeo0Tbkg9DfbBLLISXJnayldJJpzPw084sZTWlOJA0NfXycoi3xc2nu2a5TebASNHD+CQKYorQ/z0k81Gs82LjdtbB3D4Jh0rlg8O1DKomxpIVWOb+DfFBtDF8CxE2dTjMv4f6294knc+VL6pyj/mAQfSj2z1JAoJujzPFEwLZQRPL1CP1Gln2IJ9n3Tk7pgJdRnKuqZosg//ZdS9npm0G1GshgGGNvLNxDqXwxnv+EnU+nUhs5l4tm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750646738; c=relaxed/relaxed;
	bh=xmuiRc5Oy+i8T8Djb3XfsZY02vtWdmzEF1dP2C+Yx3w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AG6/kxtnahvW1wNAauTwfzKqRNh8lOVm4WAmskKBXRG4ydlJyLgHasBn/DtQlj/VO2ebZUGTfN+1uXF/UZJ2cyYntAlQBHUZHmjhtApfpqU/4gbhniH7U6TvwrYDjUEo/DMRf+lPfAIXgXTFPY3v6WnV3PAs1wKHkoKP9WYcmPf4vbIwwhab9DAX/Tn72L1OoIXxPBtfJCASyk4HtQQRwQqyQE01puD9avd6YEIU5dsJZiXexefZa5g+P6tn25AsEfrZ+Cf5hgdTSY04UE94EwYnutpbKxT5Fz6vr4JSsGDKeG9RDj3AiKCVyKQKNrpQejQ8i0/YsxaVPZQe0egkuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (unknown [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bQXWP3GRlz2yMt
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Jun 2025 12:45:37 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 23 Jun
 2025 10:44:56 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 23 Jun 2025 10:44:56 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v4 2/2] mailbox: aspeed: add mailbox driver for AST27XX series SoC
Date: Mon, 23 Jun 2025 10:44:56 +0800
Message-ID: <20250623024456.2068370-3-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623024456.2068370-1-jammy_huang@aspeedtech.com>
References: <20250623024456.2068370-1-jammy_huang@aspeedtech.com>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add mailbox controller driver for AST27XX SoCs, which provides
independent tx/rx mailbox between different processors. There are 4
channels for each tx/rx mailbox and each channel has an 32-byte FIFO.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/mailbox/Kconfig           |   8 ++
 drivers/mailbox/Makefile          |   2 +
 drivers/mailbox/ast2700-mailbox.c | 230 ++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+)
 create mode 100644 drivers/mailbox/ast2700-mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 68eeed660a4a..1c38cd570091 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -340,4 +340,12 @@ config THEAD_TH1520_MBOX
 	  kernel is running, and E902 core used for power management among other
 	  things.
 
+config AST2700_MBOX
+	tristate "ASPEED AST2700 IPC driver"
+	depends on ARCH_ASPEED || COMPILE_TEST
+	help
+	  Mailbox driver implementation for ASPEED AST27XX SoCs. This driver
+	  can be used to send message between different processors in SoC.
+	  The driver provides mailbox support for sending interrupts to the
+	  clients. Say Y here if you want to build this driver.
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 13a3448b3271..9a9add9a7548 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -72,3 +72,5 @@ obj-$(CONFIG_QCOM_CPUCP_MBOX)	+= qcom-cpucp-mbox.o
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
 
 obj-$(CONFIG_THEAD_TH1520_MBOX)	+= mailbox-th1520.o
+
+obj-$(CONFIG_AST2700_MBOX)	+= ast2700-mailbox.o
diff --git a/drivers/mailbox/ast2700-mailbox.c b/drivers/mailbox/ast2700-mailbox.c
new file mode 100644
index 000000000000..64638ac67e7a
--- /dev/null
+++ b/drivers/mailbox/ast2700-mailbox.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright Aspeed Technology Inc. (C) 2025. All rights reserved
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/* Each bit in the register represents an IPC ID */
+#define IPCR_TX_TRIG		0x00
+#define IPCR_TX_ENABLE		0x04
+#define IPCR_RX_ENABLE		0x104
+#define IPCR_TX_STATUS		0x08
+#define IPCR_RX_STATUS		0x108
+#define  RX_IRQ(n)		BIT(0 + 1 * (n))
+#define  RX_IRQ_MASK		0xf
+#define IPCR_TX_DATA		0x10
+#define IPCR_RX_DATA		0x110
+
+struct ast2700_mbox_data {
+	u8 num_chans;
+	u8 msg_size;
+};
+
+struct ast2700_mbox {
+	struct mbox_controller mbox;
+	const struct ast2700_mbox_data *drv_data;
+	void __iomem *regs;
+};
+
+static inline int ch_num(struct mbox_chan *chan)
+{
+	return chan - chan->mbox->chans;
+}
+
+static inline int ast2700_mbox_tx_done(struct ast2700_mbox *mb, int idx)
+{
+	return !(readl(mb->regs + IPCR_TX_STATUS) & BIT(idx));
+}
+
+static irqreturn_t ast2700_mbox_irq(int irq, void *p)
+{
+	struct ast2700_mbox *mb = p;
+	void __iomem *data_reg;
+	int num_words;
+	u32 *word_data;
+	u32 status;
+	int n;
+
+	/* Only examine channels that are currently enabled. */
+	status = readl(mb->regs + IPCR_RX_ENABLE) &
+		 readl(mb->regs + IPCR_RX_STATUS);
+
+	if (!(status & RX_IRQ_MASK))
+		return IRQ_NONE;
+
+	for (n = 0; n < mb->mbox.num_chans; ++n) {
+		struct mbox_chan *chan = &mb->mbox.chans[n];
+
+		if (!(status & RX_IRQ(n)))
+			continue;
+
+		/* Read the message data */
+		for (data_reg = mb->regs + IPCR_RX_DATA + mb->drv_data->msg_size * n,
+		     word_data = chan->con_priv,
+		     num_words = (mb->drv_data->msg_size / sizeof(u32));
+		     num_words;
+		     num_words--, data_reg += sizeof(u32), word_data++)
+			*word_data = readl(data_reg);
+
+		mbox_chan_received_data(chan, chan->con_priv);
+
+		/* The IRQ can be cleared only once the FIFO is empty. */
+		writel(RX_IRQ(n), mb->regs + IPCR_RX_STATUS);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int ast2700_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct ast2700_mbox *mb = dev_get_drvdata(chan->mbox->dev);
+	void __iomem *data_reg;
+	u32 *word_data;
+	int num_words;
+	int idx = ch_num(chan);
+
+	if (!(readl(mb->regs + IPCR_TX_ENABLE) & BIT(idx))) {
+		dev_warn(mb->mbox.dev, "%s: Ch-%d not enabled yet\n", __func__, idx);
+		return -EBUSY;
+	}
+
+	if (!(ast2700_mbox_tx_done(mb, idx))) {
+		dev_warn(mb->mbox.dev, "%s: Ch-%d last data has not finished\n", __func__, idx);
+		return -EBUSY;
+	}
+
+	/* Write the message data */
+	for (data_reg = mb->regs + IPCR_TX_DATA + mb->drv_data->msg_size * idx,
+	     word_data = (u32 *)data,
+	     num_words = (mb->drv_data->msg_size / sizeof(u32));
+	     num_words;
+	     num_words--, data_reg += sizeof(u32), word_data++)
+		writel(*word_data, data_reg);
+
+	writel(BIT(idx), mb->regs + IPCR_TX_TRIG);
+	dev_dbg(mb->mbox.dev, "%s: Ch-%d sent\n", __func__, idx);
+
+	return 0;
+}
+
+static int ast2700_mbox_startup(struct mbox_chan *chan)
+{
+	struct ast2700_mbox *mb = dev_get_drvdata(chan->mbox->dev);
+	int idx = ch_num(chan);
+	void __iomem *reg = mb->regs + IPCR_RX_ENABLE;
+
+	writel(readl(reg) | BIT(idx), reg);
+
+	return 0;
+}
+
+static void ast2700_mbox_shutdown(struct mbox_chan *chan)
+{
+	struct ast2700_mbox *mb = dev_get_drvdata(chan->mbox->dev);
+	int idx = ch_num(chan);
+	void __iomem *reg = mb->regs + IPCR_RX_ENABLE;
+
+	writel(readl(reg) & ~BIT(idx), reg);
+}
+
+static bool ast2700_mbox_last_tx_done(struct mbox_chan *chan)
+{
+	struct ast2700_mbox *mb = dev_get_drvdata(chan->mbox->dev);
+	int idx = ch_num(chan);
+
+	return ast2700_mbox_tx_done(mb, idx) ? true : false;
+}
+
+static const struct mbox_chan_ops ast2700_mbox_chan_ops = {
+	.send_data	= ast2700_mbox_send_data,
+	.startup	= ast2700_mbox_startup,
+	.shutdown	= ast2700_mbox_shutdown,
+	.last_tx_done	= ast2700_mbox_last_tx_done,
+};
+
+static int ast2700_mbox_probe(struct platform_device *pdev)
+{
+	struct ast2700_mbox *mb;
+	const struct ast2700_mbox_data *drv_data;
+	struct device *dev = &pdev->dev;
+	int irq, ret;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	drv_data = device_get_match_data(&pdev->dev);
+
+	mb = devm_kzalloc(dev, sizeof(*mb), GFP_KERNEL);
+	if (!mb)
+		return -ENOMEM;
+
+	mb->mbox.chans = devm_kcalloc(&pdev->dev, drv_data->num_chans,
+				      sizeof(*mb->mbox.chans), GFP_KERNEL);
+	if (!mb->mbox.chans)
+		return -ENOMEM;
+
+	/* con_priv of each channel is used to store the message received */
+	for (int i = 0; i < drv_data->num_chans; i++) {
+		mb->mbox.chans[i].con_priv = devm_kcalloc(dev, drv_data->msg_size,
+							  sizeof(u8), GFP_KERNEL);
+		if (!mb->mbox.chans[i].con_priv)
+			return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, mb);
+
+	mb->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mb->regs))
+		return PTR_ERR(mb->regs);
+
+	mb->drv_data = drv_data;
+	mb->mbox.dev = dev;
+	mb->mbox.num_chans = drv_data->num_chans;
+	mb->mbox.ops = &ast2700_mbox_chan_ops;
+	mb->mbox.txdone_irq = false;
+	mb->mbox.txdone_poll = true;
+	mb->mbox.txpoll_period = 5;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, ast2700_mbox_irq, 0, dev_name(dev), mb);
+	if (ret)
+		return ret;
+
+	return devm_mbox_controller_register(dev, &mb->mbox);
+}
+
+static const struct ast2700_mbox_data ast2700_drv_data = {
+	.num_chans = 4,
+	.msg_size = 0x20,
+};
+
+static const struct of_device_id ast2700_mbox_of_match[] = {
+	{ .compatible = "aspeed,ast2700-mailbox", .data = &ast2700_drv_data },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ast2700_mbox_of_match);
+
+static struct platform_driver ast2700_mbox_driver = {
+	.driver = {
+		.name = "ast2700-mailbox",
+		.of_match_table = ast2700_mbox_of_match,
+	},
+	.probe = ast2700_mbox_probe,
+};
+module_platform_driver(ast2700_mbox_driver);
+
+MODULE_AUTHOR("Jammy Huang <jammy_huang@aspeedtech.com>");
+MODULE_DESCRIPTION("ASPEED AST2700 IPC driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


