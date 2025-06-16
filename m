Return-Path: <linux-aspeed+bounces-1481-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6928FC7115A
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Jun 2025 13:14:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLVnp4NSPz3bcW;
	Mon, 16 Jun 2025 23:14:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750079646;
	cv=none; b=A77Co5P4oYWEwph9Hrr/iG6h93hQLmW9H+v7U+MCOFRPWg+52p9H1tSiMTDbC+IaGl9w5dw/LTzhdt/0v451Avj7qzk08jfyYMAOXIw31v2+ZsNG09M9IJ/pVtwM6INeHRb3JX+YHqlOCPZNqfYn2q0GOlucmn9127b9ZVq5uR9RQVzFJWP9MbNKPfRA6oa0S4f4sjacsO57vDeGZDbxIskaC4yXrUbR/0r+jJtRZkh1TAqczsmTSP9DZlSStdBJZ8R9jwyTvZtjI7VgHgnt2UdVRfYPTM0jhNfZMth9begz0zXf2bG2OQA6ADQ0DdDM8kbEr8eXbXVqAxxryKOBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750079646; c=relaxed/relaxed;
	bh=6h0ix1ZdixoOBaPO3IlzuOaav+hjON9yVdm3QZ+ABs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/Nu1J0VU3Vi8eH81bKpVhFT/O8ojiZtPSdwIsBkUblfk5meAuoEh/L8yxkP+O9NwDX3IgxupNWgdyj2nzuLgzRw74JElRMJpuueHlumcvXTuh6MMUhk+8qYAjUu/rq0f7+v/V216jiBOjOpV9BtPUYzZ80yVhjTLLcX3dGgej6BtP4WFYVHlnNYzA2ufRj+xpamxG8t5dK6sxA00OjJJ6c2p1jZlBIVdtE8cmHZwu82Ct82OzhGCUW7yVP+4HfxKsiW3okhWKVn2UXvLlh+jVt/tGy/zw0BOxK0seP98FM43WneLyzYkDj6rwlOmnC5c+lVerujRF2dyX67mjwU+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Kor3MH/X; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Kor3MH/X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLVnp18dBz30Vn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Jun 2025 23:14:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750079645;
	bh=6h0ix1ZdixoOBaPO3IlzuOaav+hjON9yVdm3QZ+ABs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Kor3MH/XjP0L5Qf7xtsszE318PqOoYFUW4LmZufq+PV1IG00ZaBxZrGo4TV66c7wT
	 g/nO3IrU50YVymtMloXXIbGQO+f8DLdIeKGiiVz3Q39yBcMJhutjCY1P6IjDZcisrS
	 Mp4NB+eBYCz2rS1A5RsP1/CnZwOuLKNxHufGdxTqrrcnnrzFDrQuj1rrGpaHw1AygZ
	 W7rF21jQzGf2p4NFQsopVAid4EohIDoKXZrPsbz1GXOG9DYcwhz3RlB0Ry6fJjxZMR
	 znMkjUBhJV1S6JgpRCyd+bOGYamCJcDsSsZOIR3i4zyI6uJd3FJ5nWWndufy7SaULP
	 IP1uL0ys+1VIg==
Received: from [127.0.1.1] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0A88368865;
	Mon, 16 Jun 2025 21:14:04 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 16 Jun 2025 22:43:47 +0930
Subject: [PATCH v2 10/10] soc: aspeed: lpc-snoop: Lift channel config to
 const structs
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
Message-Id: <20250616-aspeed-lpc-snoop-fixes-v2-10-3cdd59c934d3@codeconstruct.com.au>
References: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
In-Reply-To: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
To: linux-aspeed@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>, Henry Martin <bsdhenrymartin@gmail.com>, 
 Jean Delvare <jdelvare@suse.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Geissler <geissonator@yahoo.com>, 
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>
X-Mailer: b4 0.14.2

