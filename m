Return-Path: <linux-aspeed+bounces-4196-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F772CD8CA7
	for <linux-aspeed@archiver.kernel.org>; Mon,  8 Jun 2026 23:43:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ7sd2yLcz2xJT;
	Tue, 09 Jun 2026 09:43:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930467;
	cv=none; b=Jfkzrwrnj/+ba4DfgZSk8aykoQ8WD/4GUcBTojnGx3r84iwmYm74x4iHBjXIFru8iVwsJioVuvOj4pPZyTl4mWsHAfcMz6zEc1HvdCDLRcp/QGzk44gogNgnTQodnA7ZdZiXzPGPAKfAc6KiPkl2X7Gb4WFklCHs+GbfbK4BLfJOJAcvNxGIZDfA+sALAiaC8hQw/ZrBQSs4zaS5tmudyqtu3KfdEFhtw6RsqP16mGpKz3wVAqLHzhetjQjq/KIYxqEACHVC29Rid1he2ShBP+cN1oaUZZG8bc3/PvPmsfSb7ULGcm2FlX/H7XGlZK2kJZh/0RC82drYS7+JP8d/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930467; c=relaxed/relaxed;
	bh=Sl5xhQEQ5jJjs9NVyTu44PT+PkxvqNJiAQ/dgYRRiPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOQ7VEcbhXsyjWwM1rEbuzVy9ZRLPhL1fEKTsXRisffLyZcxs613DEm87we6kpJoK71hakTx/GG0ss5EHA4eodW/E5Zj9+TfuPGwFsoIsOazCu14yNLZVyrDKwbvgSOTXoGOKKutUFwOPiNEFIsileX96WM9g8zcZca2k1CzcxVtP2uiwbt15E4TTgwu5aJO+fNWYAVNpUByNeBxy3RclwZsd+lr0aqRR0h0POIdACmYw+1dVIwkhbh7WTavlwj/wLFbyVQo6Nj+/7kydCXJSk0N3s5R3wShoaenf/p6ZT5LpCJfRBWoKHoYdlTDfqLK/xArXqnnG+OHpi5aagEQ2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=V9XPAm4Q; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=V9XPAm4Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYw6p68xvz3bsQ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 09 Jun 2026 00:54:26 +1000 (AEST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so38958635e9.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 08 Jun 2026 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1780930464; x=1781535264; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sl5xhQEQ5jJjs9NVyTu44PT+PkxvqNJiAQ/dgYRRiPE=;
        b=V9XPAm4QLqk03u0y3Gm6m68Rv5EKZeGV1KT0az/5qRzAUNoOAxkCicBpdSVnSnm908
         pUjSUymlA379uDO1j/3WkmVWcilMsRboFDIa1o2xYW7FuFjwUkvy9N2QF0uA8L311BG1
         Ps5KHCZcHo77xrJtCuaP/TjONrOdPjxJwWFXYhijrvS22w/kW4xyVm5SpsKo232Xc+x5
         dbz8JEWHPkln8pwUSi1bFoQatASZ3xNNWjQ8VDpXQZktKrQiWTawIagLY3tPzEWmgCVg
         TrCUVvqHZunfv7rkKY18T71J401ohdSbKh9eQA21CrUPJ8pqpY/gMaCmefwXQSw/bfMR
         HGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930464; x=1781535264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sl5xhQEQ5jJjs9NVyTu44PT+PkxvqNJiAQ/dgYRRiPE=;
        b=pyCFYxds4HbYWMVSrcvLR1NuJhgQsUTsOFlK936+jpcM1Th06Si72es/fnBB/q1KjA
         Uqdp/dnYxz7nWo7XRSFoT43UJZ0j9N3nBdAscvw8B34tC0xV1DoAs+MYwrOZcneGGu0x
         VhDYI6b9LZX+wU7kZJ1paz0z5stncfRGJ0nJUpNsaIuufWec/lXzO/TKSQfM9vWyK3dd
         2PBNGz6paJyNZNRRfvqzsF9QqOlElxUWD6vrD/j69cd5ZwqW7ZGibKPAlK813W5Tjxg4
         aA8zaJGWkhldmkpBQmQVu6+NP98GLklP6BaDtZvQTB8q1Ek2I3k9hyFW3Cik7sCqGyq6
         mZMw==
X-Forwarded-Encrypted: i=1; AFNElJ8HDG/M1idorBWfwdNXtQ8PMpv2cIpV7wDJNg9J4xoztEac9UeoyCIFO+mq8dWfaE/U/Eo5DpHNrFeO+y0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz+AlEmWHJ6No7F92MvooftKVPPZrfBt5hmTjalEteY0dWKZm84
	0zCbNajWDTU/ZO9yVtR/NNq4KrP79QvujAQkaIwjTj1VRRGuIMm7dtC0WTWtw3wp9xU+NeVCSIy
	717kZ
X-Gm-Gg: Acq92OGyDfzQHHjGZw/qelWkfg/NiX0LHJLpnFpH0k+ggeN8MmN+Ed4vNklA+2bJobr
	4VWYxPo10hXECVOQRubsc0CelNOvUpYGQ9U17j2MUMBnZweormHZrfywmDx7K89nV3iIXSSvSAa
	oIRjNDwG7PgqPTQi92xYHAzIA/h89/oXY/uOs3UftiQ82/wzChL3YfjvwOvdC6Mn4jUnv8cklWo
	NBJw40VqDshO5X+Og3/3NoSWZp+fYlhE4IqPYGFXzP4MEtYJhGUsw8ei8OxRoZBnArS19n0EXLE
	jv3Yq3OVuZ6yKyNMah+p0ak9oEN4Xw/XhIDKyajPHW7XLd1Y8KEfQASWhqo5l5xvrX1m4953LOB
	QrY7i95MfP1T8UIuX8JaKHPUhS1G+N5WZxIlTwuZxzpD/p+b2VgGsekZFDpJVmsTz+8XirWhekg
	otsAqXi6k7ybP6PYUIRtdkI4yIJjPxafsaJZa5u3NV/krKDdW6QXegWuJRTLL3baNmvt4AzKU=
X-Received: by 2002:a05:600c:870f:b0:490:44eb:c1e7 with SMTP id 5b1f17b1804b1-490c2624a03mr258100705e9.30.1780930463932;
        Mon, 08 Jun 2026 07:54:23 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f360bd6sm56927851f8f.36.2026.06.08.07.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:54:23 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v2 1/2] soc: aspeed: add BMC-side PCIe BMC device driver
