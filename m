Return-Path: <linux-aspeed+bounces-3657-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFA3105F78B
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Mar 2026 10:08:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXKv225Hhz3cK4;
	Fri, 13 Mar 2026 21:08:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773396510;
	cv=none; b=Yve8SYtmbgjlxZWZf05v958soZuA80QNAXRSC+XWVJq2cctpQKbYvai+k0Esq9O456sfy1shazRcMOyl+RGRRNV290Hy6K/Pc8JTI6FuP8b24lH2tkwwhUGrlBK4+peJXBLNb6xwNBq3IL+3DOyav0Ej8tQ8gUACVgGBkYkFFYttcC20XIBYIcXiTYwX53X4jDMteiVCU7Nd5wLsDUeKn1DcH2nwUXxVRA7dKEi1yos4d/4P9kv9lnG/0ik8A/UepCjiAq29pt2xUT+qLQlBCrrTy3aE3pDt1WUqx/sYusTmz4/kowEJ1M2l7XDgrvH8lFvFimKcy4DtxXNkRN4nuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773396510; c=relaxed/relaxed;
	bh=clm801FsqQj5XYTkDkIE7QqmcGXJ7vyK1yLePKoIbvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lprhP0lfQ9RIvLGhLVKlsNWWXdMD9gHSZmpD75Dcdx4xy0nkmNEeJFxbhfZN3LiD5fVHy6YU+yeabe+tr0O8FZQlR1WOR8eFtofHJRfOHH8wBEbi0RroEJYq3JVfqhzeVz3/OZ44L/1tLiCbOvBmM0lJWXG/W50PS6wv7sDLugbRQZaaiM4WJ9HiwNxyjB6IibNweaw7Ajrrc/CTBRreyEGxfJEZdIJyFyRbNU7CG1sffntq06oENn67Oc0AIlwBmpPp5+un34LqksRT6i9K7BMrAivzPd0YSbPOYAh7TGeP6uXfim2Bjwcal3n1EuTKR7KbBczbYyR3tgisb1otjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=yh_chung@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXKv14CFZz3cKj;
	Fri, 13 Mar 2026 21:08:29 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Mar
 2026 18:08:12 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Mar 2026 18:08:12 +0800
From: aspeedyh <yh_chung@aspeedtech.com>
Date: Fri, 13 Mar 2026 18:07:37 +0800
Subject: [PATCH 2/7] soc: aspeed: Introduce core eSPI controller support
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
Message-ID: <20260313-upstream_espi-v1-2-9504428e1f43@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773396491; l=6557;
 i=yh_chung@aspeedtech.com; s=20260313; h=from:subject:message-id;
 bh=/rOqnxX9j6h03fyAsdgGIl0qi1TFF1cLQusaF8+cqak=;
 b=5SvpJyitqQ/Sx4PNe6gIxvhFpoq9dxYazoMvAYRv+z8OBP3B9Zc8w/Sqvr7TWuG9zU+vo/kOk
 QG8th6cPJrqD8/Qv/n8WgOgvejoRO9ZTD/PsY7YToonQZebIY04/ypY
X-Developer-Key: i=yh_chung@aspeedtech.com; a=ed25519;
 pk=o71dz0J8lpN+v0f3Mk4gT9PfVngADPC1Pex4aK6VigM=

Add core eSPI controller support and common code for ASPEED SoCs. The
eSPI engine is a slave device in BMC to communicate with the Host over
the eSPI interface.

The initial support includes basic eSPI driver probe/remove operations,
and provides operators for ASPEED SoCs to implement their own eSPI slave
device drivers that are different among SoC models.

Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
---
 drivers/soc/aspeed/Kconfig            |   7 ++
 drivers/soc/aspeed/Makefile           |   1 +
 drivers/soc/aspeed/espi/Makefile      |   1 +
 drivers/soc/aspeed/espi/aspeed-espi.c | 143 ++++++++++++++++++++++++++++++++++
 drivers/soc/aspeed/espi/aspeed-espi.h |  27 +++++++
 5 files changed, 179 insertions(+)

diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
index f579ee0b5afa..677812fab11a 100644
--- a/drivers/soc/aspeed/Kconfig
+++ b/drivers/soc/aspeed/Kconfig
@@ -52,6 +52,13 @@ config ASPEED_SOCINFO
 	help
 	  Say yes to support decoding of ASPEED BMC information.
 
+config ASPEED_ESPI
+	tristate "ASPEED eSPI slave driver"
+	help
+	  Enable driver support for Aspeed eSPI controller. The eSPI controller
+	  plays as a slave device in BMC to communicate with the Host over the
+	  eSPI interface using peripheral, virtual wire, out of band, and flash
+	  channels.
 endmenu
 
 endif
diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
index b35d74592964..79d794de428a 100644
--- a/drivers/soc/aspeed/Makefile
+++ b/drivers/soc/aspeed/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)		+= aspeed-lpc-snoop.o
 obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
 obj-$(CONFIG_ASPEED_P2A_CTRL)		+= aspeed-p2a-ctrl.o
 obj-$(CONFIG_ASPEED_SOCINFO)		+= aspeed-socinfo.o
