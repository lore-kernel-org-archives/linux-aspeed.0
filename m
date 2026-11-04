Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD78606A329
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Nov 2026 03:59:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKBWv5qGhz2xGr;
	Wed, 04 Nov 2026 14:59:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793764747;
	cv=none; b=deLUC7GHNGgeX6GTJKbRc6Zm1PT8BxjHN2zjNOm1KS5vF4GFYS61ARzzgCgCN03TjwD/ko9trNSIMP+H6OlgW2o+U/yR+PUeQEr2A1f9MYF4kPtElMOFYj1iWO73fxLEZ18nXRxcYhQwUlrH9W/BmNsETKbyw5La6Mn+mtb8WhEPhY9VVoUx38URQ8xQsMG3TCbihh9XoXTUIwmSpODWit04FCUA5OeMlUNP2BBejw3/KEYXdx4iJ0Qo5tzQ7c0ImU9zZXvb36nABMGUaOGlB5w5rQltv13eIL578yVxQsfcE9T0lT7przg/hXN9TbswgI0faRtMZmOMLDc0P2lD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793764747; c=relaxed/relaxed;
	bh=uBHr36LK49YQkkFNPU7jgzWwlJeQFqDRMsaYzjRg1WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gCqadtavGqVyKUKHK3UWffSLIf0JCWQA5bdAZVUp/tV6zS72kzZjMPxPQVKqUyo/wLQk5THo7aKR09j4xPO6SFHabNayp5IVmXIeLflWnxwCFBYUx95NWi7yMngkqDBfNCZ1oUbojtCS1GoCf/BBcApEqBy5JnmZRt/K7xwcQzXqhc+EEl6Smmsc6rk+PIB7CbiCxkREnjXIMme9q8E3qudAMwR1Eukt2jiD2pNEVL5rOs9aWJAngj31xlGWLo/+1VChu8s7D6tROSXewgjzKQ8IX9qZeLPouHz6zyRPAE3ncOi6VBFlJXJL4b+BOZXhh5iZOaLj4Ql3p3uk2XNOXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKBWv0Hd4z2x9c
	for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Nov 2026 14:59:07 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Nov
 2026 11:58:47 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Nov 2026 11:58:47 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 4 Nov 2026 11:58:35 +0800
Subject: [PATCH 1/2] gpio: aspeed: Clear only the acked line's G4 interrupt
 status
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261104-gpio-aspeed-irq-status-v1-1-9805645f856d@aspeedtech.com>
References: <20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
In-Reply-To: <20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>
CC: <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>, <stable@vger.kernel.org>, Aaron Antone
	<aae@amazon.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793764727; l=1851;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=TEOj7oqwxfBFK2B1FS9iy35fS31jC1PHn9rs7TGEd8Q=;
 b=A6uNk7/EeJuMSlFXFHIIuh48EZqHYrN2yYSRc2hFsh4mWw8YtVum+F4B801WohKC80pkwuaT2
 vpUwXOtKplwAr5NofnGBl7YfHRbziZzCYP0uP8WZB7Q9wLfy8wNUP6W
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The G4 interrupt status registers are write-1-to-clear: writing 0 to a
bit has no effect and writing 1 clears that line's status flag.
aspeed_gpio_irq_ack() clears a line's status through
aspeed_g4_reg_bit_set(), which reads the bank's status register, sets
the line's bit and writes the whole value back. That write clears every
interrupt pending in the 32-line bank, not just the acked one.

aspeed_gpio_irq_handler() reads each bank's status register once and
dispatches the lines that were set. If another line in the same bank
latches an edge after that read and before an ack in the bank, the ack
clears its status and the handler is never called for it, so the edge
is lost.

Write only the line's own bit when clearing the interrupt status on G4.

Fixes: 79fc9a2fcc45 ("gpio: aspeed: Create llops to handle hardware access")
Cc: stable@vger.kernel.org
Reported-by: Aaron Antone <aae@amazon.com>
Suggested-by: Aaron Antone <aae@amazon.com>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/gpio/gpio-aspeed.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index dc53b2decb66..2482f2ff735d 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1041,6 +1041,17 @@ static void aspeed_g4_reg_bit_set(struct aspeed_gpio *gpio, unsigned int offset,
 	void __iomem *addr = aspeed_gpio_g4_bank_reg(gpio, bank, reg);
 	u32 temp;
 
+	/*
+	 * The interrupt status register is write-1-to-clear. Write only this
+	 * line's bit so that interrupts pending on the other lines of the bank
+	 * stay latched.
+	 */
+	if (reg == reg_irq_status) {
+		if (val)
+			iowrite32(GPIO_BIT(offset), addr);
+		return;
+	}
+
 	if (reg == reg_val)
 		temp = gpio->dcache[GPIO_BANK(offset)];
 	else

-- 
2.34.1


