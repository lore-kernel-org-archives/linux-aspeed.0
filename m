Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F49606A32F
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Nov 2026 09:27:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTKBF6jpbz2xqL;
	Tue, 17 Nov 2026 20:27:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794907621;
	cv=none; b=WcMeowLHImFbbKOaTOoruNZrthDHHciiQrn535BO+mtiAADui3Xp7QUiIQl0UDsFd4tnIEigV2n3nDZnm4do6NrQYwrv4w7bMr++3+0sInEH3lbNBQ5vDdA5pP6qFPETdY+rVkue6NZXzC6sJliLRTY3ORQ2lXSFq5PkNh9mXYe8nzANjRIIDfW/o4O86Ec2pEtT/apK55AWY00twd0fxoR3HneMPzqHPmTumQkHQfN4AZlhhCAqYcc34iFqNT650UUfU9NAfZ8Q9XI3QDxJz9yM2A+zl/lNwx5SC966q6zlZW3oKGVWaPGLwui25Hc0iM9XOqhFT53kA21uZlH4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794907621; c=relaxed/relaxed;
	bh=NjspIdULMg7iYxZU8ciTyGANW0Jy2UWFALO35B1t9g4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JVmQCLCRFsiat/OzWPv6Zo/kY7usKBaOBe9k5Km5dv6CAPCbNu89DajQpZ4Aj5s6sS5J+sIGV7V67qMAsP5CWojR8WG0I76Am5v2zk9Y23WkIayQACFgNagSCsxG9wN76pGx2sE/lRD+Uj2nZ4NCTyFq5+gZMS/lzmYQwz3GFR8DcHiDQA4X7z5eQ8gJSGoq1y0hHY4tJ4lJ5DgFKjzzBI1x4Msm6o5D9oC19055UOgTcJOtnl6MhkmJgN4Vjy5NNf4vVpCgUbPOyIXqeTvU2KAppCQJ5JnqsqebHs3tMrjso4jbIIwLR5f7+A7h6iMN09LclwdUfjQXxpVmYZ63DA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTKBD68wWz2xNT
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Nov 2026 20:27:00 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 17 Nov
 2026 17:26:40 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 17 Nov 2026 17:26:40 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 17 Nov 2026 17:26:39 +0800
Subject: [PATCH v6 2/4] EDAC/aspeed: Abstract SoC differences behind chip
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261117-edac-v6-2-a2a747b95c3f@aspeedtech.com>
References: <20261117-edac-v6-0-a2a747b95c3f@aspeedtech.com>
In-Reply-To: <20261117-edac-v6-0-a2a747b95c3f@aspeedtech.com>
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794907599; l=11979;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=EEwiuXJ7hu02htNaANKzEnbtK9SyJ+0wSMSbPPYgigA=;
 b=x0L05ljwZtDSnORPM0Pr+2MWpjxZUcAcRz/6F0RF7+R/oB/r/Y2LjAagwD1dUJOv5YcL4Lg0q
 4ZLkFHJ2bBKDR2Uxzf40dulZ1AtlJQRqp+o2wSXal9/5bzAUI6LWnod
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

