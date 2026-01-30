Return-Path: <linux-aspeed+bounces-3454-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC03BD172AE
	for <linux-aspeed@archiver.kernel.org>; Sun,  1 Feb 2026 22:41:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f44V75vzCz30FD;
	Mon, 02 Feb 2026 09:41:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769761219;
	cv=none; b=f7Bby5Aele0HVzzpEQMPCup0B8DGmeBe1Hit9VtQA6lYttuWDxDKdOyH5az0U8/KTeZgUoBw9lmtgjsC0lFEPy2tN5563VsSzSBYH+mf6+ir0eMfXefP64KfcD8sJx1IAUzymlsM7MUYPn2ltOnORt1zqyBJ3t9FhJVDZ5iq8VmuKznZT5QEI0ynMZ0tNZUN/mPGyBaJEsg9Z+DGn0w4zZCZHIGQGwgG/B2Un+mGI8Hq1YUaTyVztK/cE2Hze2DUFzVQzPLGnFsJFNDaZ2Erec4Pou/QbAYf/Rzntm7/N+pFzrGJpewLR7JzFRh2uJqrrYa85r3NkHGZTG/CsdWVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769761219; c=relaxed/relaxed;
	bh=hnUz4THRm4aVeJWQLZHQhQHquSXvl8jN1UCodfFTOc4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I1L47sZ2aQMcaP75r4blznKrYi3rgBFllvvwWwDTHeiUAWJKE0zwzJAbXxmz8RMcyBAeFAw6otPSPS9hXnuHtEy/iJ8AeTkE/IngEVzoouSfz3QPUApXW3jGptlKOnHGJmqSsEilexXcHpsS3kRROr7zbPaRzXCyaGsor1RBj6wgTVw4onXrZf0uAznvGoKI4ydZ1yliKBqsBPy6m/Uq8kqoqNIuWfbavPnTZgCKrIhpbd4OMPpGkxD+qGhmYNOAypw6mmiw0VOkOMqwbgvlUixWewCJRjDxAb8HmpFRPwIomcjPA3v9fyagEExHJQbSlzmkndAliIeYac2ZVpKy9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cYTf60rf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cYTf60rf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f2TTZ15T5z2xjP
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 19:20:17 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso1019715b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 00:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769761215; x=1770366015; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hnUz4THRm4aVeJWQLZHQhQHquSXvl8jN1UCodfFTOc4=;
        b=cYTf60rfS1g0xDqAorIntNHNAvM85u40D+bKOOVvuyFZH7pz4OtgfEOOeDnSAIwJiI
         Ul0yX2yXIklyXnWQaj4hsjPioniwd+3LWPQfSQF49s1LC7vjaqw2O3o5WqwyPO4Dzk3A
         U2e6Qk7RwIw9uD4zzdJK9d9cHEu6v1Lv42Whc3YBIf8dKKYd06zH+g9ckKijkqD5Y52T
         yjou2rDdJR7n2dy+9nO+jM3TY1yimm30l3kuUCgdA1oEaqIaYgYxbYZC1KmAqlTjzVhh
         Sztg3qcs91KWFqaug3y4MEyj9hKfOXMw/HHea9MHEGWfDLlmimqDXDXTysZTDmgWHBku
         IAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769761215; x=1770366015;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnUz4THRm4aVeJWQLZHQhQHquSXvl8jN1UCodfFTOc4=;
        b=nxCsQMgPOhlrz/mjZQN8yhhbNNrNc/7loIWosVJKpdtzV2g4cXM4AVRb1SXiiqimWX
         fQJT4/1lEsD0e86+ftMFCk/gOzBztkav0e2mclZsyJwDUXy6nndST5MLgkgK7240StDd
         Xb0GIJ89kPPHVB1lRavzpragGyUr14YYpV6mH4REFdH3KIpgLeGp1ofmpJd1vdGOu81v
         sOWefL0MrhdcgELHab7rKFORbJN61k7EIesjHV0ImDWA0LVuRTCMUUVlqYSITKo4LGde
         V+PJ09V+Vci07Rsd85wNluF4orYYrh5SQ8VzrMZntVbs2NK2DCusbVOQZUBfqqBs/fMU
         TaOg==
X-Forwarded-Encrypted: i=1; AJvYcCWXDGsvw3fOC29gKxEsVIH/fMAsOmqw+YIy/VJ7s0/vfjrUHN3PtflqxyqgQFNNNLaEwMiGx5kQYUiF0hg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz9KCe54t65UdTgllAcddS3RDzBrr7IldE/CIATLjOH40IQW8EX
	wNXKsY2uvFkIugkWgWdQUn4ORoGghUyd0xsMfQjZemX0SMTAuyd9tUgA
