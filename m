Return-Path: <linux-aspeed+bounces-3423-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D285D72366
	for <linux-aspeed@archiver.kernel.org>; Fri, 23 Jan 2026 09:26:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dyCHW6ShLz2yFW;
	Fri, 23 Jan 2026 20:26:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769160407;
	cv=none; b=go0D1FtAVq6SiEJmqVEXiZR+NwyhbxlfV80m19zs9qPTMiZdgL5xoifTIU/9uO3FfGFTWN72LLxWLzTEdlVAjkT8vva43hodjeCu9sxWNnEkC7NlA6P1HhJmf2r6beKauNdCDniBUoT25k6GLKGkgmd6/P0uy2eyMeGec1pBg2XxIyfeE6wtvXXA06W0wOsgk2Zu9vxQyFbz3CIQgW6gDYoySM1fRqPAXEJk8d0YAU3clnrAoFnZXaTvlY8g7utxAHSNdzDiwKHv9scHbwI/xTJSzTIjbCupXxWNr06snLl4XfD/ic7spAigBwR2caTbjjgBZy33abDnoHX0BMU8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769160407; c=relaxed/relaxed;
	bh=2fbsN5ZEFZE5NcAhqQKkrKzJc628Um5uggFEdrqrp/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AwreyErGZNTAWQWc0TkYp7cKMcMZ85IDtgBmY+is2olcmHUtOO4CST48/lq3B07j1BPtYPtAIm6thVcXDlIGemYK7cV8PB/kJpL0I7jHhyv8QyKbyMBC5JIRKOuMaq5cMqB9WPuL9r8MgKO93nt6VQ86YZGJ4jv55i/Q0Wv9l1iq2g1Zk8ZYTA9pbxYlzcQ0wIWRkFFBcZOa2g5QcalhDEye0Yt+D1yFtwnYWRXFBoxCa0dTMulufL1FZWYtOgfnvvUZDqcRi1ZZ7NC+w76uteLSBYLb291gX7Ct0de7KP+ur2BUVgmpD+3vTm8w79HtuR+NGV8oOjkpf5HYRZ61Ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dyCHW2jmrz2xKh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 23 Jan 2026 20:26:47 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 23 Jan
 2026 17:26:26 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 23 Jan 2026 17:26:26 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 23 Jan 2026 17:26:27 +0800
Subject: [PATCH v2 2/6] gpio: aspeed-sgpio: Remove unused bank name field
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
Message-ID: <20260123-upstream_sgpio-v2-2-69cfd1631400@aspeedtech.com>
References: <20260123-upstream_sgpio-v2-0-69cfd1631400@aspeedtech.com>
In-Reply-To: <20260123-upstream_sgpio-v2-0-69cfd1631400@aspeedtech.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Andrew
 Jeffery" <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
	<bmc-sw@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769160386; l=1327;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=wq9nW1jVro6VbeJ8h0mIqtAis/vwp9TjCPIxWOSBwOI=;
 b=YC9UInze1Bq7V+AeVOJPr9VhTHhX2yJDKM/ZG0zONoIDK+mvEveIiX4wTrP4BEdrd5OhEcCIj
 NdxYKnFKt9TCSaNByioCJ1UngylgmFMsaNFYivrP/D/Yo7N9Gt/NNhW
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Drops the names array from the bank struct and its initializers, as it is
unused in the driver.

Reviewed-by: Linus Walleij <linusw@kernel.org>
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


