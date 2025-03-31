Return-Path: <linux-aspeed+bounces-1145-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC18C36019
	for <linux-aspeed@archiver.kernel.org>; Mon, 31 Mar 2025 22:56:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZRRM44chjz2yfF;
	Tue,  1 Apr 2025 09:56:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::641"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743413978;
	cv=none; b=YGRcx/wuh/WxXC05IVCcx8RAqQKwHSzX0EMxVN5fAV28v3T9ClUVpq4G3wJU7jgAfKfMg+f9AFSD5Cy4IkK6ijbjPegK7B4yIE6TbM9ISI1cPAnNEntMahxoMEeZCpiQCDitcV5czHQUbj/zoZGUY5qEh+a5ES0/sKOwdemJEGOg++XBvK7NGez9xuW0UosdsoPOtYwNGSTpg6BYAZUHWxSM3VLoHE6e9su9RS93NNeEGnv1fkEgFtXbmtXCOHO/k+RS0DSn0SwMHHuzDNw3vEqPQPm0eRzH6ZXOv+B+zDaiuHyRjzbq6iZH+W9SSwKAZLeUlmVV+NvT8p60KvTyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743413978; c=relaxed/relaxed;
	bh=RKMxlaeTxaJWI4z9WHO98X3QgiKdQ3qKVb7b/rUt++I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WiyNfoy6r9yfloH8lR05HHSIY7leGhx7tw1p4cNNyp3jSHC4PTYydZdjNo0auIKL/8k2kQIox3pGtkbsn+KNU1dMHRoXiWSjR12JoP6oCnELkwG7IYvZxZuRo+08UopARx/tAYE+cmPrKioSvaKy1pCENkl+DyFLDJWty9oPkoQqwSpYilCh1/SyDPOaSRzOgUSjIQJ+eOdnz2HsQybP6TQxh4T1M3FFo4Zv/P3IYk4jGz/Ct5/hDtpcIDQuncDBcfXa/GHr6vcN9qgSeYxA1+eWgzCBuCBN8qwQpAKcivygyDD3HRGVXhK9or9DsrKZkny6Qya81pd14Fs0ouj30A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VbD3TeEI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VbD3TeEI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZR5gs1rflz2ydw
	for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Mar 2025 20:39:35 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-223f4c06e9fso77314285ad.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Mar 2025 02:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743413974; x=1744018774; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKMxlaeTxaJWI4z9WHO98X3QgiKdQ3qKVb7b/rUt++I=;
        b=VbD3TeEIwNjTPs7wChbTo/wA9n/STORlzCb+s/AJOAHO7iS1KJ3DXSJUDOHA++IY5l
         ET25MVlkUd/nKt7eMx6eq7+Ut2q7f3+BZXmX0UK0RI5EN6tBlLOAtVWRjiBc+S1uS0Zc
         uKEUAnT1JdcUZMAUtI0Pp5Xzu66TeYIEfpikp/dVs5qk37LxCOM5u+zrDcKQ2qKhxglU
         2iAc271S3DADp7tlggOq9Rpx+fkmLzRgLak3sXxZOPohrfgepM9/RdQESISexjF/ZkOp
         BYJPej/DI7KP2xdAuXJBSSv2ExU5H3py0+9scD2aviKspG1gzIAWf3XbkPbyhIGWfQ6M
         MUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743413974; x=1744018774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKMxlaeTxaJWI4z9WHO98X3QgiKdQ3qKVb7b/rUt++I=;
        b=JkkFB1o43UcchA7tKxaiJDqaJHWKj7uDjD16FAwD50dLkTCxq4pqHjsNIf1+Wx5S4w
         H41LPVlEnnFMUPJ4i+cYx5I3vBLkqetYr6vb3D2jZX5gOsy4Nhe2lpTnV1o96xdBvFBU
         e1z8U5CPPyY9+/D4PVUkalykSAlh4DQfEmNWkZg1sbou5Zg7EM6eF7Ly4emVF34/bxsV
         QKXT6ZGMFUChsen4RJs+trB1deB+GQXf5tdKh0hWgqYAq/0j7cT7oXWPGev683QmY8Bw
         g3E3VGJ/BrGZ4IRnD/YYwooaM4utEoxUJkrAZEYE0YfUwjVVkDSPSmIaXniBneGUhzPI
         zHOA==
X-Forwarded-Encrypted: i=1; AJvYcCVV5khlLVstdbFaNJhuBReNKiilWpn10Q7pskRVLsdMs+G1VqD9c8I3gh3SD0lyfA/fy1XiDrk85jOI9Fc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwliOn7jsyQjvbDZJ+xoA06tkEjtJ5af+inG1UvBul4WUdHF+zz
	vdKz8oLdFJi9MaqrimjxpHL5wnhcbcoBfOcMOdrWGNitMfV6MYnc
X-Gm-Gg: ASbGncstXCIst4NmAMSdPzaNmZtLqryqQ7Z/rAp7PGcNzCPeF3izm7T866p6ruZja3I
	RKszT5lx4YLKuKYh+I8Fk0t+e7u2i6AeadadxKDaF3y9hrIUCh1XSgsSyBlugAXrL1QVrm+hZtm
	MbWYcT4w1QZcZnZdNVbgr+JFr3fyxI9UHjquCDhQi40YP4oZe55zDzWLp3w5A/8sP+IfGm6I9tW
	8tuDImgpnw3zLFGLI+df19qgncYYcvKUkPfxiJVgnM2fdVYDTM7ANUd8BVLjaIf6B+hLaWgqluO
	KXNeeHm1pRyAoKU7jgm0zPw4aGFCT06mn9CWJO/9CH9De/01RNQxLzhvkEQZmtDTfkTNMsc=
X-Google-Smtp-Source: AGHT+IHaTuotKrQ7H6Jwshz7QKSz02e2BY1SJ5EVZ81Mmzdz+0YDdgOAsdLuQKnlKlj+InQ4FWeA1g==
X-Received: by 2002:a17:903:46cc:b0:221:89e6:ccb6 with SMTP id d9443c01a7336-2292ef33b00mr156170785ad.25.1743413973635;
        Mon, 31 Mar 2025 02:39:33 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf93esm65083725ad.154.2025.03.31.02.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 02:39:33 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: herve.codina@bootlin.com,
	gsomlo@gmail.com,
	heiko@sntech.de,
	andersson@kernel.org,
	u.kleine-koenig@baylibre.com,
	bsdhenrymartin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/misc: Add NULL check in aspeed_lpc_enable_snoop
Date: Mon, 31 Mar 2025 17:39:22 +0800
Message-Id: <20250331093922.7735-1-bsdhenrymartin@gmail.com>
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

When devm_kasprintf() fails, it returns a NULL pointer. However, this return value is not properly checked in the function aspeed_lpc_enable_snoop.

A NULL check should be added after the devm_kasprintf() to prevent potential NULL pointer dereference error.

Fixes: 3772e5da44542 ("Aspeed LPC snoop output using misc chardev")

Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 9ab5ba9cf1d6..376b3a910797 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -200,6 +200,8 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	lpc_snoop->chan[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
 	lpc_snoop->chan[channel].miscdev.name =
 		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
+	if (!lpc_snoop->chan[channel].miscdev.name)
+		return -ENOMEM;
 	lpc_snoop->chan[channel].miscdev.fops = &snoop_fops;
 	lpc_snoop->chan[channel].miscdev.parent = dev;
 	rc = misc_register(&lpc_snoop->chan[channel].miscdev);
-- 
2.34.1


