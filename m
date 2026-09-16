Return-Path: <linux-aspeed+bounces-5006-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9465C982C4
	for <linux-aspeed@archiver.kernel.org>; Wed, 16 Sep 2026 05:31:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl6td03H8z2ylm;
	Wed, 16 Sep 2026 15:31:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789536664;
	cv=none; b=IPxxMcWLN5xV2vo4JS+vV4pw39Fz7AiVg3q6bdTUiNphJHpbBXOT8gExgJ7JtvezNbsO2u/bZ9bTrzogQap7yijII3LhzJbxF8pnXzUHC1cmMAf1Y5qj3VlHnSN02I8kM7KPpJi1UqPkPGaZ2CnCr3hpe+L1T/Hw50yvIqXbdxixu0QBr6VgB2Eq28OVYBIbyCi6dxpcIE++vIMhwWN2syhLbh91QS1rtA8dYw085l1JyzoswgXQULZmaN6CX5HZ7TlQSX+N9/FFqQMNWb0hnR799XYMx7tAUWTYhr/KaEfD7TNbTo/8K4tZlKtm/0nbNeXvAyTYWp9WNxG91Q5/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789536664; c=relaxed/relaxed;
	bh=a1g4cFM2WSPo1E46t/j2LwC9w7NZQoGrUjOI+UYrux0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gFiOSIXTWqdL5x1B2CWNR9gfgW+gE61oA6iTIz5+I70xruCAMGIjBZEiH1DNXvaezlwyKXf8zRRqHQ0jKWtYo8SPVvA/ukKkQkqifPBsoYJR0+m4I5FJxx/UCjLm0sI3grARcnxwvkOoi30qvwoxdVx+VnPNU7P46zu1gv0sr6/g5r7ACWnnHJSsjS6yf98lCwE7yAaLPPySnVKY56pPG/tt36l7mr3uDABNhibrRJjbo2RWIAKA0MghXB8oQuMMleTPpwSba5OF3DoPCh2xDFJFWxu3k4sie9oYzaBGuOYoLsdmvGHXmC7+fpb6hbYb4e9h5Cy7d5/8XtLwjXmi7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl6tc0BDcz2xbQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Sep 2026 15:31:04 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 16 Sep
 2026 13:30:40 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 16 Sep 2026 13:30:40 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 16 Sep 2026 13:30:44 +0800
Subject: [PATCH v3 7/9] EDAC/aspeed: Abstract SoC differences behind chip
 data
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
Message-ID: <20260916-edac-v3-7-23e9ed2fbdf9@aspeedtech.com>
References: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
In-Reply-To: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789536639; l=12030;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=9GcVj2fdxxCTsPwP9/o+MgofFZHMPAKymQnxcoTT3v0=;
 b=S4C32eLjvBqBvrQHBRKPboO0xtuqIJM+z+c/PwsispYoHuUaLCksGnvOZjTikhbw17zlJqnn5
 rloOduC/fnpB5xEdmqV8F5yJ3NhhCLuXerM9w3CpTvdZmT5uiFpL9QT
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The driver hard-codes the AST2400/2500/2600 register layout, ECC and
DRAM-type bits, memory types and write-protection key. Abstract these
SoC-specific details behind a per-SoC struct aspeed_edac_chip selected by
the compatible, and move the per-instance state (register base, lock)
into mci->pvt_info instead of globals, so controller variants that differ
in these details can be added as table data.

Only the AST2400 and AST2500 key-protect the interrupt control register
(MCR50); the AST2600 does not. Gate the unlock/relock on the chip carrying
a protection key and split the shared entry into keyed (AST2400/2500) and
unkeyed (AST2600) variants, so the AST2600 no longer performs the
unnecessary unlock.

Tested on an AST2600: A correctable error was injected from the console by
unlocking the controller and writing its ECC error inject test register:

  # mw 1e6e0000 fc600309
  # mw 1e6e00b0 81
  EDAC MC0: 1 CE address(es) not available on mc#0csrow#0channel#0 (csrow:0 channel:0 page:0x0 offset:0x0 grain:16 syndrome:0x0)
  EDAC MC0: 1 CE on mc#0csrow#0channel#0 (csrow:0 channel:0 page:0x8a543 offset:0xec0 grain:16 syndrome:0x0)

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

---
Changes in v2:
- Carry over the irqsave lock acquisition in init_csrows() and the
  dev_dbg() moved out of the raw_spinlock critical section.
- Store the interrupt number in struct aspeed_edac so that
  aspeed_remove() can free the interrupt without looking it up again.
