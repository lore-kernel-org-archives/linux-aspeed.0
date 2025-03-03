Return-Path: <linux-aspeed+bounces-903-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93533C282D4
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 13:18:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5zsg2qTnz3bkT;
	Tue,  4 Mar 2025 00:18:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741007927;
	cv=none; b=Jjy+/J6TfawT0PlF6fxiO+mARssVFvWk/Dxh4zzWT8mcVaZ9z/r5MxuV53Q5ObdqBtLoCLzwPBubxyWiwh83ZGwb5n+v7ZfURMo19wdIYQpVYXOqrXXNX2V+cpW+S+9cilxX8xQcpKG+8Pqbo1O/TP7C9SD3CBlMbqI1uvUs1qVJsVjJqeR9gLgsE6uIiz+66tGeakqORzwD+VG8C2bj7hi8gv6ljRDpKi9JTlVLtuidX0Ypi34PRSuzs8zQhKdypMLln54iWN+i5T7RGrgEv2C5sZreEa2IcL02np78pFWW0Amh8FRQ5VJAcho5VXIApxnGKGFIjkSqSJXFbhcATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741007927; c=relaxed/relaxed;
	bh=nNPL1a6roW0ZZry8Zwf4bxHUCK/ikUGMkO2GYygkBZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KA3psBYRCTnWKdjw+x3ezbYJtkUe9WPGI+mCdJ6q+cIiZOFHcn+9zMCaW87Ycv40o8f/HT0iwv73wGJmPnwWbyDecKdFV0WW7ejzHGa3M3gGdd53tWlabm1QwMwYRhMJfhfDfk49Cnx11dQs6NI/8oE5sYhwWZeq48P2Mc4bJs5i09kljoaXhdqVf7U2LDNF2K5NY1iFlISKM9lmZKQbKSmthAFNxFocqhIqRP9L+MlTH8URDeIzueQYJI38AV5wiKCvRB718lv9jlukEyM/GfMEA7YKjZXKZ8RBwttogyTbhCZ1CBsO8w+uUw5MSQ9s1j0cJ3AzunkBJ+Af1SBl6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=LPomqwMR; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=LPomqwMR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5zsf1pcsz3bV2
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:18:46 +1100 (AEDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-43bc63876f1so5090435e9.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 05:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007923; x=1741612723; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNPL1a6roW0ZZry8Zwf4bxHUCK/ikUGMkO2GYygkBZ8=;
        b=LPomqwMRjFrQMFk0ktTzcntbEYo4COsPUAXE9Vr/jiQQnY2DShlycUOaWlonvp9WZD
         1ATGO8J5bJeKg7XJvoyAp6IxK1XZkP039zrcMtRI9RxbeM1gauwW5i7lEkuIhC59CdSm
         +3SOs5otEnSew55+GbXsFvWtNGRVpuyTfhBJSazBhY8SvXCLK4oM6Z/EP2ez7/0GrBc5
         t6n4p2R0mUQLrGa893u2trSz7Oi5iMVKrwtaPkSWT5HeI0KL0MB+nbHDkcE9yIjtpu+5
         vgwrE8dHFxkHzxxitmHpzeg2K7kQE98JlrOK+CbnYlXZGE2fBOPAjT6bMwPFnKdBXtSX
         aeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007923; x=1741612723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNPL1a6roW0ZZry8Zwf4bxHUCK/ikUGMkO2GYygkBZ8=;
        b=wCqSg9VzNozEugc9qcr+AfhKJRNJk3GeRl5N+O1vMg2QE4wIzQtmY26sZxja98bqVx
         JJQA5DC42EZS49mRjrJfnlWpYq1UzfdW4Fz4o0gJu7mI9zCzIG/qrPex4dHBNmgxijrn
         dleXu3Et3fW41/dHiRuSzF3abCipdWuRomfh7w7rR4/RsAWEMrqghQ+wToAwNwVj7III
         +YaDrry8E3yx3P1g+vIirFTlqBsjxov0O3N/yks2oY51gZsCMNGnl6xvs3GqlPR7EW49
         mAxn61k6FjESkuZL0ymcOjl9WT7w0YROoW8pUl2bzAQ+NX6vLP4h0w5P99Lpb1S3mWXm
         aNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzUUvQz6dj3WclXnqrBcdZFtaOXeK6822zWk+tIgjyLX7Hq8vesTer4sprfsZXIWbGt6SjOFdqG25ilnk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxO9laGgCxG+IPo0AC0hfx3ukKkwgQ6MME9IJFNCtNRLpNL+yIQ
	pdYUy+N05rG+HeJY/SAxORhPAqZzdx0h1bLjSraeQV5Fy2YmogMP9Rr5pmr2lFA=
X-Gm-Gg: ASbGnct3w1Y3g1G0A5wyX0D6J4kbxhgQhOTfrqw7nhaD6wrdtQul/pfxTmo/mI86uW0
	gu55+s68CEFW072e2blrY6HfTUAfk43rEo1/RolzG+HLhCs0hemYsjViVDIM+vttrCR+xK9qHNt
	M/f6QpMTgUzeFvNPeDkP691PC6cztZUsBYbdBegDCmYl1wKN0JtD8nAUgURsbqluHuwXKxvF8lT
	kyBuPfgg0vc+4UWwqMLtRk7dqjcs6fjetl2QKg9VtM3TnB7X9kbWIDSYF9YSMkep18zZ290QdY0
	Crst1oIQxxyo03M0ylPB3iOMtlz9qZ6OE+JE+w==
X-Google-Smtp-Source: AGHT+IHbszq+vMxzQMr31b4yJpnsrbZ47M8sVQM15El+wQuWQDwBK5/Bpb/PIWwe1VCZA2bf3aRtzw==
X-Received: by 2002:a05:600c:4687:b0:439:88bb:d000 with SMTP id 5b1f17b1804b1-43ba6a83af1mr92775155e9.25.1741007923152;
        Mon, 03 Mar 2025 05:18:43 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:42 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:30 +0100
Subject: [PATCH 05/15] gpio: adp5520: use new line value setter callbacks
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
Message-Id: <20250303-gpiochip-set-conversion-v1-5-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=SunsCTO9F+EWaLdjYQiV46KnQmX+82e2K+lprMGFRIU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawqgKKxH1y23tQzCweLRSEGjaAyGcRFDUeq/
 rVWsBlWpxGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKgAKCRARpy6gFHHX
 ciKKEACBBk4kHvWvq9gEzt3a5+c5/x2eJ9ofpSxc1k6scdiEyfuTckeG0jNwsnuKnmWGVcZt5+z
 8OPcjsT0+csJp3FzC6PGpCSMfbZUtw03JIQJGM8TWeI9ulmBka8MlineJCR5DOERPeRx34SKzD+
 BQpvZfcQJngxK3LC+jkQZe5Z1vNINnA7BDbxaIFOcrweYjO+BgKJjE5TmPfdAlBSGC6BUuR1iMj
 +AhL75DSMv1bbaQ353KeDSeKhL+y1Ze29bKW5TCbzJMdU0kIsHL3BsklC1xldNZa0+Nl55J70Qt
 X8NPXyh6+Y/YbRI1lA9rrHkJ9XmvP02lU3Qsurs16hAgBT5TtxSHmp/ax0Jm+u3mG6t0Cd1EB4U
 bEiGB1Si600EmbxI/UWyIyLFISxpvQ0aHnSdL/MplN69ZiSspnqIU1gI3ZbgGznyy5hYAClZcKM
 5Gh6uws7oGhlSL8ETakeFWliTxMEZj3T+TyK2r8NHvLubPVo5c4IN6eRulRk3upWDvAhnK8n6Aw
 7hl194jwWCTYD+4ao2kfFKnSMSf6scU7P6tKw7vMRCW2aW114kU8SvfGV/Yf29RiKRL5db1W3vW
 ljM/LPc8eoRpobP5W2hQn7HrIohEw9zv/cYH3w41EC2Ac6mfFQetDtaT/UQXRPoAI2yR8rIsbd7
 V96KA6HPqQ2Ei1A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-adp5520.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-adp5520.c b/drivers/gpio/gpio-adp5520.c
index c55e821c63b6..57d12c10cbda 100644
--- a/drivers/gpio/gpio-adp5520.c
+++ b/drivers/gpio/gpio-adp5520.c
@@ -40,16 +40,18 @@ static int adp5520_gpio_get_value(struct gpio_chip *chip, unsigned off)
 	return !!(reg_val & dev->lut[off]);
 }
 
