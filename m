Return-Path: <linux-aspeed+bounces-3658-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D4C105F78B
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Mar 2026 10:09:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXKv32X4tz3cKj;
	Fri, 13 Mar 2026 21:08:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773396511;
	cv=none; b=FXvtHgowDUYh9JXHZeVYAgIpZXBRrN43vcIORfDWQj+fABCjTrwiiOhdV6IPS/XWg6TMSaDGK9Lo5KYeGiUNn83b7Pf3d+32qlJIOoKc97zbPU9Eh+2qcO/vyMI1fon8Zmze5c2X5t2muN8xT/dcVuIKb80zPqG7gVKPyGIKiFQsD4SdMTf15Q8yhUSKd/z0+AI0sITqOFBsIel0f18LJ6GELD4cXB67jszAhvWdbfCHcV12/kZrmwa02f86k4soFkgvyRsxUeq8wdW5sEswHyBwAd9NewkB0jtZeYWu98S4ln215pSLPDJFTF0LZrNYHAAUGZs9vU/84WjwnQkoIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773396511; c=relaxed/relaxed;
	bh=l05LsUh22lqkZOYTaWW9LAZLN3zw9BhFujh62ymikqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Qifv6mictFmXdkTa+c032rzkj0XvoINdkXhR/VsmGL3vQVW1uOt7yPvzwoGJO/2eRFGG/Q5CZVl1tYM6FUdnZTUVi8I6FHmlGU2aa/Ed9x5qkkTe5eYgfLWCeYViv14LFE0ARlHABeMTM/u+dWQyNlRyGtwliKw6yl/4Wxwr73WlKQW/aoMdIa9zFP2Ko9o6FTdATDn71aLiqUhJ/NXKS1n4CjUwNuyvkCuZCElSbARE26AAd8W/OaMq03oL/j6MNo0mJk/NW9BZoRpzzLCNyv7M/9bKF1X+5GmnVUw8ODSON9k/ZgpYGJ7UuunNzPy1lFQbPiu3Fr2FgdgbiqbWhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXKv23Xxsz3cLQ;
	Fri, 13 Mar 2026 21:08:30 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Mar
 2026 18:08:12 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Mar 2026 18:08:12 +0800
From: aspeedyh <yh_chung@aspeedtech.com>
Date: Fri, 13 Mar 2026 18:07:38 +0800
Subject: [PATCH 3/7] soc: aspeed: Add AST2600 peripheral channel port I/O
 support
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260313-upstream_espi-v1-3-9504428e1f43@aspeedtech.com>
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
In-Reply-To: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, <maciej.lawniczak@intel.com>, aspeedyh
	<yh_chung@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773396491; l=19063;
 i=yh_chung@aspeedtech.com; s=20260313; h=from:subject:message-id;
 bh=uPUSEpMtPwe/OxAok3JqcRQkaItbwtrK4e9obTKykTA=;
 b=O9+MCrlq/J2gFEtsK5GXWNrlTOz+Km7Qy+Zy/W5IOXqwalsK6aSGcBcpqtb4sB71h7vgxDx2/
 P5plA/VZUeqAQnEmGpKXFvERgaDSGBhe8avNRh53/FLgpp+E64VH6n4
X-Developer-Key: i=yh_chung@aspeedtech.com; a=ed25519;
 pk=o71dz0J8lpN+v0f3Mk4gT9PfVngADPC1Pex4aK6VigM=

Add initial support for the AST2600 eSPI peripheral channel handling of
port I/O transactions used for LPC-style accesses.

This patch does not yet implement peripheral memory read or write
cycles. Support for those transactions will be added in a follow-up
patch once the remaining transport and buffer handling pieces are in
place.

Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
---
 drivers/soc/aspeed/espi/Makefile       |   2 +-
 drivers/soc/aspeed/espi/aspeed-espi.c  |  24 +++
 drivers/soc/aspeed/espi/ast2600-espi.c | 139 ++++++++++++++++
 drivers/soc/aspeed/espi/ast2600-espi.h | 291 +++++++++++++++++++++++++++++++++
 4 files changed, 455 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/espi/Makefile b/drivers/soc/aspeed/espi/Makefile