---
 drivers/edac/aspeed_edac.c | 163 +++++++++++++++++++++++++++++++--------------
 1 file changed, 114 insertions(+), 49 deletions(-)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index 26d2c456cc0d..e88d9d2646de 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -3,12 +3,14 @@
  * Copyright 2018, 2019 Cisco Systems
  */
 
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/edac.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
@@ -30,8 +32,23 @@
 #define ASPEED_MCR_INTR_CTRL_CNT_UNREC  GENMASK(15, 12)
 #define ASPEED_MCR_INTR_CTRL_ENABLE     (BIT(0) | BIT(1))
 
-static DEFINE_RAW_SPINLOCK(aspeed_lock);
-static void __iomem *aspeed_regs __guarded_by(&aspeed_lock);
+struct aspeed_edac_chip {
+	unsigned int conf_reg;
+	u32 conf_ecc;
+	u32 conf_dram_type;
+	enum mem_type dram_type[2];
+	unsigned long mtype_cap;
+	unsigned int prot_reg;
+	u32 prot_key;
+};
+
+struct aspeed_edac {
+	raw_spinlock_t lock;
+
+	void __iomem *regs __guarded_by(&lock);
+	const struct aspeed_edac_chip *chip;
+	int irq;
+};
 
 static void count_rec(struct mem_ctl_info *mci, u8 rec_cnt, u32 rec_addr)
 {
@@ -96,37 +113,54 @@ static void count_un_rec(struct mem_ctl_info *mci, u8 un_rec_cnt,
 	}
 }
 
-static irqreturn_t mcr_isr(int irq, void *arg)
+static void aspeed_mcr_irq_update_enter(struct aspeed_edac *priv)
+	__must_hold(&priv->lock)
+{
+	if (priv->chip->prot_key)
+		writel(priv->chip->prot_key, priv->regs + priv->chip->prot_reg);
+}
+
+static void aspeed_mcr_irq_update_exit(struct aspeed_edac *priv)
+	__must_hold(&priv->lock)
+{
+	if (priv->chip->prot_key)
+		writel(~priv->chip->prot_key, priv->regs + priv->chip->prot_reg);
+}
+
+static irqreturn_t aspeed_mcr_isr(int irq, void *arg)
 {
 	struct mem_ctl_info *mci = arg;
 	u32 rec_addr, un_rec_addr;
+	struct aspeed_edac *priv;
 	u8 rec_cnt, un_rec_cnt;
 	u32 reg50;
 
-	scoped_guard(raw_spinlock, &aspeed_lock) {
-		reg50 = readl(aspeed_regs + ASPEED_MCR_INTR_CTRL);
-		un_rec_addr = readl(aspeed_regs + ASPEED_MCR_ADDR_UNREC);
-		rec_addr = readl(aspeed_regs + ASPEED_MCR_ADDR_REC);
+	priv = mci->pvt_info;
+
+	scoped_guard(raw_spinlock, &priv->lock) {
+		reg50 = readl(priv->regs + ASPEED_MCR_INTR_CTRL);
+		un_rec_addr = readl(priv->regs + ASPEED_MCR_ADDR_UNREC);
+		rec_addr = readl(priv->regs + ASPEED_MCR_ADDR_REC);
 
 		/*
 		 * Clearing the counters needs a set-then-clear of CLEAR. The
 		 * counter and interrupt flag fields are read-only, so writing
 		 * back the values read above leaves them unaffected.
 		 */
-		writel(ASPEED_MCR_PROT_PASSWD, aspeed_regs + ASPEED_MCR_PROT);
+		aspeed_mcr_irq_update_enter(priv);
 		writel(reg50 | ASPEED_MCR_INTR_CTRL_CLEAR,
-		       aspeed_regs + ASPEED_MCR_INTR_CTRL);
+		       priv->regs + ASPEED_MCR_INTR_CTRL);
 		writel(reg50 & ~ASPEED_MCR_INTR_CTRL_CLEAR,
-		       aspeed_regs + ASPEED_MCR_INTR_CTRL);
-		writel(~ASPEED_MCR_PROT_PASSWD, aspeed_regs + ASPEED_MCR_PROT);
+		       priv->regs + ASPEED_MCR_INTR_CTRL);
+		aspeed_mcr_irq_update_exit(priv);
 	}
 
 	dev_dbg(mci->pdev, "received edac interrupt w/ mcr register 50: 0x%x\n",
 		reg50);
 
 	/* collect data about recoverable and unrecoverable errors */
