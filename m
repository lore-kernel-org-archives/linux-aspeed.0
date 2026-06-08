Return-Path: <linux-aspeed+bounces-4192-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11014CD6E79
	for <linux-aspeed@archiver.kernel.org>; Mon,  8 Jun 2026 04:09:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYdpJ1yYYz2ytV;
	Mon, 08 Jun 2026 14:09:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780886441;
	cv=none; b=F6FHPAxOM4KYzoQ54UxiqSF2PSGs25FEp795YMubq98U41aUIY9V+0Qmbl68ki9wrCTpOVa16oaH09KCvZiRkYVogWi5yNQnJ5XbIdgC/ufUC62+bib/nJEDxk2pFB6Cjde69DiAA18JaHy9HN559WQSbGomzxT67ibCkU5qtUt62LLxyxLFWCmT+3mOurLOSR4DntH7/4BvASmeYvx0GoYszFw0SCDrDvSYs1Cx1sbJ4A6P6tvziEBgAH/dQrfoi26I/vou5z8Rq1YoTKxaMesUh1cfp6hekBfyPf+4CKcU/bsgl/SvVVWArCrXRWthYDu80RXcwLEs0EtuqnktAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780886441; c=relaxed/relaxed;
	bh=ctvKOED8Rs2Y8iHtAz2kdUCrMqrD3cqKZ8ykp6Je8z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UhtzYJ2ao9m41r935AZuhzLlJEbfgosK6VlQBFMriFPtYuXM/pLHnZFTj8+p8hlUylaE6qDZaJpcWzGLbbOoNqsfdTSyJgYTLpX2EmnSqGVyL2bP0Q3s+jepUjiV4lVNBftNnhZIW3bHBU0ZlqwUy5ra+RoXGNvEQ07kDdystV4HWgr9jxMiEHsfvV0gpOnZey3BpYIpw+hBK3wK3Wj+9MezaaWvsTXOERdAhTMXQnS7/y8KUSEZUJJpBDNuePEL1/zairAz9tH/9tBeBCj5jVM98ZH7zXoY7q465AzgSDg745niTyOvQnq9WJdOFtEvpoCuLOtJNo/1XpLTuYPrLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fHc7Q8dJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fHc7Q8dJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYbr76cpYz2ytV
	for <linux-aspeed@lists.ozlabs.org>; Mon, 08 Jun 2026 12:40:39 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-8419ab3a297so1533655b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 07 Jun 2026 19:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780886438; x=1781491238; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctvKOED8Rs2Y8iHtAz2kdUCrMqrD3cqKZ8ykp6Je8z4=;
        b=fHc7Q8dJBGo7efrLyrD2jwcTUDUEaMfdKnTDk1mGAjgQdM8vyRbtgZbBNfzYyU4Zhs
         uXD6O31BE9Ef0h+3WFgrmpFSBXqikyGhavfw187Vqj9ryc5b1JQjIYGpa2ModPgzvxHO
         /okOoys1c1YzUmrGoVcyug2Zku3XEEfmyjuMkQINF6NvcTgC3qE3xWMGWtkkTpWU7uBK
         ll03rZ/Kl36A9J7Xx7D8irVAlzEUAFeGNrOdHr5bP4BFUn5pchlx2ZdwDqmUkqCISfpE
         qnIi5U47IcxlYGOO6bgvGmKEAOgmZK1QQrtf1BYyENFzZ3zGhXpaTcM/VIKdwvMrvAFe
         YCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780886438; x=1781491238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ctvKOED8Rs2Y8iHtAz2kdUCrMqrD3cqKZ8ykp6Je8z4=;
        b=tCuN6q/h14iCyg6doPkMd5Tj9yltCYluhNb2mqP1nUekemsQf1jSqNddlT7ltHY9gZ
         mwBr7EHbifQEjpQSw0X+SH2pacRaTKtOVqLvsniExKDG6MqxsrLQOm+2qI8gBO1gKJvM
         4Hp3L2UqHgvmDbjttfMv8HLVxVN9YdBHGe8/2fagYviI+LU4S2IteHGbOWm5XcNw2HtX
         4zqDIdtDYzmjZR33b2sH5rXqXgR2/9jPoIWGE5/8KNvZIID3ONpwp3vgCe6nZT/PdJaq
         e1ZFmX9feBuqnLAmXiZb9Qjlg8pArUge/6Yyu7eDG95jP3cvtZVCjyNkxE5LRg8SWkHt
         umSA==
