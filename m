Return-Path: <linux-aspeed+bounces-2967-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884EBCFA450
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Nov 2025 22:55:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dCDG759lXz2yvk;
	Fri, 21 Nov 2025 09:55:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763616378;
	cv=none; b=ALNrnYU/vv+Q+ibEY4PIYtoN0p1BPtx05XxchJACQMfxeOOiyCKIgq5BegHJJnJYsOO++ZlqgiMRxNQ0b+wFadEISEPPgI6mqv+dET9zgKQGkLc2tSALOZdfXkj1umDdiecrcboGOfNLYUp644jsXxJWCB7NHpew1RTsTLZffIXM9OCh89TKvxqw6hwQbDNAtY0VykZmSAoLjKC3vyzQj4MSgk2hfdtqdW7pKFSkNkP78OL/05fQB1rDwIYYYCXyvVlJZ+B15EtEcoNTBwZLHDRb8t02+Bc3flvM44/ZL/uIx/xX8lZe8kKE815LeDpZadRLPPODg6ytLPuWbkZfog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763616378; c=relaxed/relaxed;
	bh=qF/HQIOynCm0t72RaSXKVxc7uoyjtBGo96ikoMO3RzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UzigDcQypO1kN48hlwP0jxhrs0Opd5/gnKu6lgEnxDERSEJ2jIjuCJ769Ox18K8cxzGv+QGp7OkHbblKeta8T3rY/PtpOEdAS98ls4c4+JzuAn+iOuqsZfbJOy4k00/phrBJeJszoHZW1+Pzv5xcf8jVCtiMrmHcUBkBulBMJkRxE1C3vVq2BgLWa4Qe0RYIt4vUtL/ZAKSbE2SA0Lis9QBuG+HYg6aBfzKtT4aTJ1PGvuZIU61IIVibS5X4i3JOu7dpKWkuk8fHySnkALZXmv2lPOFcgQ7uRV2Rf6JXY9jNScfRKBnEbaWxdQDCH+L0/gnDIOrOvaApC1zA4AcTqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SWbGYGkI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SWbGYGkI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBmzY5ftDz2yG1
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Nov 2025 16:26:17 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-299d40b0845so8199395ad.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Nov 2025 21:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763616376; x=1764221176; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qF/HQIOynCm0t72RaSXKVxc7uoyjtBGo96ikoMO3RzI=;
        b=SWbGYGkIiL7ay8xsljs0JRqFx0gFDRloKU/3EOea5+xMNRje9yDOOo0H/NJDLmt4CK
         5pDXLpTDIvqqte68p9GaPMcHENsNqDQoS4KDcuDU4eWGzC2+c1XhTE8AMmx5coZksQmY
         oVz2pROe4XIKbh2U6DOiqVdHi8JtBA0ssNxmfyy9kgVBemYHyNR5htWjiUuiWQyLkZQH
         i8GhNvYFxM+sEngNL96pJ55vrKHaAiY3Tnxzd6lvBej3pjBe4WGqAOv0UWn38es9qg1h
         hYpdC9pOTq6XqRr9sNVHQO/lHqXB4M4PqjiBjYF1ZFMdti8+F5yR1k9+lz4W4GQZQyBt
         4a7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763616376; x=1764221176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qF/HQIOynCm0t72RaSXKVxc7uoyjtBGo96ikoMO3RzI=;
        b=RrRVA/R9ekoLyEoTYd5rp2gAvU/E/V1LW0Ds2AxDo10/Br7dsimZbUC1YjO+UK/r8v
         Bg92xWJOV5TMs3o7b+y3m2M1L4WC2Rzkyb9+cN7GO/oMoVaEc5aQWLWIp3yw0eTutRra
         iQ0k8/tOQJvzCUD92kU1wasNdXG+5x6789jUpWWqm+XXKtYPYowkg6aLCa/C9FQZJ7mB
         cQgAGftlz45aLhQWhdaO93zwogzvIlGwaxnfLqRzhRiH9P8Ruukalr7VyUtl73UIsr04
         kUYf+Bnil1zb59EMioL51kCRT+4akfjofYju2DdP2MNQPoHDi+gqRmj30NScd/qNlLE8
         +0rw==