X-Gm-Gg: AZuq6aKqRwDIzpywJDIp6gYAkDqJEkymDsoNRYbJ2evIHiFylersQQlCuJBFFJiL2il
	KV2F1y0BRafTyPK5RWjs+0thdXIsNtQn8Onn0ZP52aXykWD3bTOq4ecMIqDmShmesnzCP3crAa9
	gHuRlMDuxhnHbL4dFm/Sg8ryotXOAlM1/dPcHWNXGT4C0uJoBlJGKVjf28Xwe1XVDse8/YTTbTP
	ssoUgaw9nCZ+t0BdcKheN4tc4UbBZ2eULCSGIOX7Sjtec2nmocIYnn18XLHws7sIjQ46bBOdCI+
	UTPhVlD3S5uyK64c7Gy3FipBKdnvHFpzGltAj0lqtNNYw75ACHosdno7YIpETxXyjIe7b2BqzU9
	RJ/9Qp7Cg22TqDeh7AjuC5z0IBW9Yrhn5FM1+zVMPwlBhZ/jAd4LPpbd77/fa54oPCq7zusiDQA
	lneKA0aKM8RuEjfuMqwJSZTq5ZXMqUG9wLWFroC7iSmBNaR1tPvtMRWO/0ScyVXrYeT7QCzyNPq
	oF8/gvwZHK1xVm3JNSSEBowXf3614Eux88Mc1Xca8kJ6e4vDOvQPeSyOMPwhFIg9+XsGC0HwM4m
	w/u68MOO/N+I
X-Received: by 2002:a05:6a00:b47:b0:81c:446d:6bd0 with SMTP id d2e1a72fcca58-823ab670e70mr2254931b3a.23.1769761214995;
        Fri, 30 Jan 2026 00:20:14 -0800 (PST)
Received: from 2001-b400-e3e0-2a58-5bcf-a65d-c80e-2087.emome-ip6.hinet.net (2001-b400-e3e0-2a58-5bcf-a65d-c80e-2087.emome-ip6.hinet.net. [2001:b400:e3e0:2a58:5bcf:a65d:c80e:2087])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfc712sm7866018b3a.40.2026.01.30.00.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 00:20:14 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Subject: [PATCH v4 0/7] Revise Meta Yosemite5 devicetree
Date: Fri, 30 Jan 2026 16:20:08 +0800
Message-Id: <20260130-yv5_revise_dts-v4-0-4d924455f3a7@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIALhpfGkC/3XMTQqDMBCG4auUrJuSicafrnqPUkQzowaqlkRCR
 bx7o5tKpZDNF+Z5Z+bIGnLsepqZJW+cGfow4vOJ6bbsG+IGw2ZSSAUAGZ+8KrZDKnB0HCSBIMR
 cYcICelmqzXsL3h9ht8aNg522vof192/KAxe81phUcRxent6arjTPix46tqa83HEpDlwGHmOKl
 ArQqqJfHn25hPzAo8B1CajKKJMCoj1fluUDzf+/xyoBAAA=
X-Change-ID: 20251118-yv5_revise_dts-12e10edd95d6
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Jackson Liu <Jackson.Liu@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769761212; l=1817;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=Fx+n2x+YlJ0swzNoY2QW+06k5Hll0jZhxlDQqLG+dq0=;
 b=uxTiiyp4e2eQ7rsolNoZYbQNw2OiRXFETD7vDC5ETDemNPxpMWpOJDB8iJNzvmClBi16wpYGL
 YcWVsK9mXiuDA5KFD/opjZtGMxMJlzNiDgqYjO8+xmxxTS7fjaZ0LE4
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Summary:
Revise linux device tree entry related to Meta (Facebook) Yosemite5.

Changes in v4:
- Add PDB IO expander device node
- Add GPIO to bypass OCP debug card commands
- Expand commit message explaining the shunt resistor correction
- Link to v3: https://lore.kernel.org/r/20251219-yv5_revise_dts-v3-0-ca1d5a382013@gmail.com

Changes in v3:
- Correct power monitor shunt resistor
- Revert the previous SGPIO P0_I3C_APML_ALERT_L renaming change
- Add new SGPIO line names and rename signal
- Retitle Update sensor configuration for more clarity
- Link to v2: https://lore.kernel.org/r/20251120-yv5_revise_dts-v2-0-4d7de701c5be@gmail.com

Changes in v2:
- Add ipmb node for OCP debug card
- Link to v1: https://lore.kernel.org/r/20251118-yv5_revise_dts-v1-0-fcd6b44b4497@gmail.com

Changes in v1:
- Increase i2c4/i2c12 bus speed to 400 kHz
- Update sensor configuration
- Rename sgpio P0_I3C_APML_ALERT_L

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
Kevin Tung (7):
      ARM: dts: aspeed: yosemite5: Increase i2c4/i2c12 bus speed to 400 kHz
      ARM: dts: aspeed: yosemite5: Remove ambiguous power monitor DTS nodes
      ARM: dts: aspeed: yosemite5: Add new SGPIO line names and rename signal
      ARM: dts: aspeed: yosemite5: Add ipmb node for OCP debug card
      ARM: dts: aspeed: yosemite5: Correct power monitor shunt resistor
      ARM: dts: aspeed: yosemite5: Add PDB IO expander
      ARM: dts: aspeed: yosemite5: Add debug card bypass GPIO

 .../dts/aspeed/aspeed-bmc-facebook-yosemite5.dts   | 92 +++++++++++++++-------
 1 file changed, 64 insertions(+), 28 deletions(-)
---
base-commit: 2a6ff9a25bf681302d29ec93c6b90dbe4b3ad591
change-id: 20251118-yv5_revise_dts-12e10edd95d6

Best regards,
-- 
Kevin Tung <kevin.tung.openbmc@gmail.com>