-	rec_cnt = (reg50 & ASPEED_MCR_INTR_CTRL_CNT_REC) >> 16;
-	un_rec_cnt = (reg50 & ASPEED_MCR_INTR_CTRL_CNT_UNREC) >> 12;
+	rec_cnt = FIELD_GET(ASPEED_MCR_INTR_CTRL_CNT_REC, reg50);
+	un_rec_cnt = FIELD_GET(ASPEED_MCR_INTR_CTRL_CNT_UNREC, reg50);
 
 	dev_dbg(mci->pdev, "%d recoverable interrupts and %d unrecoverable interrupts\n",
 		rec_cnt, un_rec_cnt);
@@ -136,35 +170,36 @@ static irqreturn_t mcr_isr(int irq, void *arg)
 	count_un_rec(mci, un_rec_cnt, un_rec_addr);
 
 	if (!rec_cnt && !un_rec_cnt)
-		dev_dbg(mci->pdev, "received edac interrupt, but did not find any ECC counters\n");
+		dev_dbg_ratelimited(mci->pdev, "received edac interrupt, but did not find any ECC counters\n");
 
-	scoped_guard(raw_spinlock, &aspeed_lock)
-		reg50 = readl(aspeed_regs + ASPEED_MCR_INTR_CTRL);
+	scoped_guard(raw_spinlock, &priv->lock)
+		reg50 = readl(priv->regs + ASPEED_MCR_INTR_CTRL);
 	dev_dbg(mci->pdev, "edac interrupt handled. mcr reg 50 is now: 0x%x\n",
 		reg50);
 
 	return IRQ_HANDLED;
 }
 
-static void aspeed_set_irq(bool enable)
+static void aspeed_set_irq(struct aspeed_edac *priv, bool enable)
 {
 	u32 val;
 
-	guard(raw_spinlock_irqsave)(&aspeed_lock);
+	guard(raw_spinlock_irqsave)(&priv->lock);
 
-	val = readl(aspeed_regs + ASPEED_MCR_INTR_CTRL);
+	val = readl(priv->regs + ASPEED_MCR_INTR_CTRL);
 	if (enable)
 		val |= ASPEED_MCR_INTR_CTRL_ENABLE;
 	else
 		val &= ~ASPEED_MCR_INTR_CTRL_ENABLE;
 
-	writel(ASPEED_MCR_PROT_PASSWD, aspeed_regs + ASPEED_MCR_PROT);
-	writel(val, aspeed_regs + ASPEED_MCR_INTR_CTRL);
-	writel(~ASPEED_MCR_PROT_PASSWD, aspeed_regs + ASPEED_MCR_PROT);
+	aspeed_mcr_irq_update_enter(priv);
+	writel(val, priv->regs + ASPEED_MCR_INTR_CTRL);
+	aspeed_mcr_irq_update_exit(priv);
 }
 