-static void adp5520_gpio_set_value(struct gpio_chip *chip,
-		unsigned off, int val)
+static int adp5520_gpio_set_value(struct gpio_chip *chip,
+				  unsigned int off, int val)
 {
 	struct adp5520_gpio *dev;
 	dev = gpiochip_get_data(chip);
 
 	if (val)
-		adp5520_set_bits(dev->master, ADP5520_GPIO_OUT, dev->lut[off]);
+		return adp5520_set_bits(dev->master, ADP5520_GPIO_OUT,
+					dev->lut[off]);
 	else
-		adp5520_clr_bits(dev->master, ADP5520_GPIO_OUT, dev->lut[off]);
+		return adp5520_clr_bits(dev->master, ADP5520_GPIO_OUT,
+					dev->lut[off]);
 }
 
 static int adp5520_gpio_direction_input(struct gpio_chip *chip, unsigned off)
@@ -120,7 +122,7 @@ static int adp5520_gpio_probe(struct platform_device *pdev)
 	gc->direction_input  = adp5520_gpio_direction_input;
 	gc->direction_output = adp5520_gpio_direction_output;
 	gc->get = adp5520_gpio_get_value;
-	gc->set = adp5520_gpio_set_value;
+	gc->set_rv = adp5520_gpio_set_value;
 	gc->can_sleep = true;
 
 	gc->base = pdata->gpio_start;

-- 
2.45.2


