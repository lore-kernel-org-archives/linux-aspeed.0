Return-Path: <linux-aspeed+bounces-5059-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F026CCA5FAE
	for <linux-aspeed@archiver.kernel.org>; Tue, 29 Sep 2026 22:31:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvXvm3nMLz2yfy;
	Wed, 30 Sep 2026 08:31:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790668282;
	cv=none; b=P3Am3qi+LOUU6V0wqeKmsdpdAVDoPW9O9t4Yd0m4sAwGzDlLYDxgJw39W8Z7gwq6Lg583PjhIkZylwPpGufYGBPZyIpDUYgrVkLls2rYYwIJV/PGRD9kwf9keh4KcoEnQjRHLJq38eEaDFtH20qhtfIB6vFmtZCvb89Wposwdz3/1t4DoMkTUxZ5JhCUGjQSx1f4J0K6FEm9ncYE0ZrRrjcqdrMpMVoaGLoZmj60hk/W0v8TaeDMvbOdR3HhfKsYz1ItVmxbIsKh1unCedZGDWTPTpPdpRC7lLDSfpf576lEkM5H6ZT4tcuyh/Am0eJy+o9cqNeyv3QnKL2TRXJCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790668282; c=relaxed/relaxed;
	bh=2NugkDqfPlG6XLb9mhraRjCVSd7VH0v9iuNruR6SSHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T4J7X8EghEKtqhEAAr5UVfzFdrYMQujL85WgdQXOufxfoBYeUzQAb7Vrlm80y/eEcaVxUvh2DycHDGZsxfyeMQH5NS+GDfto+agQhOzNQaa+QLadO9AmL5ehGCtGehADIRL++zJh6Bg4TSAZRjbdIimxg7H4jqlnMjMsYW/5FWSzvZE50PGSynERcJbPtRaiqpuNsA1jSYl8mgNgm9ucMsrkroF2ivm83mcmy82jyNrIz4Z7K56J419TCh+AURAmf3MQKiaAc2822JdxzyS10I2ruYZqXnC9K1BspeM9yHvDVaPGj83yw//3zjfNIrsU4r2S82CF11mrvtY5FMGo1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FpO2i7eU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::b; helo=mail-pj2-x0b.google.com; envelope-from=suwangquanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FpO2i7eU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::b; helo=mail-pj2-x0b.google.com; envelope-from=suwangquanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com [IPv6:2607:f8b0:4864:39::b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv9NT6246z2yDD
	for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Sep 2026 17:51:21 +1000 (AEST)
Received: by mail-pj2-x0b.google.com with SMTP id 98e67ed59e1d1-398a384b5f7so943924a91.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Sep 2026 00:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790668280; x=1791273080; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2NugkDqfPlG6XLb9mhraRjCVSd7VH0v9iuNruR6SSHo=;
        b=FpO2i7eUisS0pfbIiq9oiWu0wBmAwAODfuYlhjCA4MBavpWRx4Ng9nEyieM8dsySQ/
         AG3GdSOIv0nwlsDCL2YZ8/cU/21Y8RAvKZ3+v8usHxV0/ak70NxPHJzVRatDeqAnsx/i
         70oR4ramMLrRhafyMcnvgbDESJuHUyHneGLuCtPyd9m6oT/bz1W+BMjjq/Le0rWO6pIn
         ud7p8nx2cNQQngQleW7zaxodbmHC+yXCDcuSI47IpDnYInEDaZdmfRD31Ehqu3qCFJ9v
         Hb8wvmN5rInlBqm8F7wEgqrSA/AxaxZ+3hJPih7q7hGtZlU3cKLfxkSgBtCL5L4QG+JO
         dBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790668280; x=1791273080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2NugkDqfPlG6XLb9mhraRjCVSd7VH0v9iuNruR6SSHo=;
        b=fA3/ESm/Yw5t3gtqWVR9WXIDCxVUl/mIcm00My/zNn9pPC1v3h9aGfsYjMV0a/MJ7t
         WEK0JxesVtC2qth07kAPeXQf7OthvqB327tSlJDsFfbYvn2vtQQpuozCW8UkoSe4txpe
         N3F0SsUgZRLebdORf2e9QtIMkKg9iL0zWVVQg6ZTgAK4RgWH3EKNwdd/F8IUR03HtX0A
         YRa029cWoeyxSgXVzgGI3AWA4pBRWa9vysbsU6DUwazXJyWarXAHCWBWlf0fsogAjJ/R
         UzZENFJvldDkESwRGmO95RrIAXFCtZotPZExH2F/8j/YdgZjMraPeEC6WpiG0m+yqGGY
         rtwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNa7lZMDB5ulBMe9qFuUsAyGnCOFXdMEm+LGXaJao37obBtTEo1Ac6Gxp8XumXR6G4tsPtN5R8pNd+Psk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKJ2OCbyNKMQFsYa4NN1bhScEykGZ33/cIya5yLQmzGVz15QsfA
	MX/Uy3E7WMUGivITGQf7o2SdzOZ9Msw5YgTzlhDECykqCgLK7NKvWmRh
