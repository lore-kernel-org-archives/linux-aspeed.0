Return-Path: <linux-aspeed+bounces-1813-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289BCC83F17
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:47:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnW5H6G39z30Vf;
	Thu, 24 Jul 2025 09:47:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753242182;
	cv=none; b=MfrogFYxANjvVsowYS/fBBbe+ChTEG9TJgBA8nRt2R3ZObLesD+M7POR519x4ZR2OQ4cGbAVtpmcDOR0jgLupBdf05UFkGL+HDeA9TSY48bjnTmZBaw94cysMliJxOU7150fM2+8FoHsCDl6yYWqxPSzrGjkryHLoII3NcwcJPn30oy21DGRMl0qW5tUDoxcfH6mYDxXKce2bFuTrHTbiiR5Cz6JmmagW+zG0MaPU+w00Za+gTNC43PM1tSbl0WwGwGjgxAJmPy98zLSIDxcVjghqVANuMw+ei4reMKYYcn1LtP3wwIPT7wlDzImYF6wlKOvBwO6KjNF0IFZlP+KZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753242182; c=relaxed/relaxed;
	bh=KxTTJcqEHv+qBmIyyfl+JxjRyKaE0U2wO1Y0rWsQE80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NSoiNiumG7P7QUm7/6P2H9Loa6+i6l3YF4QZFDxGvPgn6hX8VGHthEB2F7KybLrlaMcR35vzzNynQ+4VFlPUJLYumCF2nk6yDroe8a/MdUQxLwHBHskEbEMxc0VH79pGdLqSgCBzBA+Cd6U0QP+Kv6nFEwBr3T4jdatjczZN/RUzn5QAYuuoTs9g4rJLJeLGSg6Kj3C6jSaev+s7N3DV7oAcXk+YWdU5CmeisqyuMNgbs8pCVv+giVqrCAUPZM7F3ea0BB+sfy2Qp8irwjAyWz67yAz/xRS+praiawdDRloKd1nWovgag+5J2awjwrwllZ+KyoHZ9elslYvhNdMR2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=B61xQsFa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=B61xQsFa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bn0Mn69Zwz2yF0
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 13:43:01 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-235a3dd4f0dso38237505ad.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Jul 2025 20:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753242179; x=1753846979; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxTTJcqEHv+qBmIyyfl+JxjRyKaE0U2wO1Y0rWsQE80=;
        b=B61xQsFa+hsXMTRe4oWhLLGCk+NVDDH23CALpg0kX3RWKbgxgIQmj48MXcfn3N4s6F
         L5t3RGN8IjrSmcNimeJhxCtKSAqlidD5WU4gH4aCWCFG0oVLMNubv2+Hkz/k7yXP62mu
         7rEf/JiGMRCjYmHMzoSLkBNzMkNSvM2f+y6ZJ0H3NBEw3Q4rkhYOPzqBR2ETF/q4Muvr
         /L143JrKpweGBssAg+fXem6pHdPOcMJiXDt2ImRQPn9xRHzO51pbqYT0nRj8Zs03QxRG
         zOGeSh30E9zbzVwcOo31yzQRLkmvteGoX1efT7Hwn2KJTlR0frVnU2XqN/nFXCXhNG7n
         ma1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753242179; x=1753846979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxTTJcqEHv+qBmIyyfl+JxjRyKaE0U2wO1Y0rWsQE80=;
        b=FAKLl5Hc6DIVG60Bm3bSij+yQ86XHCuMr5oVTnrCtuPlHVyfmdXYEUZ16+fEfXdKbf
         x9UmQjATY9eVVIzR+jK7PV8FjBgm4rouSnfRNA85XDc0/yISXWiLpbcx2V7k/5FafH8Z
         2bSNtBXVCbumt07Jqvjn/LHQubL23dxwwzAUwnp+sMfcMvSz4c3J+whfnb6KiluoYluf
         HcirgF6tYqjQ5aZdfEHuPTQA0IKyIuSoPlUnmtUQAicS1DNhp+N5iN6qYf+maeM0+wLf
         zSiQmyV3fDmoQos0+YufQMOLY4axeyWKfMBmqTScp6NrL/ivie/fLy2GpKFSh1SWMO/3
         TxAw==
