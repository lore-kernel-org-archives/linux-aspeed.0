Return-Path: <linux-aspeed+bounces-1475-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB17C7115A
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Jun 2025 13:14:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLVnj75kGz30T8;
	Mon, 16 Jun 2025 23:14:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750079641;
	cv=none; b=CgLgRWMopydjqZGkOY+Ddztn+cQQsIfQnGR8y1m3bEDrX8fFDF7P56OrO+gcdpO/fSDjT/Ev+8XF0tx64LckDwxWkkKnWI2x1bQJFPTOIPbID4/UqA6NR8FVOMa3YE/CQWYce0vjlOKsEmNn90IyhtWvE7zDmglRdJluraXysqJethAVvin/5W6CSaY/aQIHZ3jbJNI05awQVIN4ZY8sNWikxjVsox8ViBYd+PodNV0asG+g2lb90F5Uds2wVpyX/89JJ4cYW/mW4kmXpKAN2ZJqHwjRQ2KhEDMrHCzWfTmxFYstCxxOC4PtXTc4OaFORXSc+1wCmTceIo/hmRldkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750079641; c=relaxed/relaxed;
	bh=ZH2nQiJURmm3f1AacPrlu4/bRjlg+XhQ1J7Bn7VXnB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PsBldnVK7gE1QzuHzaEGAibm4LrkCK8ROvhNNgW9QatDhMo6vhBWvkmQBef2p8xTVbDl+le8ZMf6O7Zh6fnpAEDKcT05gQsdJtC8IVBBAXsM+r9URk6QhZaCRuX6SwlF1ylKVLQb8Ur+hTSbzpHfiqN+lbPP4xhVpQM4csv/fFzQhUzga6SjI/vgKj10wqiFCVwmvukFyA6EwrZdSi7iW+BTpwtx4HzQYxQ1j41joucOeQJfyUb0/mFeokcdUYVtxO8WngUGy6mwE8D7+b/P/uB/c2Jyv4ryHdayhR6N46aIri0WSNsnvbXUJlZK7X97zGgGl3n9O4MRYZjjPt9cXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=jOyYZgdx; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=jOyYZgdx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLVnj2q3hz30Vn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Jun 2025 23:14:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750079640;
	bh=ZH2nQiJURmm3f1AacPrlu4/bRjlg+XhQ1J7Bn7VXnB0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jOyYZgdxYYAWdVDWWT9hujOZNAzM7/cW8rNsAD7F/VQKHLlPYJNsa9RD7V0Mbu3CD
	 ZC3xxtBeDLKvUk3wfHwhcQr1yNbTCCJEEMVQSNJmxWpUEHRFjg9WINb24ZCOU3tUDx
	 lpiB0l8eGro6Lp/dqaeZwN71irafgr7CH9dBLiaiXT83vQNOr5HJIe4XQA49+S0xgp
	 KU2guJrnLcxMmJENIbv23CfG/lwB6Apj2Dzx5VS0K2o6baF37jr6AgkgJ+/hrW79Bh
	 pn0QzyL/NBVQp9m3AtYxPL4Uj++L8qBSWDBo9zAhlVg04udw67xJS8ziEQu1Vcjm11
	 +u4D9a6bUJasQ==
Received: from [127.0.1.1] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 329C36884F;
	Mon, 16 Jun 2025 21:14:00 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 16 Jun 2025 22:43:41 +0930
Subject: [PATCH v2 04/10] soc: aspeed: lpc-snoop: Constrain parameters in
 channel paths
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
Message-Id: <20250616-aspeed-lpc-snoop-fixes-v2-4-3cdd59c934d3@codeconstruct.com.au>
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

Ensure pointers and the channel index are valid before use.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index ca7536213e0986f737606a52996ffea620df2a7a..804c6ed9c4c671da73a6c66c1de41c59922c82dc 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -25,7 +25,6 @@
 
 #define DEVICE_NAME	"aspeed-lpc-snoop"
 
-#define NUM_SNOOP_CHANNELS 2
 #define SNOOP_FIFO_SIZE 2048
 
 #define HICR5	0x80
@@ -57,6 +56,12 @@ struct aspeed_lpc_snoop_model_data {
 	unsigned int has_hicrb_ensnp;
 };
 
+enum aspeed_lpc_snoop_index {
+	ASPEED_LPC_SNOOP_INDEX_0 = 0,
+	ASPEED_LPC_SNOOP_INDEX_1 = 1,
+	ASPEED_LPC_SNOOP_INDEX_MAX = ASPEED_LPC_SNOOP_INDEX_1,
+};
+
 struct aspeed_lpc_snoop_channel {
 	bool enabled;
 	struct kfifo		fifo;
@@ -68,7 +73,7 @@ struct aspeed_lpc_snoop {
 	struct regmap		*regmap;
 	int			irq;
 	struct clk		*clk;
-	struct aspeed_lpc_snoop_channel chan[NUM_SNOOP_CHANNELS];
+	struct aspeed_lpc_snoop_channel chan[ASPEED_LPC_SNOOP_INDEX_MAX + 1];
 };
 
 static struct aspeed_lpc_snoop_channel *snoop_file_to_chan(struct file *file)
@@ -182,9 +187,10 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
 	return 0;
 }
 
+__attribute__((nonnull))
 static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 				   struct device *dev,
-				   int channel, u16 lpc_port)
+				   enum aspeed_lpc_snoop_index channel, u16 lpc_port)
 {
 	const struct aspeed_lpc_snoop_model_data *model_data;
 	u32 hicr5_en, snpwadr_mask, snpwadr_shift, hicrb_en;
@@ -251,8 +257,9 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	return rc;
 }
 
+__attribute__((nonnull))
 static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
-				     int channel)
+				     enum aspeed_lpc_snoop_index channel)
 {
 	if (!lpc_snoop->chan[channel].enabled)
 		return;
@@ -331,16 +338,16 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 	if (rc)
 		goto err;
 
-	rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, 0, port);
+	rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, ASPEED_LPC_SNOOP_INDEX_0, port);
 	if (rc)
 		goto err;
 
 	/* Configuration of 2nd snoop channel port is optional */
 	if (of_property_read_u32_index(dev->of_node, "snoop-ports",
 				       1, &port) == 0) {
-		rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, 1, port);
+		rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, ASPEED_LPC_SNOOP_INDEX_1, port);
 		if (rc) {
-			aspeed_lpc_disable_snoop(lpc_snoop, 0);
+			aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_0);
 			goto err;
 		}
 	}
@@ -358,8 +365,8 @@ static void aspeed_lpc_snoop_remove(struct platform_device *pdev)
 	struct aspeed_lpc_snoop *lpc_snoop = dev_get_drvdata(&pdev->dev);
 
 	/* Disable both snoop channels */
-	aspeed_lpc_disable_snoop(lpc_snoop, 0);
-	aspeed_lpc_disable_snoop(lpc_snoop, 1);
+	aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_0);
+	aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_1);
 
 	clk_disable_unprepare(lpc_snoop->clk);
 }

-- 
2.39.5