X-Gm-Gg: AYBFou1/Qu1LU0Qw3Buehh4/DsfCrdNZa3NLZ25trzF1coQerOsrnuHkv+b32C89DGa
	C5rbq+mMgXD9OxgHY0WzHIJMli7M/kjkMCrRW4wUyu70JqBoOsMRJIZNXvVh5ql5dp4MVHEKRcl
	eZnmKwfOM3l4r979FlWM/kvDfjLzsk3BT/wGfJM2kWbLEsdJV+OqgluXWLFqxJJxIzCCBOHAigQ
	ULGffoxd5U/xQxck8sJX+hYBzXGLskVtNXx2oEb5afMpMYcWU/QPwn56kBSjC25axQFcMMFtPjH
	CVRGu8iBqMb6qmuoIihWOP6vaWkxNJGjjCoao6Y+XetmKazHxgBbZKfuUJ9/vL+8TrHv7FtgaRS
	hsVkWTb+xT17hbOfPUKQ2+YDz5B2qvDEONXZAgouHr6qUovZxWOSKH2z7pllqg1hVZ7hMm5ipUf
	Gna2HpY/WQEIC7rot/WLWZTi/oKaODIv1V5qWKbUULQvfBKpNlHmW0pHeYeGC25R5AgbO7izd0B
	W4QzIGlFfdS7/RpFDTo1SqLT7l4sJ4WSGgYQRZK7mTdYk6U+dWsIoEXkm+wXPS5PbDNhsTwHBVX
	KA==
X-Received: by 2002:a17:90b:4fd2:b0:3a2:b0a1:456b with SMTP id 98e67ed59e1d1-3a2b0a1459bmr3740009a91.47.1790668279738;
        Tue, 29 Sep 2026 00:51:19 -0700 (PDT)
Received: from suewang-PC.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a497ebc998sm4049236a91.2.2026.09.29.00.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 00:51:19 -0700 (PDT)
From: Sue Wang <suwangquanta@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz
Cc: Steward.Shih@quantatw.com,
	Martin.Peng@quantatw.com,
	Fred.Zhang@quantatw.com,
	p.k.lee@quantatw.com
Subject: [PATCH v14 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Date: Tue, 29 Sep 2026 15:51:05 +0800
Message-Id: <20260929075106.74731-2-suwangquanta@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929075106.74731-1-suwangquanta@gmail.com>
References: <20260929075106.74731-1-suwangquanta@gmail.com>
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

Document the new compatibles used on Meta Ventura.

Signed-off-by: Sue Wang <suwangquanta@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9ba195b8f22d..ce74b89445ce 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -98,6 +98,7 @@ properties:
               - facebook,rainiera6-bmc
               - facebook,sanmiguel-bmc
               - facebook,santabarbara-bmc
+              - facebook,ventura-rmc
               - facebook,yosemite4-bmc
               - facebook,yosemite5-bmc
               - ibm,balcones-bmc
-- 
2.34.1


