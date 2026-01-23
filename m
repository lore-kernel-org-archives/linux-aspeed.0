Return-Path: <linux-aspeed+bounces-3427-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F25D72364
	for <linux-aspeed@archiver.kernel.org>; Fri, 23 Jan 2026 09:26:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dyCHZ5WCZz309S;
	Fri, 23 Jan 2026 20:26:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769160410;
	cv=none; b=GIwwuPGtCUGV1Qb1Gg2Jl69f/VFRCocjeYySHlxSr8bd5wF2tXPlxfSFXkaj2/YXcitJlaMTHW7aUaqiSisZNOU4bEHb8nh7ObG6Vx7+2lkyR88QGDH7FLquoUKbuYsEPND2D6ldUdAc+XMrWvC5c6zxw8kXT1bGzoCdfdgxWrgni9DVvBiz11qW9KBhppGyi+aIRVK0yXpk4PDU5sr0M2ZXxk8/JG+8RyEvmhe8+RrOaBG0Tn/94eqQtwyPAw2qw2G6sGQZFdibsSLJ9nTNkScpk500DvyHjLxPysnngXR7WZoxi0hqGdMB1M8FCONY1JZ4w2Xd+13f9zgrhL9O1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769160410; c=relaxed/relaxed;
	bh=m/ffm+yyut56QN7ZcaIqXy7/dylXDhGB4suG0Kat3AI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Xip6+aCLggfiXTr51YwfjgE0zG2E4+nS7ViRDOZg4EKocS/rN9f4Ls+T3vTErqxH51nKPCHTBFrF8clQNHmtC7ACGmomryrE5yAzbzvU0WtsITVNYLoc1IdAEvWdi5S5R1MnGzl/wlSJxc9MWb/pZuoaUVtlAXeIokNidAQzx30ejb7wbPhqvbDxNs6kYBm/g56nHh5CpJdjJzPu+35+T+eVYIhZ5B2qo78v79nD5HO+bmAVnVy2J8hyzrWV0vgvQ0T0fFC4TN6sWw5oJcsQhxp0YB3+HPhcVI5LPs89dOCq8+p+rR7i7duAVxRIAQfclqZ8mTo26HpbQHjsX7mKJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dyCHZ1yGHz2xKh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 23 Jan 2026 20:26:50 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 23 Jan
 2026 17:26:27 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 23 Jan 2026 17:26:27 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 23 Jan 2026 17:26:31 +0800
Subject: [PATCH v2 6/6] gpio: aspeed-sgpio: Support G7 Aspeed sgpiom
 controller
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
Message-ID: <20260123-upstream_sgpio-v2-6-69cfd1631400@aspeedtech.com>
References: <20260123-upstream_sgpio-v2-0-69cfd1631400@aspeedtech.com>
In-Reply-To: <20260123-upstream_sgpio-v2-0-69cfd1631400@aspeedtech.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Andrew
 Jeffery" <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
	<bmc-sw@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769160386; l=5872;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=Yc0Am0JOK83f2qlQR8wy0adnCkIm88yQxe8eRCbOxTw=;
 b=qDEskd91oEVv3mtQ7vh96cpdr2vm6lBb1mwHJDfrJmAukdsk6JrYvA9PUjH5GxI1Rikq2++1z
 jOWA1tTl43NCaSCKupaIC6opihZ2EYMQNMir4ljwlIbTtckHZ+MwOMJ
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

