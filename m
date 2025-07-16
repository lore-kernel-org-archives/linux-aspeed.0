Return-Path: <linux-aspeed+bounces-1735-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50614C83F1B
	for <linux-aspeed@archiver.kernel.org>; Thu, 17 Jul 2025 00:41:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjDcq0SJBz30RK;
	Thu, 17 Jul 2025 10:41:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752647073;
	cv=none; b=UgxP0bduGY9wPGT3+pW/rBtcGnLy7YDSbakgWJA9f7lcO3Od2AKcwOPcdRopci6ac6161AXdr9te0aBjy7ueyiNnTES7CIcz/jb++aryvq3oCDUjSfNKMMwVjrU3EmFSJFEqfHwi2RWXThhHzkqe1n7rJtaTsgt+xvwmeAGigFC07ykLEbtTr9ZFTW9f389yKyLFZjyVyOQ095Lapnx1Mwpwha9FDA/xaGbYmkc4mHx1d6iac+5J967axmQ9t1tcFjh8LJsWnMO6nwYqW7vjxOX5ZV/huO/E+3pXkiZQCgigjoj3RCil3F1eYBV6hGOcfVQafFJQakEYJ/Smld2/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752647073; c=relaxed/relaxed;
	bh=Ixmx0d+ZX0XcwmYFgmX/CAvbk5ppzzZpsXvym0428IE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K+Vv3uJ69kclpZOA0s5hTyqHQKg/SZxNYDBeCytXarKB1my3CHOlJ3ll781KahO0YcyM6nQpL26sGME2jVBJ+odvmX8bFxOuLSBI53HWYdw4RW+PsRVXKiwToHHDZ4z5FmzzClB8wkgSM3Ih5nYuxE950wI7VMofo5wd9V/Kmf8n+e/zRXiBQ0rE906IuOIraDUe4i89Gy97FeYOZLKq97Kv2fh5JcQj/XwpGKwpxZX4EKxm+cxwTpTVXPyyvROorm4LqccyYldP93TY4SbrlJjoouuQrnuyDQemxw861l3atsTV/GIYxN7LtSglB2UL1hZVP6cAPZmc8vHyZElr0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ezH6h/fd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ezH6h/fd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhmHN3BXQz2yN1
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Jul 2025 16:24:31 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-236470b2dceso54798265ad.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 15 Jul 2025 23:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752647069; x=1753251869; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ixmx0d+ZX0XcwmYFgmX/CAvbk5ppzzZpsXvym0428IE=;
        b=ezH6h/fd1v2UCvwBsBPyIkn/B5oyI90XCK66pwoUfd77AkmZy5E2u0RjM6D7/embXD
         hQ90SCvh5zgLgONM77J18GOoA/vTvMA0LJQ8n6RyZA49MH8Y1h4ztUSy7bKzrruPRCCZ
         RtD+LqsfwwplW43QOntOuebFeBg6AEtaRgCeTEViFZ5HwqumQwfIP3H8e2gL+0gc9som
         bgtctKfmYwROoeqx6BKlGZ125eUgCvwqGhg6Q6C8cHzBcl9AWlh6WhYLQYI56vBCifvl
         zT6h90AuqjFGdxzzLTZWTKHZg6au61C4koLhJrWpg4N4uW4SeTGKKZXuoQfTGrYEMbSc
         KDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752647069; x=1753251869;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ixmx0d+ZX0XcwmYFgmX/CAvbk5ppzzZpsXvym0428IE=;
        b=DSfcpGbYDhlb0SCCHGosQkmHPMxFT1qFQ87gg3ihxv2DDsxSxdea0b968M+FJdVojZ
         AmUoebTHuAJhPURqhCREBkYpj19BI16p0dNha+bRwvXAOG5sLV/uHMpH0KSJ9mzhThnT
         /hsIoF25r0AqHefhotIyI1ynRWecAS0Vn99ob/0gCTo89BJd9dmcOxuUQZIYDJs9yjG7
         OIT6pAUNYGsdE/iV4p6YBNyfQUsont/w6t660Cgpts95DyT3G4W2MUgTNLJtx469hcSL
         xCO860Sf64ivEE+fnwfm4u0CmryNvtrHrJ6ENbt057NFWyr2W9OnGW96uBaM/1/VAilz
         tTpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+ub+yfBVMRfiYX0AjGF+FVyMc2W2f9UAx/WWJ9Vif50qneEB7NDiIsHvLMdidf82IEIKkylyeIewaDNU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzoM3Z18lfv5LY7B7MCHKBByQxh+fuS0MlsfusLLxoKSxWichby
	w426sjLmQOMTsCfHXAg6p0aFuANxG1T2oLDgqf3KZ4KeZkO2QvT5GkDT
