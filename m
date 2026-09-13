Return-Path: <linux-aspeed+bounces-4986-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B964C88E64
	for <linux-aspeed@archiver.kernel.org>; Mon, 14 Sep 2026 00:16:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjm0N1dKDz2yln;
	Mon, 14 Sep 2026 10:16:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:33::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789338633;
	cv=none; b=O7KJBhuVV9QzRbsBJSnqAMuhU501mfFI4TbTV6Iby/JPStt5puXk6xq/waQ/SWEuS4c2xEipwb8cxdS44iqsEKjGSL2DEPvnfmUuX2Lly353PsUwbnDSXp3vewIKOHiMo17z2d9d97p0yG43NgYgyGWB3EjPAjoWGIHvgdYjEE2fJGr79zjklnJ1k5g1O1iZTOsYI+jFVwKzfCKAFWFp29+8cKIrxclhmiGZfpLAdCVVjTuR4TC+VE42GU9rsOMlnY58VW11K/PB4KwXhBwSK9VDnmvsvxecPXff2rzjnTJixBf234RM/E1/yZL/z9gwGN6OM27AGWugH1q8ymJ6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789338633; c=relaxed/relaxed;
	bh=0bAI9mmXm3rd1fs6JBz3Pfb/OV3Rxah7vPEmWuwzOx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VPNeRfYcbnq9trW8gVggJ7O8GT2rBAZQrJUMfhpCJGsO9b0ZLhiVlI39tmOpnMRgztE16A6SHq22t7mWZ+14oZqS4lz61ZTNlNaQTsBS6E2iQbhNmkfQvEnYewOUCrRxf/BZpGaALX0iP81bRhe338ymrU/UNSL7pqYK5ZoKCLn4Bu5N6mqPD6sytdmUhlgsmA2a42Gh8P0NuXaZuCcHtoBDCcFDA9ECyQsn4su1OUuWmWtYAgrZtJFA4YyD8lwpo6TREbhWVHRlobr5nk8KL8I+1jkdzpIJbObwXzt/xL+ScMjx5OPivlMaoZNdBIqUBbsDAgOgguq+NzNfeA17rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ie8Ilvti; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:33::10; helo=mail-qv2-x10.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ie8Ilvti;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:33::10; helo=mail-qv2-x10.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv2-x10.google.com (mail-qv2-x10.google.com [IPv6:2607:f8b0:4864:33::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjjfH5Ljjz2xSV
	for <linux-aspeed@lists.ozlabs.org>; Mon, 14 Sep 2026 08:30:30 +1000 (AEST)
Received: by mail-qv2-x10.google.com with SMTP id 6a1803df08f44-90ce6d5271dso10216376d6.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 13 Sep 2026 15:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789338626; x=1789943426; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0bAI9mmXm3rd1fs6JBz3Pfb/OV3Rxah7vPEmWuwzOx0=;
        b=ie8IlvtiZ+OgHP+zdfwGilwtm2HsV7AcwQVcGGgUNUhrvdS+tC1E8jeJBodm8WUnSG
         MPu7EjUngRDQNrZZ57WNOaUP+TYovKABsV5m2xmrOgWHVKGN4jWDft9FMZ9ql43zz0WK
         0p4C9f4rKLYYBtWaLq1Lzeg/E0JeY7WUDXJRWpT1jO58tqdCcZrZpLiuDIcyehOv14QV
         NBarml3J/QsgHD6r+HxdYa+FeDKaSwqm7xTSE+u54LzqVBKnWStiSc5PwN0lVcjeAvaa
         XuQVdeITLTCWfYWvqDui8uenJs0WCphcoD0HgF/y9rMaCTXRU3ADYSQa9bBuHctAOzLD
         D9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789338626; x=1789943426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0bAI9mmXm3rd1fs6JBz3Pfb/OV3Rxah7vPEmWuwzOx0=;
        b=GfraRZ+psxFeogXeyS2/bRriM0o0kobrJwUc534bf7tNi0Xo5G4IP9XHmlCs4OnzAP
         0azEHLaJAjwdn2nzu4hYB9V9sLQKRAh4aa1bw3cXzMbQYQ3YQq/v7b1XUmwlFFcdObh8
         PLHtg/q9bagEg+5ta7y8eX9mfWYrKmnRlJRB4OCyBXgsEpO2MMmaGVfatd211nyABCAc
         Ads+F/lsCSUfEek0kUiy4voAvkm9Rg7qBjVLrtGiCAxdFrRa2Vx1IrCxoWj/0JSRYN+E
         vLFXhNhhFPhqjYqU22LZfCdIUoDcDc3uxeLRbscnNecNbj2dNCly47jbY0LGJW/GzsTA
         fkiw==
X-Forwarded-Encrypted: i=1; AKwUvBwyNjvZE41SELsnPXDamfvk1S5udwLxt5yx5t7qaQazuNJthklg5r2Xls2E31QYUYBLUNV8PFgGp4Zujbc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k4DHBvZdQ1Y0EMdf7YUGjt364S/IjXdAheHunHfS7Ad75IEPy6
	koFkbXile7QuHCfFfujqBPc2yZUVm6ziHP+Kgd56Xi6yxbmL636xUbE=
X-Gm-Gg: AYBFou2RU2TQxLlGB8yIK3PIDLqSHh54a1+vVM9VSDVjP2Lxn+eCbTKdUHx4+6jYhRZ
	mK3G32O6ErrQbKDblf5wNuM34FkW+uhce7XKvyx8N5kJC1vP7nXt1P69YQWTaUDq34O3Rm6Yu3r
	V+iK3gGCrhnKVbXVD9JaXHZUTHyDM0YYHqN99LaTGdAmiFTVswrZQwx220438LxCyEPEHS1zI4+
	gzQK5epSTp3DrzyHg7MO4A7R01BFHS/I+mgLa2b+8mQjpR5wy/VHN6U89d2UhbAArFtfUenQ49e
	l4AIfOqguozFv6jDfSYyNuA6RHDaYDRqD4RcSwvZw7zIXfFJIexxGL2qqQ0RUxBZ29F0W8Tn4fL
	EI3qTVqhg3RpNF9yIE2mjLDIYXSfKRGwEb8I1RzsBK10pKoC1qHzxctKMAVfJaeOSbrAUaULnXC
	Oci2m/oANUPo15MsAPgweIrW++18hUe8nvWJzsnt/b7cDk+N5HH9zuiGP50vJPHkoFBF5DnLVsj
	zcjmX0W14qER2qxxbGLLrcuqCGDgzbMkkk2gaL14FW8Rgi4uy3OBZneCoKN4fTkZ/9PF9UijXLp
	6voOecJ+2lQp6rBoD8jiXaufnFk3H6Rk4Odkp0u8andF
X-Received: by 2002:ad4:4ea4:0:b0:911:2a7e:abbb with SMTP id 6a1803df08f44-91226b71087mr49832196d6.14.1789338626502;
        Sun, 13 Sep 2026 15:30:26 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120ef650a6sm80587576d6.0.2026.09.13.15.30.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 15:30:25 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
	linux-aspeed@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/aspeed: Balance the display clock enable on teardown
Date: Sun, 13 Sep 2026 18:30:19 -0400
Message-ID: <20260913223019.89651-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

aspeed_gfx_load() enables the display clock without checking the return
value and never disables it on probe failure or removal. devm_clk_get()
only releases the clock reference, leaving the enable unbalanced.

Use devm_clk_get_enabled() to handle enable failures and automatically
disable and unprepare the clock on probe failure or removal.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 4f2a8f5898ec ("drm: Add ASPEED GFX driver")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Assisted-by: OpenAI:GPT-5.6
---
Validated with an ARM64 W=1 object build and strict checkpatch.
No hardware runtime, clock-failure injection or unbind testing was done.

 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index d4577663a..aa36b79d0 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -189,13 +189,12 @@ static int aspeed_gfx_load(struct drm_device *drm)
 	}
 	reset_control_deassert(priv->rst);
 
-	priv->clk = devm_clk_get(drm->dev, NULL);
+	priv->clk = devm_clk_get_enabled(drm->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev,
-			"missing or invalid clk device tree entry");
+			"failed to get and enable clock\n");
 		return PTR_ERR(priv->clk);
 	}
-	clk_prepare_enable(priv->clk);
 
 	/* Sanitize control registers */
 	writel(0, priv->base + CRT_CTRL1);

