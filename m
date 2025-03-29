Return-Path: <linux-aspeed+bounces-1138-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87491C28B20
	for <linux-aspeed@archiver.kernel.org>; Sun, 30 Mar 2025 23:31:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZQr9x00lXz2yf3;
	Mon, 31 Mar 2025 10:31:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1044"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743208163;
	cv=none; b=Ph4BGy6f08IhLUea63uOdwFOVtZ3PrrAKxvoxaskxSQBBVu9nT/At2rXOI+ZFKbA36QoYJ2vhyeXv5QzIGSiE49mRY+EN3IYBYEk1/ZSZMygSrUVnZZtzMtVbW6QyA3E+CURKL1M3fFNj51AQfoZQbM+jUKPe8gO55Wf+Bv5Gfu1BgUnbh8pYRLP08zUb2fGgXNx0Y6UNwAQy7LKnmG2o8j5CirAdfmL//nGyuxSv+B4XV5g0OSPsHGjhY00JZCQNV7QSXv6UiXTB8XgAF2c9I6fBHon/e0yGKPLaWjOhmPUPcz8mchTRb2FmfnKT59cvpuEQghrMIcdC8NRxe4Vhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743208163; c=relaxed/relaxed;
	bh=WYXL/IJoE9Di2fp4ccVQCgQpgTyRfUoS3TC43hdzJJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z5Tw6yQ4VJiPv960mr64pAGD0d/PSwcUK/0jojCvkexpNtWx4pRUt9w9Jh9HqvExtieJ36b8fIwLt3Vp4AzfXOUluc5jM5BZGNMV2gCtbdqWZs2GFG7W1GKMfEnRSigKFZ6p8UQyAJF9M2PMKb776m3sQz12SZ8ObWsGEWYArI4BKXxjo/QfWZCchrvfEw1HsEQHyV+PR/qMf9okxFelXKOgcuJopcWtOp0bz1j1IFzqDbjw9XLu9AaouCCN+JW8S9hP+T8TSq8budkW1mgXbGscKPTdhBGrAyclSQgedaQ0qReZm14a91dl7P+wQOfKU5F1E6gj+vL8Kg1rJWUYdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DlM7g96Z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1044; helo=mail-pj1-x1044.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DlM7g96Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044; helo=mail-pj1-x1044.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZPdYt0YKyz2ySm
	for <linux-aspeed@lists.ozlabs.org>; Sat, 29 Mar 2025 11:29:21 +1100 (AEDT)
Received: by mail-pj1-x1044.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so4607420a91.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Mar 2025 17:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743208159; x=1743812959; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WYXL/IJoE9Di2fp4ccVQCgQpgTyRfUoS3TC43hdzJJQ=;
        b=DlM7g96ZP8jO8WEctLw+rVTIMMtgIkYRjt7PS5oDVC0ezWmk+W2CQnep8lPnMYHtGe
         uasAURemknSUou3L5FvHjXMqhyyWmwAc4BiPWg+dVIJ07BxRG7sZqMN87tk+gdw1StPn
         pKZqJYIO0LZ0sWRBsS+64Pi0ppD17gRBbjJRIUF+/1g05G97EWCDf0Jr+KK9TCvrEF/2
         YHEuvMAXKKcY/a/c+xo2FogniQW0W+lARIiL9jv7pgQ4+j6iU+WYwdNqs+atbqpvSp2+
         NelcL8nQqWW3DSzKg5R8p1yZHvR7p/kP7PKszKzQnHVwN2HL2UJV1bqm2Dr1rzFnjeqm
         Xflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743208159; x=1743812959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYXL/IJoE9Di2fp4ccVQCgQpgTyRfUoS3TC43hdzJJQ=;
        b=Q0WHXEVoAaVmHaoHU0CYfzekevZDIV3yElDbJpb+GoCtAiQ7/qL1DPmEu1jahqqy7C
         9TUz3XbpVtAidVQPpZ0smRC3CzN95gUiFSDgrtMJf/javtFUm+nf++OmVgQxgDPoLUS3
         S0QYSJS2HTv27A50mAoN2heumsKtHWvGrezWSj2L4q1/n8rTkAFCUQzmt1X2YQL7SkLe
         lhr7wxV9pUgEEHk3rk1FNu7zDJxeEdI99cVWGVnNTrF6riXYt72miNHc+6iDtzyCT2UR
         ozEkFK8Fnc9T4IZxhObTm1X2tHRBJMRI+VXmKlP/IOM5YBWoWxySaRh6kM85lyLncXpk
         rrZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVCoNEpvc3rpPOY7untyM7oGWX5zDsQylUFYQN/3r0zN20yJf3093vHdCucEqPDMRVuAZS3oyZ41xOauA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxzXzta61tCnpSRqRYICrQxUjTyaPqNS5t4osbJDHdxVrS877+I
	Jamt4RCtVlV07KBIJtkG1h/kd5r93ZPXRCbsV8v3M6hkwXoLgM/5
