Return-Path: <linux-aspeed+bounces-1151-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2B6C36018
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Apr 2025 11:46:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZRmRX41FVz2ySc;
	Tue,  1 Apr 2025 22:46:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::642"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743493629;
	cv=none; b=iDIHe90Sa/SnDr52+/wVys4vaWmsOJdMw4rpVXa74eoKB93AVLufv+XiOKpOI2i1FxRF8/4pMWhlFNcN7Ilzqlt8Qf2Un2r3BucPYX7zzlMRrUSc+yNko+NkTlrWt9uj0y0T6x0KxnldfTyTF4UKS6y8Zg7pObNK4sDMbg8e/UO6nVlVSJDmpYXu4AGj1tv6c8fCXDAzdxmJp8z/cSYgaLJnvYSPVzEO4t1QxvG65vmt5ijfRbVZf7knGDFq8snNKHFjDIPw/qcuR/kRA8aKpCzJSZkZtt3wV0rq7JH1p2NFSJa4o31eVAUP36ttvj3RIcmoxYduomEAhgo0VvCg9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743493629; c=relaxed/relaxed;
	bh=MOOc99waxVZabi2Ytb5QxIM6jcyNAh7G14JWyJa6TT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SWLBiB/OwNN48Pnqf3wpCg5c7ekoEsRLzMOJiLdNUFKQ3uh67F+s4B59bu7wL5/ZvtAcnLXPYU06E0wxu1/aEBSuo2NeguINDZ1tmhyfvMHjrlxlOEe+FRTVVkDlgsgtGFgteLD6FkGoGBC8cr5KKyY27CNGuoUP8PDmpdSBIKXUNN0a29NDGVhSn3NLMOuLIwVIkDuKD/LjWB4pP6UKC0nffaHIvTfphtb4ioxmH0QnXdMoq/8A7jdrOxzjxPZlUGNOfAHuwuE97xzq+jsAidP1TbaSxY/UmKlYvSUjSIki8tMi8BYcsu6BBMn96Fp95xm+P6145bAfWFtS2X8n+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YwjY6vxg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YwjY6vxg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZRg7b6dKBz2xGp
	for <linux-aspeed@lists.ozlabs.org>; Tue,  1 Apr 2025 18:47:06 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-2260c915749so72412105ad.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Apr 2025 00:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743493623; x=1744098423; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MOOc99waxVZabi2Ytb5QxIM6jcyNAh7G14JWyJa6TT4=;
        b=YwjY6vxgqRy4Ze2x+pTBO+psZ80R8ioIgXFI4kLlHuLgECR0NfD76y/jlcdm0vO/CH
         2eFAwo8eqlvsqLCHV/w6e7VxMTUqk2DCOsfjJtopDvBGDa5wCk5V+pGvfCK1vU468Jp7
         yUZaVK0UrYRScB4arKImywAEOghZ8fQ+xHxvUFueaOPsFh4Ldst1KovSkSm2bZtZU6rY
         ARcML7DuI9QUOXrAWGLQsjYgPCAeUbDwa+uLIdjoB6xAGI5/+V4Pf76kYyyXsQQBgd85
         z8dKEd9j8gkRotY4GrmkrzFPdhVkYFxPowPRRIrHqBStK+W4ljoAyulstOAaXMTgL+UJ
         i3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743493623; x=1744098423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOOc99waxVZabi2Ytb5QxIM6jcyNAh7G14JWyJa6TT4=;
        b=lkEF5zd9YbtIMCn6CYo2pipNi9Z8tvZuQN1DZZhWdkqfrLljSoqLqMKKKktm8eJqrC
         TOO8soa+TNoA6tIAlKHeTmYko6wwteoyKDmXnE9oAbqmwdaQJcJ8ov5a6vrcTVcoaU1V
         80MWcxRJuM9/h10anL0VgDmly+IwvBxia/hOBR/CqxoU+ZkLM0Fz249YbSbyxhtDrdJb
         wWm8zJHIlfHmbOAhpTb+Q82ORtsSpVvXM+Do/lqF1s+YdcO0+IyoGhInUV/ZXHRuN6YT
         R4R0WeK3lxfvLMb8vjVT03oxKdSdr27Vo0NuDcBgjhpQZsZpcHuy5cNa8b03zZsV8ZAB
         pU9A==
