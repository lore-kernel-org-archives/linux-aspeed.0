Return-Path: <linux-aspeed+bounces-991-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D243C35FF7
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Mar 2025 11:21:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZDhlM0dCmz3cYN;
	Fri, 14 Mar 2025 22:21:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741951295;
	cv=none; b=UF63DfbHfq6y76AkWx1J+yRdHYOZdFIAdeJBkQjuQ4QjrjZoqvpTv6dPahjADfXfoD5xIgVluAk3Y34FEma1mcYOqrARtfGLHsJin6J8czDRTAWqj0yMFCUU1SOQGExpt+hD5U8epKolChhfSNYJlPfXw+EUnQ50MCpCeDHrqVaJ0QBTmhoi66IcixpWjOHDtoD2g2jkO1wTU1j2bSR4HXqBY+4/96/Q2ZR3jzq3fRmFiNwh+aYAXLaEYyC2YvsV4reM8b58jL0GoeLtAYIfxpsh4ewcBS0ktJQ+ae6br2sl0z8TK2VHqCTbOedyCKB96IWqIhQj5zfoVd/8dOgwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741951295; c=relaxed/relaxed;
	bh=2jU+whS8vIFLiX4DSxKr/o5Kjorh81ooAej4rrFRn0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEc2wFZPRnAe68Tm1kTayko8OsZZvTLLfFFBsFG+j1hdvn50jVrbZkS6YRANUzpkr1ie00TSs6jEGp/tZmd1MnBJle2qip8bNKueIrtK8Wh3Twyo+Cu0OyyTPB9sfY5gNFIQD03Rm0+GBS1ylZVk+ExMF4YkVQLN4TP6nmZ10MEBc9uDu/uFbqpfZBjFodIfAx2OHZiznUoaKXMbRBZMSxyWaA3d+av1rtLSDR1FBU+rSDulVBDR2nN5y69CrxIJu+hz3asU2KjyoivlDdzGwzi74Nb3QoNIUyiPQIckTU3zi7UIsjWpE84bD9ZVhZQsmISzouLcAH9fvuKXik3dZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZDhlL1Xd6z2xmk
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Mar 2025 22:21:34 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 14 Mar
 2025 19:21:14 +0800
Received: from aspeed-fw03.aspeedtech.com (192.168.10.13) by
 TWMBX01.aspeed.com (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Fri, 14 Mar 2025 19:21:14 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<derek.kiernan@amd.com>, <dragan.cvetic@amd.com>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v4 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Date: Fri, 14 Mar 2025 19:21:13 +0800
Message-ID: <20250314112113.953238-4-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314112113.953238-1-kevin_chen@aspeedtech.com>
References: <20250314112113.953238-1-kevin_chen@aspeedtech.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add LPC PCC controller driver to support POST code capture.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 drivers/misc/Kconfig          |  10 +
 drivers/misc/Makefile         |   1 +
 drivers/misc/aspeed-lpc-pcc.c | 437 ++++++++++++++++++++++++++++++++++
 3 files changed, 448 insertions(+)
 create mode 100644 drivers/misc/aspeed-lpc-pcc.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 56bc72c7ce4a..35c1d2e0c271 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -50,6 +50,16 @@ config AD525X_DPOT_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad525x_dpot-spi.
 
+config ASPEED_LPC_PCC
+	tristate "Aspeed Post Code Capture support"
+	select REGMAP
+	select MFD_SYSCON
+	default ARCH_ASPEED
+	help
+	  Provides a driver to control the LPC PCC interface,
+	  allowing the BMC to capture post code written by the
+	  the host to an arbitrary LPC I/O port.
+
 config DUMMY_IRQ
 	tristate "Dummy IRQ handler"
 	help
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 545aad06d088..4762da7804bf 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_IBMVMC)		+= ibmvmc.o
 obj-$(CONFIG_AD525X_DPOT)	+= ad525x_dpot.o
 obj-$(CONFIG_AD525X_DPOT_I2C)	+= ad525x_dpot-i2c.o
 obj-$(CONFIG_AD525X_DPOT_SPI)	+= ad525x_dpot-spi.o
+obj-$(CONFIG_ASPEED_LPC_PCC)	+= aspeed-lpc-pcc.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
 obj-$(CONFIG_DUMMY_IRQ)		+= dummy-irq.o
 obj-$(CONFIG_ICS932S401)	+= ics932s401.o
