Return-Path: <linux-aspeed+bounces-5005-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E801C982C7
	for <linux-aspeed@archiver.kernel.org>; Wed, 16 Sep 2026 05:31:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl6tb5hjSz2yjw;
	Wed, 16 Sep 2026 15:31:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789536663;
	cv=none; b=GvyG1+F0c7CmFBbc5GrhZKFinZB0XLX/HGWp5EVrgJovp8Wt/a9vlD/58tV9M5ugh8ItMMlC6CLtDkGKuodrTos580bZ2WYVFN3wV5/T0R+htAJytHFIzlze1eSFgobfc9FSKAMwSES69LctUZJOeK+2mezKARoLxTL4Shzf/6AjNc7TeZ/Mcp4S0UlqtDZhw8oVqWXEGpdGLP4SfYtKK+lAeuBI7w8X6/yeuKJwEAf625pHw2EEly5RF4rLIVhU/H+Q8TlTme0ycaRn0eSOxoD5L4XTzBE3qPlIw7WcunR8ntZ+eJnU6fEdk4Xls8v+PjPwyCNaSHm2Ks7zkAR79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789536663; c=relaxed/relaxed;
	bh=qKo3UAt+aea4ptaZgDeKs/FZOz2vSxjGek6rz3lGW3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=W4HOW1oIGMUgRl1BfjnpUloqwWbMUIw9pvl4N6wmDUERRUBix2O5DnOzQ0990BKZkvSKxs19JEurrIzvwD4rZ476/9IZ43pPWsfPjmsDMnLapaxT3gJUVprLi1WDJAFhpj6mXwBWd5yMszq93qckicsVBk0r8PLxxZ0R5lma1dB7LmBCHM32OYL2CuxkW2z9OkyOUXE2CzFf+ONU1uKqNDmqtFwyC0l/kICCz9PFrKu22VBVSMNStZPBVi8OSuIar6j3y8Kb+kEpVWvwJPXCRzZXgsP947EcyfYxgj2IawZLuVABYrD0OnT6STUuEYhWWls8UhXODYaTBm7DYpaJWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl6tZ6Dlmz2xbQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Sep 2026 15:31:02 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 16 Sep
 2026 13:30:40 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 16 Sep 2026 13:30:40 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 16 Sep 2026 13:30:43 +0800
Subject: [PATCH v3 6/9] EDAC/aspeed: Replace regmap with direct register
 access
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
Message-ID: <20260916-edac-v3-6-23e9ed2fbdf9@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789536639; l=9581;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=4vIvjd+wMbaMeekyBwMSPu6kmxJS0RjmBqXcVzKV5HY=;
 b=9Hmeyg21uF4KlKRh+vk36hi17Q3CebFa2W4LywPCIVRIWpyxOZPedhAHkXo/cDbnqhojtEA7Q
 4CAzKWRqSJxBHHLyi35TooNpMesczAUyWpU3qztcRrdyyqYuscd0SZW
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The driver instantiates its own regmap purely as an MMIO wrapper: it has
no register cache, uses custom .reg_read()/.reg_write() callbacks, and is
not shared as a syscon with other drivers. So it brings nothing here
beyond the spinlock that regmap takes around each access when fast_io is
set.

Drop the regmap and access the registers directly with readl()/writel()
under an explicit raw spinlock, held across the whole read-modify-write so
the controller is unlocked once around the grouped writes rather than on
every register write.

Annotate the register base with __guarded_by() so that, under
CONFIG_WARN_CONTEXT_ANALYSIS, the compiler checks at build time that every
hardware register access is performed while holding the lock.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

---
Changes in v2:
- Take the register lock with the irqsave variant in init_csrows() and in
  aspeed_probe(); the interrupt handler takes the same lock in hardirq
  context.
- Move the dev_dbg() of the interrupt status register out of the
  raw_spinlock critical section in the interrupt handler.
- Opt aspeed_edac.o into context analysis in drivers/edac/Makefile, so
  that the __guarded_by() annotation is actually checked.
- Note in the interrupt handler that the counter and interrupt flag
  fields are read-only, so writing back the read value is harmless.
---
 drivers/edac/Makefile      |   1 +
 drivers/edac/aspeed_edac.c | 131 +++++++++++++++++----------------------------
 2 files changed, 51 insertions(+), 81 deletions(-)

diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index a37534300ab9..9215dd0bb835 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
 obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
 obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
 obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
+CONTEXT_ANALYSIS_aspeed_edac.o		:= y
 obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
 obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
 obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index 352910e1defc..26d2c456cc0d 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -3,6 +3,7 @@
  * Copyright 2018, 2019 Cisco Systems
  */
 
+#include <linux/cleanup.h>
 #include <linux/edac.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -10,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
