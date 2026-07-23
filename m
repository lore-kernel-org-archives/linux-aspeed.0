Return-Path: <linux-aspeed+bounces-4552-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48147C531C9
	for <linux-aspeed@archiver.kernel.org>; Fri, 24 Jul 2026 05:18:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5x9V517Sz2yYq;
	Fri, 24 Jul 2026 15:18:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784784722;
	cv=none; b=Nbek9ZejEztAozvwt+vSImBRkxcBQRmjxbA8xkikw4g9oGThuaiuBcI71FrjgP5FqYVW8PtlC/UO7hyCPFfNk2rx0PUjq0wo5Ow+kjhcqvufmON0vtBgW2bfTsE7i8Ma2ADZCEN7dUdqaN3b6Z2cgJEMgQB/q3RzGOhnBnP7tf0oP3HnmxUsGy8M0WA/zNDvsumZ/h+g249woi9q4PNiGmVsVmOBFr89Lkz0z3KqXxuV2DMuGYQ60bvdDhzgw9Oe3xAQ7bX7sH9oz4nqcLYzqDS70xJIppY2FbA8VBj2Q3D0uzS9wAy3Upxo+7pBGyCVq7As0SIh0zbubpXdjsm1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784784722; c=relaxed/relaxed;
	bh=GQCEk4uZRUPDKEnKk78GF0miz0R82zKAyiCG3x64wtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UqLGzhgrdU++LmpNu32xdMizRPhs808ftgGRTcBXHGrHUe7EBh0zj2MwYQmXuJVahuM1TMpw/zUoCtidyQU/G120ykXONxGl7WPfucSmm/KS2VmUA6T8omWuDBDAal5xZbAiHhFIPUntWoNM/ZAHWbkjRl8l17FJKlQCmMKYo+IlO3NNWONzQwk5ZwbSDfCyJD12vOJX5qzu+NT7Wh+qlMzPx38shZPBdRR7sLc+Kin2gdXCG3o55b2E9z1uKdEzezYyDS9szjGo4SuRaDGwmZ2feIWxP93ku52LuOFxYM/NrFL7fYo+xX+7goX7KeTbzfCfhR9P2BeumyrIYkJwjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=yc_hsieh@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=yc_hsieh@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5KW55pVbz2xqJ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 15:32:01 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 23 Jul
 2026 13:31:42 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 23 Jul 2026 13:31:42 +0800
From: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
Date: Thu, 23 Jul 2026 13:31:38 +0800
Subject: [PATCH RFC 2/2] ipmi: kcs_bmc_aspeed: Support multiple LPC
 controller instances
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
Message-ID: <20260723-upstream_kcs_multiple_lpc-v1-2-d918b5270b86@aspeedtech.com>
References: <20260723-upstream_kcs_multiple_lpc-v1-0-d918b5270b86@aspeedtech.com>
In-Reply-To: <20260723-upstream_kcs_multiple_lpc-v1-0-d918b5270b86@aspeedtech.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Joel
 Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Corey Minyard
	<corey@minyard.net>
CC: Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openipmi-developer@lists.sourceforge.net>,
	Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784784702; l=6125;
 i=yc_hsieh@aspeedtech.com; s=20260721; h=from:subject:message-id;
 bh=WCkY6ru4QaUOU33knVeXbs5BBFO1adD73YX6nr6ufaE=;
 b=qu3mKDSW024Lstm35DdVqbd5L/9osovxUg4aLC1RhM91zWU5pAcLSM3Ve5NV8KmLvLiOIYBnc
 kLGcSjXCcLPBi+RO4zDu5VLMol13Xw2XyHWOIh4XOPQ+wxRrbAT+OP+
X-Developer-Key: i=yc_hsieh@aspeedtech.com; a=ed25519;
 pk=7KnU2ozXGF2IATT+Hvu7RbRwPxBA3/b+zhfM+UsPJMs=

Some SoCs (e.g. AST2700) expose more than one physical LPC controller,
each instantiating its own independent set of KCS0-KCS3 channels using
identical IDR/ODR/STR register offsets. kcs_bmc_device::channel is
currently overloaded to serve two distinct purposes: selecting which
HICR0/HICR2/HICRB bit-group to touch within a single LPC controller's
register file, and naming the misc chardev (/dev/ipmi-kcsN) exposed to
userspace, which must be unique system-wide. The two purposes happen
to share the same value only because the driver has so far only had
to support SoCs with a single LPC controller. On a multi-controller
SoC, KCS0 on every LPC controller computes to the same channel number,
and whichever instance probes second fails to register its chardev.

Split the two roles: keep a new driver-private `channel` field (1..4)
in struct aspeed_kcs_bmc for register access, leaving all the
HICR/IBFIE/LPCxE switch statements operating on it, and derive
kcs_bmc_device::channel as `bank * KCS_CHANNEL_MAX + channel`, where
`bank` identifies which LPC controller instance a KCS device belongs
to.

`bank` is obtained from an optional "lpcN" alias on the LPC controller
node via of_alias_get_id(), following the same convention already used
by mmc/i2c/spi/serial for instance numbering. SoCs with a single LPC
controller, and existing DTs that don't declare the alias, fall back
to bank 0, so /dev/ipmi-kcsN naming is unchanged for all existing
boards.

