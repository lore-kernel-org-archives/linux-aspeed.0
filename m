Return-Path: <linux-aspeed+bounces-1477-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026F1C73C66
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Jun 2025 13:14:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLVnl4Ftfz30WF;
	Mon, 16 Jun 2025 23:14:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750079643;
	cv=none; b=BTXIIYAIm2mH06AvBQdMbRXg3dzYSmkhQdt+gZwecJ6u5C2R9GcTe/WVSKdHwKNVYMbU8A79OfK6sRAzAPkdTYosJ3GlUXbON0iJIxdVd3MLtiy9vGQa+UW1I0nTEzEM8jGQhebmSKcXBEsrBMsRhy7e32l4cWMA9tkai7wkCvQ+r9V2S33ltFe10iPf/RCLajIEloo4pae8m5fZu07luRIbpulPs7ihxqCqyNemPXWZE9dKnaFUu82xaEBCOrGgDWTno0BTxhGx4l6K0NZT2PY79KjQ7h49Ivz3/30Vg1yVs36iT+TU/ImsJd0acLnafy3fL4l3Ur1JSgswK3MoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750079643; c=relaxed/relaxed;
	bh=UQxngRC61Uvyaf7heid0CYRZb+2b06NqoHQ2sVEb88E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g05JxvuADoVrznHsVMrqFYG3bvRZQzGV2I12W9XAm9qFOM2rzhOcXci+652kU9KilnJK+F79RGVq2Ok/VCuIF4zxJ7MxKuDoft3VjC0CeXF1sRp06ruC+rncu6PcHI3v8L9vLM25txnK5e4X49aDI493KqLbXR8QG4ZRfnygqiuVEuvmdT9Ys6D14vZQnhyrJYHZNJRe7QVJ1COhh6PKbQULDdIB1TbpoKEhpJD5w2nZaXkIFTxNrX86MNOa/T1QQSsqcg/WpiZVPKH4V2m9D+3tcagU5ab0kfFnQfsrRuEwe/0cg+1gB4dKxumhDApYk1zqlQ/1m31xDOlXlDSe7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=f8NMQNQr; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=f8NMQNQr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLVnl06LXz30Vn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Jun 2025 23:14:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750079642;
	bh=UQxngRC61Uvyaf7heid0CYRZb+2b06NqoHQ2sVEb88E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=f8NMQNQrnjxle8pqFs7cP3pruGNT7ANeAxYczqs/3t27gTO+phkNSIU2OC8MHECcx
	 o+Ibp4+Ga8sOvgeilUYQwizQ9godtzcqUGLNaj6TVH9KtiBdQlamPMe/vYtZXhVnwI
	 niy0z1l+6N7/e9C91p4b6Frcp1LclqmnQ3GdWvNmtkQAoDiho0sK1gbC89enfwFcqx
	 BZDonHrSyhchGOebClhm2/Z4dLxjSPjppmfNrj7xlpdEd5UfJma/3vrKkMyv3hOuVF
	 +wtD5JGX5/uzmkxbTFVHfAKE92vqqH4da+Js03Ptp4cvqklgKDKQvux1PipWBT6AUk
	 9EdaMrNh+i36A==
Received: from [127.0.1.1] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B6BB3686FF;
	Mon, 16 Jun 2025 21:14:01 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 16 Jun 2025 22:43:43 +0930
Subject: [PATCH v2 06/10] soc: aspeed: lpc-snoop: Rearrange channel paths
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
Message-Id: <20250616-aspeed-lpc-snoop-fixes-v2-6-3cdd59c934d3@codeconstruct.com.au>
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

Order assignments such that tests for conditions not involving resource
acquisition are ordered before those testing acquired resources, and
order managed resource acquisition before unmanaged where possible. This
way we minimise the amount of manual cleanup required.

In the process, improve readability of the code by introducing a channel
pointer that takes the place of the repeated object lookups.

