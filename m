Return-Path: <linux-aspeed+bounces-2339-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31875CAC5A5
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Sep 2025 23:45:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXD3l6G0Wz30Pg;
	Thu, 25 Sep 2025 09:45:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758716943;
	cv=none; b=Br5CRrXIfkmKMazsq4b5GdXRt7bCMAHngQU+h1Nt6qwL5rCvHiY0y5ThHVxINr1Ph0F8tAOztvO4vCrKS/lQ3iG9yfygE6w5ue16IOcUoPU63ZRMicW77bw+mjU66dBSpRjlAxelZcKYCUYroNqHSsw+jKKFultAf9cJIuTwDwt1kdV1F4KYsHwYjezXDnHHhWtAHoP+EuY+8oH00/c1bQRvJ4OnvTFtVi8jHKxPIbGip7uKNE7emBwVlkr5ef2kqFZmxGBBCqYjHKpSWjHvMAig4SuTWFfBqUob76LHn80rGHcpKX4bsXwubmrJ/yTLd5FK67cAeoiMklcZPduw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758716943; c=relaxed/relaxed;
	bh=G9cki+WEYd1Fo4/29vxQI9Qu3AJnUGwvEMisLWPLAZs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Om2J1krQFRle9pdv7Osdvu/f4Jc+JRU8n21UaqWbsMrG2q9Bjd6d+WTp3hIha9RlGYFZW5s7xEMqEOGCYL1kIrLbgJF/nwPh3kIdfPZYQRag3whzaf9f0UqJMvlasiunVBa8Wab3Xs5Yb+ZOITL2JrzwDfCklPI7VlmRsCb4LMjcP9AHuw5ODGBeWW/hOHyV3c76Aa/ceo05Kr3BytWK5BXRUrNz28kRYNsuL2ITuFVTgpBo6Td3dF8fuXiwAj5E9TSvwE6svURcBB0hz2UR3ZGNFNq5i1cH3wwJOO1cTPXgZexTyWvV5ClCco+47kqPKl4BJCIj91phw+xcnu4Eyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JuGxQbkn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JuGxQbkn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cWx3d5S1Jz2xcG
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Sep 2025 22:29:00 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso6333043b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Sep 2025 05:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758716938; x=1759321738; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G9cki+WEYd1Fo4/29vxQI9Qu3AJnUGwvEMisLWPLAZs=;
        b=JuGxQbknuarWIT0yAgAzFO1fJ9p0S+varQfPE42UlZX050EFCGICYdQ9iGstXtxH5k
         GjrZsY3jtMEMmVnjROkzWntr04f5nzZ9fPNsfUoU3eTs/V43wlxJEe4+HfXJ7rinVVsW
         0aNN3aFKuGmX4548mp7KTiJLbnQFymam5+BqOI1RAbdY2LHpIrvAMjVY2a1EX46c1cMX
         ZGIcqEzdiczE9bzUEzULC1ZqM7ukIAXoo3fodGieizM80KQK+i83WYCGiJ6lkFQmORXm
         QjgWZce89gj9xwfLRZoDBgKjeNCzZjp3bZDNgcLsfw49aWTKRFCc/rFHtv0llWReqEF7
         +ePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758716938; x=1759321738;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9cki+WEYd1Fo4/29vxQI9Qu3AJnUGwvEMisLWPLAZs=;
        b=vTxxMJY43LkY2I1JqHpPUySgoOIS0r3MpqZZCAxnqJ5egVf5BFOr9TY/ppaCJ335US
         AVNjOv7VzTvghLHh+gDyFjYKi2/MTM3TXivH+zjve0ZBub1CgtW0M1wf57RTWkb+KqZx
         YlOGXT74QlBLgkfH/mtHRq4iSnchy67ghrwrV525d+yDwNYuIFb2T8Tj//9HAYUiic1C
         nuUAoByaVbWGiL+u2fYwIs0insBNtBFwvSdPpLqDuIc20uKTUVcqBZLSPOLuYJ3wFv9/
         84mws1SKz8B74cpkfbzvUktUvA+uJLe+0lw1OmDAaWADdXSC9IowaHSgKfzpxabeQT9T
         oHBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyrF4AgS0j8mGMnouLEZ7Sage+bQFpkiuuWTZqzCtkmXuHtca4SDgl3hel1M21oCEURdkcuNDrrgaNaN8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yywgx5JQyCxGfyutVrC2hsMfv1YOe9tY92gUs2nVMArfq19wSc/
	6YQKODUfCWjCwa/BvFSUx1LpoX+HdLwZg3H/z7RMNkpM2EImllrQH/r6f9t+g57t
