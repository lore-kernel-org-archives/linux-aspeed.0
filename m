Return-Path: <linux-aspeed+bounces-3465-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6EEE8304F
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Feb 2026 03:31:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4ptQ0FlPz30GV;
	Tue, 03 Feb 2026 14:31:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770089486;
	cv=none; b=P/mpv90qPqTo5TlJ0BEfVL1f1nvbDKOzpUCuT9DPLHPzYfnWpohHhJ1SDP6o+SzRO7U0D84nzcYsivmhqCO1rRAi9pocTggRy5NiDzJuaFDJyKHmWBx2ywgHaPDRId/bRW7HsNftWQP3Gytm/9fnlWx7EDRCZjzZFHOMusQYeMbpOpdC+TDbdk1w997X3jb9pehpI1nlAV8V9ybap+QIMgC3YazCTkfDs+70zdxQJZ1+Ory8pmuCHjJJO1czHcNPV06ahC08BtZiRelHbAL7zSI6RSi/4O3uwye3wNWFaJssao6VXAFzNsnEyP0E7SFRtc5+hOL99SaXcTljxCE3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770089486; c=relaxed/relaxed;
	bh=5AppuOK9rkyT3FzeBVjF7uyns/g8wmojTasstxvzrVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UToF8A12mM+ypsCGissCI/xnNUwjH4eb/Gd4f+rd27nZIa+1Rt9O2VOfh2iZB1bEZXiM6fJ80G58e+YwJ23GDC5TuFBtPz7zHf6fOte3z81wHKcGPaNSdbffPs/cIIBdQqOlCExGddtgZoc0xNfcQ9BEHVRaclz8FX0o0UfuAQCT7dImDaom5j8VGDuJOOgET8ChuBwOTlc1clFbf1OHe7W0N5ZP8cbqhyr1TkXm6tTO+Z0kGToK54kaOXEY/+Hd8zc4lenzcQRdjL66NFGUDX2AWeW4vA+/BbsNTZkwXt1ysTlvtAJCebe7aygC7fi9I8iAe5r1US1sbyjMnMnj8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4ptP3X7Zz30FD
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Feb 2026 14:31:25 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Feb
 2026 11:31:04 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Feb 2026 11:31:04 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Tue, 3 Feb 2026 11:30:54 +0800
Subject: [PATCH RESEND v9 2/3] phy: aspeed: Add ASPEED PCIe PHY driver
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
Message-ID: <20260203-upstream_pcie_rc-v9-2-899ee4efe94e@aspeedtech.com>
References: <20260203-upstream_pcie_rc-v9-0-899ee4efe94e@aspeedtech.com>
In-Reply-To: <20260203-upstream_pcie_rc-v9-0-899ee4efe94e@aspeedtech.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>
CC: <linux-aspeed@lists.ozlabs.org>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770089464; l=7890;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=x1HQW8/L/izubxiHMzraU+k59JLvFLeY2rk3IBhD/m4=;
 b=NkO3Sf3P0Jj57B/5SkS6DlfWKq7utvyU73znVCaFwsR90xyfrsozQZ8mOJesziQnVweVKhJLa
 ZXdlyDTtccIBwrr+2Xq8npZcBej8Wq5ivEgve7OvyLmHxNDt6L9e/0C
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Introduce support for Aspeed PCIe PHY controller available in
AST2600/2700.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/phy/Kconfig                  |   1 +
 drivers/phy/Makefile                 |   1 +
 drivers/phy/aspeed/Kconfig           |  14 +++
 drivers/phy/aspeed/Makefile          |   2 +
 drivers/phy/aspeed/phy-aspeed-pcie.c | 194 +++++++++++++++++++++++++++++++++++
 5 files changed, 212 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 678dd0452f0a..f6a8f06fd244 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -103,6 +103,7 @@ config PHY_NXP_PTN3222
 
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
+source "drivers/phy/aspeed/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
 source "drivers/phy/cadence/Kconfig"
 source "drivers/phy/freescale/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index bfb27fb5a494..18990c87dfb0 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_PHY_AIROHA_PCIE)		+= phy-airoha-pcie.o
 obj-$(CONFIG_PHY_NXP_PTN3222)		+= phy-nxp-ptn3222.o
 obj-y					+= allwinner/	\
 					   amlogic/	\
