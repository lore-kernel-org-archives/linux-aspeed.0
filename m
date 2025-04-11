Return-Path: <linux-aspeed+bounces-1170-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA76EC3601E
	for <linux-aspeed@archiver.kernel.org>; Fri, 11 Apr 2025 01:09:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZYdqq6gV8z3bkT;
	Fri, 11 Apr 2025 11:09:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744333751;
	cv=none; b=gm8IrfF5UzCViNMS/tbbQRpPHv+qH6m12nZcbBiREfaoVXdyqIW7PRQbh/XWJlOQtYxnTtmM96oWf5pfrGyqyAL/W0du1z1mA3nWCpIoOvguiaL7chTJ/FwZIMPAGDbPAZr33aMgAhG0lPiVJrPh8rCor3u5ePjYyaj2H7c3z4JF3Fdk0rKLLUNrkD4WMStBGX5/9Kvq1GipxvQMATsB7J6CBrR04P31mjHfxul9RuqeLfnXXHuMwVJRY/fxUVW/E0zeJAKiUvCGN5HMdBCwUa0v63HnvrQUI0qnDYuLDgK4RlbaM0izGg+XDnzbVoFp3HbN41IaS+Vu99/4htU41g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744333751; c=relaxed/relaxed;
	bh=Kl9cNe70ebuqUBsGg3wclmdapJ/BbYZ4gItW6jHIc7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=blCsC6YAiOlIcQ/eXc82T1U2Z2FAR4QPUtS+CijZDAwrwvL0ZUvkhGe2o0TIRVMmmQP2xc8mzcKPlC+zlolAdLZplInV8/TS6sjEOisxWUqIcPimP0J+YJRLFFvwWLMmWk5Te2R2yyOOvIkGlVFUc6Sx/NZcYkbE0B2yWPRH98OWDmhWZh/ZOx5NK6Sxt+ISHk4zss23vZtwzVhVPYuuVHTumbO9VBGbIJKH3UWDyaxaAEaEz5Hq9gxHo4+Z7oqQFIrqVWERvg/HigRizHLWQRg3Wfy0XDrgfySV7ehF/VEHUOBD9VEOLB3+oiX/7DfYm/j0QjpaBGWd0f0A9tynGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=KXybtiEp; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=KXybtiEp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYdqp47bYz3bh6
	for <linux-aspeed@lists.ozlabs.org>; Fri, 11 Apr 2025 11:09:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1744333749;
	bh=Kl9cNe70ebuqUBsGg3wclmdapJ/BbYZ4gItW6jHIc7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KXybtiEpVaRs6sAGdOtnmP9rQxsNzrAWJmdNkLK8ew7d8QxZs4QbeawJkPJVvlGYE
	 kqYN+QPIEr2LOIxkxWgr2NjAowCKjUwCHvNbLmMSyLR7qUkPolYIgpnpWyUpupKQsJ
	 wxAzji6m4w24QEKZHRAbdORveQcLoi+OWJVPb4BDSrxBYVfHp2JrTWXny7XinCq+Tu
	 Vcz/WVUl33+nQkgXC1Ji/Zpx2O+G9Fw1dMcujg6GCyxCOXGLc+cChI2/R6Zi+0025x
	 9OnfmrhQZ2TQTXGqaW6izUHRwuev4+qYKqQQe8ekXqSEjAY3YwmSfMBrtXgZwPtOjP
	 wq48PWVT/MeMw==
Received: from [127.0.1.1] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4EECF7D712;
	Fri, 11 Apr 2025 09:09:09 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 11 Apr 2025 10:38:33 +0930
Subject: [PATCH 3/7] soc: aspeed: lpc-snoop: Ensure model_data is valid
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
Message-Id: <20250411-aspeed-lpc-snoop-fixes-v1-3-64f522e3ad6f@codeconstruct.com.au>
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

of_device_get_match_data() can return NULL, though shouldn't in current
circumstances. Regardless, initialise model_data closer to use so it's
clear we need to test for validity prior to dereferencing.

Fixes: 2dee584bc9e3 ("drivers/misc: (aspeed-lpc-snoop): Add ast2400 to compat")
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index e9d9a8e60a6f062c0b53c9c02e5d73768453998d..28f034b8a3b7226efe20cbe30a7da0c2b49fbd96 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -186,10 +186,10 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 				   struct device *dev,
 				   int channel, u16 lpc_port)
 {
-	int rc = 0;
+	const struct aspeed_lpc_snoop_model_data *model_data;
 	u32 hicr5_en, snpwadr_mask, snpwadr_shift, hicrb_en;
-	const struct aspeed_lpc_snoop_model_data *model_data =
-		of_device_get_match_data(dev);
+	int rc = 0;
+
 
 	if (lpc_snoop->chan[channel].enabled)
 		return -EBUSY;
@@ -236,9 +236,10 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
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


