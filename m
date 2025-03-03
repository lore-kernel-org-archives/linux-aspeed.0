Return-Path: <linux-aspeed+bounces-900-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D992C282D3
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 13:18:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5zsd2bjsz30WS;
	Tue,  4 Mar 2025 00:18:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741007925;
	cv=none; b=QeiRUWuI+OhogtBVnOWF4hAIXi6ImGJX+GrfHmKjfuuVj/tY0LH+9ZYt+/Xj8cpX8/24rRx8GpxmnQrVU2/f8f3EiYg0cZrHkjlDnFRyCyhqvANlkzGoCtWiMT98aOzYwXxG+SH04yzBRVhDv6bvRkd5bkUY3vniQFfpSKSB6c78K1V5kRE3HKTCUo7Rzecqu94Teu3MruHp8ph9IrQyhKB2LrI1vjSTiFa0oyDgYP/m1HWm4FA2wkp43K6bKNmn53D6tpNU7ncjQ5zSB8yP7L+mqqDCzAMfpL4MykCZhgH/iNN/3P3y1MoXscnSuE22HJQaWijmVndCkURI6u6B6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741007925; c=relaxed/relaxed;
	bh=fZ5oJp3c5WFM4WouXer3X9uqb/QndY0s4T1ZVpIJ/XI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WCZnD68vRyflshn/bEhcOjpdwlTrh1pN+eboEEmT5919VPNlFn8pNlVNlunLr3RX0lhD8gzCuKzCKGMLpVnybAZRAY3GkqueH5dCtcw0IujSmJ3ZM0ixy5KTMXPrzOpl/ZnIud/qCp2Kj7bwwSze0xPx8v4dyYTZym1sxlmPEjcM0xDwBO/tfiSup3cTZx1B4/7N6C/HF4xX6NJaXe3OVGF/fN3v6IWisnbHKb+jC5hSuiNPLqlTXyN12S8oTGe/FnPFTXT9IR2k+uJSWuuVK5xywnvKTBa/fzgozC0/8xKqoITXkATDdg8ahmeuVgx6PJv1Woqs9DGel5LrIh889g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=gmF+X6Wt; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=gmF+X6Wt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5zsb1Z9Sz30WY
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:18:43 +1100 (AEDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-43bbb440520so11698805e9.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 05:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007920; x=1741612720; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZ5oJp3c5WFM4WouXer3X9uqb/QndY0s4T1ZVpIJ/XI=;
        b=gmF+X6WtvChg1AUnQFeVi/sC5UL0ekch2LIR1B7py7+a175NWuIyyikYAP7/1Gvlzg
         2kcQLD540Ks3r/5+VhMN4paSz5Zl+y0Nl91CgoQyTpPSXCobOfXyz3k3xPXNMFsbIXOo
         7vYjLNoGYtHv8admRbotOQOCpbjqlXDGPoWm2wCSQqsBOFF5il9jRz3w3k9agm39Iz/N
         y6N/DLAa/YpvPkTLdwNANiqzQBGi/xqpJ2KR8nHVakjSAztuvTamvqk604RZnMgVKg+T
         TOG68WnMXX0ttWxOz5ZyK+UX9DDnmn6tYVPbzzTVNdn3+187ryFw9BYAHIYquuwpsvdp
         YYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007920; x=1741612720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZ5oJp3c5WFM4WouXer3X9uqb/QndY0s4T1ZVpIJ/XI=;
        b=NLPd0Pd5TtX6zxaAVd31Ggoxcgg+UtWjeZfYWnSAr4eanBgem7UGYgbm9hs5jfxaA4
         wa2uFkkUfeuIogCskT6cyUSZ2OuooooeNlRCk86bMc1M5CtoziDFrsMyeW7zsgeSucmR
         xdsbTuK5BGJEaKBxQcwCspFtZ0vLFgnwkrFWLseF5CPSn5UeuqBQ5tctkxMO2ZhoeJdl
         23la64dGr60dUvUvNPUe5yWagvH67pmbyn0mkeyZdjWeglE81XRUYPnBdavHmeeDF00U
         h6OfB6n3VrXwiCFH2g3GwRylx2MAsW06q4x70Klf49cPnBsObfv42Ob0dEmhe4lpMYxJ
         6doA==
X-Forwarded-Encrypted: i=1; AJvYcCWbLm+NKlG1MDdNeQFHZ4/ExcSoxuQ9v4Sx0tGCqlYP6Y95ZOPrzqJHaxZaxo2NCMI318Aj/uyZx9Ks7XQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy2wtw+RVyieGTmlDnkGcEuu8bKvXqNziSZE2+oHmrpeVZ9Gy33
	r5yV3iSVdwNk1LCIkLO5Rxe/lzGsSka0LZC2Av1wPRjxFpalgjC2NgFD3hZAAHD7j67VZQ3lFQe
	r
X-Gm-Gg: ASbGncv0nWg5xexrViTI84ynFjZedA9/OwK/kkq/C/jnyCK+pK/q0lUx815faX4adiL
	kqCCn6ucza2BlepBeFBmvlMeeMQN/zuLkYeWDnIeIlTRQGgfjwhEAmPZyDO9rB8YfIR27hEUpZl
	9ILwqRbvvkMszhLibH+99dZ7BG5dTjYBWtEB8rqEMgZV3K6d3zjOStnauesil1tOjzIiK6os2KD
	RwK3VemUVcf1rXAk4H0YQviUVSIfjE3Lxmie3JYYNjF917NJ+bFklEmgK7sqsqipZySjmQvjtis
	EoFKwuKtVkKIUQGdWz7HbS270CvRK22BgBAsdw==
X-Google-Smtp-Source: AGHT+IG5s1ruT1nmumvD1vz4k/PQPFk73wz70YSES2dlvEwqzkFmq0l7g9gUOgUlEDWIW1/6NKwMVQ==
X-Received: by 2002:a05:600c:1990:b0:439:9b80:ca6f with SMTP id 5b1f17b1804b1-43bad205987mr116763645e9.5.1741007920075;
        Mon, 03 Mar 2025 05:18:40 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:39 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:27 +0100
Subject: [PATCH 02/15] gpio: adnp: use lock guards for the I2C lock
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
Message-Id: <20250303-gpiochip-set-conversion-v1-2-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5610;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=7cE7tXYd+kBXXnaURava5I+mvo86dKpC24i0n29V+bg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawpxuJoIV5NMGocJt+m6HFa4mYBXmmZlg4hw
 8wwnHfFcfGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKQAKCRARpy6gFHHX
 cvjzEADPodYCLVwjeMTiGTqPipprljvQCB/GL3xqqTvapt8laajCeEP13MAl+wEQgOI0PZjtgmX
 IfA0F82Ky3uW/F57NzwGDDUbhJo1kkawv/eZOqQ+iySkYpAjFaF1eV+oboYthMguItGFy3KWAQ5
 JqKgAdn7TqGMrZWB4xBd2Nfu71VA+FhqgEXam6X9yeI0uNeMN0yeLZsyxvTZq66ZVrt0yop3Pg5
 kp6deFDMu8Jn1//eSLL+8uVpdoKB+Cj7AT/AUl6/5x69brbHiORb03ioq1Nv4XPE2Bva+/oCBw/
 aCFfEOyJrsROsvx1dYpcXMWytgBgxj6wM3OhAa4dXuPWGxKFq3inPX7XxK2YoKp/HlfRCs3Bv0Y
 MPsQNxupceBB6eNWtP3bk0r92+8D0i5+m3NMGz2zq83unvXskmb8q+LiwAQ79DL72CednxwdxTu
 Bj6tysTCulxtGU5NqYQDAgmXUbdvRiqUrSAmCUQAvmQ2b5Gf+VaMZIj/V+Z7gfj5/emjbGC9rem
 R+EAqun19YF+NX/B2DOft33MLhn9mZThlbEy6JE1cTaXqDp/Tq2AArFUUx/C0JDRf+HzB+Mx3q5
 dNl7v/Pp8yfkP/IZCSnqtnNj1sUXTVN69sTh4L4X2UV96caMerMTa59SIBSU4eZPg8a9MdsOwj/
 UB9QF8bbNI/2ffQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reduce the code complexity by using automatic lock guards with the I2C
mutex.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-adnp.c | 118 +++++++++++++++++++----------------------------
 1 file changed, 47 insertions(+), 71 deletions(-)

diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index 6dafab0cf964..dc87768276ec 100644
--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2011-2012 Avionic Design GmbH
  */
 
+#include <linux/cleanup.h>
 #include <linux/gpio/driver.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -101,9 +102,9 @@ static void adnp_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct adnp *adnp = gpiochip_get_data(chip);
 
-	mutex_lock(&adnp->i2c_lock);
+	guard(mutex)(&adnp->i2c_lock);
+
 	__adnp_gpio_set(adnp, offset, value);
-	mutex_unlock(&adnp->i2c_lock);
 }
 
 static int adnp_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