---
Changes in v6:
- Follow patch 1 ("EDAC/aspeed: Replace regmap with direct register
  access"): spinlock_t, no __guarded_by()/__must_hold().

Changes in v5:
- Follow v5 patch 2 ("EDAC/aspeed: Free the interrupt before the
  mem_ctl_info on remove", now applied) in using request_irq()/free_irq().

Changes in v2:
- Carry over the irqsave lock acquisition in init_csrows() and the
  dev_dbg() moved out of the raw_spinlock critical section.
- Store the interrupt number in struct aspeed_edac so that
  aspeed_remove() can free the interrupt without looking it up again.
---
 drivers/edac/aspeed_edac.c | 156 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 110 insertions(+), 46 deletions(-)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index 1c773dbec002..d56626821ce0 100644
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
@@ -30,9 +32,23 @@
 #define ASPEED_MCR_INTR_CTRL_CNT_UNREC  GENMASK(15, 12)
 #define ASPEED_MCR_INTR_CTRL_ENABLE     (BIT(0) | BIT(1))
 
-static DEFINE_SPINLOCK(aspeed_lock);
-static void __iomem *aspeed_regs;
-static int aspeed_irq;
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
+	spinlock_t lock;
+
+	void __iomem *regs;
+	const struct aspeed_edac_chip *chip;
+	int irq;
+};
 
 static void count_rec(struct mem_ctl_info *mci, u8 rec_cnt, u32 rec_addr)
 {
@@ -97,37 +113,52 @@ static void count_un_rec(struct mem_ctl_info *mci, u8 un_rec_cnt,
 	}
 }
 
-static irqreturn_t mcr_isr(int irq, void *arg)
+static void aspeed_mcr_irq_update_enter(struct aspeed_edac *priv)
+{
+	if (priv->chip->prot_key)
+		writel(priv->chip->prot_key, priv->regs + priv->chip->prot_reg);
+}
+
+static void aspeed_mcr_irq_update_exit(struct aspeed_edac *priv)
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
 
-	scoped_guard(spinlock, &aspeed_lock) {
-		reg50 = readl(aspeed_regs + ASPEED_MCR_INTR_CTRL);
-		un_rec_addr = readl(aspeed_regs + ASPEED_MCR_ADDR_UNREC);
-		rec_addr = readl(aspeed_regs + ASPEED_MCR_ADDR_REC);
+	priv = mci->pvt_info;
+
+	scoped_guard(spinlock, &priv->lock) {
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
@@ -137,35 +168,36 @@ static irqreturn_t mcr_isr(int irq, void *arg)
 	count_un_rec(mci, un_rec_cnt, un_rec_addr);
 
 	if (!rec_cnt && !un_rec_cnt)
-		dev_dbg(mci->pdev, "received edac interrupt, but did not find any ECC counters\n");
+		dev_dbg_ratelimited(mci->pdev, "received edac interrupt, but did not find any ECC counters\n");
 
-	scoped_guard(spinlock, &aspeed_lock)
-		reg50 = readl(aspeed_regs + ASPEED_MCR_INTR_CTRL);
+	scoped_guard(spinlock, &priv->lock)
+		reg50 = readl(priv->regs + ASPEED_MCR_INTR_CTRL);
 	dev_dbg(mci->pdev, "edac interrupt handled. mcr reg 50 is now: 0x%x\n",
 		reg50);
 
 	return IRQ_HANDLED;
 }
 
-static void aspeed_set_irq(bool enable)
+static void aspeed_set_irq(struct aspeed_edac *priv, bool enable)
 {
 	u32 val;
 
-	guard(spinlock_irqsave)(&aspeed_lock);
+	guard(spinlock_irqsave)(&priv->lock);
 
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
 
@@ -175,14 +207,14 @@ static int config_irq(void *ctx, struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	rc = request_irq(irq, mcr_isr, IRQF_TRIGGER_HIGH, DRV_NAME, ctx);
+	rc = request_irq(irq, aspeed_mcr_isr, IRQF_TRIGGER_HIGH, DRV_NAME, mci);
 	if (rc)
 		return rc;
 
-	aspeed_irq = irq;
+	priv->irq = irq;
 
 	/* enable interrupts */
-	aspeed_set_irq(true);
+	aspeed_set_irq(priv, true);
 
 	return 0;
 }
@@ -190,11 +222,13 @@ static int config_irq(void *ctx, struct platform_device *pdev)
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
@@ -220,12 +254,12 @@ static int init_csrows(struct mem_ctl_info *mci)
 	nr_pages = resource_size(&r) >> PAGE_SHIFT;
 	csrow->last_page = csrow->first_page + nr_pages - 1;
 
-	scoped_guard(spinlock_irqsave, &aspeed_lock)
-		reg04 = readl(aspeed_regs + ASPEED_MCR_CONF);
-	dram_type = (reg04 & ASPEED_MCR_CONF_DRAM_TYPE) ? MEM_DDR4 : MEM_DDR3;
+	scoped_guard(spinlock_irqsave, &priv->lock)
+		conf = readl(priv->regs + priv->chip->conf_reg);
+	type = field_get(priv->chip->conf_dram_type, conf);
 
 	dimm = csrow->channels[0]->dimm;
-	dimm->mtype = dram_type;
+	dimm->mtype = priv->chip->dram_type[type];
 	dimm->edac_mode = EDAC_SECDED;
 	dimm->nr_pages = nr_pages / csrow->nr_channels;
 	dimm->grain = 16;
@@ -238,21 +272,26 @@ static int init_csrows(struct mem_ctl_info *mci)
 
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
 
-	aspeed_regs = regs;
-
 	/* bail out if ECC mode is not configured */
-	reg04 = readl(regs + ASPEED_MCR_CONF);
-	if (!(reg04 & ASPEED_MCR_CONF_ECC)) {
+	conf = readl(regs + chip->conf_reg);
+	if (!field_get(chip->conf_ecc, conf)) {
 		dev_err(&pdev->dev, "ECC mode is not configured in u-boot\n");
 		return -EPERM;
 	}
@@ -267,12 +306,17 @@ static int aspeed_probe(struct platform_device *pdev)
 	layers[1].size = 1;
 	layers[1].is_virt_csrow = false;
 
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, 0);
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*priv));
 	if (!mci)
 		return -ENOMEM;
 
+	priv = mci->pvt_info;
+	priv->chip = chip;
+	spin_lock_init(&priv->lock);
+	priv->regs = regs;
+
 	mci->pdev = &pdev->dev;
-	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR4;
+	mci->mtype_cap = chip->mtype_cap;
 	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
 	mci->edac_cap = EDAC_FLAG_SECDED;
 	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
@@ -315,21 +359,41 @@ static int aspeed_probe(struct platform_device *pdev)
 static void aspeed_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct aspeed_edac *priv = mci->pvt_info;
 
 	/* disable interrupts */
-	aspeed_set_irq(false);
+	aspeed_set_irq(priv, false);
 
-	free_irq(aspeed_irq, mci);
+	free_irq(priv->irq, mci);
 
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


