Return-Path: <linux-aspeed+bounces-910-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9ADC282CD
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 13:18:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5zsq2LH8z3blk;
	Tue,  4 Mar 2025 00:18:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741007935;
	cv=none; b=C3SMR7sgK6AAlLUsbR/k4BZc8tQy4m/QpDPiE1ErtwP0N/u53QsiZ8Ldlgt6D4MyLZbZY5IqgG4XkA7jMONJ/vY5sy28XQPoYnuKaI4xQlb0rFU5NaBvC93/izbJ84ZCIiYTYmZvf+zGiSTPacqgRD5vyS+g7WcK+mv8axx3WZmItOj4if5XM8LnHFckWe51+h3xDF2hdK+uhX38ZNkyMctSeOUHVcfLRtPAwn99I5qNHAjx6HYFzA1HDVSqit3fP6wD0IDLvCcu7DYeIgyHMa38mmo70IZ4FfNNtbnEK9rop5dGHiGbWH+jg0e6qoOu9+rTPlUhbibcq6/FKVB5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741007935; c=relaxed/relaxed;
	bh=lfos9Syg08SqOn+//RWYzG2n1+EfVqjsyXohmBPCw+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mqVbgyI92Nqpi8WfnuKTdpDZQ1UUWDBQMRECF59KPYtQoEg0XUqJ3Uf/yCR+Z9ZecJrCE6b/afMkxjzZt1thhV6Sn0EHDTsC4M+RaExmR8K2h0BlAKbhh/s55Ybin1HkE8dWa1sLOMQKd+n4K/vUSET+8NRlnTibhF2uuQlcwtjlNeC13eU9z+H7UZL4XzpRVsjGXHQlXfQACUDkyOfVZk7ityqH3guoM+zro2v43EHZ6Qrss+UIYNUpyW3vNLNHZBuzqST5U/GCe+80xZoFDV1i+FpCigQGx0+MoVl44IMGJo/UyKwk452mN+6slKxYgYHY8Om84ib0hdwexhiEgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=mi6coVXb; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=mi6coVXb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5zsp1rb6z3blK
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:18:54 +1100 (AEDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-43bbc8b7c65so11524005e9.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 05:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007931; x=1741612731; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfos9Syg08SqOn+//RWYzG2n1+EfVqjsyXohmBPCw+w=;
        b=mi6coVXblDJwue/+GVL5NXFqOhUZVjqdC+32t9CbahABzQGauHE1FXTX9Ui/G7x0Hx
         W3ICC2khZHBNiDrBP8atzZK7CP4ifq9ueE+rHBNLPyt4GXBlPbbPsNFEfyhP4WWknlDc
         v585TXSCNstMI+VphZY9GPAtYc6xICMsTQ4vbh6zfz1TQ8dcQsnYJE7h9uUtcssSZTEo
         9AkN/6dXnJh5Vl/NjlZBklv1hwUw3B6KokCVrME1LCAtiDWcFZN6bz6OIDCNYpvB5Njr
         k0i/4B0DA86nD1/Vj/uFCMk4uHUcd7R7t21c6s/u71R4RXUzr1kzfrEquxPJAAJ6n07t
         Qw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007931; x=1741612731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfos9Syg08SqOn+//RWYzG2n1+EfVqjsyXohmBPCw+w=;
        b=IVvWcMml9n/t3W20HJXmaFch6n65ryOLVmORoOeRYE0+5UBE675CogAU3pB2mN4q+0
         1inlRdlXAudPKihxuDMiZVMC9jYpfp8g8495c0G64ip9pOtqrPoTo6mfR+TucJwH+qTT
         gL+GnAhgC84P215d+tyGqMKFojaDliCJNtiOi8OnV4NyttIYTZlv86Nqys72yI4vtbUO
         6yKl/+gkZLMauu2880c34O17FZ9zNf5/bz4uWGDgNTpJ9MmgL0FvNbWnUU/DBrtTjf4/
         /uA5s5q+hdJQh9JyR5CZt00/9boYUGur7sC4xcq4S7MvJJPVcS5Q5D2eslrFrdlBEYlc
         0WpA==
X-Forwarded-Encrypted: i=1; AJvYcCVvQ+PpNv0WnqD04ZsdgnPBMM8mlSVAuHo5KsxWxyt2qMc4Hohn5gKSyR1sQfSnZHomBJdRrqFfsuuf/Ec=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzW+AGEO0rOn+V7jsZZgscOt+8g4wTUIjnm0jxAEhhGToRnsc5k
	Crw7J8L5VCwQGQ3clsOFRQSZDSSdZSD67kS1POGPJxhUCImkqXCwH2TOHt+0NV8=
X-Gm-Gg: ASbGnctQjZ/Iz7+aK3uVAWlTtsyPu5ej8HiZ8Yg+Ep/cRI0BJNLlbIaic9YqomNG3rd
	IYSfa02oPynmCDOAfI8Rw3zfEYWZLuErDFm0oNg1LEbMmV+l/X0JiSQxNzt46hcYF6NzvD81N4g
	dRXGluyKpedW4szoMm1Jx1bcgY4eL6OGJ3doFvQ38f7iUHcBbB4eYpxx+VKRfVt1v+//A8y4DOJ
	b8VBeX3E3ly95IFAK0TFrIKIzxTbEj0Zh+oMGTAnBqFDwdj/KzuseGSZ0WbL8m1s2w5JKWEiJhb
	lagmhFW2El8k34Y9/O7t1zOf7Kv1eOdoVsX6cg==
X-Google-Smtp-Source: AGHT+IHXK2frQu5mm5st7OG50mDUgW+ZqOAgaKWtdnfNsGdx2IIR5+MeX+T68WRmGU9N2Zhz+vD07w==
X-Received: by 2002:a05:600c:45cc:b0:439:9ee1:86bf with SMTP id 5b1f17b1804b1-43ba7c9b8e2mr134577995e9.7.1741007931114;
        Mon, 03 Mar 2025 05:18:51 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:50 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:37 +0100
Subject: [PATCH 12/15] gpio: aspeed: use lock guards
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
Message-Id: <20250303-gpiochip-set-conversion-v1-12-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10512;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=6Biyqx/oPiy1u29C0+kNxd6YeuL0GXYE5IHU8R6GPkQ=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawre/nLb8HZ9vCTWG9HgoFrpXBkyMmO3uPg+
 DkbCvt+1bmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKwAKCRARpy6gFHHX
 ct7sD/9yKqknbydRuHgo09mRDQLljVd2RW0HD61Q3y+e/L/B6cyQnjzZKT5uGJ+v6h4lgQv+iXU
 ka+2zeotaUUZDupvz+c5QV5Z7LA8/PWAP3O7uVp9pdDlIJ9GsdOQg9KbFeQZsTOfhMKXfQTt6PY
 z0o7Fa+2lJh1TS+J24HnpMcUWXqI1Nu1N3tBj9XiBcJspKwP0iDeP3a2KjMUw3cNX+EPK7a47J3
 Snyjbs5wm8baI0fqmEyKL4pt1rZZ5mWecGL4VVpLMLZiCBTrIa+LgvxNGHkL+gKevzXYUnoYKR3
 tZKeMyE69KAyE/ZOB1tvR5UmGrw7vjpuPJMpcG4eAIIJswazrvDydIqT4M43TPIevqtqhgQg/YE
 6vp6cHKqSigeHfJcLF+msUCUvTtjmSKGBGp0LupdS+uPASKA/O/cfZx4v5tIeG2nPSnQZZl6tqR
 SIJHEXkhxoclh99WGXVu0GM2vsR9nl22pgPSYkKIwUzKV2epGnm+RVZZYhddELQ3fVhplnYWUnK
 s6bz7bNOSah0XlLT3p4hQp5s/jkOPlPszWSIJcnxeh5Q05zwmcgbdo4MF2vZBX0iaeCd4y+NI9X
 c6vgDAzA8oJ1o3lkJ5HWlhwdW/fj54pLrh+XXHSZ+a05AcdBd1vi1UyJ5kHAKf8jITmDJdjkq45
 NxSkq37b/jMxB8Q==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reduce the code complexity by using automatic lock guards with the raw
spinlock.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-aspeed.c | 101 +++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 63 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 40c1bd80f8b0..e2535aad1026 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -5,6 +5,7 @@
  * Joel Stanley <joel@jms.id.au>
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/gpio/aspeed.h>
 #include <linux/gpio/driver.h>
@@ -427,37 +428,33 @@ static void aspeed_gpio_set(struct gpio_chip *gc, unsigned int offset,
 			    int val)
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(gc);
-	unsigned long flags;
 	bool copro = false;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
+
 	copro = aspeed_gpio_copro_request(gpio, offset);
 
 	__aspeed_gpio_set(gc, offset, val);
 
 	if (copro)
 		aspeed_gpio_copro_release(gpio, offset);
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
 }
 
 static int aspeed_gpio_dir_in(struct gpio_chip *gc, unsigned int offset)
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(gc);
-	unsigned long flags;
 	bool copro = false;
 
 	if (!have_input(gpio, offset))
 		return -ENOTSUPP;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	copro = aspeed_gpio_copro_request(gpio, offset);
 	gpio->config->llops->reg_bit_set(gpio, offset, reg_dir, 0);
 	if (copro)
 		aspeed_gpio_copro_release(gpio, offset);
 
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
-
 	return 0;
 }
 