@@ -114,32 +115,26 @@ static int adnp_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 	u8 value;
 	int err;
 
-	mutex_lock(&adnp->i2c_lock);
+	guard(mutex)(&adnp->i2c_lock);
 
 	err = adnp_read(adnp, GPIO_DDR(adnp) + reg, &value);
 	if (err < 0)
-		goto out;
+		return err;
 
 	value &= ~BIT(pos);
 
 	err = adnp_write(adnp, GPIO_DDR(adnp) + reg, value);
 	if (err < 0)
-		goto out;
+		return err;
 
 	err = adnp_read(adnp, GPIO_DDR(adnp) + reg, &value);
 	if (err < 0)
-		goto out;
+		return err;
 
-	if (value & BIT(pos)) {
-		err = -EPERM;
-		goto out;
-	}
+	if (value & BIT(pos))
+		return -EPERM;
 
-	err = 0;
-
-out:
-	mutex_unlock(&adnp->i2c_lock);
-	return err;
+	return 0;
 }
 
 static int adnp_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
@@ -151,33 +146,28 @@ static int adnp_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
 	int err;
 	u8 val;
 
-	mutex_lock(&adnp->i2c_lock);
+	guard(mutex)(&adnp->i2c_lock);
 
 	err = adnp_read(adnp, GPIO_DDR(adnp) + reg, &val);
 	if (err < 0)
