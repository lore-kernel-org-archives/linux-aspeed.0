Return-Path: <linux-aspeed+bounces-3425-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787ECD72350
	for <linux-aspeed@archiver.kernel.org>; Fri, 23 Jan 2026 09:26:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dyCHY3NKcz2yFl;
	Fri, 23 Jan 2026 20:26:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769160409;
	cv=none; b=IuNo/dxaai7KWi3uEDly8mvVcXR2gfEg3e6htlz3giToug3+NFO9gQqQipZCpWpyGC4tTqagpPIYQVpOxwykC/JJKRauf5mn5OPZokAiimUdXcjFqQIBri8haH3zVlmLtuAIIo/ZDTBZuv6czG494lEQLB7gQppllkfvqklc8HZLEcjsE0A/8jOKobd7r6LsCLZ7M1V9DJu9KYhh4MDzcKl0fag4nXXuyphRdFfFgLVXXAlqNEt/v8KaJtam2XUVAMGPonMXhbn5lAO87pGuysyUJ+o+LnSzoqjAKJd9G3Dhfhkmi9MjoyXWdgYPrv9t0Hx2QHRFiNaTtTFDhPzjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769160409; c=relaxed/relaxed;
	bh=Puv5oNZqLB4wAfJKKQOHYNLUVrHspWeFYFzRA8QbBT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cEDNkL5HzLJd1L9cOC3I2D4yDhSiYPslloeJzMyQGE85F+F0JGbdwLrAcz9MBRJ103bkpr+LOCak9WLSXSqCQ9MUpWm0mNh84e0WrK8Q5eQ0Exe46XSmpsBsQGlxQERNhnKSkLzKxhRwVBgHsxitlBhpnytWQsBYbPrvI5t8zJ4azAjsJVBBrCG0V52CgpYVbVdI5GWdKzypR4qTi8ZGbDjGSGPXYunsg0OaJgtDJxiiL0KUBsMnUDjWvGGG2Q1ehCH7QjGNi/yqkaJtU216huS5YDXX6dUJwLmGLlf/f7Z5mS9iw/MAzaTB1Hpx5qBPPuh7Y0NgnxIvWh/RNA4pqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dyCHX6g6Pz2xKh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 23 Jan 2026 20:26:48 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 23 Jan
 2026 17:26:27 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 23 Jan 2026 17:26:27 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 23 Jan 2026 17:26:29 +0800
Subject: [PATCH v2 4/6] gpio: aspeed-sgpio: Convert IRQ functions to use
 llops callbacks
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
Message-ID: <20260123-upstream_sgpio-v2-4-69cfd1631400@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769160386; l=3203;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=Hl9LdLVmaEDP86aDOaXmV5qwrfCQGY8Vf57r/K2vfGo=;
 b=K5o16m1x6dewUe7aGBZCQd8VhK7H5qvqCsuX/OtBs3wmUEm1li/l9HmMHp3sC1i6NAm2bdliC
 pd+fJU5ZViyAfNRcAtJ7kLlypsitiC5xTGENG39S2WcBt/1oECAdTz9
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Update aspeed_sgpio_irq_handler() and aspeed_sgpio_setup_irqs() to use
the llops callbacks for register access instead of direct iowrite32().
This creates a unified hardware access layer, which is essential for
supporting SoCs with different register layouts like the AST2700.

Additionally, change the loop bounds to use ngpio instead of the static
ARRAY_SIZE(aspeed_sgpio_banks). This allows the driver to adapt to the
actual number of supported pins on the running SoC.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/gpio/gpio-aspeed-sgpio.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 33a830ea7d28..b5270e11b153 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -319,12 +319,13 @@ static void aspeed_sgpio_irq_handler(struct irq_desc *desc)
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
 	struct irq_chip *ic = irq_desc_get_chip(desc);
 	struct aspeed_sgpio *data = gpiochip_get_data(gc);
-	unsigned int i, p;
+	unsigned int i, p, banks;
 	unsigned long reg;
 
 	chained_irq_enter(ic, desc);
 
-	for (i = 0; i < ARRAY_SIZE(aspeed_sgpio_banks); i++) {
+	banks = DIV_ROUND_UP(gc->ngpio, 64);
+	for (i = 0; i < banks; i++) {
 		reg = data->pdata->llops->reg_bank_get(data, i << 6, reg_irq_status);
 
 		for_each_set_bit(p, &reg, 32)
@@ -355,7 +356,6 @@ static int aspeed_sgpio_setup_irqs(struct aspeed_sgpio *gpio,
 				   struct platform_device *pdev)
 {
 	int rc, i;
-	const struct aspeed_sgpio_bank *bank;
 	struct gpio_irq_chip *irq;
 
 	rc = platform_get_irq(pdev, 0);
@@ -365,12 +365,11 @@ static int aspeed_sgpio_setup_irqs(struct aspeed_sgpio *gpio,
 	gpio->irq = rc;
 
 	/* Disable IRQ and clear Interrupt status registers for all SGPIO Pins. */
-	for (i = 0; i < ARRAY_SIZE(aspeed_sgpio_banks); i++) {
-		bank =  &aspeed_sgpio_banks[i];
+	for (i = 0; i < gpio->chip.ngpio; i += 2) {
 		/* disable irq enable bits */
-		iowrite32(0x00000000, bank_reg(gpio, bank, reg_irq_enable));
+		gpio->pdata->llops->reg_bit_set(gpio, i, reg_irq_enable, 0);
 		/* clear status bits */
-		iowrite32(0xffffffff, bank_reg(gpio, bank, reg_irq_status));
+		gpio->pdata->llops->reg_bit_set(gpio, i, reg_irq_status, 1);
 	}
 
 	irq = &gpio->chip.irq;
@@ -384,14 +383,13 @@ static int aspeed_sgpio_setup_irqs(struct aspeed_sgpio *gpio,
 	irq->num_parents = 1;
 
 	/* Apply default IRQ settings */
-	for (i = 0; i < ARRAY_SIZE(aspeed_sgpio_banks); i++) {
-		bank =  &aspeed_sgpio_banks[i];
+	for (i = 0; i < gpio->chip.ngpio; i += 2) {
 		/* set falling or level-low irq */
-		iowrite32(0x00000000, bank_reg(gpio, bank, reg_irq_type0));
+		gpio->pdata->llops->reg_bit_set(gpio, i, reg_irq_type0, 0);
 		/* trigger type is edge */
-		iowrite32(0x00000000, bank_reg(gpio, bank, reg_irq_type1));
+		gpio->pdata->llops->reg_bit_set(gpio, i, reg_irq_type1, 0);
 		/* single edge trigger */
-		iowrite32(0x00000000, bank_reg(gpio, bank, reg_irq_type2));
+		gpio->pdata->llops->reg_bit_set(gpio, i, reg_irq_type2, 0);
 	}
 
 	return 0;

-- 
2.34.1


