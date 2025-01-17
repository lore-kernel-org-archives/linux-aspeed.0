Return-Path: <linux-aspeed+bounces-523-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14789C0218A
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Jan 2025 09:52:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZFQg5MgYz3ck3;
	Fri, 17 Jan 2025 20:52:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737107563;
	cv=none; b=Thnmkm2uoj9qbZ8lkSJJBlRfZmvIWHAVJ6VFnQMm4hRKzX09HR+3LDObhS1bNm6bz4cfbEnc5MCi/TLosGXSRKzuoPFnywo5xhIP5djg8DkykEBA/fXMDOnZKkBVH6HmMCS6Hf+CoxHbtWXuH3Svc15ZGsweFG614JrQnqlUkYrefRzzt9YPt9M38GMZ2INT4Gz3KUS1rJEsx9u/vpoBTrH9EKycWnyC2g8yiWSswvjIIlL+aAU526y6lKHUu1PP54Ntht4mTs/dx0x3r51qxKzAbH8oaWqR1Ol15+AtM9A4FDzwRtovFL3cLIvOv4CVzenQRywljiwUtPNvG6aTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737107563; c=relaxed/relaxed;
	bh=NfB7f3IojIs53XvlAc7mDW+MJXr1NdTNOV/1i8v3QTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAbiOn2aiRz33poslzciYeHrzJjhNAPk16oEioSflfSGK6RT+JY+Z0DDcMy4bZ5Vr2w1hf15syyLu4dwQCavuSDauvjsrhNP8op26yb+UvSMCSRCmD2bBTZssDdNTmiIImmINSB69vA4uTBNAuOEHVJs38OIKE5CUYIJ27j2wXCSv2bg+0mu5lIceOCiugFI/io0Vf6I6Z48t6y/IRMEoxiHZkwtmSButO7dwUU7kwDDa/irZu2B3DcvTb/uL7su8QZfLorGCiU8K7DX3NqaKmLeruQxdqkVYUl21yqkSXxs8BtZWJeoNnqIvT3NzKOVDTCwL445enDhWotzBq+aOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZFQg0qpWz2yD5
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 20:52:43 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 17 Jan
 2025 17:52:20 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 17 Jan 2025 17:52:20 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <elbadrym@google.com>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v0 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Date: Fri, 17 Jan 2025 17:52:17 +0800
Message-ID: <20250117095217.661070-4-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117095217.661070-1-kevin_chen@aspeedtech.com>
References: <20250117095217.661070-1-kevin_chen@aspeedtech.com>
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
 drivers/soc/aspeed/Kconfig          |  10 +
 drivers/soc/aspeed/Makefile         |   1 +
 drivers/soc/aspeed/aspeed-lpc-pcc.c | 505 ++++++++++++++++++++++++++++
 3 files changed, 516 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-lpc-pcc.c

diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
index f579ee0b5afa..dff1a82f4201 100644
--- a/drivers/soc/aspeed/Kconfig
+++ b/drivers/soc/aspeed/Kconfig
@@ -52,6 +52,16 @@ config ASPEED_SOCINFO
 	help
 	  Say yes to support decoding of ASPEED BMC information.
 
+config ASPEED_LPC_PCC
+	tristate "Aspeed Post Code Capture support"
+	select REGMAP
+	select MFD_SYSCON
+	default ARCH_ASPEED
+	help
+	  Provides a driver to control the LPC PCC interface,
+	  allowing the BMC to snoop data bytes written by the
+	  the host to an arbitrary LPC I/O port.
+
 endmenu
 
 endif
diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
index b35d74592964..1692350b3512 100644
--- a/drivers/soc/aspeed/Makefile
+++ b/drivers/soc/aspeed/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)		+= aspeed-lpc-snoop.o
 obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
 obj-$(CONFIG_ASPEED_P2A_CTRL)		+= aspeed-p2a-ctrl.o
 obj-$(CONFIG_ASPEED_SOCINFO)		+= aspeed-socinfo.o
