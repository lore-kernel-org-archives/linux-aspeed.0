Return-Path: <linux-aspeed+bounces-4835-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BC8C5DF94
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Aug 2026 07:05:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hT24Z46CWz2y2c;
	Mon, 24 Aug 2026 17:05:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787555150;
	cv=none; b=bPnPWkcXy5CxIljZ+PVLFSNpBmAO80a3dYydzYdmTkIZ+ZozYZpjXQQfXYenmYDzW3ZKzA6B7zroccDyst9gwBjUdSfgcAR7Ug+E3R0154CJD8E/cjBzg/aESig03bCMdhyXdF1OOeEaKQi0DVl79SbsKLzI7kxP9hr1y+iyvnZSv550C+XboeEsrTpSJX9sZng1JXS5Ielp7A8KiVY8jotPWbOegPbmqnCigYvVdtXU33rOwvIaCknPw1RDs0BSlr6kx1MnVR56GxKVzYtM/tvDXvosnFaaBG9Zndw2WAfhj5ujiqNfiiZvxYXU+PLhE/ppciRmgBvgRkk78/llrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787555150; c=relaxed/relaxed;
	bh=MMp4iId+8hPV993oqe/VJnslN15DJp3BJve6LUB1mUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=nPWhP6e5MwtJ0KB7E7CR18dknv+av9a0/tParEcjYLa+9AmQqNsP+v+5hTDKkzryOxgjQTnMLWUygetacK0x3lImB6NawQsKRpfe1bRdmrmGwJgnS7ixHfCUfv9/ldGUrKXFcDLzyiji7a3HgpRTuQTQBslm3FTWu0p1iix4TEc4LXS2r/vSV9lxwSKBPwNg1WRGBYZJgl7LlgFzt40Xo4HyAdRVBQ+LpW0xlndZmDUc9I/4Ur7axW3KVqO57mNOl0jwZtW2O73iddo91MAw3p/W/VnNvICKm/jrLHdpouOZ019scXA12FKaY6J3eQzmt1ghJ8LGEpBEOqUQS5OS5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=yc_hsieh@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=yc_hsieh@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hT24Y2rx0z2y06
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 17:05:48 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 24 Aug
 2026 15:05:32 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 24 Aug 2026 15:05:32 +0800
From: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
Date: Mon, 24 Aug 2026 15:05:24 +0800
Subject: [PATCH v3] ipmi: kcs_bmc_aspeed: Support multiple LPC controller
 instances
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
Message-ID: <20260824-upstream_kcs_multiple_lpc-v3-1-b15bb0f77462@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIADPti2oC/33N3wqCMBTH8VeJXbfYjs1pV71HhLjtmCP/jE2lE
 N+9KUQXgZffH5zPmUlAbzGQy2EmHicbbN/FSI4HouuyeyC1JjYBBimTAHR0YfBYtsVTh6Idm8G
 6BovGaSoTkZ8BOBcsI/Heeazsa7Nv99i1DUPv39uria/rV0121IlTRk3OMyVAMpWl1zI4RDOgr
 k+6b8lKT/DjMr7LQeSkFIoblVSYiz9uWZYP7kGXNRYBAAA=
X-Change-ID: 20260722-upstream_kcs_multiple_lpc-735942211508
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Joel
 Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Corey Minyard
	<corey@minyard.net>
CC: Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openipmi-developer@lists.sourceforge.net>,
	<jammy_huang@aspeedtech.com>, Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787555132; l=8767;
 i=yc_hsieh@aspeedtech.com; s=20260721; h=from:subject:message-id;
 bh=GfHE1UPhmD//6VWtbZY3B8MnLjOJloBHnV0v8zZ5ET8=;
 b=mT8OVPoiQAQQLuEwhCWoIJvcx7IeaPTWTOYzJjDdpV/QpBpAz5gAck/ViBDggQjjpwC3yqnZf
 xuL3BjQgFINCwjnYZYo9DE2ScPxBR1JRVvg8vQdUQxfXKKP9Rswb7rL
X-Developer-Key: i=yc_hsieh@aspeedtech.com; a=ed25519;
 pk=7KnU2ozXGF2IATT+Hvu7RbRwPxBA3/b+zhfM+UsPJMs=

Some SoCs (e.g. AST2700) expose more than one physical LPC controller
instance (e.g. lpc0@14c31000, lpc1@14c32000, plus pcie_lpc0@12c19000
and pcie_lpc1@12c19800 for the PCIe-facing path), each instantiating
its own independent set of KCS1-KCS4 channels using identical
IDR/ODR/STR register offsets.