+					   aspeed/	\
 					   broadcom/	\
 					   cadence/	\
 					   freescale/	\
diff --git a/drivers/phy/aspeed/Kconfig b/drivers/phy/aspeed/Kconfig
new file mode 100644
index 000000000000..f7aad553f3fd
--- /dev/null
+++ b/drivers/phy/aspeed/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Phy drivers for Aspeed platforms
+#
+config PHY_ASPEED_PCIE
+	tristate "ASPEED PCIe PHY driver"
+	select GENERIC_PHY
+	depends on ARCH_ASPEED
+	help
+	  This option enables support for the ASPEED PCIe PHY driver.
+	  The driver provides the necessary interface to control and
+	  configure the PCIe PHY hardware found on ASPEED SoCs.
+	  It is required for proper operation of PCIe devices on
+	  platforms using ASPEED chips.
diff --git a/drivers/phy/aspeed/Makefile b/drivers/phy/aspeed/Makefile
new file mode 100644
index 000000000000..3edce7f522e1
--- /dev/null
+++ b/drivers/phy/aspeed/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PHY_ASPEED_PCIE)		+= phy-aspeed-pcie.o
diff --git a/drivers/phy/aspeed/phy-aspeed-pcie.c b/drivers/phy/aspeed/phy-aspeed-pcie.c
new file mode 100644
index 000000000000..0f8ca7bf69b5
--- /dev/null
+++ b/drivers/phy/aspeed/phy-aspeed-pcie.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 Aspeed Technology Inc.
+ */
+
+#include <linux/phy/pcie.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+/* AST2600 PCIe Host Controller Registers */
+#define PEHR_GLOBAL		0x30
+#define  AST2600_PORT_TYPE_MASK		GENMASK(5, 4)
+#define  AST2600_PORT_TYPE(x)		FIELD_PREP(AST2600_PORT_TYPE_MASK, x)
+#define PEHR_LOCK		0x7c
+#define  PCIE_UNLOCK			0xa8
+
+/* AST2700 PEHR */
+#define PEHR_MISC_58		0x58
+#define  LOCAL_SCALE_SUP		BIT(0)
+#define PEHR_MISC_5C		0x5c
+#define  CONFIG_RC_DEVICE		BIT(30)
+#define PEHR_MISC_60		0x60
+#define  AST2700_PORT_TYPE_MASK		GENMASK(7, 4)
+#define  PORT_TYPE_ROOT			0x4
+#define PEHR_MISC_70		0x70
+#define  POSTED_DATA_CREDITS(x)		FIELD_PREP(GENMASK(15, 0), x)
+#define  POSTED_HEADER_CREDITS(x)	FIELD_PREP(GENMASK(27, 16), x)
+#define PEHR_MISC_78		0x78
+#define  COMPLETION_DATA_CREDITS(x)	FIELD_PREP(GENMASK(15, 0), x)
+#define  COMPLETION_HEADER_CREDITS(x)	FIELD_PREP(GENMASK(27, 16), x)
+
+/**
+ * struct aspeed_pcie_phy - PCIe PHY information
+ * @dev: pointer to device structure
+ * @reg: PCIe host register base address
+ * @phy: pointer to PHY structure
+ * @platform: platform specific information
+ */
+struct aspeed_pcie_phy {
+	struct device *dev;
+	void __iomem *reg;
+	struct phy *phy;
+	const struct aspeed_pcie_phy_platform *platform;
+};
+
+/**
+ * struct aspeed_pcie_phy_platform - Platform information
+ * @phy_ops: phy operations
+ */
+struct aspeed_pcie_phy_platform {
+	const struct phy_ops *phy_ops;
+};
+
+static int ast2600_phy_init(struct phy *phy)
+{
+	struct aspeed_pcie_phy *pcie_phy = phy_get_drvdata(phy);
+
+	writel(PCIE_UNLOCK, pcie_phy->reg + PEHR_LOCK);
+
+	return 0;
+}
+
+static int ast2600_phy_set_mode(struct phy *phy, enum phy_mode mode,
+				int submode)
+{
+	struct aspeed_pcie_phy *pcie_phy = phy_get_drvdata(phy);
+
+	switch (submode) {
+	case PHY_MODE_PCIE_RC:
+		writel(AST2600_PORT_TYPE(0x3), pcie_phy->reg + PEHR_GLOBAL);
+		break;
+	default:
+		dev_err(&phy->dev, "Unsupported submode %d\n", submode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct phy_ops ast2600_phy_ops = {
+	.init		= ast2600_phy_init,
+	.set_mode	= ast2600_phy_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static int ast2700_phy_init(struct phy *phy)
+{
+	struct aspeed_pcie_phy *pcie_phy = phy_get_drvdata(phy);
+
+	writel(POSTED_DATA_CREDITS(0xc0) | POSTED_HEADER_CREDITS(0xa),
+	       pcie_phy->reg + PEHR_MISC_70);
+	writel(COMPLETION_DATA_CREDITS(0x30) | COMPLETION_HEADER_CREDITS(0x8),
+	       pcie_phy->reg + PEHR_MISC_78);
+	writel(LOCAL_SCALE_SUP, pcie_phy->reg + PEHR_MISC_58);
+
+	return 0;
+}
+
+static int ast2700_phy_set_mode(struct phy *phy, enum phy_mode mode,
+				int submode)
+{
+	struct aspeed_pcie_phy *pcie_phy = phy_get_drvdata(phy);
+	u32 cfg_val;
+
+	switch (submode) {
+	case PHY_MODE_PCIE_RC:
+		writel(CONFIG_RC_DEVICE, pcie_phy->reg + PEHR_MISC_5C);
+		cfg_val = readl(pcie_phy->reg + PEHR_MISC_60);
+		FIELD_MODIFY(AST2700_PORT_TYPE_MASK, &cfg_val,
+			     PORT_TYPE_ROOT);
+		writel(cfg_val, pcie_phy->reg + PEHR_MISC_60);
+		break;
+	default:
+		dev_err(&phy->dev, "Unsupported submode %d\n", submode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct phy_ops ast2700_phy_ops = {
+	.init		= ast2700_phy_init,
+	.set_mode	= ast2700_phy_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+const struct aspeed_pcie_phy_platform pcie_phy_ast2600 = {
+	.phy_ops = &ast2600_phy_ops,
+};
+
+const struct aspeed_pcie_phy_platform pcie_phy_ast2700 = {
+	.phy_ops = &ast2700_phy_ops,
+};
+
+static int aspeed_pcie_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	struct aspeed_pcie_phy *pcie_phy;
+	const struct aspeed_pcie_phy_platform *md;
+
+	md = of_device_get_match_data(dev);
+	if (!md)
+		return -ENODEV;
+
+	pcie_phy = devm_kzalloc(dev, sizeof(*pcie_phy), GFP_KERNEL);
+	if (!pcie_phy)
+		return -ENOMEM;
+
+	pcie_phy->reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pcie_phy->reg))
+		return PTR_ERR(pcie_phy->reg);
+
+	pcie_phy->dev = dev;
+	pcie_phy->platform = md;
+
+	pcie_phy->phy = devm_phy_create(dev, dev->of_node,
+					pcie_phy->platform->phy_ops);
+	if (IS_ERR(pcie_phy->phy))
+		return dev_err_probe(dev, PTR_ERR(pcie_phy->phy),
+				     "failed to create PHY\n");
+
+	phy_set_drvdata(pcie_phy->phy, pcie_phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id aspeed_pcie_phy_of_match_table[] = {
+	{
+		.compatible = "aspeed,ast2600-pcie-phy",
+		.data = &pcie_phy_ast2600,
+	},
+	{
+		.compatible = "aspeed,ast2700-pcie-phy",
+		.data = &pcie_phy_ast2700,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, aspeed_pcie_phy_of_match_table);
+
+static struct platform_driver aspeed_pcie_driver = {
+	.probe		= aspeed_pcie_phy_probe,
+	.driver = {
+		.name	= "aspeed-pcie-phy",
+		.of_match_table = aspeed_pcie_phy_of_match_table,
+	},
+};
+
+module_platform_driver(aspeed_pcie_driver);
+
+MODULE_AUTHOR("Jacky Chou <jacky_chou@aspeedtech.com>");
+MODULE_DESCRIPTION("ASPEED PCIe PHY");
+MODULE_LICENSE("GPL");

-- 
2.34.1