In the 7th generation of the SoC from Aspeed, the control logic of the
SGPIO controller has been updated to support per-pin control. Each pin now
has its own 32-bit register, allowing for individual control of the pin's
value, interrupt type, and other settings.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/gpio/gpio-aspeed-sgpio.c | 110 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index b5270e11b153..4225261f61c8 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -19,7 +19,31 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 
-#define ASPEED_SGPIO_CTRL		0x54
+#define SGPIO_G7_IRQ_STS_BASE 0x40
+#define SGPIO_G7_IRQ_STS_OFFSET(x) (SGPIO_G7_IRQ_STS_BASE + (x) * 0x4)
+#define SGPIO_G7_CTRL_REG_BASE 0x80
+#define SGPIO_G7_CTRL_REG_OFFSET(x) (SGPIO_G7_CTRL_REG_BASE + (x) * 0x4)
+#define SGPIO_G7_OUT_DATA BIT(0)
+#define SGPIO_G7_PARALLEL_OUT_DATA BIT(1)
+#define SGPIO_G7_IRQ_EN BIT(2)
+#define SGPIO_G7_IRQ_TYPE0 BIT(3)
+#define SGPIO_G7_IRQ_TYPE1 BIT(4)
+#define SGPIO_G7_IRQ_TYPE2 BIT(5)
+#define SGPIO_G7_RST_TOLERANCE BIT(6)
+#define SGPIO_G7_INPUT_MASK BIT(9)
+#define SGPIO_G7_HW_BYPASS_EN BIT(10)
+#define SGPIO_G7_HW_IN_SEL BIT(11)
+#define SGPIO_G7_IRQ_STS BIT(12)
+#define SGPIO_G7_IN_DATA BIT(13)
+#define SGPIO_G7_PARALLEL_IN_DATA BIT(14)
+#define SGPIO_G7_SERIAL_OUT_SEL GENMASK(17, 16)
+#define SGPIO_G7_PARALLEL_OUT_SEL GENMASK(19, 18)
+#define SELECT_FROM_CSR 0
+#define SELECT_FROM_PARALLEL_IN 1
+#define SELECT_FROM_SERIAL_IN 2
+
+#define ASPEED_SGPIO_G4_CFG_OFFSET 0x54
+#define ASPEED_SGPIO_G7_CFG_OFFSET 0x0
 
 #define ASPEED_SGPIO_CLK_DIV_MASK	GENMASK(31, 16)
 #define ASPEED_SGPIO_ENABLE		BIT(0)
@@ -28,6 +52,7 @@
 struct aspeed_sgpio_pdata {
 	const u32 pin_mask;
 	const struct aspeed_sgpio_llops *llops;
+	const u32 cfg_offset;
 };
 
 struct aspeed_sgpio {
@@ -135,6 +160,30 @@ static void __iomem *aspeed_sgpio_g4_bank_reg(struct aspeed_sgpio *gpio,
 	}
 }
 
