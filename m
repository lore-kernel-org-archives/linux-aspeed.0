Return-Path: <linux-aspeed+bounces-3553-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CFDFD9E1E
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Feb 2026 22:51:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMRXc4SMSz3bZm;
	Fri, 27 Feb 2026 09:51:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772085382;
	cv=none; b=NrC97X4YLwhKWEqMXUJxR8TeqwzTTmBjiHuOmiODjInPpVfZiAXg2Myp+ZgYQphg3tbk3kfDGxMvHLI8DejeH700d0SjQhMY3fepv5S8wTnspA8RfyYxttQBOGomBRulWgJwE790P4IWcpgbLruCrl+8YJHXIHXmhq89DIjk2dFoVSonBXr4/1xn+V9fhLcs0aSt7rx36xnA/DfUkGOEBRw/aurh6VvubhvXaCZcozcA+Rcofc0e7S8v5dgjK/0FPb98Fl1x+4AuGZf+/hehdNbREKx3hXo8v6/0W/stWFOQEGxqUkQsmV9jV/qtTf1Sm7Q5JyYXEsQVM+ELXhTC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772085382; c=relaxed/relaxed;
	bh=2M1mDfXgnz5T52hMj8GNJ84lRse5GAheeg5uX9GLBPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mM8f1N+19g29Oe20bmIZF3Y2QrJa8VOkbg1ldx362Z+ZIUofAnFgw4c332acM7G6qnJBJrBf77DU9yDcZCgj4a3WwsDYyfWkhjaVoRKzOR1Ulxxy0A+onNrSZ4HPTW+dJsIH7jSKmNINMTw3RDPpgyi5GT54aJ+GXoNQYMwFUqXxD+KzKm2KsdfthULY1Cc0fTIwb6NMA1zb29gZ6ZGRHL9/cbjaUSQrrcrsmz/7U8Yh770RZM32FyeUPxvUOIs0LH9IqFI+aTXchwyALUCaxcBKjhY4EohbLsu7UZ/O1muMN7+O3G06FUvs0lt3+2pr6JK8UVZRB4Ag5oHsuNNTMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hebe6iEL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hebe6iEL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM1114qxGz2x99
	for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Feb 2026 16:56:21 +1100 (AEDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-827336c0994so525610b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 25 Feb 2026 21:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772085375; x=1772690175; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2M1mDfXgnz5T52hMj8GNJ84lRse5GAheeg5uX9GLBPU=;
        b=hebe6iELaaLFX6wYHXKNpTBAtJKO4ptaP7sfgpYS6F5wlL6feNGGczNE/wYqaivRyS
         YdAV1JVWuoUUfPoHv0cD13f1BjPei2r5Ry5dykP4v8sRsn1mv5k5Al1+sjrv2o0Ara7j
         S3pVqmVLMHd/WG2twd+Lb2NACSE/xTfjZ3YuTy6rEMzXUvDF9TswNpVB5xJCzBpvWo1y
         IvvL/k6QTJe8NTXge/PTqEBu2xP4p4Axr0GwkJJvhPfwZhr4q/U9GlgkrJQnh1Y+vUnc
         3MSHxFS289ATt2oMP1hJiGbmg7QQFPiwOVCTHuMdOC+CFjzav7pj3K1QJwEOE/HANuOg
         xivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772085375; x=1772690175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2M1mDfXgnz5T52hMj8GNJ84lRse5GAheeg5uX9GLBPU=;
        b=uraoVdm6msjPVe0fwY5pviSrKYBKnVryKMzLVKdTYSCPOMuDTzCIqTGQ6vCES0mP5L
         mFUSunAaEv2/MFzxr1/o1wzmh1Uy2CV0RZ7X5obSdqPG7VBdeuu3G6zBdahiQgpuQW4p
         QGlw7Mj+IKQU2cs3woW893i8wu2Kc8HgOVFohxPpHiFgtd7ddHqCYsC8qkQSC7FKrb+u
         Z8Q4hDTKNfPjHvHzvin6gAyop741Jo7/ZDdt1fRXAPLVYwAMcjFZ3i6VISiK3QQAnjwZ
         zC3HHWFhwi4+L6vO36bIlYSjE3p83RJvpknhR4GLqf1/FyToQd2FpFu+Wuc71zmIPem0
         afCw==
X-Forwarded-Encrypted: i=1; AJvYcCXwr5S0CcJJPRfB1/YVVOVWrdk2aYmr3P2+SiyeK+/frLYOxwpgpn5piYP1ndGztZoedLzHcaZSz2P1gx4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwuH7QP7pFA5hfkUlVoVfWUcC1WbTiTxoi4Twy+3FbazmipL9VF
	LdjIr8giNz+Uq8S+jiFzpb+tx3Kae2V0l50XSGzF7t/z/xf4C+eQBjXpuQ9xmUHz
X-Gm-Gg: ATEYQzxOtaFLSc/Ku7hJ77+e+hJ4HaWVH5OA1qsfPRbyM7Dn1DlwfHreB0/TSKy/6Kn
	Gk8qSHRTnD/hEsk1apXXRyfTLSGR86gW1gL1QECPs1ToBYmE8ZLhs1pzYuvWCS6KW9pzoZT+sGq
	/WsWdFlP+kNDP/R4k7QYh1ezKqMUYO/YdsIJqMR+sc2LPKE15BnY7pAjKlFoQFlz2JIJanTrqEK
	FIbvspbL5XB0lIWmKH21oXppFEAK4ep1ekIV9nJp6KCYZ4OxMYJD3uLe7EJJMuMHQTHwNAnHgEl
	wwrEomq+TcLAj0+IpiAKBoV/ALM8ciDYUDAvgdxcQDxAMS52oNPVgfDDLmk5/wD4djTecx/mCzJ
	D4Hfyk746G7CDTmbhh1FQqV4u4XFvOsUDgJkBqnV5BRVVX/0AdQQL+mhzM3wiK4Gie4hdrvsEtt
	KiBXklwvTvJ4bfZh1B4QULXmsGkPksZxpdBf6VJwzync2/XqdljTDNjFG/q8QsUfTwvp/nSKXNF
	zP/HJffsjGYQSEHdurebXM=
X-Received: by 2002:a05:6a20:a103:b0:366:15a0:896e with SMTP id adf61e73a8af0-395b1d2386cmr1678863637.16.1772085374725;
        Wed, 25 Feb 2026 21:56:14 -0800 (PST)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82c284sm767851a12.23.2026.02.25.21.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 21:56:14 -0800 (PST)
From: "P.K. Lee" <pkleequanta@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Jason-Hsu@quantatw.com,
	p.k.lee@quantatw.com
Subject: [PATCH v12 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Date: Thu, 26 Feb 2026 13:55:20 +0800
Message-ID: <20260226055521.1655243-2-pkleequanta@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226055521.1655243-1-pkleequanta@gmail.com>
References: <20260226055521.1655243-1-pkleequanta@gmail.com>
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

Signed-off-by: P.K. Lee <pkleequanta@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a..afabfe22c8f3 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -92,6 +92,7 @@ properties:
               - facebook,harma-bmc
               - facebook,minerva-cmc
               - facebook,santabarbara-bmc
+              - facebook,ventura-rmc
               - facebook,yosemite4-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
-- 
2.43.0


