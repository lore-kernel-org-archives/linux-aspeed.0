Return-Path: <linux-aspeed+bounces-1480-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5C5C71155
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Jun 2025 13:14:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLVnn5thtz3bTf;
	Mon, 16 Jun 2025 23:14:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750079645;
	cv=none; b=DvuViqzoQ1iTLTpPlP54sYaSiHfG0RZrBaG1LdHO2CHvsXRgfqs9gpOG5KiJmq7z4wChwwLCrOmK1ydoia3OtWUpSE84p98bD19vXKcedUqE3OKImfQv+UCCqCASNY5E9XdwBOWAm58znPbKZztC3AknwHmjaWY3lScsqeCshSX/grsd9fVUFRwJeQ6o4XL+brTGGERmp81TDkaVx2h6pgUOcMKOHBkQlcdbk1ywl4Z06vtA0qIyIO5RMoaCpNSeQIyyRE34g35LOs7BjjLpWy7YYhFy4X+iAhrFsv431KdTIm0NqdgoDq0SrpkuzVSmRo5bP23OFKxSF29giEjmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750079645; c=relaxed/relaxed;
	bh=/lpAFC+njrZ4FhM5FG8e1pUsSKmtZTOJbqXCRTKS2KA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EMJJedKp2yIocxNkQNo851JvDTUkhYV4pFxegskkhHH3VgljGiOXiMLw7C9571UC/andcnARJ0b4EIERCiUmvxZkabuvIq7G0xDLDBGY6rx3PB1qlsnv0IKriWlbFM67sUF6rJTBXtX30j17/qgdwvGBTi70RrQdQnst82ZPuucrkfIpCMg5Qo/z3A4wAwRKFm4sJCPUGJe84qCh9qhFsbKQTscOGpNXaioFzflfv8gtYTaDNbgOntp6VV35sEMFuhq/b/LX4dJoe5S1LieNF2T4Y6AaZ0/8yC+uOdL7pgIxhBfMApCxYjmWIe3v+QR3NaWIKxy6nqmFy0W7dFJJOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NET9XgRj; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NET9XgRj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLVnn2qVsz30Vn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Jun 2025 23:14:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750079644;
	bh=/lpAFC+njrZ4FhM5FG8e1pUsSKmtZTOJbqXCRTKS2KA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NET9XgRjDDQ6ddYttVxtQQdwpx+++CZ5MpuoMLb+RCxX1XQ2awHXdTmlIXAuvPoAJ
	 Q8hrXFQaM3fRylKuxJ1Y3vD3W9p6YXg1/IJuY3am41P97IS6G7hXmT2/wdgVsZpEXM
	 9lNsijfZ6XdryEQPDvWUA05rOX6aR0IFxoHHOiLY/SZslg3oXvo/uhMQ1eWc8U3hI8
	 uEqX/NKjFlA9new7sR3d/wrbx9mqqJUSkLKb6rZovmV4dr5jFHMoYKYxS1KhQFW4UV
	 Enpi2+O5gHKCG16JEitCnpEhaTs/6G+4gA4ufuv6czctTfU496CBJNy73ycsAMGJGt
	 GYKBaiXjdZn7w==
Received: from [127.0.1.1] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 426156885C;
	Mon, 16 Jun 2025 21:14:04 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 16 Jun 2025 22:43:46 +0930
Subject: [PATCH v2 09/10] soc: aspeed: lpc-snoop: Consolidate channel
 initialisation
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
Message-Id: <20250616-aspeed-lpc-snoop-fixes-v2-9-3cdd59c934d3@codeconstruct.com.au>
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

Previously, channel initialisation was a bit perilous with respect to
resource cleanup in error paths. While the implementation had issues,
it at least made an effort to eliminate some of its problems by first
testing whether any channels were enabled, and bailing out if not.

Having improved the robustness of resource handling in probe() we can
now rearrange the initial channel test to be located with the subsequent
test, and rework the unrolled conditional logic to use a loop for an
improvement in readability.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 51 +++++++++++++++++------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 8dbc9d4158b89f23bda340f060d205a29bbb43c3..9f88c5471b1b6d85f6d9e1970240f3d1904d166c 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -294,12 +294,21 @@ static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	kfifo_free(&channel->fifo);
 }
 
+static void aspeed_lpc_snoop_remove(struct platform_device *pdev)
+{
+	struct aspeed_lpc_snoop *lpc_snoop = dev_get_drvdata(&pdev->dev);
+
+	/* Disable both snoop channels */
+	aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_0);
+	aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_1);
+}
+
 static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 {
 	struct aspeed_lpc_snoop *lpc_snoop;
-	struct device *dev;
 	struct device_node *np;
-	u32 port;
+	struct device *dev;
+	int idx;
 	int rc;
 
 	dev = &pdev->dev;
@@ -322,12 +331,6 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, lpc_snoop);
 
-	rc = of_property_read_u32_index(dev->of_node, "snoop-ports", 0, &port);
-	if (rc) {
-		dev_err(dev, "no snoop ports configured\n");
-		return -ENODEV;
-	}
-
 	lpc_snoop->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(lpc_snoop->clk))
 		return dev_err_probe(dev, PTR_ERR(lpc_snoop->clk), "couldn't get clock");
@@ -336,30 +339,24 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, ASPEED_LPC_SNOOP_INDEX_0, port);
-	if (rc)
-		return rc;
+	for (idx = ASPEED_LPC_SNOOP_INDEX_0; idx <= ASPEED_LPC_SNOOP_INDEX_MAX; idx++) {
+		u32 port;
 
-	/* Configuration of 2nd snoop channel port is optional */
-	if (of_property_read_u32_index(dev->of_node, "snoop-ports",
-				       1, &port) == 0) {
-		rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, ASPEED_LPC_SNOOP_INDEX_1, port);
-		if (rc) {
-			aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_0);
-			return rc;
-		}
+		rc = of_property_read_u32_index(dev->of_node, "snoop-ports", idx, &port);
+		if (rc)
+			break;
+
+		rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, idx, port);
+		if (rc)
+			goto cleanup_channels;
 	}
 
-	return 0;
-}
+	return idx == ASPEED_LPC_SNOOP_INDEX_0 ? -ENODEV : 0;
 
-static void aspeed_lpc_snoop_remove(struct platform_device *pdev)
-{
-	struct aspeed_lpc_snoop *lpc_snoop = dev_get_drvdata(&pdev->dev);
+cleanup_channels:
+	aspeed_lpc_snoop_remove(pdev);
 
-	/* Disable both snoop channels */
-	aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_0);
-	aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_1);
+	return rc;
 }
 
 static const struct aspeed_lpc_snoop_model_data ast2400_model_data = {

-- 
2.39.5


