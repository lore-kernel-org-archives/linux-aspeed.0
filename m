Return-Path: <linux-aspeed+bounces-4933-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0677DC61DD6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:20:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0cZ3kRqz2y2M;
	Thu, 03 Sep 2026 10:20:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788359571;
	cv=none; b=SFJWESvBRoAq7Q+b8ydGABcFrfFBObiQXRwaKPZ3OdxPf50B1lV/tywOKLymr5m6rAL68e7XE8+JSGSOC7en0+u7BULBGbuzNoGM3BtvToKm0MDaDbYz/rHz+8ijiNFde4zzbjNF9qpBxqdYGnF0H9HwktMWJLdZKKeiLQ1Gj3R5ccdWwDoxaXVtFA1yfpZrBJFSZ8+KOBp3c00dOJRf6+m4ulI+zsE8GS5qLDE+5W4oJS0nvpsF5RgzgSn7KtWC2ey11J+5NT9Q1NkJJ7I2WgjiMZd8dWJBcLAdC48lwZFi/xOJihbY+Qul1B+BJJ252eBuzubkMrn1cd/KpYRsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788359571; c=relaxed/relaxed;
	bh=7YIOafvXbCcZYfkJxsD9i8XvErNivDNnj0yBlvpAKmg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KzDfh/4uiy/hKDnWPYjYj9gf5WIXEcwc/OF8CM/Kp7QVRNG09icup/sqojjIYSAY2Yiy+tG3ch/j1+e8BbjiHNZzEKB4NwRdCT4WPpCQUPWdG/a/tP8MnrzxLAsNrt6N3oCMX/2HP+TabWQh7M9oYMJ2G5td6XTKm6WqIEEibKXYKrTpP2zZFT/+10MdVud5Uz4NeOIeM6Do6Z5fFL2aCbCo9/l0zjxpbgeQgsC3yBWzBSMLHCIto43GLNh1hkSPspx63B7HO565N00zZLRtDnCkTiFsaRwTEsqnEm4KImfwS959fgUadsBaqvbiv1UerEwnf71UATsZSpi0E4SHug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=KKF8bk19; dkim-atps=neutral; spf=pass (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=runyu.xiao@seu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=seu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=KKF8bk19;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=seu.edu.cn (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=runyu.xiao@seu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 314 seconds by postgrey-1.37 at boromir; Thu, 03 Sep 2026 00:32:45 AEST
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZlZ52SK8z2xl6;
	Thu, 03 Sep 2026 00:32:43 +1000 (AEST)
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c487cfc0;
	Wed, 2 Sep 2026 22:26:07 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Iwona Winiarska <iwona.winiarska@intel.com>
Cc: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] peci: aspeed: Initialize state before requesting IRQ
Date: Wed,  2 Sep 2026 22:26:00 +0800
Message-Id: <20260902142600.3580382-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-HM-Tid: 0aa062834d9e03a1kunm2177e8e01adc4c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCShlDVh8fTkhKHk9IH0gZHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=KKF8bk19ENztW57ojYhZ3fOHVd6TfrO65VlreY5e/zGH8R63SXibz+1hD52XfdiBQEOmmSl+B0x1erwvCUuV8L1sARACXJtB8X83tXJBikjKGw7EeO8+2Xq5uZ7u9qRMdUOafMr8TNGwhZei0FHZInCgqSKU8fq84x7ouLYwvxU=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=7YIOafvXbCcZYfkJxsD9i8XvErNivDNnj0yBlvpAKmg=;
	h=date:mime-version:subject:message-id:from;

The PECI interrupt handler uses the lock and completion object as soon as
the interrupt is delivered. Initialize both before registering the
handler so an early interrupt cannot access uninitialized state.

Fixes: a85e4c52086c ("peci: Add peci-aspeed controller driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/peci/controller/peci-aspeed.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/peci/controller/peci-aspeed.c b/drivers/peci/controller/peci-aspeed.c
index a0c99ecf7..5d7f4f8fd 100644
--- a/drivers/peci/controller/peci-aspeed.c
+++ b/drivers/peci/controller/peci-aspeed.c
@@ -529,14 +529,14 @@ static int aspeed_peci_probe(struct platform_device *pdev)
 	if (priv->irq < 0)
 		return priv->irq;
 
+	init_completion(&priv->xfer_complete);
+	spin_lock_init(&priv->lock);
+
 	ret = devm_request_irq(&pdev->dev, priv->irq, aspeed_peci_irq_handler,
 			       0, "peci-aspeed", priv);
 	if (ret)
 		return ret;
 
-	init_completion(&priv->xfer_complete);
-	spin_lock_init(&priv->lock);
-
 	priv->rst = devm_reset_control_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->rst))
 		return dev_err_probe(priv->dev, PTR_ERR(priv->rst),
-- 
2.34.1