+#include <linux/spinlock.h>
 #include "edac_module.h"
 
 #define DRV_NAME "aspeed-edac"
@@ -20,7 +21,6 @@
 #define ASPEED_MCR_INTR_CTRL   0x50 /* interrupt control/status register */
 #define ASPEED_MCR_ADDR_UNREC  0x58 /* address of first un-recoverable error */
 #define ASPEED_MCR_ADDR_REC    0x5c /* address of last recoverable error */
-#define ASPEED_MCR_LAST        ASPEED_MCR_ADDR_REC
 
 #define ASPEED_MCR_PROT_PASSWD          0xfc600309
 #define ASPEED_MCR_CONF_DRAM_TYPE       BIT(4)
@@ -30,55 +30,8 @@
 #define ASPEED_MCR_INTR_CTRL_CNT_UNREC  GENMASK(15, 12)
 #define ASPEED_MCR_INTR_CTRL_ENABLE     (BIT(0) | BIT(1))
 
-static struct regmap *aspeed_regmap;
-
-static int regmap_reg_write(void *context, unsigned int reg, unsigned int val)
-{
-	void __iomem *regs = (void __iomem *)context;
-
-	/* enable write to MCR register set */
-	writel(ASPEED_MCR_PROT_PASSWD, regs + ASPEED_MCR_PROT);
-
-	writel(val, regs + reg);
-
-	/* disable write to MCR register set */
-	writel(~ASPEED_MCR_PROT_PASSWD, regs + ASPEED_MCR_PROT);
-
-	return 0;
-}
-
-static int regmap_reg_read(void *context, unsigned int reg, unsigned int *val)
-{
-	void __iomem *regs = (void __iomem *)context;
-
-	*val = readl(regs + reg);
-
-	return 0;
-}
-
-static bool regmap_is_volatile(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case ASPEED_MCR_PROT:
-	case ASPEED_MCR_INTR_CTRL:
-	case ASPEED_MCR_ADDR_UNREC:
-	case ASPEED_MCR_ADDR_REC:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static const struct regmap_config aspeed_regmap_config = {
-	.reg_bits = 32,
-	.val_bits = 32,
-	.reg_stride = 4,
-	.max_register = ASPEED_MCR_LAST,
-	.reg_write = regmap_reg_write,
-	.reg_read = regmap_reg_read,
-	.volatile_reg = regmap_is_volatile,
-	.fast_io = true,
-};
+static DEFINE_RAW_SPINLOCK(aspeed_lock);
+static void __iomem *aspeed_regs __guarded_by(&aspeed_lock);
 
 static void count_rec(struct mem_ctl_info *mci, u8 rec_cnt, u32 rec_addr)
 {
@@ -147,10 +100,27 @@ static irqreturn_t mcr_isr(int irq, void *arg)
 {
 	struct mem_ctl_info *mci = arg;
 	u32 rec_addr, un_rec_addr;
-	u32 reg50, reg5c, reg58;
-	u8  rec_cnt, un_rec_cnt;
+	u8 rec_cnt, un_rec_cnt;
+	u32 reg50;
+
+	scoped_guard(raw_spinlock, &aspeed_lock) {
+		reg50 = readl(aspeed_regs + ASPEED_MCR_INTR_CTRL);
+		un_rec_addr = readl(aspeed_regs + ASPEED_MCR_ADDR_UNREC);
+		rec_addr = readl(aspeed_regs + ASPEED_MCR_ADDR_REC);
+
+		/*
+		 * Clearing the counters needs a set-then-clear of CLEAR. The
+		 * counter and interrupt flag fields are read-only, so writing
+		 * back the values read above leaves them unaffected.
+		 */
+		writel(ASPEED_MCR_PROT_PASSWD, aspeed_regs + ASPEED_MCR_PROT);
+		writel(reg50 | ASPEED_MCR_INTR_CTRL_CLEAR,
+		       aspeed_regs + ASPEED_MCR_INTR_CTRL);
+		writel(reg50 & ~ASPEED_MCR_INTR_CTRL_CLEAR,
+		       aspeed_regs + ASPEED_MCR_INTR_CTRL);
+		writel(~ASPEED_MCR_PROT_PASSWD, aspeed_regs + ASPEED_MCR_PROT);
+	}
 
-	regmap_read(aspeed_regmap, ASPEED_MCR_INTR_CTRL, &reg50);
 	dev_dbg(mci->pdev, "received edac interrupt w/ mcr register 50: 0x%x\n",
 		reg50);
 
@@ -161,20 +131,6 @@ static irqreturn_t mcr_isr(int irq, void *arg)
 	dev_dbg(mci->pdev, "%d recoverable interrupts and %d unrecoverable interrupts\n",
 		rec_cnt, un_rec_cnt);
 
-	regmap_read(aspeed_regmap, ASPEED_MCR_ADDR_UNREC, &reg58);
-	un_rec_addr = reg58;
-
-	regmap_read(aspeed_regmap, ASPEED_MCR_ADDR_REC, &reg5c);
-	rec_addr = reg5c;
-
-	/* clear interrupt flags and error counters: */
-	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
-			   ASPEED_MCR_INTR_CTRL_CLEAR,
-			   ASPEED_MCR_INTR_CTRL_CLEAR);
-
-	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
-			   ASPEED_MCR_INTR_CTRL_CLEAR, 0);
-
 	/* process recoverable and unrecoverable errors */
 	count_rec(mci, rec_cnt, rec_addr);
 	count_un_rec(mci, un_rec_cnt, un_rec_addr);
@@ -182,13 +138,31 @@ static irqreturn_t mcr_isr(int irq, void *arg)
 	if (!rec_cnt && !un_rec_cnt)
 		dev_dbg(mci->pdev, "received edac interrupt, but did not find any ECC counters\n");
 
-	regmap_read(aspeed_regmap, ASPEED_MCR_INTR_CTRL, &reg50);
+	scoped_guard(raw_spinlock, &aspeed_lock)
+		reg50 = readl(aspeed_regs + ASPEED_MCR_INTR_CTRL);
 	dev_dbg(mci->pdev, "edac interrupt handled. mcr reg 50 is now: 0x%x\n",
 		reg50);
 
 	return IRQ_HANDLED;
 }
 
