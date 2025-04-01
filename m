Return-Path: <linux-aspeed+bounces-1150-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D23C36010
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Apr 2025 11:46:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZRmRX2sL6z2yVX;
	Tue,  1 Apr 2025 22:46:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::643"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743478794;
	cv=none; b=YD+3HrlsuCfqCn+JUFz+8hR5yemwK1kPFXCE5GWGLrRloFl9dQLJ5gCtY0rpykUK1rceNOodoKf+gbN/AzNClGiZUf0/D0oaVSENwzFfSdQp9KWWGrVq4rR+AAvIzuEEH6sSkMfK4tvlIJZWSjetDFx9kDEmbcZqLIEY3NRiKvqYAmWr5eda+hLoGxJgPLuYJsYQZmcrT9sX6XXgMEPnOK9foA5UHzcTHzC1/hXQ3bKC5ZJ6UXOrSNW7CuEUgoJQmUv7kMy7HZAQ+9uNOch1VbuJs+zUM+rQ/Fy/vKcppRyLjF+wA+zSSutIJzlJL0i2svyVUaDH+neixY3VByfhng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743478794; c=relaxed/relaxed;
	bh=IFYh5M0fsDdvGMhmL2V0U6mTiiJF12cIZfzIb8uL/7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c+se1fFofBDYuyzqJVueeWK5qW5h7K/DL46nkdydpUGfHx+Lv7hIWYHFvdNbzgGSJ83bX0O2KyoYH2PNNFpsT3t92/x2jigg8fBukTLhwzgDGTBDogo+3xX82siqa6k/ZTkgPoYPtrNXeAav8x5jIvS1Odq9knQIyfb7aiMGffBhleyRrcJPO40Zcxs1I0QkJ1zSiRO0FTCWlRg6TfbQrDHBnF+11Z+7vAgNP5iyvwgCj3cg+YEKKhYqtFLv1J1yAmrDA4K+XnEz4BCSzQmU80dnR9h3AWo8u+JBBOk/0otoDbQyQdTLOes2t/aFo5RkfFJ0fDzzn3gxS7OH8j9C6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PC1cZzCs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PC1cZzCs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZRYfJ42m1z2xQ6
	for <linux-aspeed@lists.ozlabs.org>; Tue,  1 Apr 2025 14:39:51 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-224341bbc1dso86588175ad.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Mar 2025 20:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743478790; x=1744083590; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IFYh5M0fsDdvGMhmL2V0U6mTiiJF12cIZfzIb8uL/7Y=;
        b=PC1cZzCs4iQMekXqW+ytk8IDmvct5G0YM5EZx9oTUeOFBIBJXz1dvaJvygdITW7QsT
         t1rkMKndEIdIqjFttXEN0+9iylswvZlWskXUxCOfRvcqcxYnAjZ67Ur7vZEf4ocNKe+Y
         JpnEznnbT3yyevdQkTXUJyGXXIfDQTwRMCNQ0JPyROzjhzzsDwc8QHbvFNC4AtX4pVqY
         Wtk3EXBhCKqmbUmJS5nuVAh4EwSC3mlgMGbDkx0ClHeZ6wIODHDsIE7EdDQi1PwhhfZG
         y9AjuhvYTiyk5Go6uTJhx36gCdIZ/vgczLgb1iwuAkAEttYAf+2OiFGJa0PpL2dN7TCQ
         tItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743478790; x=1744083590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFYh5M0fsDdvGMhmL2V0U6mTiiJF12cIZfzIb8uL/7Y=;
        b=Kp+XJcPEs4qV2jYeoYgILBchNSyyuYTpTpwk5QpTFA2Hr1pedEPWUv94zESX9fci8/
         a0RrnkdubHePewo34HBOTmRFAw26hmBxgcYUUpkb0tMtEBy0CrUeies8SYLpDof3ptw4
         sV7pe0aGI1purzdtBKCSO2xbWZh3UOAXV0+6YDQZxYYwxKvLW1FpmPoLBNKIs3ZNP5Wz
         sNkX0c3ewuiPSgDyKAVf9YuXbqqhCgHzKCtjJF7EUOFBxtpLBDZ5yMq8ma+olRj7vv9n
         zhQQSAxiYSbK44Ro67QLeBsBlrpdTYG+inwhy+UHrpiudwKvIPdvgyO4kit8ZcFz16vN
         hprg==
X-Forwarded-Encrypted: i=1; AJvYcCUvGpsKnPO1ZUBiYuLR5Dmxg9qtqCUBob9Bua87UOD5V5devGlcA7DyQ35DeeEENLg2CX70HNAYWIXgI0g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzR9YZicfEtepI3IEAFVqS9NK/gJYoQP9J8X8A/jzACQweuE1f/
	HNrm2EzzZY3WtbF8Jh1MuFoXvoF2aV0mr8BAkAZAg3Eb9qRu8AJh