X-Forwarded-Encrypted: i=1; AFNElJ+8zJ+scCx2wkpKf2isenvhKjXYIB8hLK51JSjKpyaVOXLYwVzFCDByGQwHXmlofikjljekT/G+P5JIZOg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyddxILtfId7EQR440V0mBaV/mCKhB+cM/5Dl/qMLIcgK3f6tFa
	MrPOc8j8uG27zxld4P06Hc5wDjjZf6CN7pQA0D3dGXaQ3Bgo1aRtfVp7
X-Gm-Gg: Acq92OEUZz4y0BILOKmQAjFMlDHR7yaAjxd+JH8xdpVF2mmWuIUiB5lBEZJmAWWwDAo
	nsAOkGQgYvG8h30R6dMAH3wdDQFx+l/GtFq0cEFzNXpbzzoJtW3KFXp2o4Qjy3TorOOImDyP5il
	OuP28zY0E63VU06kRoE1Zl0l2Fe/it1WR0wQ2SdfZOiTMSvnbjgiNlMHn6yL6HC2d9ziC4KXBMN
	u3MZwLOExBubItRrr+cMOUag/BTwf4/AkeqEMn56RkUXnP70v9DV8OwkkmbvXoUYb+F3yUy9/t6
	lWocoDGIQGDCtyvoAlrQPH6ou3sA46AZaX8bgMXlEfowqdGS7PG9giAceqjSH89bxIQUqtQP91p
	Kl9R3+1SXz6b9VUqAnhQ5kDId8U5NMYYyp62iv2BHXbt7cFhE4oIFRiRcv2fvSLrTtqN4fz9xoD
	i4xjrOkOZEU/V6RMlYg3A9+iSnjFM6aaex7rxC73/7Xe+n+jBFLWzYVLbRGQ1yMZYhI2zcea9s6
	g==
X-Received: by 2002:a05:6a00:1994:b0:842:2efa:5fac with SMTP id d2e1a72fcca58-842b0a84dfamr13614984b3a.0.1780886437636;
        Sun, 07 Jun 2026 19:40:37 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm19310520b3a.26.2026.06.07.19.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 19:40:37 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Mon, 08 Jun 2026 10:42:08 +0800
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: add Meta ventura2 board
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
Message-Id: <20260608-ventura2_initial_dts-v5-1-37ee5bcf58b6@gmail.com>
References: <20260608-ventura2_initial_dts-v5-0-37ee5bcf58b6@gmail.com>
In-Reply-To: <20260608-ventura2_initial_dts-v5-0-37ee5bcf58b6@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=909;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=J3z5h5jN99f1BFk7jnvt5xoq1tLRgjc3X0kRzaksvsA=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqJiwEHsoVl4XOLzeORZ91RcLER02EI4M9I/iHZ
 9PYK+Fuq8+JATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaiYsBAAKCRClg0K3CVbE
 gbRdCACPE3XhgkbTVANCrtQpf2oP0lX8RvR/Vhcd6UN7TXYrajkCg7mmzR+0rYrPKVh2vJZKo1i
 tsQxFq2BgoJMTuWQPfPk202YQfqyXHM5D+sL5lN+/GkZO+z+i4sYn7/9QD4CI3xZZdYsSDpLS9x
 YdDQFBsHiU2IA6yAxK4abG0mR9RJoS65tafdFx45hv52vug+S3UajteRji1GOS6eElc0jOb9ICH
 aMpx9wbfKzQUFFQDmH5SKXNF7y8tWMWPRHuONs0BUsmp7iCcMc/P3KV8xIWxc9ot+NQwUAAf2Mo
 wTKdD7/sMe5RSsjdKuhp3YDGeMnNiO7KyHJwv1p7VxnsCKTw
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Document the new compatibles used on Facebook ventura2.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9298c1a75dd1..d48607c86e8e 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -92,6 +92,7 @@ properties:
               - facebook,harma-bmc
               - facebook,minerva-cmc
               - facebook,santabarbara-bmc
+              - facebook,ventura2-rmc
               - facebook,yosemite4-bmc
               - facebook,yosemite5-bmc
               - ibm,balcones-bmc

-- 
2.34.1


