Return-Path: <linux-aspeed+bounces-3363-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8479C98322
	for <linux-aspeed@archiver.kernel.org>; Sat, 17 Jan 2026 11:17:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dtZ2833vHz2xqG;
	Sat, 17 Jan 2026 22:17:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768648656;
	cv=none; b=D5WjZrwms6gLHcBjcaSOn6op6bDBIAaq5qA7aJr4QMajrFvidY+slwWYOJvZfEp1g+l8aBIF8iPAJv0q4GM9NKPxHGm3LCe02UKWbzoQBQuyQvB7IYgwjOTb1jc47SsjbSOV5Y8QkoNpkwekjvbSV46SgbShR5w84XVI2iLe7HuvsjtArPOd7qP6pwGrD2f0RJGcWFlNAfk8Y5L5PedFvEpHo6TXmgqqNLW/lZAj2Mu5a2p8ofdOv/ZHoyI+FRZfEEcxOYdO2H5+RtwBAFTc+LB66abtyr3O4RL9+FH2OpfQdKQoEsKQBnAdMadmvNGTNNWyH4cQQB2z36OAvpV0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768648656; c=relaxed/relaxed;
	bh=UqXmybD3x03P7F050HBrnsOHdBxZN/YeJhML1v7mXgs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=RyNT4f69DkaHqDNEITYxq7yI5OuvfUhsXarOgoLrAASCFU74HcBUrGYC0KrzC/yzgJXnCYXXEYXEF06Ut4GBl8tO/Y+g6izzvwxEe2T4OLYOTqXRVwVNU2TC4dd93AwVWzOt9RZwm3RAXU4Rv5FMino9tX0K/eVWBhq5phNVZuzsuOzIvm/WrGzkg42KyILJdyXz7hZwYO1lCHE4aShRiNUGi6MCRVCWjGCNyicQYkFfZZmQ+1nBRspwj8kEQnWrnUsqQYlg1oVCyl2ML98+hv5Ji/acsTWTJD8Sj4EZ34iDrcDe8EIOjtQnHX77S892u4LS55qwx3Bm588oIaS+Ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dtZ273J4qz2xS2
	for <linux-aspeed@lists.ozlabs.org>; Sat, 17 Jan 2026 22:17:34 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sat, 17 Jan
 2026 19:17:17 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sat, 17 Jan 2026 19:17:17 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH 0/5] Add Aspeed G7 sgpio support
Date: Sat, 17 Jan 2026 19:17:07 +0800
Message-ID: <20260117-upstream_sgpio-v1-0-850ef3ffb680@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIALNva2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIyNj3dKC4pKi1MTc+OL0gsx8XXODFAtD02Qzk0RDSyWgpoKi1LTMCrC
 B0bG1tQBUzvydYAAAAA==
X-Change-ID: 20251223-upstream_sgpio-70d815c64a19
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Andrew
 Jeffery" <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
	<bmc-sw@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768648637; l=1293;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=syKloVSJGr/1yuFRDdDYloNrIqJLgRzrsOb/bxn/5bY=;
 b=72wgdRhf4CDRIKM/L9ALE3tUal9GCgSr0Cm0kA96rAZOo2xGE3onq/yk0CwAszlTsr6znYAYR
 z2pPD9SNsdMCltfNKlV45uuE9G7UfKwWHVtooaYXto0ujaarpHgbHY8
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The Aspeed 7th generation SoC features two SGPIO master controllers: both
with 256 serial inputs and outputs. The main difference from the previous
generation is that the control logic has been updated to support
per-pin control, allowing each pin to have its own 32-bit register for
configuring value, interrupt type, and more.
This patch serial also add low-level operations (llops) to abstract the
register access for SGPIO registers making it easier to extend the driver
to support different hardware register layouts.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Billy Tsai (5):
      gpio: aspeed-sgpio: Change the macro to support deferred probe
      gpio: aspeed-sgpio: Remove unused bank name field
      gpio: aspeed-sgpio: Create llops to handle hardware access
      dt-bindings: gpio: aspeed,sgpio: Support ast2700
      gpio: aspeed-sgpio: Support G7 Aspeed sgpiom controller

 .../devicetree/bindings/gpio/aspeed,sgpio.yaml     |   4 +-
 drivers/gpio/gpio-aspeed-sgpio.c                   | 364 +++++++++++++--------
 2 files changed, 228 insertions(+), 140 deletions(-)
---
base-commit: dd9b004b7ff3289fb7bae35130c0a5c0537266af
change-id: 20251223-upstream_sgpio-70d815c64a19

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


