Return-Path: <linux-aspeed+bounces-540-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF005C02181
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jan 2025 23:31:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YdgLt1FMbz2yLr;
	Thu, 23 Jan 2025 10:31:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737515040;
	cv=none; b=ToAcVb25JbeYT8Tvi6tzy4RdiP7iltQzuk1+OJZqQdTpoOSADzfiYMtlaInQ46IkcDdoX2SWnB0e/2qluWbuu/pjiGkXOdUBVMVkHfaQq7tlRqQrtHCfsWDHClMMw63ihLi/evLSpKzX5vk5l6HpLhrrf5biT+U3ReYuOYSpIyxyWUlN75Nb5UC+USjsaI3ys2wM87GGR7T8RIRtmfU54HhunimHaqkNnYVY9/H0D9c99f77nS7z9KKIeuVzibrfeU7V5oZ9rgrc75mbazKDj4D7p96fYQKwZhKoCPzUj29VlE0wUoZKnXxeSxX5o52B7jYovjAx7xs1Bh4hQMDuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737515040; c=relaxed/relaxed;
	bh=QRjh9FhrnaHu0S6KpqI8qiqynan6VGuEAgxuDFjUP/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DNM4d3QkO16OkHCsL/9jf8C52rZ9oKjgemuLSv7w+TXkEPjsn2WK8ZIheZlq0V5yOXN3gd2UoMMnvTf3+gmVdry1SQyNuLC4aIdi6jVur+rRPzyWjl+rVresJtv5HmXKs4+Dyoo+WnEUGjarzYWN2+ZV/EAWYKqybxW3L58+vwzPZ7OxX6Ev3uDAvhghQbMOeiZfGQcPMTwy/pLqQAJNy/b1e3LJ4ro4kfkhdRmnq/aaT3tYmIiwDhqBerp4BXu9sFTuVp+/lNYNgcKDSDdy1katQDWomCdAUngjZN7eaZ8hJ5Jio1bmL6fryDZ7QMsk3RiekiIjL9G6vmgGV877pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=UyoLNlt6; dkim-atps=neutral; spf=pass (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=oushixiong1025@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=UyoLNlt6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=oushixiong1025@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yd86j6hpzz2xMQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jan 2025 14:03:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=QRjh9
	FhrnaHu0S6KpqI8qiqynan6VGuEAgxuDFjUP/U=; b=UyoLNlt6vmCgZ+SJU1ru9
	gffJweKRjs98BGRmGx6BBDYGF2luHg3g+ZWa2blkEPGxtfdEivo1bO1Yqx3hVAy3
	6n2tUSlqih1Rf5dCiYmsAQXrCzsLSHtq4x8uzsRp1e8g6Wu4QnMN/+apgMPqWElQ
	HEMYAzsE4o3pnLVSmp1Il8=
Received: from localhost.localdomain (unknown [116.128.244.169])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAn0lmmX5BnaACMLQ--.47927S2;
	Wed, 22 Jan 2025 11:02:00 +0800 (CST)
From: oushixiong1025@163.com
To: Joel Stanley <joel@jms.id.au>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH v2] drm/aspeed: Use devm_platform_get_and_ioremap_resource()
Date: Wed, 22 Jan 2025 11:01:55 +0800
Message-Id: <20250122030155.57802-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:QCgvCgAn0lmmX5BnaACMLQ--.47927S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWfCryfWFWUJr13CryxAFb_yoWDWFcE9F
	48urs3XrW7AryDt3yjvanxCFyIkF9agrWrGF18KaySv3W7Z34DWryUur92qr1Y9wsayF95
	t3WUXr17A3s3CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbqQ6tUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXAPcD2eQUvPxtQAAse

From: Shixiong Ou <oushixiong@kylinos.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single call to
devm_platform_get_and_ioremap_resource().

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
V1 -> V2: Add Missing commit message.

 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index a7a6b70220eb..33f81b53771d 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -146,8 +146,7 @@ static int aspeed_gfx_load(struct drm_device *drm)
 	struct resource *res;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(drm->dev, res);
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.25.1