kcs_bmc_device::channel currently serves two purposes at once:

  1. Selecting which HICR0/HICR2/HICRB bit-group to touch within a
     single LPC controller's register file. aspeed_kcs_of_get_channel()
     derives this purely from the KCS node's register offset, yielding
     values 1..4.

  2. Naming the misc chardev (/dev/ipmi-kcsN) exposed to userspace,
     which must be unique system-wide. kcs_bmc_cdev_ipmi.c uses
     "ipmi-kcs%u".

Both happen to be the same value only because this driver has only
ever had to support SoCs with a single LPC controller. On AST2700, KCS1
on every LPC controller computes to the same channel number, and
whichever instance probes second fails outright:

	sysfs: cannot create duplicate filename '/devices/virtual/misc/ipmi-kcs1'
	ast-kcs-bmc 14c32024.kcs: Unable to register device: -17
	ast-kcs-bmc 14c32024.kcs: Failed to add chardev for KCS channel 1: -17
	ast-kcs-bmc: probe of 14c32024.kcs failed with error -17

Split the two roles: keep a new driver-private `channel` field (1..4)
in struct aspeed_kcs_bmc for register access, leaving all the
HICR/IBFIE/LPCxE switch statements operating on it, and derive
kcs_bmc_device::channel as `bank * KCS_CHANNEL_MAX + channel`, where
`bank` identifies which LPC controller instance a KCS device belongs
to.

`bank` is obtained from aspeed_kcs_of_get_bank(), which keeps a
driver-private, mutex-protected list keyed by the LPC controller's
device_node pointer and assigns bank indices in
first-seen-during-probe order. SoCs with a single LPC controller
always end up with bank 0, so /dev/ipmi-kcsN naming is unchanged for
all existing boards, and no devicetree or binding changes are required
for any platform.

Signed-off-by: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
---
Changes in v3:
- Drop the of_alias_get_id()-based bank derivation and the dt-bindings 
  patch that documented it.
- Replace with dynamic bank discovery: the first time an LPC
  controller's device_node is seen during probe, assign it the next
  available bank index and remember it in a driver-private list. This
  needs no DT/binding changes at all.

Link to v2: https://lore.kernel.org/r/20260813-upstream_kcs_multiple_lpc-v2-0-775b1db3fe95@aspeedtech.com

Changes in v2:
  - Drop the RFC tag, per Lee Jones' feedback.
  - Keep the alias-based bank-numbering approach unchanged.

Link to v1: https://lore.kernel.org/r/20260723-upstream_kcs_multiple_lpc-v1-0-d918b5270b86@aspeedtech.com
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 71 ++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index a13a3470c17a..751f477c09e0 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -10,8 +10,10 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/list.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -125,6 +127,8 @@ struct aspeed_kcs_bmc {
 		bool remove;
 		struct timer_list timer;
 	} obe;
+
+	u32 channel;
 };
 
 static inline struct aspeed_kcs_bmc *to_aspeed_kcs_bmc(struct kcs_bmc_device *kcs_bmc)
@@ -167,7 +171,7 @@ static void aspeed_kcs_outb(struct kcs_bmc_device *kcs_bmc, u32 reg, u8 data)
 	if (priv->upstream_irq.mode != aspeed_kcs_irq_serirq)
 		return;
 