+static u32 aspeed_sgpio_g7_reg_mask(const enum aspeed_sgpio_reg reg)
+{
+	switch (reg) {
+	case reg_val:
+	case reg_rdata:
+		return SGPIO_G7_OUT_DATA;
+	case reg_irq_enable:
+		return SGPIO_G7_IRQ_EN;
+	case reg_irq_type0:
+		return SGPIO_G7_IRQ_TYPE0;
+	case reg_irq_type1:
+		return SGPIO_G7_IRQ_TYPE1;
+	case reg_irq_type2:
+		return SGPIO_G7_IRQ_TYPE2;
+	case reg_irq_status:
+		return SGPIO_G7_IRQ_STS;
+	case reg_tolerance:
+		return SGPIO_G7_RST_TOLERANCE;
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
+
 #define GPIO_BANK(x)    ((x) >> 6)
 #define GPIO_OFFSET(x)  ((x) & GENMASK(5, 0))
 #define GPIO_BIT(x)     BIT(GPIO_OFFSET(x) >> 1)
@@ -457,6 +506,7 @@ static const struct aspeed_sgpio_llops aspeed_sgpio_g4_llops = {
 static const struct aspeed_sgpio_pdata ast2400_sgpio_pdata = {
 	.pin_mask = GENMASK(9, 6),
 	.llops = &aspeed_sgpio_g4_llops,
+	.cfg_offset = ASPEED_SGPIO_G4_CFG_OFFSET,
 };
 
 static int aspeed_sgpio_reset_tolerance(struct gpio_chip *chip,
@@ -486,12 +536,68 @@ static int aspeed_sgpio_set_config(struct gpio_chip *chip, unsigned int offset,
 static const struct aspeed_sgpio_pdata ast2600_sgpiom_pdata = {
 	.pin_mask = GENMASK(10, 6),
 	.llops = &aspeed_sgpio_g4_llops,
+	.cfg_offset = ASPEED_SGPIO_G4_CFG_OFFSET,
+};
+
+static void aspeed_sgpio_g7_reg_bit_set(struct aspeed_sgpio *gpio, unsigned int offset,
+					const enum aspeed_sgpio_reg reg, bool val)
+{
+	u32 mask = aspeed_sgpio_g7_reg_mask(reg);
+	void __iomem *addr = gpio->base + SGPIO_G7_CTRL_REG_OFFSET(offset >> 1);
+	u32 write_val;
+
+	if (mask) {
+		write_val = (ioread32(addr) & ~(mask)) | field_prep(mask, val);
+		iowrite32(write_val, addr);
+	}
+}
+
+static bool aspeed_sgpio_g7_reg_bit_get(struct aspeed_sgpio *gpio, unsigned int offset,
+					const enum aspeed_sgpio_reg reg)
+{
+	u32 mask = aspeed_sgpio_g7_reg_mask(reg);
+	void __iomem *addr;
+
+	addr = gpio->base + SGPIO_G7_CTRL_REG_OFFSET(offset >> 1);
+	if (reg == reg_val)
+		mask = SGPIO_G7_IN_DATA;
+
+	if (mask)
+		return field_get(mask, ioread32(addr));
+	else
+		return 0;
+}
+
+static int aspeed_sgpio_g7_reg_bank_get(struct aspeed_sgpio *gpio, unsigned int offset,
+					const enum aspeed_sgpio_reg reg)
+{
+	void __iomem *addr;
+
+	if (reg == reg_irq_status) {
+		addr = gpio->base + SGPIO_G7_IRQ_STS_OFFSET(offset >> 6);
+		return ioread32(addr);
+	} else {
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct aspeed_sgpio_llops aspeed_sgpio_g7_llops = {
+	.reg_bit_set = aspeed_sgpio_g7_reg_bit_set,
+	.reg_bit_get = aspeed_sgpio_g7_reg_bit_get,
+	.reg_bank_get = aspeed_sgpio_g7_reg_bank_get,
+};
+
+static const struct aspeed_sgpio_pdata ast2700_sgpiom_pdata = {
+	.pin_mask = GENMASK(11, 6),
+	.llops = &aspeed_sgpio_g7_llops,
+	.cfg_offset = ASPEED_SGPIO_G7_CFG_OFFSET,
 };
 
 static const struct of_device_id aspeed_sgpio_of_table[] = {
 	{ .compatible = "aspeed,ast2400-sgpio", .data = &ast2400_sgpio_pdata, },
 	{ .compatible = "aspeed,ast2500-sgpio", .data = &ast2400_sgpio_pdata, },
 	{ .compatible = "aspeed,ast2600-sgpiom", .data = &ast2600_sgpiom_pdata, },
+	{ .compatible = "aspeed,ast2700-sgpiom", .data = &ast2700_sgpiom_pdata, },
 	{}
 };
 
@@ -562,7 +668,7 @@ static int aspeed_sgpio_probe(struct platform_device *pdev)
 
 	gpio_cnt_regval = ((nr_gpios / 8) << ASPEED_SGPIO_PINS_SHIFT) & pin_mask;
 	iowrite32(FIELD_PREP(ASPEED_SGPIO_CLK_DIV_MASK, sgpio_clk_div) | gpio_cnt_regval |
-		  ASPEED_SGPIO_ENABLE, gpio->base + ASPEED_SGPIO_CTRL);
+		  ASPEED_SGPIO_ENABLE, gpio->base + gpio->pdata->cfg_offset);
 
 	raw_spin_lock_init(&gpio->lock);
 

-- 
2.34.1


