Return-Path: <linux-aspeed+bounces-1544-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6A0C7115B
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Jun 2025 01:01:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bR68b1yfwz2yft;
	Tue, 24 Jun 2025 11:01:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750674581;
	cv=none; b=knKvSSkAkXpvOru529uhUdv/EIiVJfD7dAhr/9lPTEw3wVvnSumbP67uwI2A3SrQ5tvqARLfcNTp+qCx+9lXhGzhRHSrCqtMV4+y3Ne2HItGmPNMPRC8ECNrBdn5vYHFaZgJKz08BeirVgtlXILSWuNz9TB15NuQsE8lnsRjwKpwfkD9bje4jSpcxgrkfVSXfxtNqq2Bb39a3s+l0rgSiLz8zqRk2d2KKpmSSx43io1+CD7+wSYk7Y0VxWInxFS6kR6fDRpHxz7wCGg48NsWhIy7ed4nweh4hPWjJ3mKTI7UG7Nt1D2/GukTJHBStP3qaIVF9GLcNfAjDlniLyV0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750674581; c=relaxed/relaxed;
	bh=SKbBTi7IDp31OkTJ6cIcfFVheRI1s9qIcPf1iWX2qRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QhAPm9spFtsFfRGQYpKcFsIRM6Erk2EUh2f03u+prwl3hLWIAIEsuUKAEhtJr96LZgJuz3sGMqJFcspkB7KmMy2Mhrpt2r5RUn6MPskYFfW7/ptmfqtnP1T8XvRTLWkIOqsQSnYScbRryBGyDkYKe4K9G1vNwQEK/x6ryzgh2Ywz0gldlV5IiyQN4Y0B9azTfmHy4HJsL7bunAS+dK9Ies8GaNhVxmPGVSbikU1Ux0HNT+53FC40zHBc/ubYKRst0P81nTw8LykqeuJMBK3EADHvlZOGBI1B5LyX9VAiv/VqiekrMp/xyWgsVFT0flldtBGbgGvL3XcaLNh0HzBJYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MgVa4ps4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MgVa4ps4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bQkps0jM1z2xRq
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Jun 2025 20:29:40 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-23633a6ac50so54718025ad.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Jun 2025 03:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750674579; x=1751279379; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKbBTi7IDp31OkTJ6cIcfFVheRI1s9qIcPf1iWX2qRU=;
        b=MgVa4ps4acpc648CgW9ZHQWvNA0u3XN+Jh0VTd5JuR1tS7USomO9yVYCQtbddJc7CZ
         kwW/TpQgrgY/1pcMGR15nhyqVGEcd8/rE10E/KpgQheQ1k48r5H3PubyNu2a8F9T3pQJ
         jezpmqZK74SQckVA/ma1T9GgmHkcbNr/J8ToH7ijyEpsc5hAMbW3wZysGWmL4hIUm8cB
         N8PZN+PInljN4/vpFvlU+AFgUDO3N3oDGBvkMI2ohweBKgFMgavPzvjLRAk7/TPIHoU1
         pI3b0X8bAMmLDDeHmj5YYK/3QmkjfzwFmkMvvmI+JtbrdZ/vcH/4qXanRQyEi6G0SKEx
         XxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750674579; x=1751279379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKbBTi7IDp31OkTJ6cIcfFVheRI1s9qIcPf1iWX2qRU=;
        b=Ww/mWCajSyLMVEReQsP/rvpvCHoCGEaaMN9fQ7qTUS8WkbTdpsT3b9v2ASjeNw7+LI
         T5CVTJE5JSPWe1dFgqOzH1c4/fdHDTh1xzvhKVVejvztBjCfHoRTbZ0HYgUf/mjL/3Op
         m1IQACtMBJX1K6WIJdvktcy8EDyNglxrjxWLbNCF4V34kZhHultYnyHv/Yoyl4PWftAg
         +c7ZqRt2PMyTnaAXxjKS3rRpkS9ikML3gJ5cLMKYHYx5DSGtrH+QUo3jLGUhaXowyGeo
         IyhJdxxPXjIIwLPEqwX1uYF4fn3AInW4sYlRzdjkYAHcUMZEfkpUFa0rsTg4IDJgCC6k
         oHIA==
X-Forwarded-Encrypted: i=1; AJvYcCWMQ3/OrN+DfakKFl8nUPuNG3jFx4pLS/OP5d75lntBsQmKBOmIteQiNOT5f3GUE68UPME9HOB7znCkf2U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwojhleC2XQbZG8r+GlXSqOgPmx99eLlppBSXgtxfMEFnxlLd1A
	uPBaau0D2cgxQYae9GAEyRibojTXk7q8P2iqyG5dEhjedts7kIzOnjlP
X-Gm-Gg: ASbGnctqELo5BCPowoNRFnFwbGy5jvEzeM17inFES3Ow50tgt6IAZ5UIf0PofrNsvTg
	9cqpqWo4gapK6jh/5ukGcl5KT7A2y+qlo7SCiGVKV2MiRyTagqz8VxFvF8CHzDQGE69Riykig0C
	slens3hmdCghlRyopDRabL+jLp1c66Wctb+mNqlGe6hQ94PrdhlynSVMZ0Wef7RNQKNCKraQAxl
	hNJs525GBkjvlV0oLiQ7L2MzICpEAkXbs0EUxs2dGKjotbcOyC2nMR/y2ZlBeWWED9pSY7lOmjV
	2dTocQuE7F9CEB5nhi63WxaZJz8B2UsbTn2Sr+nQtjoRt6lx78BJf3r+fXfDFKnGkeRRB7/Gz08
	wXsopWf2H3qCsuQwn1GA+K9ycvp9L3og=
X-Google-Smtp-Source: AGHT+IEM86EF9nrBu/z1x3IbxT9Xm3rBZ+c5loqQcmDNcyWe1L+5KmtdP7tl5Xb0XGFSrI5YVvs/Dw==
X-Received: by 2002:a17:903:32c5:b0:234:c8f6:1b17 with SMTP id d9443c01a7336-237d9914c92mr190971635ad.38.1750674578719;
        Mon, 23 Jun 2025 03:29:38 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237eec29a77sm39901125ad.165.2025.06.23.03.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 03:29:38 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Date: Mon, 23 Jun 2025 18:29:01 +0800
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: add Meta Clemente board
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
Message-Id: <20250623-add-support-for-meta-clemente-bmc-v3-1-c223ffcf46cf@fii-foxconn.com>
References: <20250623-add-support-for-meta-clemente-bmc-v3-0-c223ffcf46cf@fii-foxconn.com>
In-Reply-To: <20250623-add-support-for-meta-clemente-bmc-v3-0-c223ffcf46cf@fii-foxconn.com>
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
 bruce.jy.hung@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 Leo Wang <leo.jt.wang@fii-foxconn.com>, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750674571; l=886;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=jaJuRFuiQIpQeCgkDZC/ZckoYXAyyJRWtir3QL+VwYw=;
 b=SKqzHgYPQ7Ni2KNl1y7P+2ODxJOyoncuzZa0GvAoEHY7gKk26Z/Kibl+bR6P+55cRpMcqRF9L
 4hN7sj9jUWSATH9TH4C28UZ3RI0XXbKh+DvC+mnx3ZCpTpfLhEnPBrh
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

From: Leo Wang <leo.jt.wang@gmail.com>

Document the new compatibles used on Meta Clemente.

Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
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