The shifts and masks for each channel are defined by hardware and
are not something that changes at runtime. Accordingly, describe the
information in an array of const structs and associate elements with
each channel instance, removing the need for the switch and handling of
its default case.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 100 +++++++++++++++-------------------
 1 file changed, 45 insertions(+), 55 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 9f88c5471b1b6d85f6d9e1970240f3d1904d166c..2d97b8d5fb429e215c321c9c2ee3fa35d39f8618 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -63,7 +63,16 @@ enum aspeed_lpc_snoop_index {
 	ASPEED_LPC_SNOOP_INDEX_MAX = ASPEED_LPC_SNOOP_INDEX_1,
 };
 
+struct aspeed_lpc_snoop_channel_cfg {
+	enum aspeed_lpc_snoop_index index;
+	u32 hicr5_en;
+	u32 snpwadr_mask;
+	u32 snpwadr_shift;
+	u32 hicrb_en;
+};
+
 struct aspeed_lpc_snoop_channel {
+	const struct aspeed_lpc_snoop_channel_cfg *cfg;
 	bool enabled;
 	struct kfifo		fifo;
 	wait_queue_head_t	wq;
@@ -77,6 +86,23 @@ struct aspeed_lpc_snoop {
 	struct aspeed_lpc_snoop_channel chan[ASPEED_LPC_SNOOP_INDEX_MAX + 1];
 };
 
+static const struct aspeed_lpc_snoop_channel_cfg channel_cfgs[ASPEED_LPC_SNOOP_INDEX_MAX + 1] = {
+	{
+		.index = ASPEED_LPC_SNOOP_INDEX_0,
+		.hicr5_en = HICR5_EN_SNP0W | HICR5_ENINT_SNP0W,
+		.snpwadr_mask = SNPWADR_CH0_MASK,
+		.snpwadr_shift = SNPWADR_CH0_SHIFT,
+		.hicrb_en = HICRB_ENSNP0D,
+	},
+	{
+		.index = ASPEED_LPC_SNOOP_INDEX_1,
+		.hicr5_en = HICR5_EN_SNP1W | HICR5_ENINT_SNP1W,
+		.snpwadr_mask = SNPWADR_CH1_MASK,
+		.snpwadr_shift = SNPWADR_CH1_SHIFT,
+		.hicrb_en = HICRB_ENSNP1D,
+	},
+};
+
 static struct aspeed_lpc_snoop_channel *snoop_file_to_chan(struct file *file)
 {
 	return container_of(file->private_data,
@@ -189,28 +215,27 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
 }
 
 __attribute__((nonnull))
-static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
-				   struct device *dev,
-				   enum aspeed_lpc_snoop_index index, u16 lpc_port)
+static int aspeed_lpc_enable_snoop(struct device *dev,
+				    struct aspeed_lpc_snoop *lpc_snoop,
+				    struct aspeed_lpc_snoop_channel *channel,
+				    const struct aspeed_lpc_snoop_channel_cfg *cfg,
+				    u16 lpc_port)
 {
 	const struct aspeed_lpc_snoop_model_data *model_data;
-	u32 hicr5_en, snpwadr_mask, snpwadr_shift, hicrb_en;
-	struct aspeed_lpc_snoop_channel *channel;
 	int rc = 0;
 
-	channel = &lpc_snoop->chan[index];
-
 	if (WARN_ON(channel->enabled))
 		return -EBUSY;
 
 	init_waitqueue_head(&channel->wq);
 
+	channel->cfg = cfg;
 	channel->miscdev.minor = MISC_DYNAMIC_MINOR;
 	channel->miscdev.fops = &snoop_fops;
 	channel->miscdev.parent = dev;
 
 	channel->miscdev.name =
-		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, index);
+		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, cfg->index);
 	if (!channel->miscdev.name)
 		return -ENOMEM;
 
@@ -223,39 +248,18 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		goto err_free_fifo;
 
 	/* Enable LPC snoop channel at requested port */