+static void aspeed_set_irq(bool enable)
+{
+	u32 val;
+
+	guard(raw_spinlock_irqsave)(&aspeed_lock);
+
+	val = readl(aspeed_regs + ASPEED_MCR_INTR_CTRL);
+	if (enable)
+		val |= ASPEED_MCR_INTR_CTRL_ENABLE;
+	else
+		val &= ~ASPEED_MCR_INTR_CTRL_ENABLE;
+
+	writel(ASPEED_MCR_PROT_PASSWD, aspeed_regs + ASPEED_MCR_PROT);
+	writel(val, aspeed_regs + ASPEED_MCR_INTR_CTRL);
+	writel(~ASPEED_MCR_PROT_PASSWD, aspeed_regs + ASPEED_MCR_PROT);
+}
+
 static int config_irq(void *ctx, struct platform_device *pdev)
 {
 	int irq;
@@ -206,9 +180,7 @@ static int config_irq(void *ctx, struct platform_device *pdev)
 		return rc;
 
 	/* enable interrupts */
-	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
-			   ASPEED_MCR_INTR_CTRL_ENABLE,
-			   ASPEED_MCR_INTR_CTRL_ENABLE);
+	aspeed_set_irq(true);
 
 	return 0;
 }
@@ -246,7 +218,8 @@ static int init_csrows(struct mem_ctl_info *mci)
 	nr_pages = resource_size(&r) >> PAGE_SHIFT;
 	csrow->last_page = csrow->first_page + nr_pages - 1;
 
-	regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
+	scoped_guard(raw_spinlock_irqsave, &aspeed_lock)
+		reg04 = readl(aspeed_regs + ASPEED_MCR_CONF);
 	dram_type = (reg04 & ASPEED_MCR_CONF_DRAM_TYPE) ? MEM_DDR4 : MEM_DDR3;
 
 	dimm = csrow->channels[0]->dimm;
@@ -263,7 +236,6 @@ static int init_csrows(struct mem_ctl_info *mci)
 
 static int aspeed_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
 	struct edac_mc_layer layers[2];
 	struct mem_ctl_info *mci;
 	void __iomem *regs;
@@ -274,13 +246,11 @@ static int aspeed_probe(struct platform_device *pdev)
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	aspeed_regmap = devm_regmap_init(dev, NULL, (__force void *)regs,
-					 &aspeed_regmap_config);
-	if (IS_ERR(aspeed_regmap))
-		return PTR_ERR(aspeed_regmap);
+	scoped_guard(raw_spinlock_irqsave, &aspeed_lock)
+		aspeed_regs = regs;
 
 	/* bail out if ECC mode is not configured */
-	regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
+	reg04 = readl(regs + ASPEED_MCR_CONF);
 	if (!(reg04 & ASPEED_MCR_CONF_ECC)) {
 		dev_err(&pdev->dev, "ECC mode is not configured in u-boot\n");
 		return -EPERM;
@@ -347,8 +317,7 @@ static void aspeed_remove(struct platform_device *pdev)
 	int irq;
 
 	/* disable interrupts */
-	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
-			   ASPEED_MCR_INTR_CTRL_ENABLE, 0);
+	aspeed_set_irq(false);
 
 	irq = platform_get_irq(pdev, 0);
 	WARN_ON(irq < 0);

-- 
2.34.1


