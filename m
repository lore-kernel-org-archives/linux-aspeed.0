Return-Path: <linux-aspeed+bounces-3220-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C0FD3B7E5
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:46:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dffFX4xBlz2yFm;
	Mon, 29 Dec 2025 12:46:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766558752;
	cv=none; b=Z8/VlZin98OnI4TgLtAOTyLrXhrKzUxOVScD19teREOOztZ0Ou/EukXLJdvKbVyuHJkaWzVO15ooOXzxN2LkoHTIdZ1ku9pCuOZwy4835uBttW7HThonK4TUzo5C8ZFiUvJZXIWboGl3D7GwR40ot1YrDF7ceKVA8ntvVd3NG0JrLNDy6Z4d2EI9m0C/bDvSJYfsNkvkU1gSxPXWG9TuEVUmz5Rdiqx9vBFwPDIn73U4LTajb+E/z+TFE5Wn39sRo+srcertDvf3rfnbkmNCSx5NQT2lgyMGsqKU8QBZ/hAKWv35re1g6TnAqQ4AruSHjMVUAuac79cZxdz2TCcfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766558752; c=relaxed/relaxed;
	bh=FhSoLSk0toWUxTDlJMgUw8U4nRCTEhSOzea+DI4TDjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gaLgwEx8JUgJFzvvBeRcXgZRVZxu4pFSNKW7QlMoDiyvcGE5pr23Jm9xnfwFQpli6huYWRr3lGGJxUHA+kTxhelv9v+LPRfSQVF5MRD5naJYwbWt3+4fI6g6j/jDAkCSOVlXbnWuGNDApHSdhPdW80uGxFXMSJxaqrUIEipiVV+zU2JXQu3WheBI3/bYizkMANeRwE3M+ViRuObR8TAEs+zs+VzxCWzBEUCu8BXqVlIBLQVj411WNmKH612lgehypqIOLNj6uCLzPC8Nq3YBebdWPBSL3j6ROGbrRREFro875gOElClUBvE27gB5GWEG4qo82v/Kylq5UsTMT5wg3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ei6Z766q; dkim-atps=neutral; spf=pass (client-ip=209.85.216.42; helo=mail-pj1-f42.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ei6Z766q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.216.42; helo=mail-pj1-f42.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbj7g6l67z2xnl
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 17:45:51 +1100 (AEDT)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c718c5481so5534101a91.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Dec 2025 22:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766558690; x=1767163490; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhSoLSk0toWUxTDlJMgUw8U4nRCTEhSOzea+DI4TDjA=;
        b=ei6Z766qvYy5Ya+vRpCrgFF561WoxvbgQ39JYxI1XpZmF6tMUMO7e2Z/c1EKs90i5o
         /3IyLTXMR/KqpxSWra8Kqws4MQA+a+nkvYqhqBhJ3YaUlpaptf1KkHu8ildNaiLZ2leE
         I43zGXcC4HmjaSmMYKoj9z4uOiytXLqRgySbuSG4P/4zp/Y6nxsiUJiWfqhFF2oWRrly
         JeHUMYSY35S0kXFlL4mBvDsyXk2ZM4af2RlW3FEoeLPuOul/m90hXDsZ3H7wZtSe9kQ+
         i6y/a5azblAzH2PlkNsTE5OE1lmcIYnB6BKDOjdneESKyvC3jhbewHvR1hnQXRTbpg6g
         aE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766558690; x=1767163490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FhSoLSk0toWUxTDlJMgUw8U4nRCTEhSOzea+DI4TDjA=;
        b=jS/UBOMWO26KKlgPqsHMSnY9zi9qgqi9g0T3y3BzsJyhabMuMXRxgrv1WIgcJxTUx1
         n1Pn1FzKtStE3QRpMun3A+S78Ffdx3u8zUumn/Ze1+0+78biXUh8lfWVNaCh80HdMprE
         ocF6dco8XYg8da/OuqZj99015QGCllIRDZQA6hi8qHwVLvnK6DK6uZtf66SaEdbKWJSh
         kcAi8KCrEYE//WHseoBLCZXwaSjW8pO2LKbYjT2Q0o5fQPmym3KZpVh/TWlovdckHy+M
         aKqTrbAfGhViFUMj+NnQShOZ12hBuNAVMcaYGM7Lo4VGckqmU6M3VL58wVqgY34ZfCjA
         MgXA==
X-Forwarded-Encrypted: i=1; AJvYcCXngeCui2C5VUFdeRJB13ZftyPSEUFBei6Er+H7S9ODQtpHgW4c6cNluN2x/gHVyLj0tEFlsDBvn+7Ma1w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxGbMCx9cGddwNG4cnlFrbbkDPFPzOgC3/IoI/Cgxnoxnimpj7j
	GAHFIXcZpL7vFQCiowmfmXsD9BWsfl/KNuwR90tGoo4qGkZZYJW+EoQu
X-Gm-Gg: AY/fxX6S6U4kBp6SY1ooVHKsppuS3dh/MHsHBWcGT4n7HZ4Do12+ZTCGa4DfMF5vKAO
	A7Y3nzN3roxgRuS6NYYbU0NL9tE21YNIoE7BrpnW7yGAPj1vPBWcdhFG6GMY/vl9o1SOz1hPG23
	/fbkIbXbHZtdJ5Jq5B6n+ENjX5qT7/zTQYNGSfdaL07xPiW+WTM4ubL5tRZioGg8hPt5Xi0clBJ
	LpsYPWq+egpbEmtAfcU9kO49yVgs3/4k+rwTx6ncvA8CxwhcYtBpC5Iv0xC6afinpme9Sa0/8p8
	nMpb6pTHxqlXGXX3wdPts6PUlgHx/sJJ6dR8hbNyvm6cq9HnCMaVS1G+8brlNvG0lJAX4lHBFcA
	pnXPy7zvMRtMZM0U3+neypnzvgMyI7s2ltOCtQoAgCsfgUiWAyZEWDAaPP/OicwzF0KpWXVeSnb
	AzWim9W8DXOxF5xnsazFOoFmK7yV3aeAqAC4PFi6kOOpl8OtYEyGw=
X-Google-Smtp-Source: AGHT+IF47XqAx1S18wR7ab75crtb+KkCnxuWXlTWI159pIOjgr1HJTRZgwnJc/m69Ss1gbrpaihQtA==
X-Received: by 2002:a17:90b:2fc5:b0:33b:a906:e40 with SMTP id 98e67ed59e1d1-34e92137cd4mr12343985a91.2.1766558689722;
        Tue, 23 Dec 2025 22:44:49 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e7729b04dsm8320864a91.6.2025.12.23.22.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 22:44:49 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 24 Dec 2025 14:44:38 +0800
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: add Meta ventura2 board
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
Message-Id: <20251224-ventura2_initial_dts-v2-1-f193ba5d4073@gmail.com>
References: <20251224-ventura2_initial_dts-v2-0-f193ba5d4073@gmail.com>
In-Reply-To: <20251224-ventura2_initial_dts-v2-0-f193ba5d4073@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=839;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=6cfmAXzuvyWCriW+9K5ER4DTlYWIvpG7m38YclJ5GzI=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpS4vcMKwnvorNLkNzhT34TH7R/3+C9and4tOSr
 pj+5wx2J0eJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaUuL3AAKCRClg0K3CVbE
 gfzfB/4h4pxLYNKd8HUji515qRmUDHvgspkX5YvfK2QGMvk/FY4mVIk0df+U5dVHMX7TeFi9eVb
 +taH+c6kjs81NmHrITRFgebZBPpc8ACOxhjV5m1PieAQqZS60VYuaB4QNf30CINQKzBsrnz8eaX
 lFBaFhnjbg8cClydb+IJFcwsVirj5p3M85t/WTTBTb0hloEMRvntQ0t91h2AcvAtgftKQJFTrte
 Tt8+u5hC/s+9T43rrHikYSKNKEYUzUzHTjChVUFhdvX94yrwaICkLl2zl/hVhnEXlKOxnHS1Syx
 LJ9oqcaRhUcZ+RKtrDaetZeTY1WwiB0aYBiWMQ3B/rCpoyv+
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Document the new compatibles used on Facebook ventura2.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9298c1a75dd1..24e19b8d108a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -92,6 +92,7 @@ properties:
               - facebook,harma-bmc
               - facebook,minerva-cmc
               - facebook,santabarbara-bmc
+              - facebook,ventura2-bmc
               - facebook,yosemite4-bmc
               - facebook,yosemite5-bmc
               - ibm,balcones-bmc

-- 
2.34.1