index d96dc030e23b..30f9dbf92a0f 100644
--- a/drivers/soc/aspeed/espi/Makefile
+++ b/drivers/soc/aspeed/espi/Makefile
@@ -1 +1 @@
-obj-y += aspeed-espi.o
+obj-y += aspeed-espi.o ast2600-espi.o
diff --git a/drivers/soc/aspeed/espi/aspeed-espi.c b/drivers/soc/aspeed/espi/aspeed-espi.c
index 15d58b38bbe4..e369738119bc 100644
--- a/drivers/soc/aspeed/espi/aspeed-espi.c
+++ b/drivers/soc/aspeed/espi/aspeed-espi.c
@@ -13,15 +13,28 @@
 #include <linux/reset.h>
 
 #include "aspeed-espi.h"
+#include "ast2600-espi.h"
 
 struct aspeed_espi_ops {
 	void (*espi_pre_init)(struct aspeed_espi *espi);
 	void (*espi_post_init)(struct aspeed_espi *espi);
 	void (*espi_deinit)(struct aspeed_espi *espi);
+	int (*espi_perif_probe)(struct aspeed_espi *espi);
+	int (*espi_perif_remove)(struct aspeed_espi *espi);
 	irqreturn_t (*espi_isr)(int irq, void *espi);
 };
 
+static const struct aspeed_espi_ops aspeed_espi_ast2600_ops = {
+	.espi_pre_init = ast2600_espi_pre_init,
+	.espi_post_init = ast2600_espi_post_init,
+	.espi_deinit = ast2600_espi_deinit,
+	.espi_perif_probe = ast2600_espi_perif_probe,
+	.espi_perif_remove = ast2600_espi_perif_remove,
+	.espi_isr = ast2600_espi_isr,
+};
+
 static const struct of_device_id aspeed_espi_of_matches[] = {
+	{ .compatible = "aspeed,ast2600-espi", .data = &aspeed_espi_ast2600_ops },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, aspeed_espi_of_matches);
@@ -88,6 +101,14 @@ static int aspeed_espi_probe(struct platform_device *pdev)
 	if (espi->ops->espi_pre_init)
 		espi->ops->espi_pre_init(espi);
 
