Return-Path: <linux-aspeed+bounces-4045-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28BCCD343F
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 03:46:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJkHm1XnDz2y71;
	Mon, 18 May 2026 13:46:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779075297;
	cv=none; b=HHp30nyoe5WmCafUHlcy541wSawvuy+yZJ1q/CwqfM8CkuwJhH/3md83kws7BZZc9ZGW9NaNKbbEISvKN518BmgJYFPgMlI3cf9qEN8qOjKxs0Xn9pFMIQajuIFuR82zMkpZkpOJlUmf6yaTdIK3nwpgWPZBWYUxOFP46+XKDWJ++KH2nMD8lWPAsKUQsR1kAez/lnL+MX0XvJ9hSn6vkeA0IcHmXM2C0bL5hKz1GWz0C+FFYp/LkhCV9Dnnttav74TJm5iEDUY0JzgBEanaDbaOQyAVbl0wscrRAHtWxKrG3kKB/8h28Sbr0aANrNzEGkSgortwd/ZTyyxhFolhaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779075297; c=relaxed/relaxed;
	bh=8pS0Ld9uzavm9qCIn3zeBESeNJisq4fm3wOJuKswJN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOwdBSkFeeOWGnkVAvmtVOMp0/uQTiy4M5VgcL/bBIWLHh+j4ULDQXe5m6eqyJ+gnGhLJOBV9V6XF5WlQ7IrOZwQ+ZEQNbgZOESM5xg/SB7wlL2lSUtCtzzPISjug+AshBEPEmxXzY8ldIAXf2c9UazvhNYtGp2d1YJXK8qr2h12d/C39RMmAa96d+xxO5O6oDydbQPeGob7Db/yaLRu6AuteUeRG8FCeh8FyGGbPRx6v7uuRlM00OKn2uLMikkrrGhh95DiSRyZrSLCgqBGoOLiWB9TO/mtwlimlJuQHNNIZTGpYANAu9rRXcAT+rAuZF9qJUMWXoW0jk42mD1DMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HLN0tpDs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HLN0tpDs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJk2T1kS0z2xRw
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 13:34:57 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-369742178f8so793761a91.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 17 May 2026 20:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779075295; x=1779680095; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pS0Ld9uzavm9qCIn3zeBESeNJisq4fm3wOJuKswJN0=;
        b=HLN0tpDsaK+NBF8mR0S4oWm95Ym1QEWuqr7g+eLOumb9NkOntEuX40zGDabei/0Ke2
         0qXF0HnXi5g2WNYYuDBFtdp9b5hsh7PEmNJ54N6qVFwrKa8e7hz8DzKHiqPBUpa2Y0Qw
         7Gmp9wA/GaJXQBW7nPOUEugKsK67T+X/BWQqM+gfCSH+SFnN4Twgreu72PpqVBaS/5jq
         egmk6hG9BTOCHy79ZN1fnwSalQnHGGJYd1NptLeMpy1dmt7MFqsbRYUSUG1NQI/udmig
         SS86IxdBIuOwfZjebyAMk4R1hFTveyTRpRSRytpqd4wLZGCmF8vAstA2Ivn7bCCL46Wi
         0bRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779075295; x=1779680095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8pS0Ld9uzavm9qCIn3zeBESeNJisq4fm3wOJuKswJN0=;
        b=GZRgoXoLZE6QHYyJ6KMGM3rdnsWQwthsCdOG8xbdQSXtyt4kyyDeZRE5DZR7fxYt1o
         WbuOc4f76Gh62fDSXjrsqdUuCpBMTrjsX0+7F9qpMa69Fveq7gUVFkIm7JnjhS2ABCco
         30TTGrsnI5+CzHsZIAfdHQpKvxQxT5Qx9YmtclIDiPvbNrSm7VkE4xIQdxbW/abmvmhr
         PqXpd8AzRS0nOrCZqos10vdqBQajPqkaxMZWSvAl4w4yvMV9d6FlWGm0JxtqOEssnvne
         V4GwNiGaCp9okM5i2NCIzap/+/YFPmhpZU3IN4hwtvvrrik8X4q6lknhHHlGMQGNJZZV
         9QFg==
X-Forwarded-Encrypted: i=1; AFNElJ9SO4QNHKMPD6H3uzHlpUn7aQrT5AOX/kTg+Nmdt6795//lTg6YCM4nysza711eJ/KjEFSI/FWuorYEk54=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyok5+CTf+d8yMYlDUiD1e8fEaLAJiZk3LV0zGbl/TTE8viI0Fs
	1TNrs27lyf271mVY1HDqrWrwC7DtfhaLTskqOzxe43aqFKmASdxoWL9u
X-Gm-Gg: Acq92OGnLGZ9GLnnmUdTBxIgcSNNJkzf0ecxOo07FO+PwlXLzi4AObU4XiOvFxoudG8
	KqNS2eaPvW5H7wC0hOkj6fM9DlxulVOQ+89vgEV74M0F8KNNXm4GGCnYDhwV1xls2n50sSrGXa9
	zaMaIM7EZ/UcFo2Msl2KEt3hL5zwJgtXSbMmbkBuS6I+z5DS8Q8/MPixtobt/CII75Elx4vpXly
	N5bDvW76pTYmuMhRtJASunuuZ/A+JQpLXMPcgPLFkb6PvOgI5otKVBJ8g9gcNlQLI6O90FGnlQz
	MFrNbWDPURvy25u+KxU7b6Eahf3+zG+vCGpjTfPA2/AJDNlUO0jJ7CHDP4PUIHzSGhh/LtG5QRK
	Kyy/WWwnIuKHOhnSliUtJhgHzC8/CbVQ3/vMAXTWcsaydPRbSPzux41CaHI/wgMDMmqSqy6K4Qv
	p7Ez5E3IEtvmN9hqdIfKvAxzvLK+H/D123Op4kySkgpldIy7g6UNg=
X-Received: by 2002:a17:90b:5284:b0:367:bc89:546e with SMTP id 98e67ed59e1d1-369519e5346mr12755196a91.12.1779075295262;
        Sun, 17 May 2026 20:34:55 -0700 (PDT)
Received: from debian.prasanth ([103.177.82.201])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82c4031662sm11183717a12.16.2026.05.17.20.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 20:34:54 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
Date: Mon, 18 May 2026 09:04:39 +0530
Message-ID: <20260518033440.17569-2-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518033440.17569-1-prasanth.padarthi10@gmail.com>
References: <20260518033440.17569-1-prasanth.padarthi10@gmail.com>
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

Add the compatible string for the ASRock Rack B650D4U BMC,
which is an AST2600-based server motherboard.

Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 2f92b8ab0..656397850 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -77,6 +77,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asrock,b650d4u-bmc
               - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
-- 
2.47.3


