Return-Path: <linux-aspeed+bounces-1597-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14308C83013
	for <linux-aspeed@archiver.kernel.org>; Sat, 28 Jun 2025 01:56:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bTbB2339wz306l;
	Sat, 28 Jun 2025 11:56:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750993192;
	cv=none; b=YnOsZd5B0NBvnkkCZ61+Fdbfxa8jVm4UNA6FiPdu4075cbsicKQl5wAbXQyNjz0h9a20STkM9/XJcU+59bM+jSlQWTu5HN0VNBGRWz8K7CcTQIkkaA/Qt5e+nh7Wm4y/taJjML/ZSE+YrRyWubtBZ4CF36V6hTeE+C3mUDPa0rPqF1pTrRnYcXVwDrswA51TVbSJhWuN3/ZUJxtKIzc8FLSeO8YVfzNx7j3WmjxlMYjiNGHWLl+wXC945i8tz9LKYkJ5CoUgzegvgSA/reU1RZP9FQuRwXIA/DpVsTooVHHWbv2jtm/dsQmGwJaRLVgweVYSpQfF/iUCWZxlGwPUCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750993192; c=relaxed/relaxed;
	bh=UM8inYvwxYcJMQtjXe+UEuLSqBg2GM1eujKN8koXR4c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GPt/tFsSSUJvCYYxCSx58yO6ln4W2QTp50TKgyAKwJ0wPbPbh+rnn4neR8/J46LbWnvECStBQVQCVsWSLnparxn5wG7MS9ngZPplShNVLKTO2FFuJng0s6cUnOXCOVGmw8QbAydcRYKY3mJMsN4fXshBGLFYpMRZ0x9r1vxNwG3Aa+tilPBR4BToI2BeC8I7ch0PiI5xEVzTrdQrDc6rpNly3LsEAm9wtVOHZTFdyCMt+NVr7ymuAAm1cP6aHC12utAeqG6PoAzJGK/0AoDZ6TGb8AeWLm//MCzG6EGsC/Qsz2GeDc6KUNqHYC1PEvjyGIdHvduNXbXXlHkIXNdf4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=I9E0xSHo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=I9E0xSHo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bT0dy3N8Bz2xCW
	for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Jun 2025 12:59:50 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-b31c978688dso1006739a12.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Jun 2025 19:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750993187; x=1751597987; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UM8inYvwxYcJMQtjXe+UEuLSqBg2GM1eujKN8koXR4c=;
        b=I9E0xSHoC35qHF40pDHjJwZaMcLZlrJInc9xJeii+HSUwzxeWub95xg0Bt4eS/bBhF
         viix9NzJr67/bj7YNDV9frWwIDcdN1ZmLnHK+tUvIM4z1veSlxg81NquqRFQUtZnpFeY
         09C9STGgBym5ynB82DGZh0/8Fl0+1abIxgPcLpM175VbABshWtgyl4M+dpxO/KgNeBP4
         FxeIKW2PP1ecI0VythnAEUdfOysrjcP65KJKJ4GBrEaTSapSrkLgw6H1ohCfgVPlPnNY
         VxEVSMkYzBm3HvLSVlZFKilbbpY5IzBosDV1jQFtgR9Ncx1lBkoyaJSHY2WBU1GGUcwt
         m25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750993187; x=1751597987;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UM8inYvwxYcJMQtjXe+UEuLSqBg2GM1eujKN8koXR4c=;
        b=q7T6bBmcIeZ/jxZvu330h+QFy/UcKdSf1kdIDDta5Brqnj9+UO1ktpBwAE20fmmtzr
         PreOrOy6x7FbYbPaFlBpbK+TqnqCZtpdBWvFLXl6/05bTsW6sfX4XRZ2vMZRq97q574z
         tc4CF6X6n/pyESwAVRXhTVTHXYSyybyGFrnMaAHQJl5TvU5LGcd16P9zr/8HCb9IpZK4
         DbLZyT8qw93UqujPb2synBz8gqzGD8Ut/ZvuHzr3SrHR5DevBzl5gyGk5SQ6ukYMFf2L
         nd3oGCZPVF5gGG7yBbcVVNBWIz0BpW30QBLXgz8rJLTglg6FW1zNYEe73Vk2smeSgazk
         6vNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6wXMB3NTkmd8hWRbDmC8PMIPUYiwyYb6TuuAqYiAYSmigDcUFlnBisvzHJC7MLfKMHPJhXKJQt7cHgKg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw4xhzwZQSsUd27lgsUdo57Kn3gdhrl/ZYs5se+K9khp3ZDYAjv
	pWjUYi7lno9VZF+FXvE5EWu2LqDp1UAVcj+CZORNHXG1U7JQPIfeuXOx
