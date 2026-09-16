Return-Path: <linux-aspeed+bounces-4997-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E43FC982C4
	for <linux-aspeed@archiver.kernel.org>; Wed, 16 Sep 2026 00:38:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl0P03zB3z2yd7;
	Wed, 16 Sep 2026 10:38:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789519108;
	cv=none; b=oYhDJ0vGbntXMgpDzfpu2bu0bEeLPSUva7HicTRB0dahOm/vrz01+euNr+6if9PAU2Or1FIUtdrnuKCTJ2G20/4WJi24yd4SJKADPTIeQj7wVne5AUe1HPPZ+SDRXfyJ7Y3Fub3HtGAl9rTncgHlzOajqTXm2NZiMhbFIeW+gyTkP5i6LOx+7KzMI0sHwm3is5wWSHuxXYIzqSijGKGWTqv7FgbZCfLG6YtUscloqcs2mdpY054g6UXNP0NMNAyd9DIYUeoJ0NMCVvmTgsYBggoecOYSXVSq1XcWoxb6ImIZXk4fOTGDi9D7rLpjj1DLiFimjx9ikGM0j8MCjFJdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789519108; c=relaxed/relaxed;
	bh=qFZmNBf4qfYWyxV7HR/s5jPguRDPbuw+lPYCabWVA4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jICBzqP8RJ8QgAlm2EjjXjw+uBTP31l4J/pcAHBPM6ZxUWoa14B7z0sm97X8k3JTQ7y6FbgXIdaYnjGmssevnb5dj10afUHqMRDOUakGWPoQvx4LanNxlk+oR9TmhuqIkHFnfJ468ZnBUG/Ll8KNRiLZsvEKyxyKEPNhyltqFiboXYEvbZbOaC6/hpI666ZlSVg83IM/nEFxzGVJ5BXoPlUorEHz18PMb+6s90dFWX4QTCyBcIuefD6iIdjSvo30DUZ87YRG7qBe8S/4qnL61He0EFZmVpY3dZAVd0PzGyD23PsMfBoe8Qt0hrCiwNs7hxZZXevwWaSy9ZVt7rSvVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl0Nz2FXBz2xkr
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Sep 2026 10:38:27 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 16 Sep
 2026 08:38:02 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 16 Sep 2026 08:38:02 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 16 Sep 2026 08:38:02 +0800
Subject: [PATCH v4 2/3] phy: aspeed: Add AST2700 USB3.2 PHY driver
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
Message-ID: <20260916-upstream_usb3phy-v4-2-812e76037d01@aspeedtech.com>
References: <20260916-upstream_usb3phy-v4-0-812e76037d01@aspeedtech.com>
In-Reply-To: <20260916-upstream_usb3phy-v4-0-812e76037d01@aspeedtech.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>, Manivannan Sadhasivam <mani@kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789519082; l=11212;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=oCJAxByK5/0L3PDNVLGEo5PitCkaMXRWfGb2v4ns6J4=;
 b=QWp3sMwpU92WXAttQP0ufCkTkCI2TeJC2gqur4jeMogAgBKzxuLhcTNuCvac5hIP0SyjI/9jD
 3M7AyCiOoABB+LAJEGOt54sGXKzjCxFMkXEWnzEfe6g+6wdzdoXd/TR
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add a driver for the USB3.2 PHY on the Aspeed AST2700, which is paired
with the DWC3 controller.

The PHY draws its configuration from an internal SRAM in both of the
available modes, so the driver must wait for PHY3S00_INIT_DONE before
selecting one. PHY3S00_SRAM_BYPASS selects the default design
configuration and PHY3S00_SRAM_EXT_LOAD the ROM code configuration; the
driver uses the latter.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

---
Changes in v4:
- Indent the register bitfield definitions so they are distinguishable
  from the register offsets, and use lowercase hex.
- Set PHY3S00_SRAM_EXT_LOAD rather than PHY3S00_SRAM_BYPASS. Bypassing
  the SRAM leaves the PHY on the default RTL design configuration,
  whereas the external load path applies the ROM patch so the PHY runs
  the ROM configuration.
- Describe the SRAM handshake in the commit message, answering Andrew's
  question on v2 about why the driver waits for the SRAM to initialise.
---
 drivers/phy/Kconfig                  |   1 +
 drivers/phy/Makefile                 |   1 +
 drivers/phy/aspeed/Kconfig           |  15 +++
 drivers/phy/aspeed/Makefile          |   2 +
 drivers/phy/aspeed/phy-aspeed-usb3.c | 236 +++++++++++++++++++++++++++++++++++
 5 files changed, 255 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 19f3b7d12b7d..85fa381978f8 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -171,6 +171,7 @@ config PHY_XGENE
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/apple/Kconfig"
+source "drivers/phy/aspeed/Kconfig"
 source "drivers/phy/axiado/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
 source "drivers/phy/cadence/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index d7aa516bcc49..c6dd02003bbe 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
 obj-$(CONFIG_GENERIC_PHY)		+= allwinner/	\
 					   amlogic/	\
 					   apple/	\