+	if (espi->ops->espi_perif_probe) {
+		rc = espi->ops->espi_perif_probe(espi);
+		if (rc) {
+			dev_err(dev, "cannot init peripheral channel, rc=%d\n", rc);
+			goto err_deinit;
+		}
+	}
+
 	rc = devm_request_irq(dev, espi->irq, espi->ops->espi_isr, 0,
 			      dev_name(dev), espi);
 	if (rc) {
@@ -121,6 +142,9 @@ static void aspeed_espi_remove(struct platform_device *pdev)
 	if (!espi)
 		return;
 
+	if (espi->ops->espi_perif_remove)
+		espi->ops->espi_perif_remove(espi);
+
 	if (espi->ops->espi_deinit)
 		espi->ops->espi_deinit(espi);
 
diff --git a/drivers/soc/aspeed/espi/ast2600-espi.c b/drivers/soc/aspeed/espi/ast2600-espi.c
new file mode 100644
index 000000000000..8effd0404d1f
--- /dev/null
+++ b/drivers/soc/aspeed/espi/ast2600-espi.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright Aspeed Technology Inc.
+ */
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/reset.h>
+
+#include "aspeed-espi.h"
+#include "ast2600-espi.h"
+
+static void ast2600_espi_perif_isr(struct aspeed_espi *espi)
+{
+	u32 sts;
+
+	sts = readl(espi->regs + ESPI_INT_STS);
+
+	if (sts & ESPI_INT_STS_PERIF_PC_RX_CMPLT)
+		writel(ESPI_INT_STS_PERIF_PC_RX_CMPLT, espi->regs + ESPI_INT_STS);
+}
+
+static void ast2600_espi_perif_sw_reset(struct aspeed_espi *espi)
+{
+	u32 reg;
+
+	reg = readl(espi->regs + ESPI_CTRL);
+	reg &= ~(ESPI_CTRL_PERIF_NP_TX_SW_RST
+		 | ESPI_CTRL_PERIF_NP_RX_SW_RST
+		 | ESPI_CTRL_PERIF_PC_TX_SW_RST
+		 | ESPI_CTRL_PERIF_PC_RX_SW_RST
+		 | ESPI_CTRL_PERIF_NP_TX_DMA_EN
+		 | ESPI_CTRL_PERIF_PC_TX_DMA_EN
+		 | ESPI_CTRL_PERIF_PC_RX_DMA_EN
+		 | ESPI_CTRL_PERIF_SW_RDY);
+	writel(reg, espi->regs + ESPI_CTRL);
+
+	udelay(1);
+
+	reg |= (ESPI_CTRL_PERIF_NP_TX_SW_RST
+		| ESPI_CTRL_PERIF_NP_RX_SW_RST
+		| ESPI_CTRL_PERIF_PC_TX_SW_RST
+		| ESPI_CTRL_PERIF_PC_RX_SW_RST);
+	writel(reg, espi->regs + ESPI_CTRL);
+}
+
+static void ast2600_espi_perif_reset(struct aspeed_espi *espi)
+{
+	u32 reg;
+
+	writel(ESPI_INT_EN_PERIF, espi->regs + ESPI_INT_EN_CLR);
+	writel(ESPI_INT_STS_PERIF, espi->regs + ESPI_INT_STS);
+
+	writel(0x0, espi->regs + ESPI_MMBI_INT_EN);
+	writel(0xffffffff, espi->regs + ESPI_MMBI_INT_STS);
+
+	reg = readl(espi->regs + ESPI_CTRL2);
+	reg &= ~(ESPI_CTRL2_MCYC_RD_DIS_WDT | ESPI_CTRL2_MCYC_WR_DIS_WDT);
+	writel(reg, espi->regs + ESPI_CTRL2);
+
+	reg = readl(espi->regs + ESPI_CTRL);
+	reg &= ~(ESPI_CTRL_PERIF_NP_TX_DMA_EN
+		 | ESPI_CTRL_PERIF_PC_TX_DMA_EN
+		 | ESPI_CTRL_PERIF_PC_RX_DMA_EN
+		 | ESPI_CTRL_PERIF_SW_RDY);
+	writel(reg, espi->regs + ESPI_CTRL);
+
+	reg = readl(espi->regs + ESPI_CTRL) | ESPI_CTRL_PERIF_SW_RDY;
+	writel(reg, espi->regs + ESPI_CTRL);
+}
+
+int ast2600_espi_perif_probe(struct aspeed_espi *espi)
+{
+	ast2600_espi_perif_reset(espi);
+	return 0;
+}
+
+int ast2600_espi_perif_remove(struct aspeed_espi *espi)
+{
+	u32 reg;
+
+	writel(ESPI_INT_EN_PERIF, espi->regs + ESPI_INT_EN_CLR);
+
+	reg = readl(espi->regs + ESPI_CTRL2);
+	reg |= (ESPI_CTRL2_MCYC_RD_DIS | ESPI_CTRL2_MCYC_WR_DIS);
+	writel(reg, espi->regs + ESPI_CTRL2);
+
+	reg = readl(espi->regs + ESPI_CTRL);
+	reg &= ~(ESPI_CTRL_PERIF_NP_TX_DMA_EN
+		 | ESPI_CTRL_PERIF_PC_TX_DMA_EN
+		 | ESPI_CTRL_PERIF_PC_RX_DMA_EN
+		 | ESPI_CTRL_PERIF_SW_RDY);
+	writel(reg, espi->regs + ESPI_CTRL);
+	return 0;
+}
+
+/* global control */
+irqreturn_t ast2600_espi_isr(int irq, void *arg)
+{
+	struct aspeed_espi *espi;
+	u32 sts;
+
+	espi = (struct aspeed_espi *)arg;
+	sts = readl(espi->regs + ESPI_INT_STS);
+
+	if (!sts)
+		return IRQ_NONE;
+
+	if (sts & ESPI_INT_STS_PERIF)
+		ast2600_espi_perif_isr(espi);
+
+	if (sts & ESPI_INT_STS_RST_DEASSERT) {
+		/* this will clear all interrupt enable and status */
+		reset_control_assert(espi->rst);
+		reset_control_deassert(espi->rst);
+
+		ast2600_espi_perif_sw_reset(espi);
+		ast2600_espi_perif_reset(espi);
+
+		/* re-enable eSPI_RESET# interrupt */
+		writel(ESPI_INT_EN_RST_DEASSERT, espi->regs + ESPI_INT_EN);
+	}
+
+	return IRQ_HANDLED;
+}
+
+void ast2600_espi_pre_init(struct aspeed_espi *espi)
+{
+	writel(ESPI_INT_EN_RST_DEASSERT, espi->regs + ESPI_INT_EN_CLR);
+}
+
+void ast2600_espi_post_init(struct aspeed_espi *espi)
+{
+	writel(ESPI_INT_EN_RST_DEASSERT, espi->regs + ESPI_INT_EN);
+}
+
+void ast2600_espi_deinit(struct aspeed_espi *espi)
+{
+	writel(ESPI_INT_EN_RST_DEASSERT, espi->regs + ESPI_INT_EN_CLR);
+}
diff --git a/drivers/soc/aspeed/espi/ast2600-espi.h b/drivers/soc/aspeed/espi/ast2600-espi.h
new file mode 100644
index 000000000000..309479ee1187
--- /dev/null
+++ b/drivers/soc/aspeed/espi/ast2600-espi.h
@@ -0,0 +1,291 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Register definitions for Aspeed AST2600 eSPI controller
+ * Copyright 2026 Aspeed Technology Inc.
+ */
+#ifndef AST2600_ESPI_H
+#define AST2600_ESPI_H
+
+#include <linux/bits.h>
+#include <linux/irqreturn.h>
+#include "aspeed-espi.h"
+
+/* registers */
+#define ESPI_CTRL				0x000
+#define   ESPI_CTRL_FLASH_TX_SW_RST		BIT(31)
+#define   ESPI_CTRL_FLASH_RX_SW_RST		BIT(30)
+#define   ESPI_CTRL_OOB_TX_SW_RST		BIT(29)
+#define   ESPI_CTRL_OOB_RX_SW_RST		BIT(28)
+#define   ESPI_CTRL_PERIF_NP_TX_SW_RST		BIT(27)
+#define   ESPI_CTRL_PERIF_NP_RX_SW_RST		BIT(26)
+#define   ESPI_CTRL_PERIF_PC_TX_SW_RST		BIT(25)
+#define   ESPI_CTRL_PERIF_PC_RX_SW_RST		BIT(24)
+#define   ESPI_CTRL_FLASH_TX_DMA_EN		BIT(23)
+#define   ESPI_CTRL_FLASH_RX_DMA_EN		BIT(22)
+#define   ESPI_CTRL_OOB_TX_DMA_EN		BIT(21)
+#define   ESPI_CTRL_OOB_RX_DMA_EN		BIT(20)
+#define   ESPI_CTRL_PERIF_NP_TX_DMA_EN		BIT(19)
+#define   ESPI_CTRL_PERIF_PC_TX_DMA_EN		BIT(17)
+#define   ESPI_CTRL_PERIF_PC_RX_DMA_EN		BIT(16)
+#define   ESPI_CTRL_FLASH_EDAF_MODE		GENMASK(11, 10)
+#define   ESPI_CTRL_VW_GPIO_SW			BIT(9)
+#define   ESPI_CTRL_FLASH_SW_RDY		BIT(7)
+#define   ESPI_CTRL_OOB_SW_RDY			BIT(4)
+#define   ESPI_CTRL_VW_SW_RDY			BIT(3)
+#define   ESPI_CTRL_PERIF_SW_RDY		BIT(1)
+#define ESPI_STS				0x004
+#define ESPI_INT_STS				0x008
+#define   ESPI_INT_STS_RST_DEASSERT		BIT(31)
+#define   ESPI_INT_STS_OOB_RX_TMOUT		BIT(23)
+#define   ESPI_INT_STS_VW_SYSEVT1		BIT(22)
+#define   ESPI_INT_STS_FLASH_TX_ERR		BIT(21)
+#define   ESPI_INT_STS_OOB_TX_ERR		BIT(20)
+#define   ESPI_INT_STS_FLASH_TX_ABT		BIT(19)
+#define   ESPI_INT_STS_OOB_TX_ABT		BIT(18)
+#define   ESPI_INT_STS_PERIF_NP_TX_ABT		BIT(17)
+#define   ESPI_INT_STS_PERIF_PC_TX_ABT		BIT(16)
+#define   ESPI_INT_STS_FLASH_RX_ABT		BIT(15)
+#define   ESPI_INT_STS_OOB_RX_ABT		BIT(14)
+#define   ESPI_INT_STS_PERIF_NP_RX_ABT		BIT(13)
+#define   ESPI_INT_STS_PERIF_PC_RX_ABT		BIT(12)
+#define   ESPI_INT_STS_PERIF_NP_TX_ERR		BIT(11)
+#define   ESPI_INT_STS_PERIF_PC_TX_ERR		BIT(10)
+#define   ESPI_INT_STS_VW_GPIO			BIT(9)
+#define   ESPI_INT_STS_VW_SYSEVT		BIT(8)
+#define   ESPI_INT_STS_FLASH_TX_CMPLT		BIT(7)
+#define   ESPI_INT_STS_FLASH_RX_CMPLT		BIT(6)
+#define   ESPI_INT_STS_OOB_TX_CMPLT		BIT(5)
+#define   ESPI_INT_STS_OOB_RX_CMPLT		BIT(4)
+#define   ESPI_INT_STS_PERIF_NP_TX_CMPLT	BIT(3)
+#define   ESPI_INT_STS_PERIF_PC_TX_CMPLT	BIT(1)
+#define   ESPI_INT_STS_PERIF_PC_RX_CMPLT	BIT(0)
+#define ESPI_INT_EN				0x00c
+#define   ESPI_INT_EN_RST_DEASSERT		BIT(31)
+#define   ESPI_INT_EN_OOB_RX_TMOUT		BIT(23)
+#define   ESPI_INT_EN_VW_SYSEVT1		BIT(22)
+#define   ESPI_INT_EN_FLASH_TX_ERR		BIT(21)
+#define   ESPI_INT_EN_OOB_TX_ERR		BIT(20)
+#define   ESPI_INT_EN_FLASH_TX_ABT		BIT(19)
+#define   ESPI_INT_EN_OOB_TX_ABT		BIT(18)
+#define   ESPI_INT_EN_PERIF_NP_TX_ABT		BIT(17)
+#define   ESPI_INT_EN_PERIF_PC_TX_ABT		BIT(16)
+#define   ESPI_INT_EN_FLASH_RX_ABT		BIT(15)
+#define   ESPI_INT_EN_OOB_RX_ABT		BIT(14)
+#define   ESPI_INT_EN_PERIF_NP_RX_ABT		BIT(13)
+#define   ESPI_INT_EN_PERIF_PC_RX_ABT		BIT(12)
+#define   ESPI_INT_EN_PERIF_NP_TX_ERR		BIT(11)
+#define   ESPI_INT_EN_PERIF_PC_TX_ERR		BIT(10)
+#define   ESPI_INT_EN_VW_GPIO			BIT(9)
+#define   ESPI_INT_EN_VW_SYSEVT			BIT(8)
+#define   ESPI_INT_EN_FLASH_TX_CMPLT		BIT(7)
+#define   ESPI_INT_EN_FLASH_RX_CMPLT		BIT(6)
+#define   ESPI_INT_EN_OOB_TX_CMPLT		BIT(5)
+#define   ESPI_INT_EN_OOB_RX_CMPLT		BIT(4)
+#define   ESPI_INT_EN_PERIF_NP_TX_CMPLT		BIT(3)
+#define   ESPI_INT_EN_PERIF_PC_TX_CMPLT		BIT(1)
+#define   ESPI_INT_EN_PERIF_PC_RX_CMPLT		BIT(0)
+#define ESPI_PERIF_PC_RX_DMA			0x010
+#define ESPI_PERIF_PC_RX_CTRL			0x014
+#define   ESPI_PERIF_PC_RX_CTRL_SERV_PEND	BIT(31)
+#define   ESPI_PERIF_PC_RX_CTRL_LEN		GENMASK(23, 12)
+#define   ESPI_PERIF_PC_RX_CTRL_TAG		GENMASK(11, 8)
+#define   ESPI_PERIF_PC_RX_CTRL_CYC		GENMASK(7, 0)
+#define ESPI_PERIF_PC_RX_DATA			0x018
+#define ESPI_PERIF_PC_TX_DMA			0x020
+#define ESPI_PERIF_PC_TX_CTRL			0x024
+#define	  ESPI_PERIF_PC_TX_CTRL_TRIG_PEND	BIT(31)
+#define	  ESPI_PERIF_PC_TX_CTRL_LEN		GENMASK(23, 12)
+#define	  ESPI_PERIF_PC_TX_CTRL_TAG		GENMASK(11, 8)
+#define	  ESPI_PERIF_PC_TX_CTRL_CYC		GENMASK(7, 0)
+#define ESPI_PERIF_PC_TX_DATA			0x028
+#define ESPI_PERIF_NP_TX_DMA			0x030
+#define ESPI_PERIF_NP_TX_CTRL			0x034
+#define   ESPI_PERIF_NP_TX_CTRL_TRIG_PEND	BIT(31)
+#define	  ESPI_PERIF_NP_TX_CTRL_LEN		GENMASK(23, 12)
+#define	  ESPI_PERIF_NP_TX_CTRL_TAG		GENMASK(11, 8)
+#define	  ESPI_PERIF_NP_TX_CTRL_CYC		GENMASK(7, 0)
+#define ESPI_PERIF_NP_TX_DATA			0x038
+#define ESPI_OOB_RX_DMA				0x040
+#define ESPI_OOB_RX_CTRL			0x044
+#define	  ESPI_OOB_RX_CTRL_SERV_PEND		BIT(31)
+#define	  ESPI_OOB_RX_CTRL_LEN			GENMASK(23, 12)
+#define	  ESPI_OOB_RX_CTRL_TAG			GENMASK(11, 8)
+#define	  ESPI_OOB_RX_CTRL_CYC			GENMASK(7, 0)
+#define ESPI_OOB_RX_DATA			0x048
+#define ESPI_OOB_TX_DMA				0x050
+#define ESPI_OOB_TX_CTRL			0x054
+#define	  ESPI_OOB_TX_CTRL_TRIG_PEND		BIT(31)
+#define	  ESPI_OOB_TX_CTRL_LEN			GENMASK(23, 12)
+#define	  ESPI_OOB_TX_CTRL_TAG			GENMASK(11, 8)
+#define	  ESPI_OOB_TX_CTRL_CYC			GENMASK(7, 0)
+#define ESPI_OOB_TX_DATA			0x058
+#define ESPI_FLASH_RX_DMA			0x060
+#define ESPI_FLASH_RX_CTRL			0x064
+#define	  ESPI_FLASH_RX_CTRL_SERV_PEND		BIT(31)
+#define	  ESPI_FLASH_RX_CTRL_LEN		GENMASK(23, 12)
+#define	  ESPI_FLASH_RX_CTRL_TAG		GENMASK(11, 8)
+#define	  ESPI_FLASH_RX_CTRL_CYC		GENMASK(7, 0)
+#define ESPI_FLASH_RX_DATA			0x068
+#define ESPI_FLASH_TX_DMA			0x070
+#define ESPI_FLASH_TX_CTRL			0x074
+#define	  ESPI_FLASH_TX_CTRL_TRIG_PEND		BIT(31)
+#define	  ESPI_FLASH_TX_CTRL_LEN		GENMASK(23, 12)
+#define	  ESPI_FLASH_TX_CTRL_TAG		GENMASK(11, 8)
+#define	  ESPI_FLASH_TX_CTRL_CYC		GENMASK(7, 0)
+#define ESPI_FLASH_TX_DATA			0x078
+#define ESPI_CTRL2				0x080
+#define   ESPI_CTRL2_VW_TX_SORT			BIT(30)
+#define   ESPI_CTRL2_MCYC_RD_DIS_WDT		BIT(11)
+#define   ESPI_CTRL2_MCYC_WR_DIS_WDT		BIT(10)
+#define   ESPI_CTRL2_MCYC_RD_DIS		BIT(6)
+#define   ESPI_CTRL2_MMBI_RD_DIS		ESPI_CTRL2_MCYC_RD_DIS
+#define   ESPI_CTRL2_MCYC_WR_DIS		BIT(4)
+#define   ESPI_CTRL2_MMBI_WR_DIS		ESPI_CTRL2_MCYC_WR_DIS
+#define ESPI_PERIF_MCYC_SADDR			0x084
+#define ESPI_PERIF_MMBI_SADDR			ESPI_PERIF_MCYC_SADDR
+#define ESPI_PERIF_MCYC_TADDR			0x088
+#define ESPI_PERIF_MMBI_TADDR			ESPI_PERIF_MCYC_TADDR
+#define ESPI_PERIF_MCYC_MASK			0x08c
+#define ESPI_PERIF_MMBI_MASK			ESPI_PERIF_MCYC_MASK
+#define ESPI_FLASH_EDAF_TADDR			0x090
+#define   ESPI_FLASH_EDAF_TADDR_BASE		GENMASK(31, 24)
+#define   ESPI_FLASH_EDAF_TADDR_MASK		GENMASK(15, 8)
+#define ESPI_VW_SYSEVT_INT_EN			0x094
+#define ESPI_VW_SYSEVT				0x098
+#define   ESPI_VW_SYSEVT_HOST_RST_ACK		BIT(27)
+#define   ESPI_VW_SYSEVT_RST_CPU_INIT		BIT(26)
+#define   ESPI_VW_SYSEVT_SLV_BOOT_STS		BIT(23)
+#define   ESPI_VW_SYSEVT_NON_FATAL_ERR		BIT(22)
+#define   ESPI_VW_SYSEVT_FATAL_ERR		BIT(21)
+#define   ESPI_VW_SYSEVT_SLV_BOOT_DONE		BIT(20)
+#define   ESPI_VW_SYSEVT_OOB_RST_ACK		BIT(16)
+#define   ESPI_VW_SYSEVT_NMI_OUT		BIT(10)
+#define   ESPI_VW_SYSEVT_SMI_OUT		BIT(9)
+#define   ESPI_VW_SYSEVT_HOST_RST_WARN		BIT(8)
+#define   ESPI_VW_SYSEVT_OOB_RST_WARN		BIT(6)
+#define   ESPI_VW_SYSEVT_PLTRSTN		BIT(5)
+#define   ESPI_VW_SYSEVT_SUSPEND		BIT(4)
+#define   ESPI_VW_SYSEVT_S5_SLEEP		BIT(2)
+#define   ESPI_VW_SYSEVT_S4_SLEEP		BIT(1)
+#define   ESPI_VW_SYSEVT_S3_SLEEP		BIT(0)
+#define ESPI_VW_GPIO_VAL			0x09c
+#define ESPI_GEN_CAP_N_CONF			0x0a0
+#define ESPI_CH0_CAP_N_CONF			0x0a4
+#define ESPI_CH1_CAP_N_CONF			0x0a8
+#define ESPI_CH2_CAP_N_CONF			0x0ac
+#define ESPI_CH3_CAP_N_CONF			0x0b0
+#define ESPI_CH3_CAP_N_CONF2			0x0b4
+#define ESPI_VW_GPIO_DIR			0x0c0
+#define ESPI_VW_GPIO_GRP			0x0c4
+#define ESPI_INT_EN_CLR				0x0fc
+#define ESPI_VW_SYSEVT1_INT_EN			0x100
+#define ESPI_VW_SYSEVT1				0x104
+#define   ESPI_VW_SYSEVT1_SUSPEND_ACK		BIT(20)
+#define   ESPI_VW_SYSEVT1_SUSPEND_WARN		BIT(0)
+#define ESPI_VW_SYSEVT_INT_T0			0x110
+#define ESPI_VW_SYSEVT_INT_T1			0x114
+#define ESPI_VW_SYSEVT_INT_T2			0x118
+#define ESPI_VW_SYSEVT_INT_STS			0x11c
+#define ESPI_VW_SYSEVT1_INT_T0			0x120
+#define ESPI_VW_SYSEVT1_INT_T1			0x124
+#define ESPI_VW_SYSEVT1_INT_T2			0x128
+#define ESPI_VW_SYSEVT1_INT_STS			0x12c
+#define ESPI_OOB_RX_DESC_NUM			0x130
+#define ESPI_OOB_RX_DESC_RPTR			0x134
+#define	  ESPI_OOB_RX_DESC_RPTR_UPDATE		BIT(31)
+#define   ESPI_OOB_RX_DESC_RPTR_RP		GENMASK(11, 0)
+#define ESPI_OOB_RX_DESC_WPTR			0x138
+#define   ESPI_OOB_RX_DESC_WPTR_RECV_EN		BIT(31)
+#define   ESPI_OOB_RX_DESC_WPTR_SP		GENMASK(27, 16)
+#define   ESPI_OOB_RX_DESC_WPTR_WP		GENMASK(11, 0)
+#define ESPI_OOB_TX_DESC_NUM			0x140
+#define ESPI_OOB_TX_DESC_RPTR			0x144
+#define	  ESPI_OOB_TX_DESC_RPTR_UPDATE		BIT(31)
+#define ESPI_OOB_TX_DESC_WPTR			0x148
+#define	  ESPI_OOB_TX_DESC_WPTR_SEND_EN		BIT(31)
+#define ESPI_MMBI_CTRL				0x800
+#define   ESPI_MMBI_CTRL_INST_SZ		GENMASK(10, 8)
+#define   ESPI_MMBI_CTRL_TOTAL_SZ		GENMASK(6, 4)
+#define   ESPI_MMBI_CTRL_EN			BIT(0)
+#define ESPI_MMBI_INT_STS			0x808
+#define ESPI_MMBI_INT_EN			0x80c
+#define ESPI_MMBI_HOST_RWP(x)			(0x810 + ((x) << 3))
+
+/* collect ESPI_INT_EN bits for convenience */
+#define ESPI_INT_EN_PERIF			\
+	(ESPI_INT_EN_PERIF_NP_TX_ABT |		\
+	 ESPI_INT_EN_PERIF_PC_TX_ABT |		\
+	 ESPI_INT_EN_PERIF_NP_RX_ABT |		\
+	 ESPI_INT_EN_PERIF_PC_RX_ABT |		\
+	 ESPI_INT_EN_PERIF_NP_TX_ERR |		\
+	 ESPI_INT_EN_PERIF_PC_TX_ERR |		\
+	 ESPI_INT_EN_PERIF_NP_TX_CMPLT |	\
+	 ESPI_INT_EN_PERIF_PC_TX_CMPLT |	\
+	 ESPI_INT_EN_PERIF_PC_RX_CMPLT)
+
+#define ESPI_INT_EN_VW			\
+	(ESPI_INT_EN_VW_SYSEVT1 |	\
+	 ESPI_INT_EN_VW_GPIO    |	\
+	 ESPI_INT_EN_VW_SYSEVT)
+
+#define ESPI_INT_EN_OOB		\
+	(ESPI_INT_EN_OOB_RX_TMOUT |	\
+	 ESPI_INT_EN_OOB_TX_ERR |	\
+	 ESPI_INT_EN_OOB_TX_ABT |	\
+	 ESPI_INT_EN_OOB_RX_ABT |	\
+	 ESPI_INT_EN_OOB_TX_CMPLT |	\
+	 ESPI_INT_EN_OOB_RX_CMPLT)
+
+#define ESPI_INT_EN_FLASH		\
+	(ESPI_INT_EN_FLASH_TX_ERR |	\
+	 ESPI_INT_EN_FLASH_TX_ABT |	\
+	 ESPI_INT_EN_FLASH_RX_ABT |	\
+	 ESPI_INT_EN_FLASH_TX_CMPLT |	\
+	 ESPI_INT_EN_FLASH_RX_CMPLT)
+
+/* collect ESPI_INT_STS bits for convenience */
+#define ESPI_INT_STS_PERIF			\
+	(ESPI_INT_STS_PERIF_NP_TX_ABT |		\
+	 ESPI_INT_STS_PERIF_PC_TX_ABT |		\
+	 ESPI_INT_STS_PERIF_NP_RX_ABT |		\
+	 ESPI_INT_STS_PERIF_PC_RX_ABT |		\
+	 ESPI_INT_STS_PERIF_NP_TX_ERR |		\
+	 ESPI_INT_STS_PERIF_PC_TX_ERR |		\
+	 ESPI_INT_STS_PERIF_NP_TX_CMPLT |	\
+	 ESPI_INT_STS_PERIF_PC_TX_CMPLT |	\
+	 ESPI_INT_STS_PERIF_PC_RX_CMPLT)
+
+#define ESPI_INT_STS_VW			\
+	(ESPI_INT_STS_VW_SYSEVT1 |	\
+	 ESPI_INT_STS_VW_GPIO    |	\
+	 ESPI_INT_STS_VW_SYSEVT)
+
+#define ESPI_INT_STS_OOB		\
+	(ESPI_INT_STS_OOB_RX_TMOUT |	\
+	 ESPI_INT_STS_OOB_TX_ERR |	\
+	 ESPI_INT_STS_OOB_TX_ABT |	\
+	 ESPI_INT_STS_OOB_RX_ABT |	\
+	 ESPI_INT_STS_OOB_TX_CMPLT |	\
+	 ESPI_INT_STS_OOB_RX_CMPLT)
+
+#define ESPI_INT_STS_FLASH		\
+	(ESPI_INT_STS_FLASH_TX_ERR |	\
+	 ESPI_INT_STS_FLASH_TX_ABT |	\
+	 ESPI_INT_STS_FLASH_RX_ABT |	\
+	 ESPI_INT_STS_FLASH_TX_CMPLT |	\
+	 ESPI_INT_STS_FLASH_RX_CMPLT)
+
+/* function operators */
+void ast2600_espi_pre_init(struct aspeed_espi *espi);
+void ast2600_espi_post_init(struct aspeed_espi *espi);
+void ast2600_espi_deinit(struct aspeed_espi *espi);
+int ast2600_espi_perif_probe(struct aspeed_espi *espi);
+int ast2600_espi_perif_remove(struct aspeed_espi *espi);
+int ast2600_espi_vw_probe(struct aspeed_espi *espi);
+int ast2600_espi_vw_remove(struct aspeed_espi *espi);
+int ast2600_espi_oob_probe(struct aspeed_espi *espi);
+int ast2600_espi_oob_remove(struct aspeed_espi *espi);
+int ast2600_espi_flash_probe(struct aspeed_espi *espi);
+int ast2600_espi_flash_remove(struct aspeed_espi *espi);
+irqreturn_t ast2600_espi_isr(int irq, void *arg);
+#endif

-- 
2.34.1