X-Gm-Gg: ASbGnctRLcUvTsAJzwVGYb7KQM/RpcpqfxuaM5vrwjhoRfIdkOf/fu0pjO4htvxV4sr
	VXeKZ2jJ9qhPSu7id/sV4+P0RDqCWZHj/+89KjnRGisuy9+Gv1wqvQxS+LCOkQPGG06p7BLLs5l
	woEjJ4RcVWyjjedVWoL5KFA0Tq/Ay41BoJnXK887X/dToxdeLJqSWKlc+ibzg2q6Vp5DFC8i6I3
	ZWV9/xG7YXxa2YYJ0cLqsrkeFadVRVAp0aw9fM8bsXWsWiKvddTPHT/LKoF+ORGOBh2YsexWpBz
	FRRpmUyZr2M4wDOz4NXA95Vl/wqrTxfV7oFDPQCj+L93PjXaWk+iB23eFgWlw4xiKlNzz+k=
X-Google-Smtp-Source: AGHT+IGT8jkNO5+IfXQCLnbfYUK9R0hC9L7cWhycJGTtXws06galosA23s3dNcxmybY3RaYeogb7zw==
X-Received: by 2002:a17:902:eb83:b0:220:c4e8:3b9f with SMTP id d9443c01a7336-2292f8968e9mr195477775ad.0.1743478789870;
        Mon, 31 Mar 2025 20:39:49 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eedcedesm77958805ad.67.2025.03.31.20.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 20:39:49 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	u.kleine-koenig@baylibre.com,
	andersson@kernel.org,
	arnd@arndb.de,
	herve.codina@bootlin.com,
	bsdhenrymartin@gmail.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] drivers/misc: Add NULL check in aspeed_lpc_enable_snoop
Date: Tue,  1 Apr 2025 11:39:35 +0800
Message-Id: <20250401033935.17617-1-bsdhenrymartin@gmail.com>
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

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V2 -> V3: Simplify the arrary access and correct commit message.
V1 -> V2: Removed blank line between tags.

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 35 ++++++++++++++++++---------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 9ab5ba9cf1d6..25ebecd14103 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -189,22 +189,28 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	u32 hicr5_en, snpwadr_mask, snpwadr_shift, hicrb_en;
 	const struct aspeed_lpc_snoop_model_data *model_data =
 		of_device_get_match_data(dev);
+	struct aspeed_lpc_snoop_channel *snoop_chan = &lpc_snoop->chan[channel];
+	struct miscdevice *mdev = &snoop_chan->miscdev;
+
+	init_waitqueue_head(&snoop_chan->wq);
 
-	init_waitqueue_head(&lpc_snoop->chan[channel].wq);
 	/* Create FIFO datastructure */
-	rc = kfifo_alloc(&lpc_snoop->chan[channel].fifo,
-			 SNOOP_FIFO_SIZE, GFP_KERNEL);
+	rc = kfifo_alloc(&snoop_chan->fifo, SNOOP_FIFO_SIZE, GFP_KERNEL);
 	if (rc)
 		return rc;
 
-	lpc_snoop->chan[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
-	lpc_snoop->chan[channel].miscdev.name =
-		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
-	lpc_snoop->chan[channel].miscdev.fops = &snoop_fops;
-	lpc_snoop->chan[channel].miscdev.parent = dev;
-	rc = misc_register(&lpc_snoop->chan[channel].miscdev);
+	mdev->minor = MISC_DYNAMIC_MINOR;
+	mdev->name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
+	if (!mdev->name) {
+		rc = -ENOMEM;
+		goto err_free_fifo;
+	}
+
+	mdev->fops = &snoop_fops;
+	mdev->parent = dev;
+	rc = misc_register(mdev);
 	if (rc)
-		return rc;
+		goto err_free_fifo;
 
 	/* Enable LPC snoop channel at requested port */
 	switch (channel) {
@@ -221,7 +227,8 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		hicrb_en = HICRB_ENSNP1D;
 		break;
 	default:
-		return -EINVAL;
+		rc = -EINVAL;
+		goto err_misc_deregister;
 	}
 
 	regmap_update_bits(lpc_snoop->regmap, HICR5, hicr5_en, hicr5_en);
@@ -232,6 +239,12 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 				hicrb_en, hicrb_en);
 
 	return rc;
+
+err_misc_deregister:
+	misc_deregister(mdev);
+err_free_fifo:
+	kfifo_free(&snoop_chan->fifo);
+	return rc;
 }
 
 static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
-- 
2.34.1