+					   aspeed/	\
 					   axiado/	\
 					   broadcom/	\
 					   cadence/	\
diff --git a/drivers/phy/aspeed/Kconfig b/drivers/phy/aspeed/Kconfig
new file mode 100644
index 000000000000..7b5f48db2be8
--- /dev/null
+++ b/drivers/phy/aspeed/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+#
+# PHY drivers for ASPEED
+#
+
+config PHY_ASPEED_USB3
+	tristate "ASPEED USB3 PHY driver"
+	select GENERIC_PHY
+	depends on (ARCH_ASPEED || COMPILE_TEST)
+	help
+	  Enable this to support the USB 3.2 PHY on the Aspeed AST2700 SoC.
+	  It supports SuperSpeedPlus Gen2x1 (10 Gbps), SuperSpeed (5 Gbps),
+	  High Speed (480 Mbps), Full Speed (12 Mbps) and Low Speed
+	  (1.5 Mbps), and is paired with the DWC3 USB controller.
diff --git a/drivers/phy/aspeed/Makefile b/drivers/phy/aspeed/Makefile
new file mode 100644
index 000000000000..d96d9d73a009
--- /dev/null
+++ b/drivers/phy/aspeed/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PHY_ASPEED_USB3)		+= phy-aspeed-usb3.o
diff --git a/drivers/phy/aspeed/phy-aspeed-usb3.c b/drivers/phy/aspeed/phy-aspeed-usb3.c
new file mode 100644
index 000000000000..6f371cae02f3
--- /dev/null
+++ b/drivers/phy/aspeed/phy-aspeed-usb3.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Aspeed Technology Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#define PHY3S00				0x00
+#define  PHY3S00_INIT_DONE		BIT(15)
+#define  PHY3S00_SRAM_BYPASS		BIT(7)
+#define  PHY3S00_SRAM_EXT_LOAD		BIT(6)
+#define PHY3S04				0x04
+#define PHY3C00				0x08
+#define PHY3C04				0x0c
+#define PHY3P00				0x10
+#define  PHY3P00_RX_ADAPT_AFE_EN_G1	BIT(0)
+#define  PHY3P00_RX_ADAPT_AFE_EN_G2	BIT(1)
+#define  PHY3P00_RX_ADAPT_DFE_EN_G1	BIT(2)
+#define  PHY3P00_RX_ADAPT_DFE_EN_G2	BIT(3)
+#define  PHY3P00_RX_CDR_VCO_LOWFREQ_G1	BIT(4)
+#define  PHY3P00_RX_CDR_VCO_LOWFREQ_G2	BIT(5)
+#define  PHY3P00_RX_EQ_AFE_GAIN_G1	GENMASK(9, 6)
+#define  PHY3P00_RX_EQ_AFE_GAIN_G2	GENMASK(13, 10)
+#define  PHY3P00_RX_EQ_ATT_LVL_G1	GENMASK(16, 14)
+#define  PHY3P00_RX_EQ_ATT_LVL_G2	GENMASK(19, 17)
+#define  PHY3P00_RX_EQ_CTLE_BOOST_G1	GENMASK(24, 20)
+#define  PHY3P00_RX_EQ_CTLE_BOOST_G2	GENMASK(29, 25)
+#define  PHY3P00_RX_EQ_DELTA_IQ_G1_LO	GENMASK(31, 30)
+
+#define PHY3P04				0x14
+#define  PHY3P04_RX_EQ_DELTA_IQ_G1_HI	GENMASK(1, 0)
+#define  PHY3P04_RX_EQ_DELTA_IQ_G2	GENMASK(5, 2)
+#define  PHY3P04_RX_EQ_DFE_TAP1_G1	GENMASK(13, 6)
+#define  PHY3P04_RX_EQ_DFE_TAP1_G2	GENMASK(21, 14)
+#define  PHY3P04_RX_LOS_LFPS_EN		BIT(22)
+#define  PHY3P04_RX_LOS_THRESHOLD	GENMASK(25, 23)
+#define  PHY3P04_RX_TERM_CTRL		GENMASK(28, 26)
+#define  PHY3P04_TX_EQ_MAIN_G1_LO	GENMASK(31, 29)
+
+#define PHY3P08				0x18
+#define  PHY3P08_TX_EQ_MAIN_G1_HI	GENMASK(1, 0)
+#define  PHY3P08_TX_EQ_MAIN_G2		GENMASK(6, 2)
+#define  PHY3P08_TX_EQ_OVRD		BIT(7)
+#define  PHY3P08_TX_EQ_POST_G1		GENMASK(12, 9)
+#define  PHY3P08_TX_EQ_POST_G2		GENMASK(16, 13)
+#define  PHY3P08_TX_EQ_PRE_G1		GENMASK(20, 17)
+#define  PHY3P08_TX_EQ_PRE_G2		GENMASK(24, 21)
+#define  PHY3P08_TX_IBOOST_LVL		GENMASK(28, 25)
+#define  PHY3P08_TX_TERM_CTRL		GENMASK(31, 29)
+
+#define PHY3P0C				0x1c
+#define  PHY3P0C_TX_VBOOST_EN		BIT(0)
+
+#define PHY3CMD				0x40
+
+#define PHY3P_RX_EQ_CTLE_BOOST_G1_DEFAULT	0x7
+#define PHY3P_RX_EQ_CTLE_BOOST_G2_DEFAULT	0x7
+#define PHY3P_RX_EQ_DELTA_IQ_G1_DEFAULT		0x3
+#define PHY3P_RX_EQ_DELTA_IQ_G2_DEFAULT		0x5
+#define PHY3P_RX_LOS_THRESHOLD_DEFAULT		0x3
+#define PHY3P_RX_TERM_CTRL_DEFAULT		0x2
+#define PHY3P_TX_EQ_MAIN_G1_DEFAULT		0xa
+#define PHY3P_TX_EQ_MAIN_G2_DEFAULT		0x9
+#define PHY3P_TX_EQ_POST_G1_DEFAULT		0x4
+#define PHY3P_TX_EQ_POST_G2_DEFAULT		0x3
+#define PHY3P_TX_EQ_PRE_G2_DEFAULT		0x2
+#define PHY3P_TX_IBOOST_LVL_DEFAULT		0xf
+#define PHY3P_TX_TERM_CTRL_DEFAULT		0x2
+
+#define PHY3P00_DEFAULT ( \
+	PHY3P00_RX_ADAPT_AFE_EN_G1 | \
+	PHY3P00_RX_ADAPT_AFE_EN_G2 | \
+	PHY3P00_RX_ADAPT_DFE_EN_G1 | \
+	PHY3P00_RX_ADAPT_DFE_EN_G2 | \
+	FIELD_PREP(PHY3P00_RX_EQ_CTLE_BOOST_G1, PHY3P_RX_EQ_CTLE_BOOST_G1_DEFAULT) | \
+	FIELD_PREP(PHY3P00_RX_EQ_CTLE_BOOST_G2, PHY3P_RX_EQ_CTLE_BOOST_G2_DEFAULT) | \
+	FIELD_PREP(PHY3P00_RX_EQ_DELTA_IQ_G1_LO, \
+		   PHY3P_RX_EQ_DELTA_IQ_G1_DEFAULT & 0x3) \
+)
+
+#define PHY3P04_DEFAULT ( \
+	FIELD_PREP(PHY3P04_RX_EQ_DELTA_IQ_G1_HI, \
+		   PHY3P_RX_EQ_DELTA_IQ_G1_DEFAULT >> 2) | \
+	FIELD_PREP(PHY3P04_RX_EQ_DELTA_IQ_G2, PHY3P_RX_EQ_DELTA_IQ_G2_DEFAULT) | \
+	PHY3P04_RX_LOS_LFPS_EN | \
+	FIELD_PREP(PHY3P04_RX_LOS_THRESHOLD, PHY3P_RX_LOS_THRESHOLD_DEFAULT) | \
+	FIELD_PREP(PHY3P04_RX_TERM_CTRL, PHY3P_RX_TERM_CTRL_DEFAULT) | \
+	FIELD_PREP(PHY3P04_TX_EQ_MAIN_G1_LO, \
+		   PHY3P_TX_EQ_MAIN_G1_DEFAULT & 0x7) \
+)
+
+#define PHY3P08_DEFAULT ( \
+	FIELD_PREP(PHY3P08_TX_EQ_MAIN_G1_HI, PHY3P_TX_EQ_MAIN_G1_DEFAULT >> 3) | \
+	FIELD_PREP(PHY3P08_TX_EQ_MAIN_G2, PHY3P_TX_EQ_MAIN_G2_DEFAULT) | \
+	FIELD_PREP(PHY3P08_TX_EQ_POST_G1, PHY3P_TX_EQ_POST_G1_DEFAULT) | \
+	FIELD_PREP(PHY3P08_TX_EQ_POST_G2, PHY3P_TX_EQ_POST_G2_DEFAULT) | \
+	FIELD_PREP(PHY3P08_TX_EQ_PRE_G2, PHY3P_TX_EQ_PRE_G2_DEFAULT) | \
+	FIELD_PREP(PHY3P08_TX_IBOOST_LVL, PHY3P_TX_IBOOST_LVL_DEFAULT) | \
+	FIELD_PREP(PHY3P08_TX_TERM_CTRL, PHY3P_TX_TERM_CTRL_DEFAULT) \
+)
+
+#define PHY3P0C_DEFAULT \
+	PHY3P0C_TX_VBOOST_EN
+
+struct aspeed_usb3_phy {
+	void __iomem *regs;
+	struct reset_control *rst;
+	struct device *dev;
+	struct clk *clk;
+};
+
+static int aspeed_usb3_phy_init(struct phy *phy)
+{
+	struct aspeed_usb3_phy *aspeed_phy = phy_get_drvdata(phy);
+	u32 val;
+	int ret;
+
+	ret = clk_prepare_enable(aspeed_phy->clk);
+	if (ret) {
+		dev_err(aspeed_phy->dev, "Failed to enable clock %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_control_deassert(aspeed_phy->rst);
+	if (ret)
+		goto err_disable_clk;
+
+	/* Wait for USB3 PHY internal SRAM initialization done */
+	ret = readl_poll_timeout(aspeed_phy->regs + PHY3S00, val,
+				 val & PHY3S00_INIT_DONE,
+				 USEC_PER_MSEC, 10 * USEC_PER_MSEC);
+	if (ret) {
+		dev_err(aspeed_phy->dev, "SRAM init timeout\n");
+		goto err_assert_reset;
+	}
+
+	val = readl(aspeed_phy->regs + PHY3S00);
+	val |= PHY3S00_SRAM_EXT_LOAD;
+	writel(val, aspeed_phy->regs + PHY3S00);
+
+	/* Set protocol1_ext signals as default PHY3 settings based on SNPS documents.
+	 * Including PCFGI[54]: protocol1_ext_rx_los_lfps_en for better compatibility
+	 */
+	writel(PHY3P00_DEFAULT, aspeed_phy->regs + PHY3P00);
+	writel(PHY3P04_DEFAULT, aspeed_phy->regs + PHY3P04);
+	writel(PHY3P08_DEFAULT, aspeed_phy->regs + PHY3P08);
+	writel(PHY3P0C_DEFAULT, aspeed_phy->regs + PHY3P0C);
+
+	return 0;
+
+err_assert_reset:
+	reset_control_assert(aspeed_phy->rst);
+err_disable_clk:
+	clk_disable_unprepare(aspeed_phy->clk);
+	return ret;
+}
+
+static int aspeed_usb3_phy_exit(struct phy *phy)
+{
+	struct aspeed_usb3_phy *aspeed_phy = phy_get_drvdata(phy);
+
+	reset_control_assert(aspeed_phy->rst);
+	clk_disable_unprepare(aspeed_phy->clk);
+
+	return 0;
+}
+
+static const struct phy_ops aspeed_usb3_phy_ops = {
+	.init		= aspeed_usb3_phy_init,
+	.exit		= aspeed_usb3_phy_exit,
+	.owner		= THIS_MODULE,
+};
+
+static int aspeed_usb3_phy_probe(struct platform_device *pdev)
+{
+	struct aspeed_usb3_phy *aspeed_phy;
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct phy *phy;
+
+	aspeed_phy = devm_kzalloc(dev, sizeof(*aspeed_phy), GFP_KERNEL);
+	if (!aspeed_phy)
+		return -ENOMEM;
+
+	aspeed_phy->dev = dev;
+
+	aspeed_phy->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(aspeed_phy->clk))
+		return PTR_ERR(aspeed_phy->clk);
+
+	aspeed_phy->rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(aspeed_phy->rst))
+		return PTR_ERR(aspeed_phy->rst);
+
+	aspeed_phy->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(aspeed_phy->regs))
+		return PTR_ERR(aspeed_phy->regs);
+
+	phy = devm_phy_create(dev, NULL, &aspeed_usb3_phy_ops);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	phy_set_drvdata(phy, aspeed_phy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id aspeed_usb3_phy_match_table[] = {
+	{
+		.compatible = "aspeed,ast2700-usb3-phy",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, aspeed_usb3_phy_match_table);
+
+static struct platform_driver aspeed_usb3_phy_driver = {
+	.probe		= aspeed_usb3_phy_probe,
+	.driver		= {
+		.name	= KBUILD_MODNAME,
+		.of_match_table	= aspeed_usb3_phy_match_table,
+	},
+};
+module_platform_driver(aspeed_usb3_phy_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ASPEED USB3.2 PHY Driver");
+MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");

-- 
2.34.1