X-Forwarded-Encrypted: i=1; AJvYcCVo08GXfy1FDtMbalmcNzBtSngyDH7VxNsQBb9zboxZSHHCMBPoM3Yh6ss8QWyoHfPlbH3YknW24hCLGJs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzp0xHX3JFgi7ysVF72pXzV+k9I+EHk7PAU9gu/GZCSAZJz8HX6
	HxMUwsYPuxwsUTbKnHuFaWPr+BJGR3y4x6qdPsbKgjOenE8Ccr64cJFR
X-Gm-Gg: ASbGncusq/wPat/XMqsV/18gPDDBCWXjwvWTc0CF0zutSakpva8ps3GAsAzfR92JDRA
	Di6i0X4Sb3BYoVS80gEJbkubtLfmxAffFZ6GSj9qxdGBo2AgrYWUJkX3gftaSxM4mA8t2Q0jfNt
	Fox0prWYZaa5LbK7vbymIOXAI3ExrLBwvdIVFKTxLusQs/0c6kQbQhPmlMYqiWnxNJqL3tHhEn4
	svxLusG3UM+sj04r0lwnpLGjAlvpEGiE+Rb8MNtLwVruoWCf5TmpQg5jXcOCg9q1uTeg9rmvLDE
	WXHbMHIWIF393g9DMXGbq6i4zOYFLJOx/38DecG5L7jVqT1T/sPhzgtg0hiq2Xm9YU2RNL4r/Kd
	6V3bJNEDE8hQQbaX6SIDNEumNbezDMxRgly6txTbiuBc8H6mpJqqEynllUJr+K/16X2TFLavDBh
	3jZ/uCfIMSyd0qTAwjMTJGM9PaaiVrn68DKApmnjRTkYfN4iWYK0QVFBFOhddxK1flmTqbyqdgF
	MIcUJstzCNIZDaeXR8R/1AN4aKT2j+AAAGAvnAw8NdLji4Omp3UYwl3u8XhVH5bsHflCVniDjtd
	1h2mtrnF/ywX/ylF2MdnuA==
X-Google-Smtp-Source: AGHT+IGJp8Cd93sU3s6BBrNTH9o8Scku4SN9E6zIdoS1tC6GjkQGhpnvZ3DbOoHW82d2G+ALkdH5tQ==
X-Received: by 2002:a17:90b:48cd:b0:340:d81d:7874 with SMTP id 98e67ed59e1d1-34727d50e86mr1936462a91.26.1763616376006;
        Wed, 19 Nov 2025 21:26:16 -0800 (PST)
Received: from 2001-b400-e301-38bf-be0d-b72c-6bec-2812.emome-ip6.hinet.net (2001-b400-e301-38bf-be0d-b72c-6bec-2812.emome-ip6.hinet.net. [2001:b400:e301:38bf:be0d:b72c:6bec:2812])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3472692e5d3sm1221342a91.9.2025.11.19.21.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 21:26:15 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Thu, 20 Nov 2025 13:26:01 +0800
Subject: [PATCH v2 4/4] ARM: dts: aspeed: yosemite5: Add ipmb node for OCP
 debug card
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-yv5_revise_dts-v2-4-4d7de701c5be@gmail.com>
References: <20251120-yv5_revise_dts-v2-0-4d7de701c5be@gmail.com>
In-Reply-To: <20251120-yv5_revise_dts-v2-0-4d7de701c5be@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763616361; l=881;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=ttl/th87rXvNyHmcSwWPnJPpHSYTR2HIKjXWUQwTrdM=;
 b=JEsyeMSA9gIhSSUyjpQLiUtfsCFoU+UZynLjaWaM6x/TjxUQxg8e9xdI1yHXyYRZzvK5xSzVp
 nPAWG1911ZqCjSlQvVZErHuhB5TxTtt6NIApPgyBuhQC3d0mB6JC3RG
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Add the device tree node to enable the IPMB interface used by
the OCP debug card.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 060757b7211a6da777c51d9f0c886796cf2450a4..b4ae1628ad5a8f8b5283f88760877846862b3835 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -365,7 +365,14 @@ i2c6mux0ch3: i2c@3 {
 
 /* SCM CPLD I2C */
 &i2c7 {
+	multi-master;
 	status = "okay";
+
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
 };
 
 &i2c8 {

-- 
2.51.2


