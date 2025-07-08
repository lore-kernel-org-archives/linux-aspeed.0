Return-Path: <linux-aspeed+bounces-1683-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CAAC83F1B
	for <linux-aspeed@archiver.kernel.org>; Sat, 12 Jul 2025 03:11:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bfDB84j9hz2xS0;
	Sat, 12 Jul 2025 13:11:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751969907;
	cv=none; b=j0vDWqvbyTB6YZKybvwtO8e2L7M8zZ+h8qLUwVweFrIFPHRqATW7LTvfaKGkSbO1fMYGiIK0ikl4BFbWcGljNa/pFPzVBGsv8MVlAWUEeuw+4998QKN5gTaK36/P94bKrZBvUTqxqc4gRUFMxixiTyzPKKNh396CyPlWv/Y2nsQ2sDMpI95kNNZ/AaCphKHqLRqS4pUJ7wCO3LK/Ndcbvr/WelXNu0FK19mT3pl78HN9lp03c9MwmYjgyo7pGuDlm4s2Ij5fKkIb4a3zn9fAUq0VP9gJsQba/MJ+062VMIEy7DZNXA2m2vDsaO/yWGw5HdNwQUhAZIHmdd4mY1n8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751969907; c=relaxed/relaxed;
	bh=mdLp0YjegKAXW1He8H6sCHobxtr0SXLGuwvu5w7+xXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kr82EZmGR602qHMgCSfPP7pfnM9b4HH9L+K2nHG81Fi4/P9L3M53xnGfbkx5W8snEQjRcCNNxWb5hSoCJr17zbd5UlHUt3CJE4z3Vl3UmwEzJuJs8g4jIU2ms528bvhnazjvYtYnwmchazHIRh4UIsyMvDSUt1OPCP/jiF7DsR8orWqx7GoM5u2tUBVQSgEEqyn6mjexge2UwpV3muu8fxiGLJt570AO2iEc0vYgxskXxD/IxII2+P5sEkc4t/PSes4GwfTE5Max6dHHVq+2OQqCjFXiMqAp2WS0R2edGXCfvoC2iTbvznN6IoubxSp8UEeaFpCzPEG9JRqqOpOfkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IrVMWWm7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IrVMWWm7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbxry4PqMz3bV6
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Jul 2025 20:18:26 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-234b440afa7so40251915ad.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 08 Jul 2025 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751969904; x=1752574704; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdLp0YjegKAXW1He8H6sCHobxtr0SXLGuwvu5w7+xXs=;
        b=IrVMWWm7jjrixzeA99nQ+zx/z/JCW2mcfoGpknmMervUaOUmU6x2G/RKLZwmcb9i/D
         DwY5ccdTQUIGKI24fRCO4D1HeaKkFI3scQCAHdHLi4VR0pGa73RBeFTSbLiVZCdpm7H+
         PzDZgEGf8vIXGGnDOUj6I03/LoAQHNMa6IHSs2ol82f9YXAbxIO2WlBdSblkrtaShS5p
         WqGcAgWA26UGQlbDfTiHEQP9+UE0uLRgtOd1LpRXspIV6DIUAM5Yo69KfM2c7T4sNfPi
         xcrsXKd9AnxlfAWGlG8w4wedOMAZD4c2WYFCmj/+2q3dePPeO3xOaelJ6V6DrUQGEkXz
         GQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969904; x=1752574704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdLp0YjegKAXW1He8H6sCHobxtr0SXLGuwvu5w7+xXs=;
        b=eKSfLEdPWTdmAi/CS8+r3r+dzSVS5ssDPzWt/etLeY8d5BZV1GO0qglw/HGeI0Pu++
         qDPXvcEwBefziX0U41nw+8NqKuVBlhxWnL2Ij2icQWFtO1kxHPW1Yg10Fgw6buNesIn0
         PFHDf8GYBAFrnQwvzPKRQgz0A3YQE9KImiv0RKhz6YKdET35XBB/qmdhkaRKoN4tNOLK
         PzTC3W0uH224jUiDPHomrud7Btt34VnvKJA3NxYIcIMwO4ABFbWUkmAdhN7/By+rDeX/
         BABAk/9tHdvjvGV3dBT8MooAlBqMjgyVLet4HsC+KvAvpfxMkM1JJpTuRjgG6a6mAYv8
         YFrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2L9TT4YpKXIgNs43D9zcdH47HsCMBol1LeD4mw3yYUP7g4+baRlB8pWAzR95N6bprxmH8r+YqBKdjglY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw3SQ1YUWdQISKF3IxXSIpUXl8cgijgrjRLldYQREyGeLJCaWo5
	eI6DMf0gYVYD/4bt/stirfGHgexYkceAlP4aIGLC/34u965KoOHh9L0S
X-Gm-Gg: ASbGncvuoYFSUsfvhnrQ5wZDXgMR5zR8CnftDCcFa0SUhMWMYOUSIO1JY7dZNKoHdRV
	4uoR6qAujidGyf9x5uM6q+ao4mBjWdm9FMNKY4GiO0qLR/X+YFlZdH+Gn8WeP3ybzQRc5yCLKRF
	T2TzWHo5jIVS1idj8jAx7jtFZUUByfEnqQ9CAVIsaXD+1CBOdQpHd6xXoBUQCNuV4vBjbi8DM96
	TwoHq8dFzwrorPU8Ljcy0bN4CPqMBPyTNKoMzfPF4HYs7oof5oYyMVS+CFzvdiuaM5jQKaCTv8W
	o3N8TC1GjPiBczzM6PQBtrLKT8g/I+pQFzwjSzCsRlUJr16yHyESOexzsY9Va7VT+UVPwIVsbZt
	Iv8csy8X0LJP5lCa+3AQqXEzs0CX9iUs=
X-Google-Smtp-Source: AGHT+IGu7WYapWMHc9637DgsnJHKg4bnLFJuKBic8k4Cy5AmF5szo6dnD7F1fr+X4Zl1kXa/RsNNJA==
X-Received: by 2002:a17:903:2443:b0:235:779:edfe with SMTP id d9443c01a7336-23dd1d5e471mr35706785ad.43.1751969904340;
        Tue, 08 Jul 2025 03:18:24 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee4a40e3sm11114709a12.34.2025.07.08.03.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:18:23 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Date: Tue, 08 Jul 2025 18:18:00 +0800
Subject: [PATCH v6 1/2] dt-bindings: arm: aspeed: add Meta Clemente board
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
Message-Id: <20250708-add-support-for-meta-clemente-bmc-v6-1-7f3e57bd0336@fii-foxconn.com>
References: <20250708-add-support-for-meta-clemente-bmc-v6-0-7f3e57bd0336@fii-foxconn.com>
In-Reply-To: <20250708-add-support-for-meta-clemente-bmc-v6-0-7f3e57bd0336@fii-foxconn.com>
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
 Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751969896; l=880;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=Vkb9aXhwjRXn290zw8y+gVMx1U5e/fNse2oic6Bf6HY=;
 b=bPsPFlNf9KCv5/kLFTdwnvncwMCBUnDkJASOXjZZIH2IID/WfCpaxiJ2uad0l5I+UtHc3qCyD
 hfxgrBqr8BoD94uBPmk1ePYW7J8Kb4DHtjBSdGA9XGTcRGquyi3YA92
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

From: Leo Wang <leo.jt.wang@gmail.com>

Document the new compatibles used on Meta Clemente.

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


