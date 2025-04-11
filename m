Return-Path: <linux-aspeed+bounces-1175-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A36BC369AC
	for <linux-aspeed@archiver.kernel.org>; Fri, 11 Apr 2025 01:09:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZYdqv1mXZz30Vj;
	Fri, 11 Apr 2025 11:09:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744333755;
	cv=none; b=CgdhcrH6afl+UuISOwrzh5Z+xhBm6uFvNJ7qjPHkFX1SOLcHiY8oBe3Ko1DewPYyzvj8S86mgbwDuq4B2+Oi2mLBYJyOpKHkfFAzltBFv8Y4ZBXsfYT+wExXIGHzjughuhRfthXrc8ST3o8p8sAOibshnw9ndoduYxDjcKaLqV9RnhHN68+I47megp6uNazMmcVEbgeNx/HrZytWtIm1PvYiFoAWKskZf10r+WYDTOo1sFii6+N57ZF9HiagV0sSGfSPD72y5XgQbONIBR/FJ9Fp90K3mwgx8chUt6/48n6lp/1wGpwaBkvo8QS9ui+uti3n84mOieOO9GxM9c+r8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744333755; c=relaxed/relaxed;
	bh=5d2qecfXxLFsaK8953Ze2wHaQJoHjLdmHiRZ/zMT2W4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abscY4aBSsVx1X92gF6inrQ4ySjec4RGe7HYx0+5NA3twA9b4qcfqrfyZwlFqnosmEA+WbywUpiHIwvF7icQQaxJyZliibIrU+xhKo7QCoguoIf3ISmtuI0bkqPAWD9QNqUWXtfnxNJ6uDJdAyGEmzUIy/Y9WCZRlGXSgBaYdsDk3AjEdvN7BCT04lz4wX5Rk5XAKI9yGphiQTitIsjdiuswTv0wSCLIwu3PUr2LA0NuWpbgFfyyg3ZxOnmYyI3xdVN5gRvM5sU012plwkuAFglF02u7CXIj0wtzAc5upFzOCLd8RvMpnLWodNm/gGdFPLxzA39TIRDK0wfW14MYNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RxRK3urb; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RxRK3urb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYdqr1vnCz3bh0
	for <linux-aspeed@lists.ozlabs.org>; Fri, 11 Apr 2025 11:09:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1744333751;
	bh=5d2qecfXxLFsaK8953Ze2wHaQJoHjLdmHiRZ/zMT2W4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RxRK3urbtqHCux2yvKr3Gday1m7MxlHZfjP51M0pU7PtXXAT6nSXsvkkTYg3uMMzL
	 /gkibMwHZ0RtmYUM63NDsXRhzokmXqknjY4/NNbs/0/6cA6SNZ+9icNt9jF1oNGGcj
	 3fACPSlg+D8I4YoBhHbIoSs0d+4bEEoSEiUdQXcfdxBdLLJsLJToHz7kpZAaO5rmYF
	 WGbYEV5lG01NjsKuKcrqj9K/RjQcBwDTllRIi65WReUgZleU2ZY9p55O2U+bffwH/o
	 /SGlyOXaBms/TwX/EibCD6hT3lMLAhPl0C4p2fU6Z5zZzaR+T3sWPtIxbiK5XEdI4g
	 0CvxqQkgLB8Rg==
Received: from [127.0.1.1] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A59267D715;
	Fri, 11 Apr 2025 09:09:10 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 11 Apr 2025 10:38:35 +0930
Subject: [PATCH 5/7] soc: aspeed: lpc-snoop: Rename 'channel' to 'index' in
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-aspeed-lpc-snoop-fixes-v1-5-64f522e3ad6f@codeconstruct.com.au>
References: <20250411-aspeed-lpc-snoop-fixes-v1-0-64f522e3ad6f@codeconstruct.com.au>
In-Reply-To: <20250411-aspeed-lpc-snoop-fixes-v1-0-64f522e3ad6f@codeconstruct.com.au>
To: linux-aspeed@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>, Henry Martin <bsdhenrymartin@gmail.com>, 
 Jean Delvare <jdelvare@suse.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Geissler <geissonator@yahoo.com>, 
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>
X-Mailer: b4 0.14.2

We'll introduce another 'channel' variable shortly

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 47 ++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 6ab362aeb180c8ad356422d8257717f41a232b3c..f6952f71eda52c95aea5ad1084edd218b88f1234 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -185,40 +185,40 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
 __attribute__((nonnull))
 static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 				   struct device *dev,