Signed-off-by: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index a13a3470c17a..591c11a44503 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -125,6 +125,8 @@ struct aspeed_kcs_bmc {
 		bool remove;
 		struct timer_list timer;
 	} obe;
+
+	u32 channel;
 };
 
 static inline struct aspeed_kcs_bmc *to_aspeed_kcs_bmc(struct kcs_bmc_device *kcs_bmc)
@@ -167,7 +169,7 @@ static void aspeed_kcs_outb(struct kcs_bmc_device *kcs_bmc, u32 reg, u8 data)
 	if (priv->upstream_irq.mode != aspeed_kcs_irq_serirq)
 		return;
 
-	switch (kcs_bmc->channel) {
+	switch (priv->channel) {
 	case 1:
 		switch (priv->upstream_irq.id) {
 		case 12:
@@ -232,7 +234,7 @@ static int aspeed_kcs_set_address(struct kcs_bmc_device *kcs_bmc, u32 addrs[2],
 	if (WARN_ON(nr_addrs < 1 || nr_addrs > 2))
 		return -EINVAL;
 
-	switch (priv->kcs_bmc.channel) {
+	switch (priv->channel) {
 	case 1:
 		regmap_update_bits(priv->map, LPC_HICR4, LPC_HICR4_LADR12AS, 0);
 		regmap_write(priv->map, LPC_LADR12H, addrs[0] >> 8);
@@ -315,7 +317,7 @@ static int aspeed_kcs_config_upstream_irq(struct aspeed_kcs_bmc *priv, u32 id, u
 	priv->upstream_irq.mode = aspeed_kcs_irq_serirq;
 	priv->upstream_irq.id = id;
 
-	switch (priv->kcs_bmc.channel) {
+	switch (priv->channel) {
 	case 1:
 		/* Needs IRQxE1 rather than (ID1IRQX, SEL1IRQX, IRQXE1) before AST2600 A3 */
 		break;
@@ -347,7 +349,7 @@ static int aspeed_kcs_config_upstream_irq(struct aspeed_kcs_bmc *priv, u32 id, u
 	default:
 		dev_warn(priv->kcs_bmc.dev,
 			 "SerIRQ configuration not supported on KCS channel %d\n",
-			 priv->kcs_bmc.channel);
+			 priv->channel);
 		return -EINVAL;
 	}
 
@@ -358,7 +360,7 @@ static void aspeed_kcs_enable_channel(struct kcs_bmc_device *kcs_bmc, bool enabl
 {
 	struct aspeed_kcs_bmc *priv = to_aspeed_kcs_bmc(kcs_bmc);
 
-	switch (kcs_bmc->channel) {
+	switch (priv->channel) {
 	case 1:
 		regmap_update_bits(priv->map, LPC_HICR0, LPC_HICR0_LPC1E, enable * LPC_HICR0_LPC1E);
 		return;
@@ -374,7 +376,7 @@ static void aspeed_kcs_enable_channel(struct kcs_bmc_device *kcs_bmc, bool enabl
 		regmap_update_bits(priv->map, LPC_HICRB, LPC_HICRB_LPC4E, enable * LPC_HICRB_LPC4E);
 		return;
 	default:
-		pr_warn("%s: Unsupported channel: %d", __func__, kcs_bmc->channel);
+		pr_warn("%s: Unsupported channel: %d", __func__, priv->channel);
 		return;
 	}
 }
@@ -435,7 +437,7 @@ static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask,
 	if (mask & KCS_BMC_EVENT_TYPE_IBF) {
 		const bool enable = !!(state & KCS_BMC_EVENT_TYPE_IBF);
 
-		switch (kcs_bmc->channel) {
+		switch (priv->channel) {
 		case 1:
 			regmap_update_bits(priv->map, LPC_HICR2, LPC_HICR2_IBFIE1,
 					   enable * LPC_HICR2_IBFIE1);
@@ -453,7 +455,7 @@ static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask,
 					   enable * LPC_HICRB_IBFIE4);
 			return;
 		default:
-			pr_warn("%s: Unsupported channel: %d", __func__, kcs_bmc->channel);
+			pr_warn("%s: Unsupported channel: %d", __func__, priv->channel);
 			return;
 		}
 	}
@@ -526,6 +528,17 @@ static int aspeed_kcs_of_get_channel(struct platform_device *pdev)
 	return -EINVAL;
 }
 
+static int aspeed_kcs_of_get_bank(struct device_node *lpc_np)
+{
+	int id;
+
+	id = of_alias_get_id(lpc_np, "lpc");
+	if (id < 0)
+		return 0;
+
+	return id;
+}
+
 static int
 aspeed_kcs_of_get_io_address(struct platform_device *pdev, u32 addrs[2])
 {
@@ -559,7 +572,7 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 	struct device_node *np;
 	bool have_upstream_irq;
 	u32 upstream_irq[2];
-	int rc, channel;
+	int rc, channel, bank;
 	int nr_addrs;
 	u32 addrs[2];
 
@@ -575,6 +588,8 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 	if (channel < 0)
 		return channel;
 
+	bank = aspeed_kcs_of_get_bank(np);
+
 	nr_addrs = aspeed_kcs_of_get_io_address(pdev, addrs);
 	if (nr_addrs < 0)
 		return nr_addrs;
@@ -590,9 +605,11 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
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
 

-- 
2.34.1