X-Gm-Gg: ASbGncvGNoEfi1/yJOMA1TgK6wUzO46hln/q9ojNyVZA8ZA1iOgLmNR0kBIraXxtxNe
	z8oSj/Yio1BdD3kRnVVqoXTrdrKZZrNWL5j7YgBUYawxxOFBpba7FnEHfFwXMpLouprL5lH3WBr
	nsCMSYHmNMmFVhhxtllfnLCupFfJFHsUSqt06qPdARCsQgSLFMlzbCFovLpFPHlsOJscMAdSsLc
	7gmWAEiQNKrclDKlvjuzwA30uK3r3ocln8EFZr6jzV6vLapLtQLslyNT7zkq3NK8I5e4uryKGse
	x7pY91W1InyvhYRWAX7rcJw/qGJVJT+3buWQujXPjcqW/y2GM+KdtFeJpSBBKHQZBu9G4pLKVpq
	BR0WieDgGyUu4UKQE1m5L3Tq7VvPFe9eQpa0LHEWRrg==
X-Google-Smtp-Source: AGHT+IFoDN8qLfLeTBIPOwa7sPJd2PCjUeJWH1WcwtLhHFRMtIYH77B3tlxBJ9aajx0wAOSTXR2YVg==
X-Received: by 2002:a17:90b:58ed:b0:312:e6f1:c05d with SMTP id 98e67ed59e1d1-318c8eb9aa8mr2246427a91.2.1750993187197;
        Thu, 26 Jun 2025 19:59:47 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5426bd9sm5358186a91.27.2025.06.26.19.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 19:59:46 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Subject: [PATCH v4 0/2] ARM: dts: Add support for Meta Clemente BMC
Date: Fri, 27 Jun 2025 10:59:01 +0800
Message-Id: <20250627-add-support-for-meta-clemente-bmc-v4-0-ce7ff23460c4@fii-foxconn.com>
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
X-B4-Tracking: v=1; b=H4sIAPUIXmgC/5XNTQrCMBCG4atI1o40vxpX3kNcpNOJBmxSkloU6
 d2NrgRd6PIbhue9s0I5UGHbxZ1lmkIJKdahlguGJxePBKGrm4lG6MbwDbiug3IZhpRH8ClDT6M
 DPFNPcSRoewSruFPGtqiFZNUZMvlwfTX2h7pPoYwp317JiT+v/+gThwZIozPGEql1u/Mh1N8rp
 hhXmHr2bEzizRX8F1dU16Am32jLlcXvrnx35S+urC4KIb1Hrwz6T3ee5wcuQsH3iAEAAA==
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
 bruce.jy.hung@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 Leo Wang <leo.jt.wang@fii-foxconn.com>, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750993183; l=1697;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=iElNKH47dFr7cEuSYr/PXBozji92kqyZzzl41GE5XUw=;
 b=PxQX6epia39JyezSIwOl8kvO2UxGdecuVsTKr4L1dZkZzWZeGL1DCZ7IW5u4C0IWWbswU/k6N
 GYEeJIqGln7ClrW3occr47U7J5jPhyR2KsFaWdL/lSbiymy2AXmpYGn
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

This series adds initial support for the Meta Clemente BMC based on the ASPEED AST2600 SoC.

Patch 1 documents the compatible string.
Patch 2 adds the device tree for the board.

Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
---
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