@@ -465,13 +462,12 @@ static int aspeed_gpio_dir_out(struct gpio_chip *gc,
 			       unsigned int offset, int val)
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(gc);
-	unsigned long flags;
 	bool copro = false;
 
 	if (!have_output(gpio, offset))
 		return -ENOTSUPP;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	copro = aspeed_gpio_copro_request(gpio, offset);
 	__aspeed_gpio_set(gc, offset, val);
@@ -479,7 +475,6 @@ static int aspeed_gpio_dir_out(struct gpio_chip *gc,
 
 	if (copro)
 		aspeed_gpio_copro_release(gpio, offset);
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
 
 	return 0;
 }
@@ -487,7 +482,6 @@ static int aspeed_gpio_dir_out(struct gpio_chip *gc,
 static int aspeed_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(gc);
-	unsigned long flags;
 	u32 val;
 
 	if (!have_input(gpio, offset))
@@ -496,12 +490,10 @@ static int aspeed_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 	if (!have_output(gpio, offset))
 		return GPIO_LINE_DIRECTION_IN;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	val = gpio->config->llops->reg_bit_get(gpio, offset, reg_dir);
 
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
-
 	return val ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
 }
 
@@ -527,7 +519,6 @@ static inline int irqd_to_aspeed_gpio_data(struct irq_data *d,
 static void aspeed_gpio_irq_ack(struct irq_data *d)
 {
 	struct aspeed_gpio *gpio;
-	unsigned long flags;
 	int rc, offset;
 	bool copro = false;
 
@@ -535,20 +526,19 @@ static void aspeed_gpio_irq_ack(struct irq_data *d)
 	if (rc)
 		return;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
+
 	copro = aspeed_gpio_copro_request(gpio, offset);
 
 	gpio->config->llops->reg_bit_set(gpio, offset, reg_irq_status, 1);
 
 	if (copro)
 		aspeed_gpio_copro_release(gpio, offset);
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
 }
 
 static void aspeed_gpio_irq_set_mask(struct irq_data *d, bool set)
 {
 	struct aspeed_gpio *gpio;
-	unsigned long flags;
 	int rc, offset;
 	bool copro = false;
 
@@ -560,14 +550,14 @@ static void aspeed_gpio_irq_set_mask(struct irq_data *d, bool set)
 	if (set)
 		gpiochip_enable_irq(&gpio->chip, irqd_to_hwirq(d));
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
+
 	copro = aspeed_gpio_copro_request(gpio, offset);
 
 	gpio->config->llops->reg_bit_set(gpio, offset, reg_irq_enable, set);
 
 	if (copro)
 		aspeed_gpio_copro_release(gpio, offset);
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
 
 	/* Masking the IRQ */
 	if (!set)
@@ -591,7 +581,6 @@ static int aspeed_gpio_set_type(struct irq_data *d, unsigned int type)
 	u32 type2 = 0;
 	irq_flow_handler_t handler;
 	struct aspeed_gpio *gpio;
-	unsigned long flags;
 	int rc, offset;
 	bool copro = false;
 
@@ -620,16 +609,19 @@ static int aspeed_gpio_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
-	copro = aspeed_gpio_copro_request(gpio, offset);
+	scoped_guard(raw_spinlock_irqsave, &gpio->lock) {
+		copro = aspeed_gpio_copro_request(gpio, offset);
 
-	gpio->config->llops->reg_bit_set(gpio, offset, reg_irq_type0, type0);
-	gpio->config->llops->reg_bit_set(gpio, offset, reg_irq_type1, type1);
-	gpio->config->llops->reg_bit_set(gpio, offset, reg_irq_type2, type2);
+		gpio->config->llops->reg_bit_set(gpio, offset, reg_irq_type0,
+						 type0);
+		gpio->config->llops->reg_bit_set(gpio, offset, reg_irq_type1,
+						 type1);
+		gpio->config->llops->reg_bit_set(gpio, offset, reg_irq_type2,
+						 type2);
 
-	if (copro)
-		aspeed_gpio_copro_release(gpio, offset);
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
+		if (copro)
+			aspeed_gpio_copro_release(gpio, offset);
+	}
 
 	irq_set_handler_locked(d, handler);
 
@@ -686,17 +678,16 @@ static int aspeed_gpio_reset_tolerance(struct gpio_chip *chip,
 					unsigned int offset, bool enable)
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
-	unsigned long flags;
 	bool copro = false;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
+
 	copro = aspeed_gpio_copro_request(gpio, offset);
 
 	gpio->config->llops->reg_bit_set(gpio, offset, reg_tolerance, enable);
 
 	if (copro)
 		aspeed_gpio_copro_release(gpio, offset);
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
 
 	return 0;
 }
@@ -798,7 +789,6 @@ static int enable_debounce(struct gpio_chip *chip, unsigned int offset,
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
 	u32 requested_cycles;
-	unsigned long flags;
 	int rc;
 	int i;
 
@@ -812,12 +802,12 @@ static int enable_debounce(struct gpio_chip *chip, unsigned int offset,
 		return rc;
 	}
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	if (timer_allocation_registered(gpio, offset)) {
 		rc = unregister_allocated_timer(gpio, offset);
 		if (rc < 0)
-			goto out;
+			return rc;
 	}
 
 	/* Try to find a timer already configured for the debounce period */
@@ -855,7 +845,7 @@ static int enable_debounce(struct gpio_chip *chip, unsigned int offset,
 			 * consistency.
 			 */
 			configure_timer(gpio, offset, 0);
-			goto out;
+			return rc;
 		}
 
 		i = j;
@@ -863,34 +853,26 @@ static int enable_debounce(struct gpio_chip *chip, unsigned int offset,
 		iowrite32(requested_cycles, gpio->base + gpio->config->debounce_timers_array[i]);
 	}
 
-	if (WARN(i == 0, "Cannot register index of disabled timer\n")) {
-		rc = -EINVAL;
-		goto out;
-	}
+	if (WARN(i == 0, "Cannot register index of disabled timer\n"))
+		return -EINVAL;
 
 	register_allocated_timer(gpio, offset, i);
 	configure_timer(gpio, offset, i);
 
-out:
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
-
 	return rc;
 }
 
 static int disable_debounce(struct gpio_chip *chip, unsigned int offset)
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
-	unsigned long flags;
 	int rc;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	rc = unregister_allocated_timer(gpio, offset);
 	if (!rc)
 		configure_timer(gpio, offset, 0);
 
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
-
 	return rc;
 }
 
