Return-Path: <linux-aspeed+bounces-3471-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5C8E8306E
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Feb 2026 09:50:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4zJ55N7bz30M6;
	Tue, 03 Feb 2026 20:50:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770112245;
	cv=none; b=CvNBMSPd4Ee8HzUKpTi86H5cVA8isja8nPzMs1+7WyBGWxg1pt/5cVP86XuTiD2c5dpiVzF6MEcfy+k9NlFOle8/dyroSk/YHZuZZJAV1PU0aw2EEsgvl+n7YmaPJlk3p5JFDIQHirSb4RxHSFV3W6sMgCqv8Gr6XuwBhhfWHYnIu8OS43UWoWLKVpQxP6tvVpi9rWqZWQyNvPozsGBPqTN3GpRnVIxYhlYlTOUIetmt9RH3jKMKNKppE6xdtOOnfrTHUkRwNZW7X6+LS2YIz5Evkpf8YCrl0Z3RMNTxpsywQgAnppOw3BHItzCZUmn95/dllh2rnweVfx9IJZpX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770112245; c=relaxed/relaxed;
	bh=HE5glzw2S4WCKHAKIYJ8k8reipPAB965cTMWcHuh4wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d+MOzBSgv5BW5hob3zSZigQxS8G1yMykuSP3jFKbQmFg0a8wYl24LdY5MXRJkPvDKaDF01Ijr9mXFYacni2Op/XwcvUvH7GcZu6AD/yDDeEkYimbQYkVIA9cqD6jpGE7TheeYHd2qIauOKyns05ntiq3Za3Jk2NYav7yjgfnq9dfFD+J3A4CVJxmVDb4p6w6a+sDVOwKWsnnNiV9EZDRakWpk6KA4pxS9GeuAUVPBCe8ONzSVY9O9tkFNXRvLNq0SRhiLP2cusCqEbMUvtSjzq9Vj/GtOUUq6ScsxNBP2/i9WKfg2xWqXXeDQq94dwtjYYzyzTfY8zyu5Yih41fFhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dkzti1oa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dkzti1oa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4zJ46Z22z30GV
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Feb 2026 20:50:44 +1100 (AEDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c46d68f2b4eso3355229a12.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Feb 2026 01:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770112243; x=1770717043; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HE5glzw2S4WCKHAKIYJ8k8reipPAB965cTMWcHuh4wE=;
        b=dkzti1oaRxh7mh18KOMYBz0yWkBsH+UM/VWrKX5QIYl042TpIZL9dP62r+WHhNeu7Y
         gdDrjcf+lLaohr4x58LvQ84ljyNzZ5ttyocO34DtJ/UAVRGQ6v5nfTeL5yV9msNxPO9n
         LO4sSI9xG4WkVJWGITRFANGjIARTtLRFid1QCoiZYC1l8OrdFqlNftSSsZx70IgSH37z
         7H1vgDiRjz9FLudGXcZcrFjWTh+JITS17Z7/w2ybz+dmag6dNuuu5Er+pcdAFn0dBU6B
         +H6/xljSaJ/MUIesKiXoE4xZtoCcz5I+G3MoOs1pjAcAoqE1/n+yhrZuEMnFIjyR4BIj
         maZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770112243; x=1770717043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HE5glzw2S4WCKHAKIYJ8k8reipPAB965cTMWcHuh4wE=;
        b=Y3Y/Mx01p08QOhaRB/CBWtTTuvI1Sh8OZhhX7kZ419dOzRnB18OgZ7YnguouSPfrvO
         21ERYAd5akS3rhLd/rYyiSRSQW8hpDwnFQKIZ3zXvNfww6acmBadUyWBtH6oeBx0RcAb
         1Q8PKWewJvF4WK2ToJePS61EGqxIrVlhRuIfmqLDQXyRSncBvpIoGAeRYqOWqafBCm69
         XZQ/VB5KddfK1kZvOYtKPAl4YM21TXgJ4ByV5Plvcs0gXHkFUfxS/ApB9UZKCkmBFmhK
         CrzrpR4n/vHyxuv+DBk9bfVfFSWWZrOqNWYJgJLVYTU2g6bgkA1jq2Oelunlzy+3vLgU
         gZ+g==
X-Forwarded-Encrypted: i=1; AJvYcCWKXMsDTvQcHxcKcuEg5+oDS4VSWxvoc89X4TCqliCzS3vc/JIxJBK8we1pu4SDyWoUqnN/O49gcjlvnx4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyEdOvzzx9QIu/1XLmS3UBMVpnsMq4Yua0CWCN1iWcnL9XDNpfM
	nWAFKC/q2rKWFvgkn3AsyQGX1L8qsZ8o8SsGRSBNBs26TlE2mXsTyuhs
X-Gm-Gg: AZuq6aIiCsoLjz22jZlaudEbkwyuRIL7a5excwiNVsZOZtvtqZE7kfTJ2X5IaAllfY+
	JbMVuc5fhk4HzEkmpo40C3HC58uL4bZLMpxXO+HD0cPKssiyp/6owm+MSdlL1h1AIIsapprWY8y
	aJuPNBDjr+73WAtmETrNSw6K6KAhvBLUeGzApfK8wJTaUtSVXO/KiJmNEzfDvlBMjhU8gvZYjbH
	qWcx3z+rt2EpzvIEFqlNuBC2/JoTifZRB5bSmtLYaptYoAep/MSoVyvCIrbhXH2YATkL0/Y1udm
	Ff31usd5OqgdQN19Ildv/mPbMihwyeAsZHreC6JiaHrsRgy15H0m225a5QkWYMLXINhkv3AXzZS
	ZBs64XWK6ZxqT/Ik4IXznxgZbD6/OSSvwwQDeNf24v0v83TEilX4ibS+TpMyK72ANVLnHmgNgOe
	HzfOY/og2KtmdLBuFLNu5/o1CyDOinjG43lMaV6Qf0PO8ObZlUsnILP2qrqnyHmweg0nfecfDPA
	Q==
X-Received: by 2002:a05:6a21:7804:b0:393:8fc:5284 with SMTP id adf61e73a8af0-39308fc8453mr7414208637.70.1770112242816;
        Tue, 03 Feb 2026 01:50:42 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a336a1csm17535332a12.19.2026.02.03.01.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:50:42 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Tue, 03 Feb 2026 17:48:14 +0800
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: add Meta SanMiguel BMC
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
Message-Id: <20260203-sanmiguel_init_dts-v2-1-6a5682c32b38@gmail.com>
References: <20260203-sanmiguel_init_dts-v2-0-6a5682c32b38@gmail.com>
In-Reply-To: <20260203-sanmiguel_init_dts-v2-0-6a5682c32b38@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, Roger Kan <Roger.Kan@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770112237; l=841;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=awDe2howAZDyvltIFZvQ9S1Z3NdAcsc3EqMeuy1puZc=;
 b=6Btw6wU97hhwe3vFKaiSmnwtqfWoR5H5FeSRtHNAThM6D2qJ/ppeb7Nl+1bqScZU3xQ3yYFxs
 zv5FMUtvvQvDlQMXkVYE35LS2ReTJrYjkluEoxdLbqAdirSmUJXIhQc
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add Meta (Facebook) SanMiguel BMC board compatible.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9298c1a75dd1..6c84e6c80978 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -91,6 +91,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,sanmiguel-bmc
               - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
               - facebook,yosemite5-bmc

-- 
2.31.1