-	switch (kcs_bmc->channel) {
+	switch (priv->channel) {
 	case 1:
 		switch (priv->upstream_irq.id) {
 		case 12:
@@ -232,7 +236,7 @@ static int aspeed_kcs_set_address(struct kcs_bmc_device *kcs_bmc, u32 addrs[2],
 	if (WARN_ON(nr_addrs < 1 || nr_addrs > 2))
 		return -EINVAL;
 
-	switch (priv->kcs_bmc.channel) {
+	switch (priv->channel) {
 	case 1:
 		regmap_update_bits(priv->map, LPC_HICR4, LPC_HICR4_LADR12AS, 0);
 		regmap_write(priv->map, LPC_LADR12H, addrs[0] >> 8);
@@ -315,7 +319,7 @@ static int aspeed_kcs_config_upstream_irq(struct aspeed_kcs_bmc *priv, u32 id, u
 	priv->upstream_irq.mode = aspeed_kcs_irq_serirq;
 	priv->upstream_irq.id = id;
 
-	switch (priv->kcs_bmc.channel) {
+	switch (priv->channel) {
 	case 1:
 		/* Needs IRQxE1 rather than (ID1IRQX, SEL1IRQX, IRQXE1) before AST2600 A3 */
 		break;
@@ -347,7 +351,7 @@ static int aspeed_kcs_config_upstream_irq(struct aspeed_kcs_bmc *priv, u32 id, u
 	default:
 		dev_warn(priv->kcs_bmc.dev,
 			 "SerIRQ configuration not supported on KCS channel %d\n",
-			 priv->kcs_bmc.channel);
+			 priv->channel);
 		return -EINVAL;
 	}
 
@@ -358,7 +362,7 @@ static void aspeed_kcs_enable_channel(struct kcs_bmc_device *kcs_bmc, bool enabl
 {
 	struct aspeed_kcs_bmc *priv = to_aspeed_kcs_bmc(kcs_bmc);
 
-	switch (kcs_bmc->channel) {
+	switch (priv->channel) {
 	case 1:
 		regmap_update_bits(priv->map, LPC_HICR0, LPC_HICR0_LPC1E, enable * LPC_HICR0_LPC1E);
 		return;
@@ -374,7 +378,7 @@ static void aspeed_kcs_enable_channel(struct kcs_bmc_device *kcs_bmc, bool enabl
 		regmap_update_bits(priv->map, LPC_HICRB, LPC_HICRB_LPC4E, enable * LPC_HICRB_LPC4E);
 		return;
 	default:
-		pr_warn("%s: Unsupported channel: %d", __func__, kcs_bmc->channel);
+		pr_warn("%s: Unsupported channel: %d", __func__, priv->channel);
 		return;
 	}
 }
@@ -435,7 +439,7 @@ static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask,
 	if (mask & KCS_BMC_EVENT_TYPE_IBF) {
 		const bool enable = !!(state & KCS_BMC_EVENT_TYPE_IBF);
 
-		switch (kcs_bmc->channel) {
+		switch (priv->channel) {
 		case 1:
 			regmap_update_bits(priv->map, LPC_HICR2, LPC_HICR2_IBFIE1,
 					   enable * LPC_HICR2_IBFIE1);
@@ -453,7 +457,7 @@ static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask,
 					   enable * LPC_HICRB_IBFIE4);
 			return;
 		default:
-			pr_warn("%s: Unsupported channel: %d", __func__, kcs_bmc->channel);
+			pr_warn("%s: Unsupported channel: %d", __func__, priv->channel);
 			return;
 		}
 	}
@@ -526,6 +530,47 @@ static int aspeed_kcs_of_get_channel(struct platform_device *pdev)
 	return -EINVAL;
 }
 
+struct aspeed_kcs_bank {
+	struct device_node *lpc_np;
+	struct list_head entry;
+};
+
+static DEFINE_MUTEX(aspeed_kcs_bank_lock);
+static LIST_HEAD(aspeed_kcs_banks);
+
+/*
+ * Assign each distinct LPC controller device_node a stable bank index the
+ * first time it's seen, so that KCS devices instantiated from different LPC
+ * controllers on the same SoC (e.g. AST2700) don't collide on the same
+ * global kcs_bmc_device::channel value.
+ */
+static int aspeed_kcs_of_get_bank(struct device_node *lpc_np)
+{
+	struct aspeed_kcs_bank *bank;
+	int index = 0;
+
+	mutex_lock(&aspeed_kcs_bank_lock);
+
+	list_for_each_entry(bank, &aspeed_kcs_banks, entry) {
+		if (bank->lpc_np == lpc_np)
+			goto out;
+		index++;
+	}
+
+	bank = kzalloc(sizeof(*bank), GFP_KERNEL);
+	if (!bank) {
+		mutex_unlock(&aspeed_kcs_bank_lock);
+		return -ENOMEM;
+	}
+
+	bank->lpc_np = lpc_np;
+	list_add_tail(&bank->entry, &aspeed_kcs_banks);
+
+out:
+	mutex_unlock(&aspeed_kcs_bank_lock);
+	return index;
+}
+
 static int
 aspeed_kcs_of_get_io_address(struct platform_device *pdev, u32 addrs[2])
 {
@@ -559,7 +604,7 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 	struct device_node *np;
 	bool have_upstream_irq;
 	u32 upstream_irq[2];
-	int rc, channel;
+	int rc, channel, bank;
 	int nr_addrs;
 	u32 addrs[2];
 
@@ -575,6 +620,10 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 	if (channel < 0)
 		return channel;
 
+	bank = aspeed_kcs_of_get_bank(np);
+	if (bank < 0)
+		return bank;
+
 	nr_addrs = aspeed_kcs_of_get_io_address(pdev, addrs);
 	if (nr_addrs < 0)
 		return nr_addrs;
@@ -590,9 +639,11 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->channel = channel;
+
 	kcs_bmc = &priv->kcs_bmc;
 	kcs_bmc->dev = &pdev->dev;
-	kcs_bmc->channel = channel;
+	kcs_bmc->channel = bank * KCS_CHANNEL_MAX + channel;
 	kcs_bmc->ioreg = ast_kcs_bmc_ioregs[channel - 1];
 	kcs_bmc->ops = &aspeed_kcs_ops;
 

---
base-commit: f0e6f20cb52b14c2c441f04e21cef0c95d498cac
change-id: 20260722-upstream_kcs_multiple_lpc-735942211508

Best regards,
-- 
Yu-Che Hsieh <yc_hsieh@aspeedtech.com>