@@ -961,7 +943,6 @@ int aspeed_gpio_copro_grab_gpio(struct gpio_desc *desc,
 	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
 	int rc = 0, bindex, offset = gpio_chip_hwgpio(desc);
 	const struct aspeed_gpio_bank *bank = to_bank(offset);
-	unsigned long flags;
 
 	if (!aspeed_gpio_support_copro(gpio))
 		return -EOPNOTSUPP;
@@ -974,13 +955,12 @@ int aspeed_gpio_copro_grab_gpio(struct gpio_desc *desc,
 		return -EINVAL;
 	bindex = offset >> 3;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	/* Sanity check, this shouldn't happen */
-	if (gpio->cf_copro_bankmap[bindex] == 0xff) {
-		rc = -EIO;
-		goto bail;
-	}
+	if (gpio->cf_copro_bankmap[bindex] == 0xff)
+		return -EIO;
+
 	gpio->cf_copro_bankmap[bindex]++;
 
 	/* Switch command source */
@@ -994,8 +974,6 @@ int aspeed_gpio_copro_grab_gpio(struct gpio_desc *desc,
 		*dreg_offset = bank->rdata_reg;
 	if (bit)
 		*bit = GPIO_OFFSET(offset);
- bail:
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(aspeed_gpio_copro_grab_gpio);
@@ -1009,7 +987,6 @@ int aspeed_gpio_copro_release_gpio(struct gpio_desc *desc)
 	struct gpio_chip *chip = gpiod_to_chip(desc);
 	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
 	int rc = 0, bindex, offset = gpio_chip_hwgpio(desc);
-	unsigned long flags;
 
 	if (!aspeed_gpio_support_copro(gpio))
 		return -EOPNOTSUPP;
@@ -1021,21 +998,19 @@ int aspeed_gpio_copro_release_gpio(struct gpio_desc *desc)
 		return -EINVAL;
 	bindex = offset >> 3;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	/* Sanity check, this shouldn't happen */
-	if (gpio->cf_copro_bankmap[bindex] == 0) {
-		rc = -EIO;
-		goto bail;
-	}
+	if (gpio->cf_copro_bankmap[bindex] == 0)
+		return -EIO;
+
 	gpio->cf_copro_bankmap[bindex]--;
 
 	/* Switch command source */
 	if (gpio->cf_copro_bankmap[bindex] == 0)
 		aspeed_gpio_change_cmd_source(gpio, offset,
 					      GPIO_CMDSRC_ARM);
- bail:
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(aspeed_gpio_copro_release_gpio);

-- 
2.45.2