X-Gm-Gg: ASbGncv1FM5OpRyNumEimbTdYK/tmXl/JbR3awWCzPWA3MbrN82wNdpBgk0lx7XqL1I
	p8oySAZjoV9Zqda1xA81i7/Mv0Zbkf3TzbXPj6Ec69DcPCBElWnQMyvKxtYQ0NxqB/aQ4R/eg96
	DKO/H8+p7vnSL35vVs8StYc8w+3ezag8VPQEwfIu87XFpCbDLhdIi0sHFXrrAFmz00NqCf14QOi
	LgBr23JYTELW5Ucxi8w4CG1KLLLRbBatJbYLtVI//oIFrw6ou2By5LwnCjuqHRK5Cod5t7nRUfs
	CoeLHpz8z8EXCCpjoyg8yn3/EZNPsD1PsOCUv7bER7EWpvNmyXDqdtl4uSzspfFyRvUOONnziRK
	93rxT/UsChEy4A1gkK7p0ao/unhwVpS8dtHpsqxD2IZlYdlEOpR37peUM1jN6TxPwY6s=
X-Google-Smtp-Source: AGHT+IGm4cJ+T3HY2+WuL/rqcwTfbyVXKPV0HvI1TYx1fR1w0T8QhNT4nMZujHcDMajbIK8BJ72cvQ==
X-Received: by 2002:a17:902:ce05:b0:234:c549:d9f1 with SMTP id d9443c01a7336-23e25770c34mr20051935ad.47.1752647069238;
        Tue, 15 Jul 2025 23:24:29 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4286081sm119060955ad.1.2025.07.15.23.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 23:24:28 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Subject: [PATCH v7 0/2] ARM: dts: Add support for Meta Clemente BMC
Date: Wed, 16 Jul 2025 14:24:13 +0800
Message-Id: <20250716-add-support-for-meta-clemente-bmc-v7-0-d5bb7459c5aa@fii-foxconn.com>
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
X-B4-Tracking: v=1; b=H4sIAI1Fd2gC/5XRTWrEMAwF4KsMXtfF/x531XuULhJF6hiaONhpm
 DLk7nVm00BTyCyfEN8T6MYK5oiFvZxuLOMcS0xDDf7pxODSDB/IY1czU0JZ4eSZN13Hy9c4pjx
 xSpn3ODUcPrHHYULe9sCDkY1xoQWrNKvOmJHi9d7x9l7zJZYp5e975SzX6SP6LLngaKFxLiAa3
 75SjHX3CmkYniH1bO2Y1cZV8oirquvAIgkbpAmw7+qtq4+4urqglCYCMg5o3zVb1x9xzeqiJ1L
 aOAFm37UPu7a6Qp+xcyShDf/c635dLw79zVXXk0br205o7f66y7L8ANRXyaSQAgAA
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
 leo.jt.wang@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 bruce.jy.hung@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752647065; l=2248;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=W6r72LmSQKxnB3NxMfqcJSeFdWoREW67QPymehaZIA0=;
 b=8vhHKoKK7lvo1KdZwHaApUl0O8pnWGj4MKV8UhTeUKzY8y58117CJrT3tf2h2MPLhz4Nyauxa
 rwUzvGqJAkIBN6PqtnrPWjEtFfojOJfps2cVGhHxQKZkXxL9qRlMKI/
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

This series adds initial support for the Meta Clemente BMC based on the
ASPEED AST2600 SoC.

Patch 1 documents the compatible string.
Patch 2 adds the device tree for the board.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
Changes in v7:
- Relocate CBC FRU EEPROMs from i2c13 to i2c12.
- Link to v6: https://lore.kernel.org/r/20250708-add-support-for-meta-clemente-bmc-v6-0-7f3e57bd0336@fii-foxconn.com

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
 .../dts/aspeed/aspeed-bmc-facebook-clemente.dts    | 1297 ++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi    |   11 +
 4 files changed, 1310 insertions(+)
---
base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
change-id: 20250618-add-support-for-meta-clemente-bmc-941a469bc523

Best regards,
-- 
Leo Wang <leo.jt.wang@fii-foxconn.com>


