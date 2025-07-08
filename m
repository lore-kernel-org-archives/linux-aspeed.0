Return-Path: <linux-aspeed+bounces-1685-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1427AC83F20
	for <linux-aspeed@archiver.kernel.org>; Sat, 12 Jul 2025 03:11:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bfDB9458wz2y8W;
	Sat, 12 Jul 2025 13:11:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751969906;
	cv=none; b=Td0LGzdNxzu1EA3xHwD3mZjhypU3j99AKUIzNd+DVJSDruiM7t4udbL2eaNhtX3FCTdHvB4EBSoxo/QCaQH9XXxrwaQ858S8rvk1wnUdSwctoF0E+Pza2IAJpFIu9s57Xz1WADeSHO8kW1kOcOQu0QtxPjCDkm0wxBKZ7MZ6Dm6T79gR4JMfKeiPRV6sR/nWg3meEzDXfj/a7rdMHNuKeK485A/jYaUTJJTgdDPFN1SREFoJJsQWWQppF3N64oKvUMyv7adOcxi/BmYBtdujjJtwdhvMgmUIFOkp3S/EvI2OHpc8rGi+zK3rh4IztOAlmD09ZwvsdEDtdU4M3uTmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751969906; c=relaxed/relaxed;
	bh=dLtaJj3z2oPY1ShSlkHP1j/IqOzaduHiAyYzCbRo9Ls=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Oaf7Lls5zbNYdiQ7W2Hpt4jNUFnL7hikiI5UoEWC30T5V03BaP5yaB1+PlefHHcH2dZH8Ik3loI2nLhrphpkdAHGjFFuPXm5thHO5QaqLjgVFDdTLCTf6CtPcvSgUbknu+5T/cz0aAw/bthXeTLED4P2Z6ThRt4VBG72vzTlyIq7O27CA3gOfh+Zm3QGRzCHGl7DAeIntBIeb42LQrz1e6NuTstXTINK257ldlmV9YlNP/PbUFH8cZYJJNBWoS48YKpDpruGyqURUqW5cT0mP6GxLmYxLFi45nAeKFdnakMvnsdukbslQg2J6fVz6hbRVNaUvPlsTmaAY4X4VIYe5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HCRtRkmO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HCRtRkmO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbxrx0xybz30Wn
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Jul 2025 20:18:23 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-748d982e97cso3721731b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 08 Jul 2025 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751969901; x=1752574701; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dLtaJj3z2oPY1ShSlkHP1j/IqOzaduHiAyYzCbRo9Ls=;
        b=HCRtRkmORg1ZE3B426t5ixYGXxHLwv87bUziJnVX2dxObWtp3jnynSxDpB6eIgPrzp
         4p28rY64Mn5o8uAhddlaoecjNfoDG6hNRhmhs6nSeOC//3/VmfMnD3N1eC8KID8Z5aZd
         clY7vKWPpCzXpcwcKW3ePGa+ZdTMNHOLGzmNjNaFUVRUgUbRHAwV9CMxQy/HVypta1yZ
         8vRoNtL0gI/0v8aFfYfFTfP7+bNZJhkVagkl+tCwQNJ+tRuZKXeniAo2xVhvccFKF1rg
         0+GW6hQZH2HNVpeXzDoaBbH+6ljxQ+jyRE3yrUWX8AFHPfC25ErNa726iussvX3/boLx
         wdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969901; x=1752574701;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLtaJj3z2oPY1ShSlkHP1j/IqOzaduHiAyYzCbRo9Ls=;
        b=laKkhh90RaOVRNVID3fQJxPNlpAubjEKBLXbm9a0R4imqMgFvKBeWA1Rqv6SHQV23q
         +lOZhHjhu7Qm0SCJhuA146qm7DtkE+no73Jf0pBMDzqoKSKoXt6Eedj16egvLbJBCd65
         iJpRvVbzK9aift1pmOw8g/9FA2Fsh4wrXxN7uMzQVThAHgdfzlpMd6odYXa3lvd9KgZ0
         F8jJyibOeC4oT8dk6pvjxD72eKDcWwvQSJndCoWCcfrfX5iT5qrDHda9NOjqZU7NKOXm
         BUq4AYIe94E6ZnJYNrgCWrYrhE4Nx+0gIWh5Ifi9fqj8Nka5gDozMCAxsCi6UYJKdk6x
         PrZw==
X-Forwarded-Encrypted: i=1; AJvYcCVkcIrcCdajP+lXIiqI819ZcVHr9tVeG8IrJYN8m/bamxSISiLuBUAJMW7tvq3oz6vXGnvNGtXw1VCvbA8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzAtomzYZ9xO9bXbR9ubs/Pgr3dPnp715P/z5cIm4NelF0EMUDk
	n+Ke/pi9sWUFfRXqn3GS6EEaL6gwc++CJlpF0sNdY9UljA/f+bCh1Ssb