-				   int channel, u16 lpc_port)
+				   int index, u16 lpc_port)
 {
 	const struct aspeed_lpc_snoop_model_data *model_data;
 	u32 hicr5_en, snpwadr_mask, snpwadr_shift, hicrb_en;
 	int rc = 0;
 
-	if (channel < 0 || channel >= ARRAY_SIZE(lpc_snoop->chan))
+	if (index < 0 || index >= ARRAY_SIZE(lpc_snoop->chan))
 		return -EINVAL;
 
-	if (lpc_snoop->chan[channel].enabled)
+	if (lpc_snoop->chan[index].enabled)
 		return -EBUSY;
 
-	init_waitqueue_head(&lpc_snoop->chan[channel].wq);
+	init_waitqueue_head(&lpc_snoop->chan[index].wq);
 	/* Create FIFO datastructure */
-	rc = kfifo_alloc(&lpc_snoop->chan[channel].fifo,
+	rc = kfifo_alloc(&lpc_snoop->chan[index].fifo,
 			 SNOOP_FIFO_SIZE, GFP_KERNEL);
 	if (rc)
 		return rc;
 
-	lpc_snoop->chan[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
-	lpc_snoop->chan[channel].miscdev.name =
-		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
-	if (!lpc_snoop->chan[channel].miscdev.name) {
+	lpc_snoop->chan[index].miscdev.minor = MISC_DYNAMIC_MINOR;
+	lpc_snoop->chan[index].miscdev.name =
+		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, index);
+	if (!lpc_snoop->chan[index].miscdev.name) {
 		rc = -ENOMEM;
 		goto err_free_fifo;
 	}
-	lpc_snoop->chan[channel].miscdev.fops = &snoop_fops;
-	lpc_snoop->chan[channel].miscdev.parent = dev;
-	rc = misc_register(&lpc_snoop->chan[channel].miscdev);
+	lpc_snoop->chan[index].miscdev.fops = &snoop_fops;
+	lpc_snoop->chan[index].miscdev.parent = dev;
+	rc = misc_register(&lpc_snoop->chan[index].miscdev);
 	if (rc)
 		goto err_free_fifo;
 
 	/* Enable LPC snoop channel at requested port */
-	switch (channel) {
+	switch (index) {
 	case 0:
 		hicr5_en = HICR5_EN_SNP0W | HICR5_ENINT_SNP0W;
 		snpwadr_mask = SNPWADR_CH0_MASK;
@@ -244,28 +244,29 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	if (model_data && model_data->has_hicrb_ensnp)
 		regmap_update_bits(lpc_snoop->regmap, HICRB, hicrb_en, hicrb_en);
 
-	lpc_snoop->chan[channel].enabled = true;
+	lpc_snoop->chan[index].enabled = true;
 
 	return 0;
 
 err_misc_deregister:
-	misc_deregister(&lpc_snoop->chan[channel].miscdev);
+	misc_deregister(&lpc_snoop->chan[index].miscdev);
 err_free_fifo:
-	kfifo_free(&lpc_snoop->chan[channel].fifo);
+	kfifo_free(&lpc_snoop->chan[index].fifo);
 	return rc;
 }
 
 __attribute__((nonnull))
 static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
-				     int channel)
+				     int index)
 {
-	if (channel < 0 || channel >= ARRAY_SIZE(lpc_snoop->chan))
+	if (index < 0 || index >= ARRAY_SIZE(lpc_snoop->chan))
 		return;
 
-	if (!lpc_snoop->chan[channel].enabled)
+	if (!lpc_snoop->chan[index].enabled)
 		return;
 
-	switch (channel) {
+	/* Disable interrupts along with the device */
+	switch (index) {
 	case 0:
 		regmap_update_bits(lpc_snoop->regmap, HICR5,
 				   HICR5_EN_SNP0W | HICR5_ENINT_SNP0W,
@@ -280,10 +281,10 @@ static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		return;
 	}
 
-	lpc_snoop->chan[channel].enabled = false;
+	lpc_snoop->chan[index].enabled = false;
 	/* Consider improving safety wrt concurrent reader(s) */
-	misc_deregister(&lpc_snoop->chan[channel].miscdev);
-	kfifo_free(&lpc_snoop->chan[channel].fifo);
+	misc_deregister(&lpc_snoop->chan[index].miscdev);
+	kfifo_free(&lpc_snoop->chan[index].fifo);
 }
 
 static int aspeed_lpc_snoop_probe(struct platform_device *pdev)

-- 
2.39.5