Date: Mon,  8 Jun 2026 14:51:22 +0000
Message-ID: <af322e76d34ad504e0bdec470293a017b489cfd7.1780929570.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1780929570.git.gregoire.layet@9elements.com>
References: <cover.1780929570.git.gregoire.layet@9elements.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Taken from ASPEED 6.18 Kernel SDK

Add support for VUART over PCIe between BMC and host.
This add BMC side driver.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
Tested-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 drivers/soc/aspeed/Kconfig          |   7 ++
 drivers/soc/aspeed/Makefile         |   1 +
 drivers/soc/aspeed/aspeed-bmc-dev.c | 187 ++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-bmc-dev.c

diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
index f579ee0b5afa..3e1fcf3c3268 100644
--- a/drivers/soc/aspeed/Kconfig
+++ b/drivers/soc/aspeed/Kconfig
@@ -4,6 +4,13 @@ if ARCH_ASPEED || COMPILE_TEST
 
 menu "ASPEED SoC drivers"
 
+config ASPEED_BMC_DEV
+	tristate "ASPEED BMC Device"
+	default n
+	help
+	  Enable support for the ASPEED AST2600 BMC Device.
+	  This exposes the PCIe-to-LPC bridge of the BMC to the host over PCIe.
+
 config ASPEED_LPC_CTRL
 	tristate "ASPEED LPC firmware cycle control"
 	select REGMAP
diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
index b35d74592964..fab0d247df66 100644
--- a/drivers/soc/aspeed/Makefile
+++ b/drivers/soc/aspeed/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_ASPEED_BMC_DEV)		+= aspeed-bmc-dev.o
 obj-$(CONFIG_ASPEED_LPC_CTRL)		+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_ASPEED_LPC_SNOOP)		+= aspeed-lpc-snoop.o
 obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
diff --git a/drivers/soc/aspeed/aspeed-bmc-dev.c b/drivers/soc/aspeed/aspeed-bmc-dev.c
new file mode 100644
index 000000000000..7a204b543c97
--- /dev/null
+++ b/drivers/soc/aspeed/aspeed-bmc-dev.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (C) ASPEED Technology Inc.
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#include <linux/regmap.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
+
+#define SCU_TRIGGER_MSI
+
+/* AST2600 SCU */
+#define ASPEED_SCU04			0x04
+#define AST2600A3_SCU04				0x05030303
+#define ASPEED_SCUC20			0xC20
+#define ASPEED_SCUC24			0xC24
+#define MSI_ROUTING_MASK			GENMASK(11, 10)
+#define PCIDEV1_INTX_MSI_HOST2BMC_EN		BIT(18)
+#define MSI_ROUTING_PCIe2LPC_PCIDEV0		(0x1 << 10)
+#define MSI_ROUTING_PCIe2LPC_PCIDEV1		(0x2 << 10)
+
+#define ASPEED_SCU_PCIE_CONF_CTRL	0xC20
+#define  SCU_PCIE_CONF_BMC_DEV_EN			 BIT(8)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_MMIO		 BIT(9)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_MSI		 BIT(11)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_IRQ		 BIT(13)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_DMA		 BIT(14)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_E2L		 BIT(15)
+#define  SCU_PCIE_CONF_BMC_DEV_EN_LPC_DECODE BIT(21)
+
+#define ASPEED_SCU_BMC_DEV_CLASS	0xC68
+
+
+struct aspeed_platform {
+	int (*init)(struct platform_device *pdev);
+};
+
+struct aspeed_bmc_device {
+	struct device *dev;
+	int id;
+	void __iomem *reg_base;
+
+	int pcie2lpc;
+	int irq;
+
+	const struct aspeed_platform *platform;
+
+	struct regmap *scu;
+	int pcie_irq;
+};
+
+
+static int aspeed_ast2600_init(struct platform_device *pdev)
+{
+	struct aspeed_bmc_device *bmc_device = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	u32 pcie_config_ctl = SCU_PCIE_CONF_BMC_DEV_EN_IRQ |
+			      SCU_PCIE_CONF_BMC_DEV_EN_MMIO | SCU_PCIE_CONF_BMC_DEV_EN;
+	u32 scu_id;
+
+	bmc_device->scu = syscon_regmap_lookup_by_phandle(dev->of_node, "aspeed,scu");
+	if (IS_ERR(bmc_device->scu)) {
+		dev_err(&pdev->dev, "failed to find SCU regmap\n");
+		return PTR_ERR(bmc_device->scu);
+	}
+
+	if (bmc_device->pcie2lpc)
+		pcie_config_ctl |= SCU_PCIE_CONF_BMC_DEV_EN_E2L |
+				   SCU_PCIE_CONF_BMC_DEV_EN_LPC_DECODE;
+
+	regmap_update_bits(bmc_device->scu, ASPEED_SCU_PCIE_CONF_CTRL,
+			   pcie_config_ctl, pcie_config_ctl);
+
+	/* update class code to others as it is a MFD device */
+	regmap_write(bmc_device->scu, ASPEED_SCU_BMC_DEV_CLASS, 0xff000000);
+
+#ifdef SCU_TRIGGER_MSI
+	//SCUC24[17]: Enable PCI device 1 INTx/MSI from SCU560[15]. Will be added in next version
+	regmap_update_bits(bmc_device->scu, ASPEED_SCUC20, BIT(11) | BIT(14), BIT(11) | BIT(14));
+
+	regmap_read(bmc_device->scu, ASPEED_SCU04, &scu_id);
+	if (scu_id == AST2600A3_SCU04)
+		regmap_update_bits(bmc_device->scu, ASPEED_SCUC24,
+				   PCIDEV1_INTX_MSI_HOST2BMC_EN | MSI_ROUTING_MASK,
+				   PCIDEV1_INTX_MSI_HOST2BMC_EN | MSI_ROUTING_PCIe2LPC_PCIDEV1);
+	else
+		regmap_update_bits(bmc_device->scu, ASPEED_SCUC24,
+				   BIT(17) | BIT(14) | BIT(11), BIT(17) | BIT(14) | BIT(11));
+#else
+	//SCUC24[18]: Enable PCI device 1 INTx/MSI from Host-to-BMC controller.
+	regmap_update_bits(bmc_device->scu, 0xc24, BIT(18) | BIT(14), BIT(18) | BIT(14));
+#endif
+
+
+	return 0;
+}
+
+
+static struct aspeed_platform ast2600_plaform = {
+	.init = aspeed_ast2600_init
+};
+
+
+static const struct of_device_id aspeed_bmc_device_of_matches[] = {
+	{ .compatible = "aspeed,ast2600-bmc-device", .data = &ast2600_plaform },
+	{},
+};
+MODULE_DEVICE_TABLE(of, aspeed_bmc_device_of_matches);
+
+static int aspeed_bmc_device_probe(struct platform_device *pdev)
+{
+	struct aspeed_bmc_device *bmc_device;
+	struct device *dev = &pdev->dev;
+	const void *md = of_device_get_match_data(dev);
+	int ret = 0;
+
+	if (!md)
+		return -ENODEV;
+
+	bmc_device = devm_kzalloc(&pdev->dev, sizeof(struct aspeed_bmc_device), GFP_KERNEL);
+	if (!bmc_device)
+		return -ENOMEM;
+	dev_set_drvdata(dev, bmc_device);
+
+	bmc_device->platform = md;
+
+	bmc_device->id = of_alias_get_id(dev->of_node, "bmcdev");
+	if (bmc_device->id < 0)
+		bmc_device->id = 0;
+
+	bmc_device->dev = dev;
+	bmc_device->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(bmc_device->reg_base))
+		return PTR_ERR(bmc_device->reg_base);
+
+	bmc_device->irq = platform_get_irq(pdev, 0);
+	if (bmc_device->irq < 0) {
+		dev_err(&pdev->dev, "platform get of irq[=%d] failed!\n", bmc_device->irq);
+		return bmc_device->irq;
+	}
+
+	if (of_property_read_bool(dev->of_node, "pcie2lpc"))
+		bmc_device->pcie2lpc = 1;
+
+	ret = bmc_device->platform->init(pdev);
+	if (ret) {
+		dev_err(dev, "Initialize bmc device failed\n");
+		goto out;
+	}
+
+	dev_info(dev, "aspeed bmc device: driver successfully loaded.\n");
+
+	return 0;
+
+out:
+	dev_warn(dev, "aspeed bmc device: driver init failed (ret=%d)!\n", ret);
+	return ret;
+}
+
+static void aspeed_bmc_device_remove(struct platform_device *pdev)
+{
+	struct aspeed_bmc_device *bmc_device = platform_get_drvdata(pdev);
+
+	devm_free_irq(&pdev->dev, bmc_device->irq, bmc_device);
+	devm_kfree(&pdev->dev, bmc_device);
+}
+
+static struct platform_driver aspeed_bmc_device_driver = {
+	.probe		= aspeed_bmc_device_probe,
+	.remove		= aspeed_bmc_device_remove,
+	.driver		= {
+		.name	= KBUILD_MODNAME,
+		.of_match_table = aspeed_bmc_device_of_matches,
+	},
+};
+
+module_platform_driver(aspeed_bmc_device_driver);
+
+MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
+MODULE_DESCRIPTION("ASPEED BMC DEVICE Driver");
+MODULE_LICENSE("GPL");
\ No newline at end of file
-- 
2.51.2


