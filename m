Return-Path: <linux-aspeed+bounces-543-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA29C0218D
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jan 2025 23:31:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YdgLv4kzdz2yZN;
	Thu, 23 Jan 2025 10:31:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737448720;
	cv=none; b=CrFpaendcYV8gNfNB+ZbvwU/vASFZIodKZQjqQCK1D0FWdFEK9lxFThTiRiHI7dQQG35MrN8vcG0TMfyaIxGIEdXlaRyd2KK3Ul+N4XWFyfL9CMeOUwlECdkDAxxK8JeseWQ5JE76iYVxujxPdHG1OYY3dI8sfPhIU0BIJFdDlNJ6l+88k1aCLbQlp2PHlaw6e7Nad/gELs9oCUS5f223eZ5K0EKkFw54gS6D7sDiZmzxA1TCtryct5LhbC1zvg+8QUCsatP+Q8tOepw5fX+NRXCT/2VTP7tZoWjzSyL3w3itATUo8WHuKmy6Ve9UJNDn5FE2nJtOFqL3K0LZASdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737448720; c=relaxed/relaxed;
	bh=pDSeFk+LOdLdoQAIClpWcVVVNDGjKxQEEF+U/Jv1pBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WD3EnB2LNYXD26VtVcJtUVKbhnWAcOjLRyEhISkytBk3q3OjWVsncgAqou2WGd2kCCNx+KhnY7Y0qVGiNtA5i+suP/y67sjs9EmYBsP+xXmAoxs4yIM6f2alXcSwOB3Rl3fZgOchxUlkCdTGnlVe+4XPDV8WZRgnfbxiut2aiWl7pzypAPmm2yw0PZIh0mB6vidTaGzfttF8xzu2V7Sp9NWcyvWiBKartfPBIZW9v7HUyuZs1lUCGskumoVNn8BbpB8A2d10yLRiIENM2lLxqq/JhfIg6bOcsIkkr/bYsEz2uvEI1MBz1rpYgAYqAq8CWzGqS41lwnpiaE4s2Dd2jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ahj6IIUZ; dkim-atps=neutral; spf=pass (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=oushixiong1025@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ahj6IIUZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=oushixiong1025@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1830 seconds by postgrey-1.37 at boromir; Tue, 21 Jan 2025 19:38:37 AEDT
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YcgbK4yVBz2yFD
	for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Jan 2025 19:38:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pDSeF
	k+LOdLdoQAIClpWcVVVNDGjKxQEEF+U/Jv1pBA=; b=ahj6IIUZMKJCkYc/gVT5k
	2LojJslh/h9nEiHrrOLFgAZ4OO091ZLdH+d/wefRgNJOP5vs0XtZ7FvLJ0+wHwdW
	GYHtob1Pryh43Zsk7BBsPMfInpZbTiZyDlrTeVYgJSrP08yDHmz08cmy3BJgStoV
	iza9kQas21cbXJmklBsd9k=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3TwjcUY9n605cHg--.59188S2;
	Tue, 21 Jan 2025 15:50:53 +0800 (CST)
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
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/aspeed: Use devm_platform_get_and_ioremap_resource()
Date: Tue, 21 Jan 2025 15:50:41 +0800
Message-Id: <20250121075041.201599-1-oushixiong1025@163.com>
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
X-CM-TRANSID:_____wD3TwjcUY9n605cHg--.59188S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW3uw4UJr1kAFyrJFWxtFb_yoW3KFbE9F
	48ursxXFW7Aryqg3y2v3ZxCFyIkF9a9rW8GF18tayFq3W7Z34DX34jgr1vqr1a9w4fAF98
	t3WUJr13A3s7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbqNtDUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXQ3bD2ePUAodpQAAsO

From: Shixiong Ou <oushixiong@kylinos.cn>

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
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