-		goto out;
+		return err;
 
 	val |= BIT(pos);
 
 	err = adnp_write(adnp, GPIO_DDR(adnp) + reg, val);
 	if (err < 0)
-		goto out;
+		return err;
 
 	err = adnp_read(adnp, GPIO_DDR(adnp) + reg, &val);
 	if (err < 0)
-		goto out;
+		return err;
 
-	if (!(val & BIT(pos))) {
-		err = -EPERM;
-		goto out;
-	}
+	if (!(val & BIT(pos)))
+		return -EPERM;
 
 	__adnp_gpio_set(adnp, offset, value);
-	err = 0;
 
-out:
-	mutex_unlock(&adnp->i2c_lock);
-	return err;
+	return 0;
 }
 
 static void adnp_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
@@ -189,25 +179,24 @@ static void adnp_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	for (i = 0; i < num_regs; i++) {
 		u8 ddr, plr, ier, isr;
 
-		mutex_lock(&adnp->i2c_lock);
+		scoped_guard(mutex, &adnp->i2c_lock) {
+			err = adnp_read(adnp, GPIO_DDR(adnp) + i, &ddr);
+			if (err < 0)
+				return;
 
-		err = adnp_read(adnp, GPIO_DDR(adnp) + i, &ddr);
-		if (err < 0)
-			goto unlock;
+			err = adnp_read(adnp, GPIO_PLR(adnp) + i, &plr);
+			if (err < 0)
+				return;
 
-		err = adnp_read(adnp, GPIO_PLR(adnp) + i, &plr);
-		if (err < 0)
-			goto unlock;
+			err = adnp_read(adnp, GPIO_IER(adnp) + i, &ier);
+			if (err < 0)
+				return;
 
-		err = adnp_read(adnp, GPIO_IER(adnp) + i, &ier);
-		if (err < 0)
-			goto unlock;
+			err = adnp_read(adnp, GPIO_ISR(adnp) + i, &isr);
+			if (err < 0)
+				return;
 
-		err = adnp_read(adnp, GPIO_ISR(adnp) + i, &isr);
-		if (err < 0)
-			goto unlock;
-
-		mutex_unlock(&adnp->i2c_lock);
+		}
 
 		for (j = 0; j < 8; j++) {
 			unsigned int bit = (i << adnp->reg_shift) + j;
@@ -232,11 +221,6 @@ static void adnp_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 				   direction, level, interrupt, pending);
 		}
 	}
-
-	return;
-
-unlock:
-	mutex_unlock(&adnp->i2c_lock);
 }
 
 static irqreturn_t adnp_irq(int irq, void *data)
@@ -252,28 +236,20 @@ static irqreturn_t adnp_irq(int irq, void *data)
 		unsigned long pending;
 		int err;
 
-		mutex_lock(&adnp->i2c_lock);
+		scoped_guard(mutex, &adnp->i2c_lock) {
+			err = adnp_read(adnp, GPIO_PLR(adnp) + i, &level);
+			if (err < 0)
+				continue;
 
-		err = adnp_read(adnp, GPIO_PLR(adnp) + i, &level);
-		if (err < 0) {
-			mutex_unlock(&adnp->i2c_lock);
-			continue;
+			err = adnp_read(adnp, GPIO_ISR(adnp) + i, &isr);
+			if (err < 0)
+				continue;
+
+			err = adnp_read(adnp, GPIO_IER(adnp) + i, &ier);
+			if (err < 0)
+				continue;
 		}
 
-		err = adnp_read(adnp, GPIO_ISR(adnp) + i, &isr);
-		if (err < 0) {
-			mutex_unlock(&adnp->i2c_lock);
-			continue;
-		}
-
-		err = adnp_read(adnp, GPIO_IER(adnp) + i, &ier);
-		if (err < 0) {
-			mutex_unlock(&adnp->i2c_lock);
-			continue;
-		}
-
-		mutex_unlock(&adnp->i2c_lock);
-
 		/* determine pins that changed levels */
 		changed = level ^ adnp->irq_level[i];
 
@@ -365,12 +341,12 @@ static void adnp_irq_bus_unlock(struct irq_data *d)
 	struct adnp *adnp = gpiochip_get_data(gc);
 	unsigned int num_regs = 1 << adnp->reg_shift, i;
 
-	mutex_lock(&adnp->i2c_lock);
+	scoped_guard(mutex, &adnp->i2c_lock) {
+		for (i = 0; i < num_regs; i++)
+			adnp_write(adnp, GPIO_IER(adnp) + i,
+				   adnp->irq_enable[i]);
+	}
 
-	for (i = 0; i < num_regs; i++)
-		adnp_write(adnp, GPIO_IER(adnp) + i, adnp->irq_enable[i]);
-
-	mutex_unlock(&adnp->i2c_lock);
 	mutex_unlock(&adnp->irq_lock);
 }
 

-- 
2.45.2