diff --git a/drivers/misc/aspeed-lpc-pcc.c b/drivers/misc/aspeed-lpc-pcc.c
new file mode 100644
index 000000000000..61c76cb176bc
--- /dev/null
+++ b/drivers/misc/aspeed-lpc-pcc.c
@@ -0,0 +1,437 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) ASPEED Technology Inc.
+ */
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/fs.h>
+#include <linux/kfifo.h>
+#include <linux/mfd/syscon.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/poll.h>
+#include <linux/regmap.h>
+#include <linux/dma-mapping.h>
+#include <linux/sizes.h>
+
+#define DEVICE_NAME "aspeed-lpc-pcc"
+
+static DEFINE_IDA(aspeed_pcc_ida);
+
+#define HICR5	0x80
+#define HICR5_EN_SNP0W			BIT(0)
+#define HICR5_EN_SNP1W			BIT(2)
+#define HICR6	0x084
+#define   HICR6_EN2BMODE		BIT(19)
+#define SNPWADR	0x090
+#define PCCR6	0x0c4
+#define   PCCR6_DMA_CUR_ADDR		GENMASK(27, 0)
+#define PCCR4	0x0d0
+#define   PCCR4_DMA_ADDRL_MASK		GENMASK(31, 0)
+#define   PCCR4_DMA_ADDRL_SHIFT		0
+#define PCCR5	0x0d4
+#define   PCCR5_DMA_ADDRH_MASK		GENMASK(27, 24)
+#define   PCCR5_DMA_ADDRH_SHIFT		24
+#define   PCCR5_DMA_LEN_MASK		GENMASK(23, 0)
+#define   PCCR5_DMA_LEN_SHIFT		0
+#define HICRB	0x100
+#define   HICRB_ENSNP0D			BIT(14)
+#define   HICRB_ENSNP1D			BIT(15)
+#define PCCR0	0x130
+#define   PCCR0_EN_DMA_INT		BIT(31)
+#define   PCCR0_EN_DMA_MODE		BIT(14)
+#define   PCCR0_ADDR_SEL_MASK		GENMASK(13, 12)
+#define   PCCR0_ADDR_SEL_SHIFT		12
+#define   PCCR0_RX_TRIG_LVL_MASK	GENMASK(10, 8)
+#define   PCCR0_RX_TRIG_LVL_SHIFT	8
+#define   PCCR0_CLR_RX_FIFO		BIT(7)
+#define   PCCR0_MODE_SEL_MASK		GENMASK(5, 4)
+#define   PCCR0_MODE_SEL_SHIFT		4
+#define   PCCR0_EN_RX_TMOUT_INT		BIT(2)
+#define   PCCR0_EN_RX_AVAIL_INT		BIT(1)
+#define   PCCR0_EN			BIT(0)
+#define PCCR1	0x134
+#define   PCCR1_BASE_ADDR_MASK		GENMASK(15, 0)
+#define   PCCR1_BASE_ADDR_SHIFT		0
+#define   PCCR1_DONT_CARE_BITS_MASK	GENMASK(21, 16)
+#define   PCCR1_DONT_CARE_BITS_SHIFT	16
+#define PCCR2	0x138
+#define   PCCR2_INT_STATUS_PATTERN_B	BIT(16)
+#define   PCCR2_INT_STATUS_PATTERN_A	BIT(8)
+#define   PCCR2_INT_STATUS_DMA_DONE	BIT(4)
+#define   PCCR2_INT_STATUS_DATA_RDY	PCCR2_INT_STATUS_DMA_DONE
+#define   PCCR2_INT_STATUS_RX_OVER	BIT(3)
+#define   PCCR2_INT_STATUS_RX_TMOUT	BIT(2)
+#define   PCCR2_INT_STATUS_RX_AVAIL	BIT(1)
+#define PCCR3	0x13c
+#define   PCCR3_FIFO_DATA_MASK		GENMASK(7, 0)
+
+#define PCC_DMA_BUFSZ	(256 * SZ_1K)
+
+enum pcc_fifo_threshold {
+	PCC_FIFO_THR_1_BYTE,
+	PCC_FIFO_THR_1_EIGHTH,
+	PCC_FIFO_THR_2_EIGHTH,
+	PCC_FIFO_THR_3_EIGHTH,
+	PCC_FIFO_THR_4_EIGHTH,
+	PCC_FIFO_THR_5_EIGHTH,
+	PCC_FIFO_THR_6_EIGHTH,
+	PCC_FIFO_THR_7_EIGHTH,
+	PCC_FIFO_THR_8_EIGHTH,
+};
+
+enum pcc_record_mode {
+	PCC_REC_1B,
+	PCC_REC_2B,
+	PCC_REC_4B,
+	PCC_REC_FULL,
+};
+
+enum pcc_port_hbits_select {
+	PCC_PORT_HBITS_SEL_NONE,
+	PCC_PORT_HBITS_SEL_45,
+	PCC_PORT_HBITS_SEL_67,
+	PCC_PORT_HBITS_SEL_89,
+};
+
+struct aspeed_pcc_dma {
+	uint32_t rptr;
+	uint8_t *virt;
+	dma_addr_t addr;
+	uint32_t size;
+};
+
+struct aspeed_pcc_ctrl {
+	struct device *dev;
+	struct regmap *regmap;
+	int irq;
+	uint32_t port;
+	struct aspeed_pcc_dma dma;
+	struct kfifo fifo;
+	wait_queue_head_t wq;
+	struct miscdevice mdev;
+	int mdev_id;
+};
+
+static inline bool is_valid_rec_mode(uint32_t mode)
+{
+	return (mode > PCC_REC_FULL) ? false : true;
+}
+
+static inline bool is_valid_high_bits_select(uint32_t sel)
+{
+	return (sel > PCC_PORT_HBITS_SEL_89) ? false : true;
+}
+
+static ssize_t aspeed_pcc_file_read(struct file *file, char __user *buffer,
+				    size_t count, loff_t *ppos)
+{
+	int rc;
+	unsigned int copied;
+	struct aspeed_pcc_ctrl *pcc = container_of(file->private_data,
+					      struct aspeed_pcc_ctrl,
+					      mdev);
+
+	if (kfifo_is_empty(&pcc->fifo)) {
+		if (file->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		rc = wait_event_interruptible(pcc->wq,
+					      !kfifo_is_empty(&pcc->fifo));
+		if (rc == -ERESTARTSYS)
+			return -EINTR;
+	}
+
+	rc = kfifo_to_user(&pcc->fifo, buffer, count, &copied);
+
+	return rc ? rc : copied;
+}
+
+static __poll_t aspeed_pcc_file_poll(struct file *file,
+				     struct poll_table_struct *pt)
+{
+	struct aspeed_pcc_ctrl *pcc = container_of(file->private_data,
+					      struct aspeed_pcc_ctrl,
+					      mdev);
+
+	poll_wait(file, &pcc->wq, pt);
+
+	return !kfifo_is_empty(&pcc->fifo) ? POLLIN : 0;
+}
+
+static const struct file_operations pcc_fops = {
+	.owner = THIS_MODULE,
+	.read = aspeed_pcc_file_read,
+	.poll = aspeed_pcc_file_poll,
+};
+
+static irqreturn_t aspeed_pcc_dma_isr(int irq, void *arg)
+{
+	uint32_t reg, rptr, wptr;
+	struct aspeed_pcc_ctrl *pcc = (struct aspeed_pcc_ctrl *)arg;
+	struct kfifo *fifo = &pcc->fifo;
+
+	regmap_write_bits(pcc->regmap, PCCR2, PCCR2_INT_STATUS_DMA_DONE, PCCR2_INT_STATUS_DMA_DONE);
+
+	regmap_read(pcc->regmap, PCCR6, &reg);
+	wptr = (reg & PCCR6_DMA_CUR_ADDR) - (pcc->dma.addr & PCCR6_DMA_CUR_ADDR);
+	rptr = pcc->dma.rptr;
+
+	do {
+		if (kfifo_is_full(fifo))
+			kfifo_skip(fifo);
+
+		kfifo_put(fifo, pcc->dma.virt[rptr]);
+
+		rptr = (rptr + 1) % pcc->dma.size;
+	} while (rptr != wptr);
+
+	pcc->dma.rptr = rptr;
+
+	wake_up_interruptible(&pcc->wq);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t aspeed_pcc_isr(int irq, void *arg)
+{
+	uint32_t sts;
+	struct aspeed_pcc_ctrl *pcc = (struct aspeed_pcc_ctrl *)arg;
+
+	regmap_read(pcc->regmap, PCCR2, &sts);
+
+	if (!(sts & (PCCR2_INT_STATUS_RX_TMOUT |
+		     PCCR2_INT_STATUS_RX_AVAIL |
+		     PCCR2_INT_STATUS_DMA_DONE)))
+		return IRQ_NONE;
+
+	return aspeed_pcc_dma_isr(irq, arg);
+}
+
+/*
+ * A2600-15 AP note
+ *
+ * SW workaround to prevent generating Non-Fatal-Error (NFE)
+ * eSPI response when PCC is used for port I/O byte snooping
+ * over eSPI.
+ */
+static int aspeed_a2600_15(struct aspeed_pcc_ctrl *pcc, struct device *dev)
+{
+	u32 hicr5_en, hicrb_en;
+
+	/* abort if snoop is enabled */
+	regmap_read(pcc->regmap, HICR5, &hicr5_en);
+	if (hicr5_en & (HICR5_EN_SNP0W | HICR5_EN_SNP1W)) {
+		dev_err(dev, "A2600-15 should be applied with snoop disabled\n");
+		return -EPERM;
+	}
+
+	/* set SNPWADR of snoop device */
+	regmap_write(pcc->regmap, SNPWADR, pcc->port | ((pcc->port + 2) << 16));
+
+	/* set HICRB[15:14]=11b to enable ACCEPT response for SNPWADR */
+	hicrb_en = HICRB_ENSNP0D | HICRB_ENSNP1D;
+	regmap_update_bits(pcc->regmap, HICRB, hicrb_en, hicrb_en);
+
+	/* set HICR6[19] to extend SNPWADR to 2x range */
+	regmap_update_bits(pcc->regmap, HICR6, HICR6_EN2BMODE, HICR6_EN2BMODE);
+
+	return 0;
+}
+
+static int aspeed_pcc_enable(struct aspeed_pcc_ctrl *pcc, struct device *dev)
+{
+	int rc;
+
+	rc = aspeed_a2600_15(pcc, dev);
+	if (rc)
+		return rc;
+
+	/* record mode: Set 2-Byte mode. */
+	regmap_update_bits(pcc->regmap, PCCR0,
+			   PCCR0_MODE_SEL_MASK,
+			   PCC_REC_2B << PCCR0_MODE_SEL_SHIFT);
+
+	/* port address */
+	regmap_update_bits(pcc->regmap, PCCR1,
+			   PCCR1_BASE_ADDR_MASK,
+			   pcc->port << PCCR1_BASE_ADDR_SHIFT);
+
+	/* Set address high bits selection to 0b01 for address bit[5:4] */
+	regmap_update_bits(pcc->regmap, PCCR0,
+			   PCCR0_ADDR_SEL_MASK,
+			   PCC_PORT_HBITS_SEL_45 << PCCR0_ADDR_SEL_SHIFT);
+
+	/* Set LPC don't care address to 0x3 for port 80~83h */
+	regmap_update_bits(pcc->regmap, PCCR1,
+			   PCCR1_DONT_CARE_BITS_MASK,
+			   0x3 << PCCR1_DONT_CARE_BITS_SHIFT);
+
+	/* set DMA ring buffer size and enable interrupts */
+	regmap_write(pcc->regmap, PCCR4, pcc->dma.addr & 0xffffffff);
+#ifdef CONFIG_ARM64
+	regmap_update_bits(pcc->regmap, PCCR5, PCCR5_DMA_ADDRH_MASK,
+			   (pcc->dma.addr >> 32) << PCCR5_DMA_ADDRH_SHIFT);
+#endif
+	regmap_update_bits(pcc->regmap, PCCR5, PCCR5_DMA_LEN_MASK,
+			   (pcc->dma.size / 4) << PCCR5_DMA_LEN_SHIFT);
+	regmap_update_bits(pcc->regmap, PCCR0,
+			   PCCR0_EN_DMA_INT | PCCR0_EN_DMA_MODE,
+			   PCCR0_EN_DMA_INT | PCCR0_EN_DMA_MODE);
+
+	regmap_update_bits(pcc->regmap, PCCR0, PCCR0_EN, PCCR0_EN);
+
+	return 0;
+}
+
+static int aspeed_pcc_disable(struct aspeed_pcc_ctrl *pcc)
+{
+	/* Disable PCC and DMA Mode for safety */
+	regmap_update_bits(pcc->regmap, PCCR0, PCCR0_EN |  PCCR0_EN_DMA_MODE, 0);
+
+	/* Clear Rx FIFO. */
+	regmap_update_bits(pcc->regmap, PCCR0, PCCR0_CLR_RX_FIFO, 1);
+
+	/* Clear All interrupts status. */
+	regmap_write(pcc->regmap, PCCR2,
+		     PCCR2_INT_STATUS_RX_OVER | PCCR2_INT_STATUS_DMA_DONE |
+		     PCCR2_INT_STATUS_PATTERN_A | PCCR2_INT_STATUS_PATTERN_B);
+
+	return 0;
+}
+
+static int aspeed_pcc_probe(struct platform_device *pdev)
+{
+	int rc;
+	struct aspeed_pcc_ctrl *pcc;
+	struct device *dev = &pdev->dev;
+	uint32_t fifo_size = PAGE_SIZE;
+
+	pcc = devm_kzalloc(dev, sizeof(*pcc), GFP_KERNEL);
+	if (!pcc)
+		return -ENOMEM;
+
+	pcc->regmap = syscon_node_to_regmap(dev->parent->of_node);
+	if (IS_ERR(pcc->regmap))
+		return dev_err_probe(dev, PTR_ERR(pcc->regmap), "Couldn't get regmap\n");
+
+	rc = of_property_read_u32(dev->of_node, "pcc-ports", &pcc->port);
+	if (rc) {
+		dev_err(dev, "no pcc ports configured\n");
+		return rc;
+	}
+
+	rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (rc) {
+		dev_err(dev, "cannot set 64-bits DMA mask\n");
+		return rc;
+	}
+
+	pcc->dma.size = PCC_DMA_BUFSZ;
+	pcc->dma.virt = dmam_alloc_coherent(dev,
+					    pcc->dma.size,
+					    &pcc->dma.addr,
+					    GFP_KERNEL);
+	if (!pcc->dma.virt) {
+		dev_err(dev, "cannot allocate DMA buffer\n");
+		return -ENOMEM;
+	}
+
+	fifo_size = roundup(pcc->dma.size, PAGE_SIZE);
+	rc = kfifo_alloc(&pcc->fifo, fifo_size, GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	/* Disable PCC to clean up DMA buffer before request IRQ. */
+	rc = aspeed_pcc_disable(pcc);
+	if (rc) {
+		dev_err(dev, "Couldn't disable PCC\n");
+		goto err_free_kfifo;
+	}
+
+	pcc->irq = platform_get_irq(pdev, 0);
+	if (pcc->irq < 0) {
+		rc = pcc->irq;
+		goto err_free_kfifo;
+	}
+
+	rc = devm_request_irq(dev, pcc->irq, aspeed_pcc_isr, 0, DEVICE_NAME, pcc);
+	if (rc < 0) {
+		dev_err(dev, "Couldn't request IRQ %d\n", pcc->irq);
+		goto err_free_kfifo;
+	}
+
+	init_waitqueue_head(&pcc->wq);
+
+	pcc->mdev_id = ida_alloc(&aspeed_pcc_ida, GFP_KERNEL);
+	if (pcc->mdev_id < 0) {
+		dev_err(dev, "Couldn't allocate ID\n");
+		goto err_free_kfifo;
+	}
+
+	pcc->mdev.parent = dev;
+	pcc->mdev.minor = MISC_DYNAMIC_MINOR;
+	pcc->mdev.name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME,
+					pcc->mdev_id);
+	pcc->mdev.fops = &pcc_fops;
+	rc = misc_register(&pcc->mdev);
+	if (rc) {
+		dev_err(dev, "Couldn't register misc device\n");
+		goto err_free_ida;
+	}
+
+	rc = aspeed_pcc_enable(pcc, dev);
+	if (rc) {
+		dev_err(dev, "Couldn't enable PCC\n");
+		goto err_dereg_mdev;
+	}
+
+	dev_set_drvdata(dev, pcc);
+
+	return 0;
+
+err_dereg_mdev:
+	misc_deregister(&pcc->mdev);
+
+err_free_ida:
+	ida_free(&aspeed_pcc_ida, pcc->mdev_id);
+
+err_free_kfifo:
+	kfifo_free(&pcc->fifo);
+
+	return rc;
+}
+
+static void aspeed_pcc_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct aspeed_pcc_ctrl *pcc = dev_get_drvdata(dev);
+
+	kfifo_free(&pcc->fifo);
+	ida_free(&aspeed_pcc_ida, pcc->mdev_id);
+	misc_deregister(&pcc->mdev);
+}
+
+static const struct of_device_id aspeed_pcc_table[] = {
+	{ .compatible = "aspeed,ast2600-lpc-pcc" },
+};
+
+static struct platform_driver aspeed_pcc_driver = {
+	.driver = {
+		.name = "aspeed-pcc",
+		.of_match_table = aspeed_pcc_table,
+	},
+	.probe = aspeed_pcc_probe,
+	.remove = aspeed_pcc_remove,
+};
+
+module_platform_driver(aspeed_pcc_driver);
+
+MODULE_AUTHOR("Chia-Wei Wang <chiawei_wang@aspeedtech.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Driver for Aspeed Post Code Capture");
-- 
2.34.1