-static int config_irq(void *ctx, struct platform_device *pdev)
+static int config_irq(struct mem_ctl_info *mci, struct platform_device *pdev)
 {
+	struct aspeed_edac *priv = mci->pvt_info;
 	int irq;
 	int rc;
 
@@ -174,13 +209,15 @@ static int config_irq(void *ctx, struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	rc = devm_request_irq(&pdev->dev, irq, mcr_isr, IRQF_TRIGGER_HIGH,
-			      DRV_NAME, ctx);
+	rc = devm_request_irq(&pdev->dev, irq, aspeed_mcr_isr, IRQF_TRIGGER_HIGH,
+			      DRV_NAME, mci);
 	if (rc)
 		return rc;
 
+	priv->irq = irq;
+
 	/* enable interrupts */
-	aspeed_set_irq(true);
+	aspeed_set_irq(priv, true);
 
 	return 0;
 }
@@ -188,11 +225,13 @@ static int config_irq(void *ctx, struct platform_device *pdev)
 static int init_csrows(struct mem_ctl_info *mci)
 {
 	struct csrow_info *csrow = mci->csrows[0];
-	u32 nr_pages, dram_type;
-	struct dimm_info *dimm;
+	struct aspeed_edac *priv = mci->pvt_info;
 	struct device_node *np;
+	struct dimm_info *dimm;
 	struct resource r;
-	u32 reg04;
+	unsigned int type;
+	u32 nr_pages;
+	u32 conf;
 	int rc;
 
 	/* retrieve info about physical memory from device tree */
@@ -218,12 +257,12 @@ static int init_csrows(struct mem_ctl_info *mci)
 	nr_pages = resource_size(&r) >> PAGE_SHIFT;
 	csrow->last_page = csrow->first_page + nr_pages - 1;
 
-	scoped_guard(raw_spinlock_irqsave, &aspeed_lock)
-		reg04 = readl(aspeed_regs + ASPEED_MCR_CONF);
-	dram_type = (reg04 & ASPEED_MCR_CONF_DRAM_TYPE) ? MEM_DDR4 : MEM_DDR3;
+	scoped_guard(raw_spinlock_irqsave, &priv->lock)
+		conf = readl(priv->regs + priv->chip->conf_reg);
+	type = field_get(priv->chip->conf_dram_type, conf);
 
 	dimm = csrow->channels[0]->dimm;
-	dimm->mtype = dram_type;
+	dimm->mtype = priv->chip->dram_type[type];
 	dimm->edac_mode = EDAC_SECDED;
 	dimm->nr_pages = nr_pages / csrow->nr_channels;
 	dimm->grain = 16;
@@ -236,22 +275,26 @@ static int init_csrows(struct mem_ctl_info *mci)
 
 static int aspeed_probe(struct platform_device *pdev)
 {
+	const struct aspeed_edac_chip *chip;
+	struct device *dev = &pdev->dev;
 	struct edac_mc_layer layers[2];
+	struct aspeed_edac *priv;
 	struct mem_ctl_info *mci;
 	void __iomem *regs;
-	u32 reg04;
+	u32 conf;
 	int rc;
 
+	chip = of_device_get_match_data(dev);
+	if (!chip)
+		return -EINVAL;
+
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	scoped_guard(raw_spinlock_irqsave, &aspeed_lock)
-		aspeed_regs = regs;
-
 	/* bail out if ECC mode is not configured */
-	reg04 = readl(regs + ASPEED_MCR_CONF);
-	if (!(reg04 & ASPEED_MCR_CONF_ECC)) {
+	conf = readl(regs + chip->conf_reg);
+	if (!field_get(chip->conf_ecc, conf)) {
 		dev_err(&pdev->dev, "ECC mode is not configured in u-boot\n");
 		return -EPERM;
 	}
@@ -266,12 +309,17 @@ static int aspeed_probe(struct platform_device *pdev)
 	layers[1].size = 1;
 	layers[1].is_virt_csrow = false;
 
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, 0);
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*priv));
 	if (!mci)
 		return -ENOMEM;
 
+	priv = mci->pvt_info;
+	priv->chip = chip;
+	scoped_guard(raw_spinlock_init, &priv->lock)
+		priv->regs = regs;
+
 	mci->pdev = &pdev->dev;
-	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR4;
+	mci->mtype_cap = chip->mtype_cap;
 	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
 	mci->edac_cap = EDAC_FLAG_SECDED;
 	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
@@ -314,24 +362,41 @@ static int aspeed_probe(struct platform_device *pdev)
 static void aspeed_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
-	int irq;
+	struct aspeed_edac *priv = mci->pvt_info;
 
 	/* disable interrupts */
-	aspeed_set_irq(false);
+	aspeed_set_irq(priv, false);
 
-	irq = platform_get_irq(pdev, 0);
-	WARN_ON(irq < 0);
-	devm_free_irq(&pdev->dev, irq, mci);
+	devm_free_irq(&pdev->dev, priv->irq, mci);
 
 	/* free resources */
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
 }
 
+static const struct aspeed_edac_chip ast2400_edac = {
+	.conf_reg = ASPEED_MCR_CONF,
+	.conf_ecc = ASPEED_MCR_CONF_ECC,
+	.conf_dram_type = ASPEED_MCR_CONF_DRAM_TYPE,
+	.dram_type = { MEM_DDR3, MEM_DDR4 },
+	.mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR4,
+	.prot_reg = ASPEED_MCR_PROT,
+	.prot_key = ASPEED_MCR_PROT_PASSWD,
+};
+
+/* The AST2600 does not key-protect the interrupt control register (MCR50). */
+static const struct aspeed_edac_chip ast2600_edac = {
+	.conf_reg = ASPEED_MCR_CONF,
+	.conf_ecc = ASPEED_MCR_CONF_ECC,
+	.conf_dram_type = ASPEED_MCR_CONF_DRAM_TYPE,
+	.dram_type = { MEM_DDR3, MEM_DDR4 },
+	.mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR4,
+};
+
 static const struct of_device_id aspeed_of_match[] = {
-	{ .compatible = "aspeed,ast2400-sdram-edac" },
-	{ .compatible = "aspeed,ast2500-sdram-edac" },
-	{ .compatible = "aspeed,ast2600-sdram-edac" },
+	{ .compatible = "aspeed,ast2400-sdram-edac", .data = &ast2400_edac },
+	{ .compatible = "aspeed,ast2500-sdram-edac", .data = &ast2400_edac },
+	{ .compatible = "aspeed,ast2600-sdram-edac", .data = &ast2600_edac },
 	{},
 };
 

-- 
2.34.1