X-Gm-Gg: ASbGncvhyiH6cnf0p0zfja0/6fJuJBQRhi01h40/gcpkQcFFHY+YyClIh+kaOVbPAJs
	5OujULPp/WZs4KjdFfBUvCzmkzrEmFFPaXRNdtUd+7zw4HU1ONG8zx5viIHS2h82ghu3EXv3yYR
	y7T1YklrZvgaNUOsUePFn53iFne34UQxzLp6dxUSeO1tmu+/7aPRf+AfEYcUpnP37sUzvE0G6NH
	R2rgMd8+aFDi1dOcMx18VGr6AH/fKJd7BHty2c2i2QCIuTCd7EHrekMqQoNlga2V+bpziOFesNb
	rMGQmSiSHPzRL8qxVgSQpYVibvBee83BT+RC5EjO7mkp0FFW6KEXXaF3dJnRJHy/2s5l0A==
X-Google-Smtp-Source: AGHT+IFA2z+X2uC61UN1KJifyXv9jI8e3ROzSjHTCWF6TbJpXqQnAeo9E5gok3I3WbstaxxTgqoAHg==
X-Received: by 2002:a17:90b:134d:b0:2fa:e9b:33b8 with SMTP id 98e67ed59e1d1-305320afaadmr1854600a91.18.1743208159280;
        Fri, 28 Mar 2025 17:29:19 -0700 (PDT)
Received: from henry.localdomain ([36.112.187.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30516d3e535sm2541627a91.1.2025.03.28.17.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 17:29:18 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: linux-usb@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org
Cc: gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] Subject: [PATCH] usb: gadget: aspeed: Add NULL check in the ast_vhub_init_dev
Date: Sat, 29 Mar 2025 08:29:11 +0800
Message-Id: <20250329002911.132826-1-bsdhenrymartin@gmail.com>
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

When devm_kasprintf() fails, it returns a NULL pointer. However, this return value is not properly checked in the function ast_vhub_init_dev.

A NULL check should be added after the devm_kasprintf call to prevent potential NULL pointer dereference error.

Fixes: 7ecca2a4080cb ("usb/gadget: Add driver for Aspeed SoC virtual hub")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index 573109ca5b79..1709a58299a5 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -545,9 +545,11 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 	struct device *parent = &vhub->pdev->dev;
 	int rc;
 
+	d->name = devm_kasprintf(parent, GFP_KERNEL, "port%d", idx + 1);
+	if (!d->name)
+		return -ENOMEM;
 	d->vhub = vhub;
 	d->index = idx;
-	d->name = devm_kasprintf(parent, GFP_KERNEL, "port%d", idx+1);
 	d->regs = vhub->regs + 0x100 + 0x10 * idx;
 
 	ast_vhub_init_ep0(vhub, &d->ep0, d);
-- 
2.34.1