X-Forwarded-Encrypted: i=1; AJvYcCXuJZcFYob939YIQz8wAl8lQcErVsHAvqiGXs09X2eM6KA2tM6K4hn2UPFm3tJsCP+LFRoEMZasIBiPBPA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw/RQQTHOXWvAqDkV8yiDiVrffvoXT1OTUSgk11KHsVUUsaOLgn
	fXMtdSkYHBcEu/f7EOHCXuYIBCI8nxFEoc/DhAZULXtTkwJ6NFbc
X-Gm-Gg: ASbGncug/FtVR4vS+WOeHA011lJ6G+xKMsinFopVAsGO0uvH3Q7duCp3kL69XynKAhm
	EI4VRi8DSQ1o+Lopm//cl0GDIsCypZe+anRPsl0sU1EYGhUtZS2ExdUxlFyZlorNByAp4738TA2
	F/uX65Jn6/sVQaBaMkqwBd5xBo+iH1McgVm/8fYV81eToX6lYeCO2K4LwertQPQA/DWf+zwfVKO
	ZgBq8i+0a170tQYJIe3l0fkIWeOHKxzNSsn3shDfiHdtQKW043wWSipaxQAGGg189jcVv/vCKf7
	qDmQ3WGdiGTf3mXDuM9aGX5djCZxaXrl1RbfksQ5TzYFvDTTL/FEEqVUXNOrgD+srHyOwkc=
X-Google-Smtp-Source: AGHT+IFZy01sSWuQIVITMC/7GCZ0VOUQ9l5P25t3PEDAJzmDMq/S0RjaavN8GMJVclcwJerUhN7Uuw==
X-Received: by 2002:a05:6a00:a93:b0:730:95a6:375f with SMTP id d2e1a72fcca58-7398033f039mr19324112b3a.3.1743493622478;
        Tue, 01 Apr 2025 00:47:02 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e2a0e2sm8512745b3a.67.2025.04.01.00.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 00:47:02 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	gsomlo@gmail.com,
	heiko@sntech.de,
	arnd@arndb.de,
	herve.codina@bootlin.com,
	andersson@kernel.org,
	u.kleine-koenig@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v4] soc: aspeed: Add NULL check in aspeed_lpc_enable_snoop()
Date: Tue,  1 Apr 2025 15:46:47 +0800
Message-Id: <20250401074647.21300-1-bsdhenrymartin@gmail.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() returns NULL when memory allocation fails. Currently,
aspeed_lpc_enable_snoop() does not check for this case, which results in a
NULL pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Fixes: 3772e5da4454 ("soc: aspeed: Aspeed LPC snoop output using misc chardev")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V3 -> V4: 
- Add proper cleanup when devm_kasprintf() fails
- Ensure kfifo and miscdevice get released on error
V2 -> V3: 
- Simplify the array access and correct commit message.
V1 -> V2: 
- Remove blank line between tags.

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 9ab5ba9cf1d6..3e3f178b1226 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -200,11 +200,15 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	lpc_snoop->chan[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
 	lpc_snoop->chan[channel].miscdev.name =
 		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
+	if (!lpc_snoop->chan[channel].miscdev.name) {
+		rc = -ENOMEM;
+		goto err_free_fifo;
+	}
 	lpc_snoop->chan[channel].miscdev.fops = &snoop_fops;
 	lpc_snoop->chan[channel].miscdev.parent = dev;
 	rc = misc_register(&lpc_snoop->chan[channel].miscdev);
 	if (rc)
-		return rc;
+		goto err_free_fifo;
 
 	/* Enable LPC snoop channel at requested port */
 	switch (channel) {
@@ -221,7 +225,8 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		hicrb_en = HICRB_ENSNP1D;
 		break;
 	default:
-		return -EINVAL;
+		rc = -EINVAL;
+		goto err_misc_deregister;
 	}
 
 	regmap_update_bits(lpc_snoop->regmap, HICR5, hicr5_en, hicr5_en);
@@ -231,6 +236,12 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		regmap_update_bits(lpc_snoop->regmap, HICRB,
 				hicrb_en, hicrb_en);
 
+	return 0;
+
+err_misc_deregister:
+	misc_deregister(&lpc_snoop->chan[channel].miscdev);
+err_free_fifo:
+	kfifo_free(&lpc_snoop->chan[channel].fifo);
 	return rc;
 }
 
-- 
2.34.1