X-Forwarded-Encrypted: i=1; AJvYcCVFZX56fBjADrW3shYf4/CZyTU8KXQHeV/wPXibUFCObHykeE4VnspzouYWh1vBLBgh1cWLiyTl/ZQH76U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxyG0YzxUpceXaqreSvVgn/FzhcQnXBobBKkoMCySxIxt+KutiF
	gSyvNjOvs5qtnyP4YWppxbJqIgOpK9ukTbXnxXV8/pcjeKmnRzRvabYY
X-Gm-Gg: ASbGncuS0ZI0uRkoNn+/HxQhw0iBUOaRkiYlDTLaWB0O/lwjY14IWN9d67y595AK210
	ySAaAwW21DSiNMvw+4FvrT34dD2eP6Pu2dV5SVy38hPcLbC0WmVrvbVp7nnSm3FdZRJ0rB714If
	7xTnW+khlGR3BgQhcdJ0Eo1BAkI32vh2cFWM3GzzjcypeJP5eBmxoJTshFYSTKO5xHzZ6ek01dA
	InGdCy1XXOUzmBSpvQ7VsRCUI5V+P2eCEUS9T6ZMV00AgTtl+q41mMPqr6yus6dCbvqUmtddgky
	BoZmh3kTjJyhnP3WwBVp3xE5ltoY2Re00ZokFv9hdICdg9rPSr5q8Zbk/kXyIPd/aV8DqJvAwD1
	cZUD0VR6+A0n1ATkDYup/Pqx/npcquVlo6OIeJYDMx9QKPOTuGg0MQtxHqArLm5j9PMI=
X-Google-Smtp-Source: AGHT+IHHjKFVRY0n3ORvJ/3tCcnOK/FTC9oaQ2WPdkygTI1KPwN0ZyYuDsFX8L5lqzEAzGwyYH1SkQ==
X-Received: by 2002:a17:903:1b63:b0:234:986c:66bf with SMTP id d9443c01a7336-23f9814686cmr18960685ad.11.1753242179340;
        Tue, 22 Jul 2025 20:42:59 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4d47sm86197605ad.99.2025.07.22.20.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 20:42:58 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Date: Wed, 23 Jul 2025 11:42:40 +0800
Subject: [PATCH v9 1/3] dt-bindings: arm: aspeed: add Meta Clemente board
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
Message-Id: <20250723-add-support-for-meta-clemente-bmc-v9-1-b76e7de4d6c8@fii-foxconn.com>
References: <20250723-add-support-for-meta-clemente-bmc-v9-0-b76e7de4d6c8@fii-foxconn.com>
In-Reply-To: <20250723-add-support-for-meta-clemente-bmc-v9-0-b76e7de4d6c8@fii-foxconn.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 leo.jt.wang@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 bruce.jy.hung@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753242171; l=933;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=UnfBA/U+nB3GVshcJhQl74M74uA3eyzQykqLq1TeLXk=;
 b=+GgM3+LvWhnm2FqtnNygp4YoEvMVXUlT8wog8dP/1q6l8MnZguge5Wl9WcS72UyfKkcvYZDhm
 2Jre0Fw6cIPC0FdWrh7UNQvuzjCapzC6NV2twAE8FkKulLeqiGmTJI+
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

From: Leo Wang <leo.jt.wang@gmail.com>

Document the new compatibles used on Meta Clemente.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fbb076582a6c0e801903c3500b459f..ff3fea63cecd99ec2dc56d3cf71403f897681a98 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -81,6 +81,7 @@ properties:
               - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
+              - facebook,clemente-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc

-- 
2.43.0


