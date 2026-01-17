Return-Path: <linux-aspeed+bounces-3365-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208ABC98323
	for <linux-aspeed@archiver.kernel.org>; Sat, 17 Jan 2026 11:17:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dtZ295Hknz309S;
	Sat, 17 Jan 2026 22:17:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768648657;
	cv=none; b=mTfMbofEDx8TQgGRWuxq9lSJwOpdCQU3diGBNuJkJANNghtUyBQPGGnKo/ckUp+n7gBBXdePaYxxRXH2uEpEhJBpOQz6o5YOkcU6vagT9ToUp9bPixIhdkTpBZXtkZ5ck7OZWcJqj1cG7ISnylCV+HJYI1nLzDhfo5P1tlwkf14A1pnsahACkZaeaSTWqhGGCh1rhJJBqBdni7ogi4av/gmnQs37PB9+cdSJSahQO7pg7wmx1X2OnLAoD+/jDN/mBmnPD11AamMxPYOLSJymTt0wZXs0X6O6QarC6b0QDrFjZWYhTiNKWmVK4cEVI0PR2XdHr1NPoTpThtLCqi8KgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768648657; c=relaxed/relaxed;
	bh=31I21V0ZLQuFhsYu4By5pECArDesghza00F1thw3Ido=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dZjdOvGnOO/hKu7S4akBoUNdE5V9qdhAtGrrK9KlC7jIrmI6fiq+4Ata05G+E/fhRnIEVV+VRznOMeYzX3e9Qd07iIuGKNTvBmyeBB7M5XNQDbj5E+kZR63Oeb7gWUd7PuBsgJ84MTSQEO06LaQ5muK46xFrrOr3Imf7PVbtITKMsMwP4qtZ6zlbIy4vMnWlbieibJFIURWPAv8fL9lp+avdi8QMSoEsihiLU5RTktoxNJZfcLyU7yBhTb0ZbuzzURCyEsT6hJ/USESTsf6PSUte0w5G1EweQrEyca4nGYtktzbseWFMjlmdfHI1tErptaFjyshvbe5gl9XKcZ4DhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dtZ291RwMz2xS2
	for <linux-aspeed@lists.ozlabs.org>; Sat, 17 Jan 2026 22:17:37 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sat, 17 Jan
 2026 19:17:17 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sat, 17 Jan 2026 19:17:17 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Sat, 17 Jan 2026 19:17:09 +0800
Subject: [PATCH 2/5] gpio: aspeed-sgpio: Remove unused bank name field
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
Message-ID: <20260117-upstream_sgpio-v1-2-850ef3ffb680@aspeedtech.com>
References: <20260117-upstream_sgpio-v1-0-850ef3ffb680@aspeedtech.com>
In-Reply-To: <20260117-upstream_sgpio-v1-0-850ef3ffb680@aspeedtech.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Andrew
 Jeffery" <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
	<bmc-sw@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768648637; l=1279;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=SKQ0UCfpVZsXx1vqEVOZz/+nmvbJAsfFSAPsnOZxtWk=;
 b=k2LVCG2VagQD1eIDaRMgFRwUurzQ/Cu9gfgS0o7/bRo9EEg1cVDQLuXQVxNFVa9668aEDQGiM
 v1qVLcFLYU2A7S/oafjJLDbd7aJj7CZ/YNHfOOIZlxD/6wjXE3hp/RQ
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Drops the names array from the bank struct and its initializers, as it is
unused in the driver.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/gpio/gpio-aspeed-sgpio.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 318cd0e39741..a96ed6d8a55d 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -43,7 +43,6 @@ struct aspeed_sgpio_bank {
 	u16    rdata_reg;
 	u16    irq_regs;
 	u16    tolerance_regs;
-	const char  names[4][3];
 };
 
 /*
@@ -59,28 +58,24 @@ static const struct aspeed_sgpio_bank aspeed_sgpio_banks[] = {
 		.rdata_reg = 0x0070,
 		.irq_regs = 0x0004,
 		.tolerance_regs = 0x0018,
-		.names = { "A", "B", "C", "D" },
 	},
 	{
 		.val_regs = 0x001C,
 		.rdata_reg = 0x0074,
 		.irq_regs = 0x0020,
 		.tolerance_regs = 0x0034,
-		.names = { "E", "F", "G", "H" },
 	},
 	{
 		.val_regs = 0x0038,
 		.rdata_reg = 0x0078,
 		.irq_regs = 0x003C,
 		.tolerance_regs = 0x0050,
-		.names = { "I", "J", "K", "L" },
 	},
 	{
 		.val_regs = 0x0090,
 		.rdata_reg = 0x007C,
 		.irq_regs = 0x0094,
 		.tolerance_regs = 0x00A8,
-		.names = { "M", "N", "O", "P" },
 	},
 };
 

-- 
2.34.1


