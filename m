Return-Path: <linux-aspeed+bounces-4661-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475F4C5AC67
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Aug 2026 03:00:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHjLs3Whhz2y1Y;
	Sun, 09 Aug 2026 13:00:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786090644;
	cv=none; b=HLdBJcv8NOmUw+iQIUw4yrEjuXCSDfpJfpJyAbo+Y0yKMbgMtXfpouDpbpnuYGst6MHYL/pKhACWfXqP99/BSxCg+H1utwnxLsyEAlGW1dbopj6qt4NIpEAc5BJKVs+avdSkZJsY2hy0ddHWB+jZ+4fjoo7xUlDa6XkCR1zYWPDhL6heIO7cS6toxmmM8RykE5a3jW7oVC/MgAnVbmfWWotPgftF0T4/+6TFnbFOV2g+nA0bAmBW+uQh24p35ty+82MI7I88R1WAuOEtfPRlhziKbWnHhF/u0YTa4RlPET64OiDzEdDRIhTXbotV/gdiGI79ole0rABejMGQf1Tzew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786090644; c=relaxed/relaxed;
	bh=xhHhQhUh884edb2pkrtgwkkFMcH6OBy0eevlqyMXflE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEpGXAkxAz+SMU+4OV94xmdYhUYT/+17rWFJs0CvAnNZGFVHepw+xhI13rbvf5vbTkJckk3q6qCMfgjUXwJqdIvjykJiwn7q8JyLQ+fvISciN9ELcY14G5hYmYiemzhJ0K/UnLblQ5BwrkarLJoSg2iFmiSMg5ZvRy51Gf+xCBCEnFW+6PtcTgjkVIwj8U7OOUtNWYDeJ9G9ksEmMIAujEf1baXiOUOP8vvqWgLNbJLrmG8wy9nNP0JD23gMQmT4h5A1nAroXI82myBvNxIdb58tpPWETdBtGn9BlgwKqhtXfBE5wD5ZWD+oDqxQOBoam7F2IfVYYFyYuX4v+bRXXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pmi4vMjQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pmi4vMjQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGcT0202vz3bps
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 18:17:24 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so3041943a91.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 01:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786090642; x=1786695442; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xhHhQhUh884edb2pkrtgwkkFMcH6OBy0eevlqyMXflE=;
        b=pmi4vMjQ67FXMqSiCHeUm7rbi61CFsrWk0A9p8Tnr/VhypVYWd64yNP8N9lqhONFSg
         FGg0TXcdaMkyCvpi7WB15N/Kvk2vzN6jKZMCqpK0fL6jJsfZJ/3ZOj+HZPGC7NQVCFZ2
         ZRxd/WZju7RXJnMacSzHCKi+FnHUMehs7u+0I0BZcZP9NyYoG58u7zBOuSc/+XTMwdor
         hpG4nm1dllOA+3KhN8rHpdSk1dV7JHrbKBjhEqXzFgmlchNMEjg2HcC+hhH6lm/QeJ5V
         tmL1i6N6MTGm/4e7LbG2dsXm6fbVUd6OklguBFWPhYHkJRSfD8K6SdBEsPKlHbb75XAr
         sELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786090642; x=1786695442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xhHhQhUh884edb2pkrtgwkkFMcH6OBy0eevlqyMXflE=;
        b=qNOLzSF+2kRaz/9Jqi6jIPG5qhQZ+dv7NQurttwKSzgAErKjI5ajwJ098MModFv/lX
         O+klcawy/6Y0/p4FbGhQBJJODYxLcUr7Cxyvk1WLfZNV/afCvhj0LBjDr/gSVAtvxGjH
         t2wpWfgGuj756nNXIGH8taZ4O27whaYOMo9prJoCc02+fH8NC0OFypXVa/7Y5r+BQ6tI
         6PQGV1VGaKTo/bE66t54gtSXO3eDMn1gd5qntgn4LMMuJT91Dy1ALdccjAoQBYFrH8my
         T4xyGm+fRTYvbsvVHMF9ltSnh8eVi9IzUVZFHY3t6BW2qXU/4jQoNYeBYlFgv3YSeU41
         ML6Q==
X-Forwarded-Encrypted: i=1; AHgh+RoMhIus1aUKn78fwpow6D/77FMVudEdAp2jNs5D8ubuT5UqJtyERGFFJAXA9jQA7EsOJJ06WyVDEHf2kWA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YycVjMTg8p05bRfNu5UKoWIqsDkQQkqHcX/C9oC22ZBkWlV3uDf
	0goV6dVaYBuDl69uCnPfX8jZLTOQrz6T6OB0wPsxQ6eDZ5hOse6iWZFu
X-Gm-Gg: AR+sD13JLND2YLmcbcMR/tVM388W/b2L6EfDdZmHDhC+MKc0XgsTnUH4dYO7LZhpKh2
	hUCVCHtrDY3J4SFuL4GXnNch147v53UmDrdk0HeFeO3+ntgEPMfrz1Cx1FMXiAMhF3LFfN3RPix
	UCwzTLb/yBRuiOoyXir0qZgfgD+S4gWX84L7hrTV0ZqRARCdSnawdJiR4A+vR2dXrZlQ5N80pWm
	Q85TgSHPQIT8Ep/BmPvqLsFsyP0u2QQIIE+5BGnuAgFkoeqhXaMX3+cyrg0tXc/EC2ACKrs9cG2
	9+zWa1peVqP0zDgh/ktzp2RztXSPm8Uzn5Y9qW3RTGoQucJG+mjAkkyRTiJwROAGxZLI1krtV18
	362czZnHX5OZSU5Mv/YsXnQZTzCKOC/c81itsy4rHZzMRrUf46ze1V8QruGvZmgQGWmvWOSLAeJ
	UcIWICxejQWFyKv/xWE2izlBEzVBjw7bF6xoo8hSe42h8fK0PUxDqu3z0XVpYQQSM/qa+R9ElGP
	FZJLBI+ttiZgtf+E/HzeZgwdVOvYE+f48f1RXer94YwuYzEfQfCfNIHx4hhoLh3k2WDeVXouiu5
	nYv1
X-Received: by 2002:a17:90b:4e8d:b0:38d:ec31:4840 with SMTP id 98e67ed59e1d1-3903c5932femr22557442a91.13.1786090642107;
        Fri, 07 Aug 2026 01:17:22 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de8ddcsm3913377a91.6.2026.08.07.01.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:17:21 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 4/4] watchdog: aspeed: Propagate errors from optional IRQ lookup
Date: Fri,  7 Aug 2026 15:16:52 +0700
Message-ID: <20260807081652.38692-4-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807081652.38692-1-phucduc.bui@gmail.com>
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
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
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no IRQ is available, while other errors should be propagated.

Propagate errors such as -EPROBE_DEFER and -EINVAL instead of continuing
probe without the IRQ.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/watchdog/aspeed_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index c9e79851504c..48454ac86074 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -429,6 +429,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	if (wdt->cfg->irq_mask) {
 		int irq = platform_get_irq_optional(pdev, 0);
 
+		if (irq < 0 && irq != -ENXIO)
+			return irq;
 		if (irq > 0) {
 			ret = devm_request_irq(dev, irq, aspeed_wdt_irq,
 					       IRQF_SHARED, dev_name(dev),
-- 
2.43.0


