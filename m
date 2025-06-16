Return-Path: <linux-aspeed+bounces-1474-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51FDC7115F
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Jun 2025 13:14:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLVnj3TWPz30W1;
	Mon, 16 Jun 2025 23:14:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750079641;
	cv=none; b=czVi3VzbFiRWQ5djR1N11n+lyBJvUJw4qZIf+cFNajeSxbEaMfUu8EBRGDhDQ9EuqtngCMtaqroSftAcha3O9956/6HovYcw3ADIWj6+eA1VNp2GVRRUJrF4skxmKDwn2zeVgmIfnHVYwB1IwJYXlLayAOUqXPUfsNToF+U2UsMnToawvw57ktdhSgkFLx53WmfvC+zI9pTuzy8ZBR+e895pY/oPmjf6BFDancyKHbwaMY/5jYpgccsber+3VvDPVEAWM2V/OixNpcpTcpCALHC2baqFkqCe+n6SUHxn0MZXajT76WmYW9Ohy5iGyGVDpNNSpTjP6a+JMKCPtpjCQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750079641; c=relaxed/relaxed;
	bh=6HfCH5xCSmXty1+8psQGrMNCTeyB1xRyjYHFsLCwi+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQYMBvpApr8UobWqN0HD7AWi9eUoFNBRHIMO5aAeb1HztV8lhO3XGtx8z+G1a19m0JSIDk0pbRtT+qv8LKUYOM6CxbqQHAVEodBvgapNo5iWpzJQx+eWXk9I+1G5z8MD+CbHMz8l8iN7xOoEI6D8wXh3l3xLSGS6zOxsKbiJ4hWqMyE6ZgF+NSBnJR7KbK3lAqhvQ3YMZLFZpLX/FVVuroS7MqY1oplIurDC5UvoP1riodQ13+NDg32UXbiCczOIAhlUE/E757D++5eFB3iXgUn6omR22XiO8a58pXTHnviUWFFsJlP/0+7A1UQzFfxxZR8dZqNTwZqn4DQN6zd5Tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GVOeV9iR; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GVOeV9iR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLVnh4gD4z30T8
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Jun 2025 23:14:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750079640;
	bh=6HfCH5xCSmXty1+8psQGrMNCTeyB1xRyjYHFsLCwi+g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GVOeV9iRfH4ougILfDCxE3OyCTfrmUJ/K1YnrK4cbBjy1MJ6Zjhl6aD+/CxxNYxql
	 m79+64WKF+HVXv/vfBmcf7+AF3/WbJnXrKsjceCgjpTatdC2xJCqFbsmWYx+IObccM
	 MHPWi7G3Pn4LhNKTT3tiKsVEY8WYRGHaHumbfKLsRuZmogPhSao/kV4U6vaOJOfstQ
	 8U+qND8iR3oW0SK8+kottZZ1Jp9IGZwP2DP3J2cZnrHHv5YrreoRw5hqYtpWTcvvEw
	 HsvYgoSbnQ1RrijY5OIB8GG2+bLxNFkZWOSrqKx4sTD5CViQh0tgAXyLyM6Sg3Tj8j
	 pProyHd+DH+nw==
Received: from [127.0.1.1] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5248968848;
	Mon, 16 Jun 2025 21:13:59 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 16 Jun 2025 22:43:40 +0930
Subject: [PATCH v2 03/10] soc: aspeed: lpc-snoop: Ensure model_data is
 valid
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
Message-Id: <20250616-aspeed-lpc-snoop-fixes-v2-3-3cdd59c934d3@codeconstruct.com.au>
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

of_device_get_match_data() can return NULL, though shouldn't in current
circumstances. Regardless, initialise model_data closer to use so it's
clear we need to test for validity prior to dereferencing.

Fixes: 2dee584bc9e3 ("drivers/misc: (aspeed-lpc-snoop): Add ast2400 to compat")
Acked-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index fc3a2c41cc10739f5f70ded7ac02baab6468d652..ca7536213e0986f737606a52996ffea620df2a7a 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -186,10 +186,9 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 				   struct device *dev,
 				   int channel, u16 lpc_port)
 {
-	int rc = 0;
+	const struct aspeed_lpc_snoop_model_data *model_data;
 	u32 hicr5_en, snpwadr_mask, snpwadr_shift, hicrb_en;
-	const struct aspeed_lpc_snoop_model_data *model_data =
-		of_device_get_match_data(dev);
+	int rc = 0;
 
 	if (WARN_ON(lpc_snoop->chan[channel].enabled))
 		return -EBUSY;
@@ -236,9 +235,10 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	regmap_update_bits(lpc_snoop->regmap, HICR5, hicr5_en, hicr5_en);
 	regmap_update_bits(lpc_snoop->regmap, SNPWADR, snpwadr_mask,
 			   lpc_port << snpwadr_shift);
-	if (model_data->has_hicrb_ensnp)
-		regmap_update_bits(lpc_snoop->regmap, HICRB,
-				hicrb_en, hicrb_en);
+
+	model_data = of_device_get_match_data(dev);
+	if (model_data && model_data->has_hicrb_ensnp)
+		regmap_update_bits(lpc_snoop->regmap, HICRB, hicrb_en, hicrb_en);
 
 	lpc_snoop->chan[channel].enabled = true;
 

-- 
2.39.5


