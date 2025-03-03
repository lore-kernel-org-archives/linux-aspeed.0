Return-Path: <linux-aspeed+bounces-912-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387E7C282D2
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 13:18:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5zsr6hcgz3bld;
	Tue,  4 Mar 2025 00:18:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741007936;
	cv=none; b=hjbR2hyR4y2WAemAqplOC7RBZD79aKkenucBNA80jakd1wD4ubSbPUMQkIRO776nAnD37opN0h+1QGc83079iQRjhQgwqpMgXkLHheLGDty81uaMxoPKyf/VkplBvxsrD4I4EHmyi1nvCZtgXA3AEJrbX8NJ/9bmdd+PFRrqrIy04+Pp7ZHzXM3EnZe4A78f6G29KmnkAHVDzYcwSKdxzfg2GhmUABCiKhPq+HgKIL1XiIKYcS0isJQF6LXR+kSLO3d0qDGKUB/hSw04dWELkBkQtVdkr8cwBetWBVUlvDg7q3gsH9PgtuQakd6p+vSVHxcm7joEbNO+qmISZhP5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741007936; c=relaxed/relaxed;
	bh=9Mna2g5kGAQGbITypIOAf332guWttEFjYKfE+wICzl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mPiqqx5doM/7odWt4chduDltV4nDdmrqB5EyJTSw0ylfE/mW/9UYpTNS+JKESvdBLGnDHNSvOe1mGiK8JhIstV8F8qch/7aRz3iy8j3vuy2jTHcUj1KrExxpd+ZCRGDs3wXZ0Czey/HiITPJePRXcnbRW6ZncHePlog4wezSs2qdd5hPEPE5iYOlaN/lB24Vur6dpDLNolCGRFCs5GhDPHE7fftteDBIayTJ+VLciE6zxDnPnFbTy2hxiFrHQPNexY0s7u6te8W6ayCdaOagGp5s8X7hnYbs81pE6Qo38jkWT+85FTpwA3g2NIGb65O1v9yMHvTnGiAiT/fhkPe9hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=szRQAgr1; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=szRQAgr1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5zsr0PHBz3blK
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:18:55 +1100 (AEDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-43bbd711eedso9766305e9.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 05:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007933; x=1741612733; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Mna2g5kGAQGbITypIOAf332guWttEFjYKfE+wICzl8=;
        b=szRQAgr1Pri6fATBBIMgPqKJgggG9yDpJNxdmJlGSI14ngp/nVdBKIsC8JvWYvnDSE
         Jus0KUlmsmQt/AotwB6jl8r31kJJbIdmgxWtkNKmkN3SWiFjBPg7escst9c/6pJkS5pc
         Eok/45h7T40BkueOlVHcIkE4rs7/OQcezJ/qqnKFzVJI4pL8nOtJrc0k3RDgtiLcxnm1
         hWlqt7umK8NxSOvz8d15TlSBds4v6wGkg6WEQSF6nFtbYyZ2o1pKt04UUxsU9LUfx4B6
         nuQRspEN8an4+TrkBWzJlr3OV8UZJpQHfbbJ0JmtAT2+J3CsCbfsomMMfRrSn4EwsBKx
         DCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007933; x=1741612733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Mna2g5kGAQGbITypIOAf332guWttEFjYKfE+wICzl8=;
        b=vcp9zprgnUuvL/rPtoj6P4rzMpN2rrN6PoDS+g3MRDqZm+mUV8/48FZY/NJXu19sCx
         c9S7J6LVJgkhjkr+o9RRcfCqqUngvOVLXfv7FSE6I43GnZx8KTdyj7Q4jUG0/DbmDqYS
         J//90glUJhTKXekwLT+226YZgYtyhK6v8XqBYP59apZvUeB6H0j8tVYmIwsvvHiA6xhB
         g9twt164ZNrmJEdxm4KCCzOEyfat0aLzBuuh0g/xG2VAMR1H1NfS96R79lXtLk+Uaw+6
         8q98hX9tBfpiWE1pzXrNFZFrUi5iuiwo2Iel3IxPP5abdOdz0lmki1O7UyTnWcY0m2zY
         DW6g==
X-Forwarded-Encrypted: i=1; AJvYcCVuJa1fA7xWeOD6tIaN0/wy+wCjUkqUB8szZxKj326u0lOoPaqyaMaAMN54cLrexX37Nntc11GYxfEMnkc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyefr59mih61QUf7s9o9ZxAP8II637m1iro751M5VVnkOwLiHRG
	+Ld05PZP/oLLCt7tjMwb4pQoiab4Cj4UACEdLRfgTsEmR/rtTZ77cmKvqSdXKI8=
X-Gm-Gg: ASbGncvm5zBTQ1MRSOH+AIJO99Z0nxlBWM1ZZOCNLfEuuYkb4f2mN/P/OZi2s2/47da
	BtNxyW/j6h94/LoCys2GHSVpo5X2gGO0OIj8EWdbvY3L8lS6CMKL6jvVXEG6514koQrp7v7yRnq
	5q3YSSZlTx22vjGIfeOOWeji9Nksi2CF/tYUl6SxtGix3zmYD+xHXAuYWOiKUznsbuArvTF6LH/
	F75rp4VfJEdsyZh6ZlvJbRDfzK6/Rko4w04Vz4uB/nhZu3uwjhLQF/1K/3ru+PwdJWKRrJjUO27
	ARB4P3P4JVZLCuJ2Az66pOLD6GypuukgfwfgvA==
X-Google-Smtp-Source: AGHT+IFY22PCA1a2+aN5bDi5iCcPupeWgrWRYBU3OAd6qR1uqfM8OPw60ciFVK/sAA1n6Y60dhPpwQ==
X-Received: by 2002:a05:600c:1392:b0:439:88bb:d002 with SMTP id 5b1f17b1804b1-43ba6727b57mr103602005e9.23.1741007933166;
        Mon, 03 Mar 2025 05:18:53 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:52 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:39 +0100
Subject: [PATCH 14/15] gpio: aspeed-sgpio: use lock guards
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-gpiochip-set-conversion-v1-14-1d5cceeebf8b@linaro.org>
References: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
In-Reply-To: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mun Yew Tham <mun.yew.tham@intel.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5780;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=0qXZl4P6oay9QYtQck71x8HYJPy63jgVqg/jPZp1JP8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawsJBgL9NLW7b7FCtj23bKQ2kGRMqw9cfP5j
 kWw5bq4/RWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsLAAKCRARpy6gFHHX
 cjEGD/9I/yPodJyzCvoLyTdAs9s5HAxWXV840R+OGBpnA+oBXEY0FEbNiwC/ZRm6SNhGJrpxwfM
 0Cw6Nxab1aIHNmI/IkLcksuG5r8U++V+RfblyWmsofiye6Cjmi2k1JY8NHPqGNfxGHSCi05c6hr
 +o0YH0h4Pkb/XCzt7Xrp9gQxm14ttMk9AnxYSEj8KT53aCRaiacOJeAueSocxP/0plWhJWnLBlE
 udhOpcnmP2QDd3bu2veRGB05Tb3mO8juN5L0ClWpZH7vfWmJ4tGxo6CLQ/BJCbctfAzExS6R+8Z
 wrisMCfrjV1zNfFfgvEC9iQXHEXeprwQA+LPKEdM8uUK7wsSIaNYRhgCH2zKOv3tfd84zaa04xA
 VHJ6Si4eURMZ5f5J26a+xy6d9LHe7hM6r4zG/yOurvpFt5+UdpPnB7K9tC0AtobOSf1nYMXu/Sx
 xSgB2mwmYmf3UgO0RE9yimPFnwaA4+Q6rMb2bSyqnKDIC9RbqCYCdO0fqjgz0zaWogldF2563Pc
 rqMkKNXgx38lLXc1hXAjdiEn5FsrcnratZRfM72ETy/jHE1TjvODlvn4UVeKvQg1+yYmrtuOnZ5
 D9tcdNqZ961mLhWwMoF//HwFYaND3V9NpBfENgdDRuf/cQg9XmRLHJDhqH0uqZ+Ah5XIdxt1iBe
 e56xOZfdkwuJ96Q==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reduce the code complexity by using automatic lock guards with the raw
spinlock.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-aspeed-sgpio.c | 76 +++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 47 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 34eb26298e32..5ce86de22563 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
 #include <linux/hashtable.h>
@@ -170,17 +171,14 @@ static int aspeed_sgpio_get(struct gpio_chip *gc, unsigned int offset)
 {
 	struct aspeed_sgpio *gpio = gpiochip_get_data(gc);
 	const struct aspeed_sgpio_bank *bank = to_bank(offset);
-	unsigned long flags;
 	enum aspeed_sgpio_reg reg;
 	int rc = 0;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	reg = aspeed_sgpio_is_input(offset) ? reg_val : reg_rdata;
 	rc = !!(ioread32(bank_reg(gpio, bank, reg)) & GPIO_BIT(offset));
 
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
-
 	return rc;
 }
 
@@ -214,13 +212,10 @@ static int sgpio_set_value(struct gpio_chip *gc, unsigned int offset, int val)
 static void aspeed_sgpio_set(struct gpio_chip *gc, unsigned int offset, int val)
 {
 	struct aspeed_sgpio *gpio = gpiochip_get_data(gc);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	sgpio_set_value(gc, offset, val);
-
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
 }
 
 static int aspeed_sgpio_dir_in(struct gpio_chip *gc, unsigned int offset)
@@ -231,15 +226,14 @@ static int aspeed_sgpio_dir_in(struct gpio_chip *gc, unsigned int offset)
 static int aspeed_sgpio_dir_out(struct gpio_chip *gc, unsigned int offset, int val)
 {
 	struct aspeed_sgpio *gpio = gpiochip_get_data(gc);
-	unsigned long flags;
 	int rc;
 
 	/* No special action is required for setting the direction; we'll
 	 * error-out in sgpio_set_value if this isn't an output GPIO */
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
+
 	rc = sgpio_set_value(gc, offset, val);
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
 
 	return rc;
 }
@@ -269,7 +263,6 @@ static void aspeed_sgpio_irq_ack(struct irq_data *d)
 {
 	const struct aspeed_sgpio_bank *bank;
 	struct aspeed_sgpio *gpio;
-	unsigned long flags;
 	void __iomem *status_addr;
 	int offset;
 	u32 bit;
@@ -278,18 +271,15 @@ static void aspeed_sgpio_irq_ack(struct irq_data *d)
 
 	status_addr = bank_reg(gpio, bank, reg_irq_status);
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	iowrite32(bit, status_addr);
-
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
 }
 
 static void aspeed_sgpio_irq_set_mask(struct irq_data *d, bool set)
 {
 	const struct aspeed_sgpio_bank *bank;
 	struct aspeed_sgpio *gpio;
-	unsigned long flags;
 	u32 reg, bit;
 	void __iomem *addr;
 	int offset;
@@ -301,17 +291,15 @@ static void aspeed_sgpio_irq_set_mask(struct irq_data *d, bool set)
 	if (set)
 		gpiochip_enable_irq(&gpio->chip, irqd_to_hwirq(d));
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &gpio->lock) {
+		reg = ioread32(addr);
+		if (set)
+			reg |= bit;
+		else
+			reg &= ~bit;
 
-	reg = ioread32(addr);
-	if (set)
-		reg |= bit;
-	else
-		reg &= ~bit;
-
-	iowrite32(reg, addr);
-
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
+		iowrite32(reg, addr);
+	}
 
 	/* Masking the IRQ */
 	if (!set)
@@ -339,7 +327,6 @@ static int aspeed_sgpio_set_type(struct irq_data *d, unsigned int type)
 	const struct aspeed_sgpio_bank *bank;
 	irq_flow_handler_t handler;
 	struct aspeed_sgpio *gpio;
-	unsigned long flags;
 	void __iomem *addr;
 	int offset;
 
@@ -366,24 +353,22 @@ static int aspeed_sgpio_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &gpio->lock) {
+		addr = bank_reg(gpio, bank, reg_irq_type0);
+		reg = ioread32(addr);
+		reg = (reg & ~bit) | type0;
+		iowrite32(reg, addr);
 
-	addr = bank_reg(gpio, bank, reg_irq_type0);
-	reg = ioread32(addr);
-	reg = (reg & ~bit) | type0;
-	iowrite32(reg, addr);
+		addr = bank_reg(gpio, bank, reg_irq_type1);
+		reg = ioread32(addr);
+		reg = (reg & ~bit) | type1;
+		iowrite32(reg, addr);
 
-	addr = bank_reg(gpio, bank, reg_irq_type1);
-	reg = ioread32(addr);
-	reg = (reg & ~bit) | type1;
-	iowrite32(reg, addr);
-
-	addr = bank_reg(gpio, bank, reg_irq_type2);
-	reg = ioread32(addr);
-	reg = (reg & ~bit) | type2;
-	iowrite32(reg, addr);
-
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
+		addr = bank_reg(gpio, bank, reg_irq_type2);
+		reg = ioread32(addr);
+		reg = (reg & ~bit) | type2;
+		iowrite32(reg, addr);
+	}
 
 	irq_set_handler_locked(d, handler);
 
@@ -487,13 +472,12 @@ static int aspeed_sgpio_reset_tolerance(struct gpio_chip *chip,
 					unsigned int offset, bool enable)
 {
 	struct aspeed_sgpio *gpio = gpiochip_get_data(chip);
-	unsigned long flags;
 	void __iomem *reg;
 	u32 val;
 
 	reg = bank_reg(gpio, to_bank(offset), reg_tolerance);
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	val = readl(reg);
 
@@ -504,8 +488,6 @@ static int aspeed_sgpio_reset_tolerance(struct gpio_chip *chip,
 
 	writel(val, reg);
 
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
-
 	return 0;
 }
 

-- 
2.45.2