+obj-$(CONFIG_ASPEED_LPC_PCC)		+= aspeed-lpc-pcc.o
diff --git a/drivers/soc/aspeed/aspeed-lpc-pcc.c b/drivers/soc/aspeed/aspeed-lpc-pcc.c
new file mode 100644
index 000000000000..156707642224
--- /dev/null
+++ b/drivers/soc/aspeed/aspeed-lpc-pcc.c
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) ASPEED Technology Inc.
+ */
+#include <linux/bitops.h>
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
+struct aspeed_pcc {
+	struct device *dev;
+	struct regmap *regmap;
+	int irq;
+	uint32_t rec_mode;
+	uint32_t port;
+	uint32_t port_xbits;
+	uint32_t port_hbits_select;
+	uint32_t dma_mode;
+	struct aspeed_pcc_dma dma;
+	struct kfifo fifo;
+	wait_queue_head_t wq;
+	struct miscdevice mdev;
+	int mdev_id;
+	bool a2600_15;
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
+	struct aspeed_pcc *pcc = container_of(file->private_data,
+					      struct aspeed_pcc,
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
+	struct aspeed_pcc *pcc = container_of(file->private_data, struct aspeed_pcc, mdev);
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
+	struct aspeed_pcc *pcc = (struct aspeed_pcc *)arg;
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
+	uint32_t sts, reg;
+	struct aspeed_pcc *pcc = (struct aspeed_pcc *)arg;
+	struct kfifo *fifo = &pcc->fifo;
+
+	regmap_read(pcc->regmap, PCCR2, &sts);
+
+	if (!(sts & (PCCR2_INT_STATUS_RX_TMOUT |
+		     PCCR2_INT_STATUS_RX_AVAIL |
+		     PCCR2_INT_STATUS_DMA_DONE)))
+		return IRQ_NONE;
+
+	if (pcc->dma_mode)
+		return aspeed_pcc_dma_isr(irq, arg);
+
+	while (sts & PCCR2_INT_STATUS_DATA_RDY) {
+		regmap_read(pcc->regmap, PCCR3, &reg);
+
+		if (kfifo_is_full(fifo))
+			kfifo_skip(fifo);
+
+		kfifo_put(fifo, reg & PCCR3_FIFO_DATA_MASK);
+
+		regmap_read(pcc->regmap, PCCR2, &sts);
+	}
+
+	wake_up_interruptible(&pcc->wq);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * A2600-15 AP note
+ *
+ * SW workaround to prevent generating Non-Fatal-Error (NFE)
+ * eSPI response when PCC is used for port I/O byte snooping
+ * over eSPI.
+ */
+static int aspeed_a2600_15(struct aspeed_pcc *pcc, struct device *dev)
+{
+	struct device_node *np;
+	u32 hicrb_en;
+
+	/* abort if snoop is enabled */
+	np = of_find_compatible_node(dev->parent->of_node, NULL, "aspeed,ast2600-lpc-snoop");
+	if (np) {
+		if (of_device_is_available(np)) {
+			dev_err(dev, "A2600-15 should be applied with snoop disabled\n");
+			return -EPERM;
+		}
+	}
+
+	/* abort if port is not 4-bytes continuous range */
+	if (pcc->port_xbits != 0x3) {
+		dev_err(dev, "A2600-15 should be applied on 4-bytes continuous I/O address range\n");
+		return -EINVAL;
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
+static int aspeed_pcc_enable(struct aspeed_pcc *pcc, struct device *dev)
+{
+	int rc;
+
+	if (pcc->a2600_15) {
+		rc = aspeed_a2600_15(pcc, dev);
+		if (rc)
+			return rc;
+	}
+
+	/* record mode */
+	regmap_update_bits(pcc->regmap, PCCR0,
+			   PCCR0_MODE_SEL_MASK,
+			   pcc->rec_mode << PCCR0_MODE_SEL_SHIFT);
+
+	/* port address */
+	regmap_update_bits(pcc->regmap, PCCR1,
+			   PCCR1_BASE_ADDR_MASK,
+			   pcc->port << PCCR1_BASE_ADDR_SHIFT);
+
+	/* port address high bits selection or parser control */
+	regmap_update_bits(pcc->regmap, PCCR0,
+			   PCCR0_ADDR_SEL_MASK,
+			   pcc->port_hbits_select << PCCR0_ADDR_SEL_SHIFT);
+
+	/* port address dont care bits */
+	regmap_update_bits(pcc->regmap, PCCR1,
+			   PCCR1_DONT_CARE_BITS_MASK,
+			   pcc->port_xbits << PCCR1_DONT_CARE_BITS_SHIFT);
+
+	/* set DMA ring buffer size and enable interrupts */
+	if (pcc->dma_mode) {
+		regmap_write(pcc->regmap, PCCR4, pcc->dma.addr & 0xffffffff);
+		regmap_update_bits(pcc->regmap, PCCR5, PCCR5_DMA_ADDRH_MASK,
+				   (pcc->dma.addr >> 32) << PCCR5_DMA_ADDRH_SHIFT);
+		regmap_update_bits(pcc->regmap, PCCR5, PCCR5_DMA_LEN_MASK,
+				   (pcc->dma.size / 4) << PCCR5_DMA_LEN_SHIFT);
+		regmap_update_bits(pcc->regmap, PCCR0,
+				   PCCR0_EN_DMA_INT | PCCR0_EN_DMA_MODE,
+				   PCCR0_EN_DMA_INT | PCCR0_EN_DMA_MODE);
+	} else {
+		regmap_update_bits(pcc->regmap, PCCR0, PCCR0_RX_TRIG_LVL_MASK,
+				   PCC_FIFO_THR_4_EIGHTH << PCCR0_RX_TRIG_LVL_SHIFT);
+		regmap_update_bits(pcc->regmap, PCCR0,
+				   PCCR0_EN_RX_TMOUT_INT | PCCR0_EN_RX_AVAIL_INT,
+				   PCCR0_EN_RX_TMOUT_INT | PCCR0_EN_RX_AVAIL_INT);
+	}
+
+	regmap_update_bits(pcc->regmap, PCCR0, PCCR0_EN, PCCR0_EN);
+
+	return 0;
+}
+
+static int aspeed_pcc_probe(struct platform_device *pdev)
+{
+	int rc;
+	struct aspeed_pcc *pcc;
+	struct device *dev = &pdev->dev;
+	uint32_t fifo_size = PAGE_SIZE;
+
+	pcc = devm_kzalloc(&pdev->dev, sizeof(*pcc), GFP_KERNEL);
+	if (!pcc)
+		return -ENOMEM;
+
+	pcc->dev = dev;
+	rc = of_property_read_u32(dev->of_node, "port-addr", &pcc->port);
+	if (rc) {
+		dev_err(dev, "cannot get port address\n");
+		return -ENODEV;
+	}
+
+	/* optional, by default: 0 -> 1-Byte mode */
+	of_property_read_u32(dev->of_node, "rec-mode", &pcc->rec_mode);
+	if (!is_valid_rec_mode(pcc->rec_mode)) {
+		dev_err(dev, "invalid record mode: %u\n",
+			pcc->rec_mode);
+		return -EINVAL;
+	}
+
+	/* optional, by default: 0 -> no don't care bits */
+	of_property_read_u32(dev->of_node, "port-addr-xbits", &pcc->port_xbits);
+
+	/*
+	 * optional, by default: 0 -> no high address bits
+	 *
+	 * Note that when record mode is set to 1-Byte, this
+	 * property is ignored and the corresponding HW bits
+	 * behave as read/write cycle parser control with the
+	 * value set to 0b11
+	 */
+	if (pcc->rec_mode) {
+		of_property_read_u32(dev->of_node, "port-addr-hbits-select",
+				     &pcc->port_hbits_select);
+		if (!is_valid_high_bits_select(pcc->port_hbits_select)) {
+			dev_err(dev, "invalid high address bits selection: %u\n",
+				pcc->port_hbits_select);
+			return -EINVAL;
+		}
+	} else {
+		pcc->port_hbits_select = 0x3;
+	}
+
+	/* AP note A2600-15 */
+	pcc->a2600_15 = of_property_read_bool(dev->of_node, "A2600-15");
+	if (pcc->a2600_15)
+		dev_info(dev, "A2600-15 AP note patch is selected\n");
+
+	rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (rc) {
+		dev_err(dev, "cannot set 64-bits DMA mask\n");
+		return rc;
+	}
+
+	pcc->dma_mode = of_property_read_bool(dev->of_node, "dma-mode");
+	if (pcc->dma_mode) {
+		pcc->dma.size = PCC_DMA_BUFSZ;
+		pcc->dma.virt = dmam_alloc_coherent(dev,
+						    pcc->dma.size,
+						    &pcc->dma.addr,
+						    GFP_KERNEL);
+		if (!pcc->dma.virt) {
+			dev_err(dev, "cannot allocate DMA buffer\n");
+			return -ENOMEM;
+		}
+
+		fifo_size = roundup(pcc->dma.size, PAGE_SIZE);
+	}
+
+	rc = kfifo_alloc(&pcc->fifo, fifo_size, GFP_KERNEL);
+	if (rc) {
+		dev_err(dev, "cannot allocate kFIFO\n");
+		return -ENOMEM;
+	}
+
+	pcc->regmap = syscon_node_to_regmap(pdev->dev.parent->of_node);
+	if (IS_ERR(pcc->regmap)) {
+		dev_err(dev, "cannot map register\n");
+		return -ENODEV;
+	}
+
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
+	pcc->irq = platform_get_irq(pdev, 0);
+	if (pcc->irq < 0) {
+		dev_err(dev, "cannot get IRQ\n");
+		rc = -ENODEV;
+		goto err_free_kfifo;
+	}
+
+	rc = devm_request_irq(dev, pcc->irq, aspeed_pcc_isr, 0, DEVICE_NAME, pcc);
+	if (rc < 0) {
+		dev_err(dev, "cannot request IRQ handler\n");
+		goto err_free_kfifo;
+	}
+
+	init_waitqueue_head(&pcc->wq);
+
+	pcc->mdev_id = ida_alloc(&aspeed_pcc_ida, GFP_KERNEL);
+	if (pcc->mdev_id < 0) {
+		dev_err(dev, "cannot allocate ID\n");
+		return pcc->mdev_id;
+	}
+
+	pcc->mdev.parent = dev;
+	pcc->mdev.minor = MISC_DYNAMIC_MINOR;
+	pcc->mdev.name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME,
+					pcc->mdev_id);
+	pcc->mdev.fops = &pcc_fops;
+	rc = misc_register(&pcc->mdev);
+	if (rc) {
+		dev_err(dev, "cannot register misc device\n");
+		goto err_free_kfifo;
+	}
+
+	rc = aspeed_pcc_enable(pcc, dev);
+	if (rc) {
+		dev_err(dev, "cannot enable PCC\n");
+		goto err_dereg_mdev;
+	}
+
+	dev_set_drvdata(&pdev->dev, pcc);
+
+	dev_info(dev, "module loaded\n");
+
+	return 0;
+
+err_dereg_mdev:
+	misc_deregister(&pcc->mdev);
+
+err_free_kfifo:
+	kfifo_free(&pcc->fifo);
+
+	return rc;
+}
+
+static int aspeed_pcc_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct aspeed_pcc *pcc = dev_get_drvdata(dev);
+
+	kfifo_free(&pcc->fifo);
+	misc_deregister(&pcc->mdev);
+
+	return 0;
+}
+
+static const struct of_device_id aspeed_pcc_table[] = {
+	{ .compatible = "aspeed,ast2600-lpc-pcc" },
+	{ },
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