+obj-$(CONFIG_ASPEED_ESPI)		+= espi/
diff --git a/drivers/soc/aspeed/espi/Makefile b/drivers/soc/aspeed/espi/Makefile
new file mode 100644
index 000000000000..d96dc030e23b
--- /dev/null
+++ b/drivers/soc/aspeed/espi/Makefile
@@ -0,0 +1 @@
+obj-y += aspeed-espi.o
diff --git a/drivers/soc/aspeed/espi/aspeed-espi.c b/drivers/soc/aspeed/espi/aspeed-espi.c
new file mode 100644
index 000000000000..15d58b38bbe4
--- /dev/null
+++ b/drivers/soc/aspeed/espi/aspeed-espi.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Unified Aspeed eSPI driver framework for different generation SoCs
+ */
+
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#include "aspeed-espi.h"
+
+struct aspeed_espi_ops {
+	void (*espi_pre_init)(struct aspeed_espi *espi);
+	void (*espi_post_init)(struct aspeed_espi *espi);
+	void (*espi_deinit)(struct aspeed_espi *espi);
+	irqreturn_t (*espi_isr)(int irq, void *espi);
+};
+
+static const struct of_device_id aspeed_espi_of_matches[] = {
+	{ }
+};
+MODULE_DEVICE_TABLE(of, aspeed_espi_of_matches);
+
+static int aspeed_espi_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct aspeed_espi *espi;
+	struct resource *res;
+	struct device *dev;
+	int rc;
+
+	dev = &pdev->dev;
+	espi = devm_kzalloc(dev, sizeof(*espi), GFP_KERNEL);
+	if (!espi)
+		return -ENOMEM;
+
+	espi->dev = dev;
+	match = of_match_device(aspeed_espi_of_matches, dev);
+	if (!match)
+		return -ENODEV;
+
+	espi->pdev = pdev;
+	espi->ops = match->data;
+	if (!espi->ops || !espi->ops->espi_isr)
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "cannot get resource\n");
+		return -ENODEV;
+	}
+
+	espi->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(espi->regs)) {
+		dev_err(dev, "cannot map registers\n");
+		return PTR_ERR(espi->regs);
+	}
+
+	espi->irq = platform_get_irq(pdev, 0);
+	if (espi->irq < 0) {
+		dev_err(dev, "cannot get IRQ number\n");
+		return espi->irq;
+	}
+
+	espi->rst = devm_reset_control_get_optional(dev, NULL);
+	if (IS_ERR(espi->rst)) {
+		dev_err(dev, "cannot get reset control\n");
+		return PTR_ERR(espi->rst);
+	}
+
+	espi->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(espi->clk)) {
+		dev_err(dev, "cannot get clock control\n");
+		return PTR_ERR(espi->clk);
+	}
+
+	rc = clk_prepare_enable(espi->clk);
+	if (rc) {
+		dev_err(dev, "cannot enable clocks\n");
+		return rc;
+	}
+
+	if (espi->ops->espi_pre_init)
+		espi->ops->espi_pre_init(espi);
+
+	rc = devm_request_irq(dev, espi->irq, espi->ops->espi_isr, 0,
+			      dev_name(dev), espi);
+	if (rc) {
+		dev_err(dev, "cannot request IRQ\n");
+		goto err_deinit;
+	}
+
+	if (espi->ops->espi_post_init)
+		espi->ops->espi_post_init(espi);
+
+	platform_set_drvdata(pdev, espi);
+
+	dev_info(dev, "module loaded\n");
+
+	return 0;
+
+err_deinit:
+	if (espi->ops->espi_deinit)
+		espi->ops->espi_deinit(espi);
+	clk_disable_unprepare(espi->clk);
+
+	return rc;
+}
+
+static void aspeed_espi_remove(struct platform_device *pdev)
+{
+	struct aspeed_espi *espi;
+
+	espi = platform_get_drvdata(pdev);
+
+	if (!espi)
+		return;
+
+	if (espi->ops->espi_deinit)
+		espi->ops->espi_deinit(espi);
+
+	clk_disable_unprepare(espi->clk);
+}
+
+static struct platform_driver aspeed_espi_driver = {
+	.driver = {
+		.name = "aspeed-espi",
+		.of_match_table = aspeed_espi_of_matches,
+	},
+	.probe = aspeed_espi_probe,
+	.remove = aspeed_espi_remove,
+};
+
+module_platform_driver(aspeed_espi_driver);
+
+MODULE_AUTHOR("Aspeed Technology Inc.");
+MODULE_DESCRIPTION("Aspeed eSPI controller");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/aspeed/espi/aspeed-espi.h b/drivers/soc/aspeed/espi/aspeed-espi.h
new file mode 100644
index 000000000000..f4ad7f61fef6
--- /dev/null
+++ b/drivers/soc/aspeed/espi/aspeed-espi.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Unified eSPI driver header file and data structures
+ * Copyright 2026 Aspeed Technology Inc.
+ */
+#ifndef ASPEED_ESPI_H
+#define ASPEED_ESPI_H
+
+#include <linux/irqreturn.h>
+#include <linux/miscdevice.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#define DEVICE_NAME		"aspeed-espi"
+
+struct aspeed_espi {
+	struct platform_device *pdev;
+	struct device *dev;
+	void __iomem *regs;
+	struct reset_control *rst;
+	struct clk *clk;
+	int dev_id;
+	int irq;
+	const struct aspeed_espi_ops *ops;
+};
+
+#endif

-- 
2.34.1


