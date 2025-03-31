Return-Path: <linux-aspeed+bounces-1142-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D38C3600C
	for <linux-aspeed@archiver.kernel.org>; Mon, 31 Mar 2025 22:56:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZRRM32SgQz2yrg;
	Tue,  1 Apr 2025 09:56:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::641"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743433978;
	cv=none; b=HGMYNJ0QKFUL410+H5Fqrq1NfjTovfZzej92PHWyG0DbkKMcUz8k/YeCkKqfzDLF/6a46dRvtOOiFSYBT8kao24mWzcSEUfVQOTYAq4Ye/nFCHz9T6M1HZlxioe/wrdb0Pj5XKQvV+qqDb3Gc+5s2YewkQHHSjPUGbwGP5D1r4GitTyLRK+/uOeBvc1gEkk487N3L37dqxsqOi3HhmQjUFydc+clypBSiPPj2ZkTSDR/W3Z68DuNqDWaho7Rc5uY32CPNIlSIPInUQAyrXO25rUURa9yK9lHwklshc9rIoQsUeQ6WQwhX6S02XoT8WNhYugEk7Js3scJA7lVHcySJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743433978; c=relaxed/relaxed;
	bh=UQs6q6PQtFgVe2Al3n7AGyLmvRZf/U28ub434FoB4Us=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jNQF/Gp4w+TyE7gBqWNgVS6pJp+TM7YO8Ln0+DVlO+l8VDXDMa234fAJHcqnJcdFhBD/LPZmXfBEHt5cmHyKyQrhOCkemtbk6G50lTAVTPMKzGNmTiQzs/cJU2QPVCiqRxkB2sBdhNvCdcH8tWl9YF60T4lF/SoNgypHQl2OtTtcqScF5oGMMKIhbJ7myoB+4PlXJYK4yZ1OpgujZLd+Yp4WG+cC+SxSUfiLsaKx1OFIRc3/eQIFJKGpyzMW1IeR5av8AX70zoUhAmIJ3oLaIknBEujKx3G5HnX1WBSiJXBuznvZNJOG9hjvl4PmoWpIxE4SUmESuQ0jMWfpM3VRMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LXbCnMi8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LXbCnMi8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZRF4S4yTwz2xQD
	for <linux-aspeed@lists.ozlabs.org>; Tue,  1 Apr 2025 02:12:54 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-2264aefc45dso115542555ad.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Mar 2025 08:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743433972; x=1744038772; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UQs6q6PQtFgVe2Al3n7AGyLmvRZf/U28ub434FoB4Us=;
        b=LXbCnMi8ytD2VPykrTld/KTQoj8Bf7WMjPWMrTf5ZT9T26N0Oo/ehGfxkVnhHiqL+G
         qigCT4SRalaXU83dcSjHQTyNqkIqPzmyzSXy9PZWu4D0fUIwl1Vk8yb0mU9Mld5cx7H6
         pY2tHzduY/FFSbOeUhoSTvgXh22pC5EkK1tvZPWE3NA8FcMaoyPotCili1EAYESDLUqd
         dihjyHx+wVw4uXZ8FxJaoFW9Ys5WHz4heCBnfAYpK9YDNFIm48Vy4BFtWtvNz6Vp190a
         aWVVEE5zcDXVqbU+Dr1DHDutaANQq4vl9aTJHRvuZXBXzwXENevbHNYCPTx31SBUKPpC
         v/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433972; x=1744038772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQs6q6PQtFgVe2Al3n7AGyLmvRZf/U28ub434FoB4Us=;
        b=lNwseAgxX4sqMwY6G25IDO7I1N6klNiUSvBH6i5T0THVXhqU9qlJhLGMNs3CUzDzqR
         PhlHsTDi/mfPIeRPIWMPTvI4D4W7+CClCtkoNE08cB6GrnhmoazjlBGviAtisT6Ip0/l
         HM7WuL/28rQfwvIecmfQLZw1ZL6xdE9cH0mcWB/4vb14Zz5ApjxdMSiQch4K6vR2D70J
         9lfTYmMx4HY6cGViao+35tFyCa85y7lVgFDoHQYnTV5g0nFZgUW2q6tLh1g3XDrLTvQn
         OsI0bJ9KwXq5HFq3zk+Kh5k1cT8k0VOAKwC9O4S5C06Nankqk5myYzqzMk9ZUo460qKk
         cIrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMeTMRVbiMgi3TJ0kKUSuP5EIs2xwtjgihMt6QzhtnhFiXDM1OFAyTH8aCW9e3ofJexOUJ3ppWjJ5cYYo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw6ru9CwlcBRvaA6+wBaa7IsR5ceXJLpUvOJyyIqo314erb0/KJ
	iHnWVODYWUuMzxB2xS+Ur8YCxQPikUAmh3trvdg+CVxL9ry4I6qa
X-Gm-Gg: ASbGncshcoumFYl8ic4v8tuWV5vMbGYT25/Uf/ctVUq0/mt6kDIyl1FhkssBSUa6Drr
	y0VN5clTTpy20P7gYJ2R7n0xZKmntJhEhdYxLqOleyCdlUwn6zC/vwaQ8znsTElcVJwf3yeCTKp
	TEo5b4JypjTlpq91mQfgbaaK8tXK0SlAyVprebtSaNOCebSQ1uXPp+/4vLCDeU2kZYLpgdmD07n
	BQrc4QkoHKltgCDsdS9sgcz+q7dX+O1X3IAne1L8rrGCVYPyABuusm6HRpFKe4JgOdUGbx6DFt0
	Il/QgXpMnYIlWjkwcPJoGGS6vOeENqJB7Q2z6WJrFh8Oa5upEQxnf9OqsZoBWTiK4Ai3TEmMNrN
	gmsdJKQ==
X-Google-Smtp-Source: AGHT+IFu36yXNBcYaTdIut4XpIU2h0wu30Oj49ASXXvk6ejJjANWdSL5zYgJyYHCGhMg5H3r4F/Duw==
X-Received: by 2002:a05:6a00:b8c:b0:732:a24:7354 with SMTP id d2e1a72fcca58-7398033f3ecmr14860283b3a.4.1743433972309;
        Mon, 31 Mar 2025 08:12:52 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710684bcsm7033689b3a.113.2025.03.31.08.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:12:51 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: bsdhenrymartin@gmail.com,
	u.kleine-koenig@baylibre.com,
	arnd@arndb.de,
	herve.codina@bootlin.com,
	gsomlo@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers/misc: Add NULL check in aspeed_lpc_enable_snoop
Date: Mon, 31 Mar 2025 23:12:38 +0800
Message-Id: <20250331151238.13703-1-bsdhenrymartin@gmail.com>
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

devm_kasprintf() returns NULL if memory allocation fails. Currently,
aspeed_lpc_enable_snoop() does not check for this case, leading to a NULL
pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V1 -> V2: Removed blank line between tags.

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