X-Gm-Gg: ASbGncvxVd4ujxHCuRrMFCmbYi+TdMQyBUfVvRng8buKdwxn/lFf9/2xXVOy5fhPXXK
	QaanBXU1+OapD9LpZFSSg1+npXsXTjkz4qz6H4ue316IVIHZgBsYyTFUqlf7ShTTlqCVElPC2d7
	cHj+jYrWp307Bj9u1zM3DR+G/wZq7bOhaf2fqkO7TBbUMoVOkrsDqmn7cUv507Xna5No1h4Kl1e
	WI9MiY7src3yZ8Wa5THNyI9I989XYsMO7YUYzXBuzmLH4zUguT2B2AmNXteUIJJbWU65i6/MWsB
	trNlZgAZGAoofdXc4pLly79/t3jJ2OXUZhIfbAbgpgPrk7beUhwk78ZUoh6jt+IkGCTwniXHHp3
	crHejnsgoGTKJnI5Lp05RrGhTyeQW7yU=
X-Google-Smtp-Source: AGHT+IHFTbQU/uYOoMrihd+GoWidRAGLXPHYkD16HziD5MyIKSHN6gIaJzOtsuNhgeCshtOg1HOW5A==
X-Received: by 2002:a05:6a21:a44:b0:1f5:9024:3254 with SMTP id adf61e73a8af0-225b7f19724mr25324211637.6.1751969900609;
        Tue, 08 Jul 2025 03:18:20 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee4a40e3sm11114709a12.34.2025.07.08.03.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:18:19 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Subject: [PATCH v6 0/2] ARM: dts: Add support for Meta Clemente BMC
Date: Tue, 08 Jul 2025 18:17:59 +0800
Message-Id: <20250708-add-support-for-meta-clemente-bmc-v6-0-7f3e57bd0336@fii-foxconn.com>
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
X-B4-Tracking: v=1; b=H4sIAFfwbGgC/5XOTW6DMBAF4KtEXteV/4mz6j2iLMww01gqGNkUp
 Yq4e01WLFiQ5XsafW+erGCOWNjl9GQZ51hiGmpwHycG9zB8I49dzUwJZYWTZx66jpffcUx54pQ
 y73EKHH6wx2FC3vbAvZHBON+CVZpVZ8xI8fHauN5qvscypfz3mpzl2r6jz5ILjhaCcx7RNO0Xx
 VhvH5CG4RNSz9aNWW1cJY+4qroOLJKwXhoP+67euvqIq6sLSmkiIOOA9l2zdZsjrlldbIiUNk6
 A2Xft266trtBn7BxJaP3Ov8uy/AOXrcBoOAIAAA==
X-Change-ID: 20250618-add-support-for-meta-clemente-bmc-941a469bc523
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751969896; l=2063;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=lQzrd3v8IVLh9gCaLq7WUnZF8AHGYqftBF79jT2Lra4=;
 b=KlqQpQVMjrnLsTyzdw9K7byzDuSgHRV9Z3mimvYYtAWncmVd2YRbbCEniIfrILAVU2LEhX156
 mgdNooJdzBbDK0eYj+sxgUbJ1UwgKhLdxEcF+FpXccjYalJHvhtPZBC
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

This series adds initial support for the Meta Clemente BMC based on the
ASPEED AST2600 SoC.

Patch 1 documents the compatible string.
Patch 2 adds the device tree for the board.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
Changes in v6:
- Correct Author email to match Signed-off-by email address.
- Link to v5: https://lore.kernel.org/r/20250627-add-support-for-meta-clemente-bmc-v5-0-038ed6f1cb9f@fii-foxconn.com

Changes in v5:
- Remove accidentally pasted texts.
- Link to v4: https://lore.kernel.org/r/20250627-add-support-for-meta-clemente-bmc-v4-0-ce7ff23460c4@fii-foxconn.com

Changes in v4:
- Move properties of nodes defined in the same file from label ref back to where they belong.
- Move pinctrl default configs for ncsi3 and ncsi4 to aspeed-g6-pinctrl.dtsi.
- Add properties to i2c10 and i2c15 to enable MCTP.
- Link to v3: https://lore.kernel.org/r/20250623-add-support-for-meta-clemente-bmc-v3-0-c223ffcf46cf@fii-foxconn.com

Changes in v3:
- Modify leakage sensor to reflect current design.
- Link to v2: https://lore.kernel.org/r/20250621-add-support-for-meta-clemente-bmc-v2-0-6c5ef059149c@fii-foxconn.com

Changes in v2:
- Fix patch 1/2 subject line to match dt-bindings convention.
- Reorder device tree nodes in patch 2/2 to follow upstream DTS style.
- Link to v1: https://lore.kernel.org/r/20250618-add-support-for-meta-clemente-bmc-v1-0-e5ca669ee47b@fii-foxconn.com

---
Leo Wang (2):
      dt-bindings: arm: aspeed: add Meta Clemente board
      ARM: dts: aspeed: clemente: add Meta Clemente BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-clemente.dts    | 1291 ++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi    |   11 +
 4 files changed, 1304 insertions(+)
---
base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
change-id: 20250618-add-support-for-meta-clemente-bmc-941a469bc523

Best regards,
-- 
Leo Wang <leo.jt.wang@fii-foxconn.com>