X-Gm-Gg: ASbGncvwJMPE6E7g/KUVvNoAmpVEXHbuBrGtp2C+3dWdqPS641fZfbqPLyx9YipScGo
	TQdlXNSaF5TLh1QMt6Lnc/hGZEFaEF7jAGxTorZ+wPNvihfGVGcZRME86h8oEhwacvNYPJuSei+
	UhfW31GXuOJst+bRUXcIk7Yck72YGz3muf8gclBd8nd7ij5tx0dlmLj5pCSj+8zpDgqwtbC9poI
	alYShhUdxnu9n+IG3wHBJfffWkl/vEsi4sUHZBdDGKHgJjEcSA/lauhitMmvZF/zkXvRjzyX/5p
	YtWQua7hYwZ2EcrakwDK3bJk98UIGGQzwkSLRqwU8jf1CW3BNKe7GovI94pOtq9IDi5F315Rwfm
	RT+W6sMEI+myCtOjSB0zsixtrLHvLkLXgXTAHktTzo5RKDpqOQ9X/Tf4VYipLUbzSbDbG48aJXs
	pNs4aS3jqszkuPTuq6s33M6ZzYz7aCVt+ItBOP3uu2zrgtvOtGN7lOwMMJp+DnnnhLKfjkxIgQ4
	dlKYma0fewnngcLglj1A4I=
X-Google-Smtp-Source: AGHT+IG4MBG8e2v0+aWHeqFMOXrtFI9OgNz+261XXbIkXToJkywcJkLjC2xVVDMaTiVwkRv5RMwAtw==
X-Received: by 2002:a05:6a00:2e1f:b0:77f:2140:9685 with SMTP id d2e1a72fcca58-77f538b5bedmr7501268b3a.9.1758716937676;
        Wed, 24 Sep 2025 05:28:57 -0700 (PDT)
Received: from 2001-b400-e384-7809-32b4-db27-121a-a0aa.emome-ip6.hinet.net (2001-b400-e384-7809-50d7-4f66-57aa-588c.emome-ip6.hinet.net. [2001:b400:e384:7809:50d7:4f66:57aa:588c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f254f8f68sm11058495b3a.56.2025.09.24.05.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:28:57 -0700 (PDT)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Subject: [PATCH v2 0/2] Add Meta (Facebook) Yosemite5 BMC (AST2600)
Date: Wed, 24 Sep 2025 20:28:49 +0800
Message-Id: <20250924-yv5_add_dts-v2-0-39a4a8e3c9e6@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAHk02gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMT3coy0/jElJT4lJJiXUsjM4vEZEOTlLRkAyWgjoKi1LTMCrBp0bG
 1tQA6ljkcXQAAAA==
X-Change-ID: 20250924-yv5_add_dts-9268ac14dfc0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Amithash Prasasd <amithash@meta.com>, 
 Kevin Tung <Kevin.Tung@quantatw.com>, Ken Chen <Ken.Chen@quantatw.com>, 
 Leo Yang <Leo-Yang@quantatw.com>, Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758716933; l=1114;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=tFiVhe6+5SAbHrArHEtHiWSR8X3PeSACMPBwCd3KpFk=;
 b=UVVmdvPWigN3kriTk9rFgPHT54UndEAYVQbKwdxLVCvi3Ykim8QPI25cmLzYR2LAl+p2TcHn1
 rIlr8+vvbiuBSzH9fppX5Surc2xp6nYJoqru68dzes7KNcXqTMNtibL
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Summary:
Add device tree for the Meta (Facebook) Yosemite5 compute node,
based on the AST2600 BMC.

The Yosemite5 platform provides monitoring of voltages, power,
temperatures, and other critical parameters across the motherboard,
CXL board, E1.S expansion board, and NIC components. The BMC also
logs relevant events and performs appropriate system actions in
response to abnormal conditions.

Change log:
v1 -> v2:
  - send v2 of the series so that it's properly threaded.
  - add idle disconnect to i2c mux.
v1:
 - create yosemite5 dts fils.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
Kevin Tung (2):
      dt-bindings: arm: aspeed: add Meta Yosemite5 board
      ARM: dts: aspeed: yosemite5: Add Meta Yosemite5 BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-yosemite5.dts   | 1068 ++++++++++++++++++++
 2 files changed, 1069 insertions(+)
---
base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
change-id: 20250924-yv5_add_dts-9268ac14dfc0

Best regards,
-- 
Kevin Tung <kevin.tung.openbmc@gmail.com>