-	switch (index) {
-	case 0:
-		hicr5_en = HICR5_EN_SNP0W | HICR5_ENINT_SNP0W;
-		snpwadr_mask = SNPWADR_CH0_MASK;
-		snpwadr_shift = SNPWADR_CH0_SHIFT;
-		hicrb_en = HICRB_ENSNP0D;
-		break;
-	case 1:
-		hicr5_en = HICR5_EN_SNP1W | HICR5_ENINT_SNP1W;
-		snpwadr_mask = SNPWADR_CH1_MASK;
-		snpwadr_shift = SNPWADR_CH1_SHIFT;
-		hicrb_en = HICRB_ENSNP1D;
-		break;
-	default:
-		rc = -EINVAL;
-		goto err_misc_deregister;
-	}
-
-	/* Enable LPC snoop channel at requested port */
-	regmap_update_bits(lpc_snoop->regmap, HICR5, hicr5_en, hicr5_en);
-	regmap_update_bits(lpc_snoop->regmap, SNPWADR, snpwadr_mask,
-			   lpc_port << snpwadr_shift);
+	regmap_set_bits(lpc_snoop->regmap, HICR5, cfg->hicr5_en);
+	regmap_update_bits(lpc_snoop->regmap, SNPWADR, cfg->snpwadr_mask,
+		lpc_port << cfg->snpwadr_shift);
 
 	model_data = of_device_get_match_data(dev);
 	if (model_data && model_data->has_hicrb_ensnp)
-		regmap_update_bits(lpc_snoop->regmap, HICRB, hicrb_en, hicrb_en);
+		regmap_set_bits(lpc_snoop->regmap, HICRB, cfg->hicrb_en);
 
 	channel->enabled = true;
 
 	return 0;
 
-err_misc_deregister:
-	misc_deregister(&channel->miscdev);
 err_free_fifo:
 	kfifo_free(&channel->fifo);
 	return rc;
@@ -263,30 +267,13 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 
 __attribute__((nonnull))
 static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
-				     enum aspeed_lpc_snoop_index index)
+				     struct aspeed_lpc_snoop_channel *channel)
 {
-	struct aspeed_lpc_snoop_channel *channel;
-
-	channel = &lpc_snoop->chan[index];
-
 	if (!channel->enabled)
 		return;
 
 	/* Disable interrupts along with the device */
-	switch (index) {
-	case 0:
-		regmap_update_bits(lpc_snoop->regmap, HICR5,
-				   HICR5_EN_SNP0W | HICR5_ENINT_SNP0W,
-				   0);
-		break;
-	case 1:
-		regmap_update_bits(lpc_snoop->regmap, HICR5,
-				   HICR5_EN_SNP1W | HICR5_ENINT_SNP1W,
-				   0);
-		break;
-	default:
-		return;
-	}
+	regmap_clear_bits(lpc_snoop->regmap, HICR5, channel->cfg->hicr5_en);
 
 	channel->enabled = false;
 	/* Consider improving safety wrt concurrent reader(s) */
@@ -299,8 +286,8 @@ static void aspeed_lpc_snoop_remove(struct platform_device *pdev)
 	struct aspeed_lpc_snoop *lpc_snoop = dev_get_drvdata(&pdev->dev);
 
 	/* Disable both snoop channels */
-	aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_0);
-	aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_1);
+	aspeed_lpc_disable_snoop(lpc_snoop, &lpc_snoop->chan[0]);
+	aspeed_lpc_disable_snoop(lpc_snoop, &lpc_snoop->chan[1]);
 }
 
 static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
@@ -339,6 +326,8 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	static_assert(ARRAY_SIZE(channel_cfgs) == ARRAY_SIZE(lpc_snoop->chan),
+		"Broken implementation assumption regarding cfg count");
 	for (idx = ASPEED_LPC_SNOOP_INDEX_0; idx <= ASPEED_LPC_SNOOP_INDEX_MAX; idx++) {
 		u32 port;
 
@@ -346,7 +335,8 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 		if (rc)
 			break;
 
-		rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, idx, port);
+		rc = aspeed_lpc_enable_snoop(dev, lpc_snoop, &lpc_snoop->chan[idx],
+					     &channel_cfgs[idx], port);
 		if (rc)
 			goto cleanup_channels;
 	}

-- 
2.39.5