Acked-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 51 ++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index e9d17239163a8ae5145bd3652fcec572b70bd11c..9992212c789d4224edcc0ee1a3bb9c73f9fc661b 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -194,28 +194,30 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 {
 	const struct aspeed_lpc_snoop_model_data *model_data;
 	u32 hicr5_en, snpwadr_mask, snpwadr_shift, hicrb_en;
+	struct aspeed_lpc_snoop_channel *channel;
 	int rc = 0;
 
-	if (WARN_ON(lpc_snoop->chan[index].enabled))
+	channel = &lpc_snoop->chan[index];
+
+	if (WARN_ON(channel->enabled))
 		return -EBUSY;
 
-	init_waitqueue_head(&lpc_snoop->chan[index].wq);
-	/* Create FIFO datastructure */
-	rc = kfifo_alloc(&lpc_snoop->chan[index].fifo,
-			 SNOOP_FIFO_SIZE, GFP_KERNEL);
+	init_waitqueue_head(&channel->wq);
+
+	channel->miscdev.minor = MISC_DYNAMIC_MINOR;
+	channel->miscdev.fops = &snoop_fops;
+	channel->miscdev.parent = dev;
+
+	channel->miscdev.name =
+		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, index);
+	if (!channel->miscdev.name)
+		return -ENOMEM;
+
+	rc = kfifo_alloc(&channel->fifo, SNOOP_FIFO_SIZE, GFP_KERNEL);
 	if (rc)
 		return rc;
 
-	lpc_snoop->chan[index].miscdev.minor = MISC_DYNAMIC_MINOR;
-	lpc_snoop->chan[index].miscdev.name =
-		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, index);
-	if (!lpc_snoop->chan[index].miscdev.name) {
-		rc = -ENOMEM;
-		goto err_free_fifo;
-	}
-	lpc_snoop->chan[index].miscdev.fops = &snoop_fops;
-	lpc_snoop->chan[index].miscdev.parent = dev;
-	rc = misc_register(&lpc_snoop->chan[index].miscdev);
+	rc = misc_register(&channel->miscdev);
 	if (rc)
 		goto err_free_fifo;
 
@@ -238,6 +240,7 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		goto err_misc_deregister;
 	}
 
+	/* Enable LPC snoop channel at requested port */
 	regmap_update_bits(lpc_snoop->regmap, HICR5, hicr5_en, hicr5_en);
 	regmap_update_bits(lpc_snoop->regmap, SNPWADR, snpwadr_mask,
 			   lpc_port << snpwadr_shift);
@@ -246,14 +249,14 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	if (model_data && model_data->has_hicrb_ensnp)
 		regmap_update_bits(lpc_snoop->regmap, HICRB, hicrb_en, hicrb_en);
 
-	lpc_snoop->chan[index].enabled = true;
+	channel->enabled = true;
 
 	return 0;
 
 err_misc_deregister:
-	misc_deregister(&lpc_snoop->chan[index].miscdev);
+	misc_deregister(&channel->miscdev);
 err_free_fifo:
-	kfifo_free(&lpc_snoop->chan[index].fifo);
+	kfifo_free(&channel->fifo);
 	return rc;
 }
 
@@ -261,7 +264,11 @@ __attribute__((nonnull))
 static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 				     enum aspeed_lpc_snoop_index index)
 {
-	if (!lpc_snoop->chan[index].enabled)
+	struct aspeed_lpc_snoop_channel *channel;
+
+	channel = &lpc_snoop->chan[index];
+
+	if (!channel->enabled)
 		return;
 
 	/* Disable interrupts along with the device */
@@ -280,10 +287,10 @@ static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		return;
 	}
 
-	lpc_snoop->chan[index].enabled = false;
+	channel->enabled = false;
 	/* Consider improving safety wrt concurrent reader(s) */
-	misc_deregister(&lpc_snoop->chan[index].miscdev);
-	kfifo_free(&lpc_snoop->chan[index].fifo);
+	misc_deregister(&channel->miscdev);
+	kfifo_free(&channel->fifo);
 }
 
 static int aspeed_lpc_snoop_probe(struct platform_device *pdev)

-- 
2.39.5


