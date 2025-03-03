Return-Path: <linux-aspeed+bounces-898-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351CCC282CD
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 13:18:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5zsc3cdWz30Yb;
	Tue,  4 Mar 2025 00:18:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741007924;
	cv=none; b=GFGIdGukc1zvktz+DM3MkehLfjDZ/r2EVB7nANYOiEnl+XYk99GIYlVjXQ695G45E5nYrwJg1pu5PDGU77no/hg/Nl0bM1SzJeEW+SrxOSediW2FuWw1z7b8/b8DFYV368pqyZ3ZGNrwUj3uuTp4SaguTTZQixs4Kb5rY7jADOw2XBjptI5rQKFOdsQyRnc0ZHut3qrvZzi9W7S5ieDomOAvcJ8ZubrNIcXGfUMd1MdueGbQKGRL9UN+wJAR+wm6LGy/poq9XEsxIuMLOjHgOn9aRGDFefSzkdEUol6aIQp8SEPjCLa4HlpynN3TqXa2bCI1ZQSt3mwulwhzpHQDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741007924; c=relaxed/relaxed;
	bh=TidBt2SWkGKP+ilcC4ucnacYIVlA19tuK+wOmbWsRkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q9E8g+xPQjHJqYRuXg8PRdRApercsPysRT4F2GNo3+kKguxcWw6AwzZSuyPODupzUeG8zzla+SzH5rwnaGJvqWR01UJZGA4gOMh4KM6tyPtCTkPWEvene3z6X8E2o5K4n4kOlC/yZsVlvgqQyArjvhmtZTANdLZ5Q66hDm0SIOvj6iwFSi4pU/31fiI3+gmRF0QL5BzHb6uHAsTR+EzLXg0OCo8SwKNhJKl05f8DOIZGSaJVJQHRwK/THTvMwrWQnfXOEMxygZul4g2AAup4MzmbDe7SxTyDyrGGzxlh8fxZknnTKuUfPfRvg1DWcL+opkcrMlqZAyk3OmqUjCCVIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=jN8gVC+I; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=jN8gVC+I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5zsZ2gzYz30WS
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:18:41 +1100 (AEDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-43996e95114so30136095e9.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 05:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007919; x=1741612719; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TidBt2SWkGKP+ilcC4ucnacYIVlA19tuK+wOmbWsRkQ=;
        b=jN8gVC+IkiXFng7ZLOu1lXo1EgI/nlRyqsDfEGWKUnWd2Z7ZeW0gmPcy5I9JMbcVXv
         /BGqSE3gRjqW9E2qTsDouJBURKAzWyCXvlO+dy8iQU+fie7GsBknCJ++4Z93C+Dh8W9I
         mtiEzcZtLiwcMG5bWvHvZ+JIFpcKBl+DJAwYhaAo32L71ZIX4208SZX7iaWPFH/CD1A3
         6PX22niTULHs9RsF73e/L/I6yqREhn0lGkQRIbyW7A68ZGBpZFZQx1VsRCh5mKcoELjV
         YgFlZwMmMAIwcdpAvOp+DIhijlx590bQd/K417A0eHp4Xo7HXSv1wcQbeDhdPsJMLJ5e
         xVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007919; x=1741612719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TidBt2SWkGKP+ilcC4ucnacYIVlA19tuK+wOmbWsRkQ=;
        b=kibFQ6ltVIPFcelnQvQXylYyNViepwx/Q+zIqWLMz5f0obg3yTOMWYtmuN/g9m0zHn
         y6MT0g18bb9qCFxj6Q5bYf+vXqE9HokZYvvVKJCt0xysjToz9JLn5Qc73nma8nuzhuOC
         YlrbDt05733qna9UZkHQt2eAB6/GmsRgme0VMKII59ZcjpNJO/JXHVom98+ujvQSBM4W
         uqLphgGnSqs8jOxkoVcziq3miYn+RqXDjYvId5GlCzq8KPAXZk3ec1/8b3woF9+zNQUW
         Mk2M+NbmvvQ9P9GjVA6u+PPlHIlyvCxmmwgVD9SG6Uj6E9HaPD90mCw4PmiE6jxLVDX2
         uXNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVILJBhF58WpMOysgRQwPtimOxJNtMXLh6jsKwNc74j5bY5HS6J9MmNf9YqND3hWkw+6iwkxQHqhY4sWz8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyjMxdsMnPeCCijZXtLjOKNn8vjDK4HxvQWeIqEIwy66KzBruSf
	2rTDsPCkjRMX3dwVOQXCytiuVpROcMhMpLBwkQdTdRwNe/itkCUNM5aX+/IWCv4=
X-Gm-Gg: ASbGncvzzZWh0/Cf79Ubcn7wop4VkruGXb2Unwrr9MHgc+Xqq8gFNnSeLfg2thT0mXh
	7010ndEcG3QhckAVCd0/dUFDUsaA+rbgAwm4inERp64801ncZCYFTpBprow2nRtmQE5u1truHhv
	pZtM0z/ykUW/53VpnX40I/vRaf+v8apryZkwaw2ivWbqps2alZzkJ2feq9TKWlt14GBuF8yT+i6
	03mZ7QF4K0dMuFuB2/t1YltxiPhLf8znbBV9O8Lb1MZiOHEgaO/3ut3yJI1CyFH2UzfsSWVqofQ
	pOzbTHuxOO8i6OdRw/m3/bYeZVLeBC516cJ8ZQ==
X-Google-Smtp-Source: AGHT+IEGZIkGsjS/ODOZpGkDFGZZ9llwwB4c/+lpidwwZqW9qJGdaX/avIm1867Tn1hlaTWUqZfeFA==
X-Received: by 2002:a05:600c:a01:b0:439:8a44:1e65 with SMTP id 5b1f17b1804b1-43ba66e67b6mr114493835e9.7.1741007919063;
        Mon, 03 Mar 2025 05:18:39 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:38 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:26 +0100
Subject: [PATCH 01/15] gpio: 74x164: use new line value setter callbacks
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
Message-Id: <20250303-gpiochip-set-conversion-v1-1-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2379;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=fJTqv/+sZnRFGZ6FlOnt5hhk1BWl5pYK/rnPH5nY6Lg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawpW8tUrAxZZ/uk/w5xMTaLwsBNhfY98oNOV
 E6KDpZn+g2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKQAKCRARpy6gFHHX
 cpXFD/90YRmLFeyVnmIsi24hzo26FQhOWMYIRRDxzqpqNifd2b5mGvcBLkEwjzddss4IcMVw21Q
 gS0MpbNM+Rc/5g0YTAsQj5MKkpA5BSTvWyBUSA1trgrg0jZycAOGWBzRlpTYds/BH8yhCs/0pi6
 jmr90cZ6YXNnwnn6tU8Dmm+VOEDTnJimqBajFU+X9LDauS9ztFrbujTbVnfYMdSVjZHq6ZwLrIi
 qstWSErBzvhIAgAI0C/a2NrE6fh9Cw405kAE1wNI9DZAIo8gsSfP1leoDzVZ7i/LWurlnBRYmq0
 QapIAkzpl/Z1eBJkeS2ZR9OarmJeckFvuZHB96FRxvYG+wCYXxQYz25spUm8V5z4wxtxWKPA+5k
 5eA41bD5JlEtpb6QfTBin5dIlQU27UMrYZcZ7t6iBpE/gJyin7Os6R3fZaiM4qXR3wQ5RGYKJQz
 nGaaq5t6vTwUGDHsrJ4Bo1OQX/HISzfI5SGeaKUXhCfQ+1Geq8bLOD2wTeOt1BKtLvktU6CZh8a
 3V4IUfcddbMtemRGIcxcLM7Miy9cC+Kp/vZi4tWNpI6OwWkVg2C5WlBbKprsR39MQ9JqYdzS7RO
 PS3NYhJUj8YVocKe2vSeRtpW96rU3G1Qru8AXqkzD0URk7Nnbin41UUdW8Y+9ytmXjndYhGT1gh
 JDb3B9tKdW80oag==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-74x164.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index 640ac24b72a2..4dd5c2c330bb 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -50,8 +50,8 @@ static int gen_74x164_get_value(struct gpio_chip *gc, unsigned offset)
 	return !!(chip->buffer[bank] & BIT(pin));
 }
 
-static void gen_74x164_set_value(struct gpio_chip *gc,
-		unsigned offset, int val)
+static int gen_74x164_set_value(struct gpio_chip *gc,
+				unsigned int offset, int val)
 {
 	struct gen_74x164_chip *chip = gpiochip_get_data(gc);
 	u8 bank = chip->registers - 1 - offset / 8;
@@ -64,11 +64,11 @@ static void gen_74x164_set_value(struct gpio_chip *gc,
 	else
 		chip->buffer[bank] &= ~BIT(pin);
 
-	__gen_74x164_write_config(chip);
+	return __gen_74x164_write_config(chip);
 }
 
-static void gen_74x164_set_multiple(struct gpio_chip *gc, unsigned long *mask,
-				    unsigned long *bits)
+static int gen_74x164_set_multiple(struct gpio_chip *gc, unsigned long *mask,
+				   unsigned long *bits)
 {
 	struct gen_74x164_chip *chip = gpiochip_get_data(gc);
 	unsigned long offset;
@@ -85,7 +85,7 @@ static void gen_74x164_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 		chip->buffer[bank] &= ~bankmask;
 		chip->buffer[bank] |= bitmask;
 	}
-	__gen_74x164_write_config(chip);
+	return __gen_74x164_write_config(chip);
 }
 
 static int gen_74x164_direction_output(struct gpio_chip *gc,
@@ -141,8 +141,8 @@ static int gen_74x164_probe(struct spi_device *spi)
 	chip->gpio_chip.label = spi->modalias;
 	chip->gpio_chip.direction_output = gen_74x164_direction_output;
 	chip->gpio_chip.get = gen_74x164_get_value;
-	chip->gpio_chip.set = gen_74x164_set_value;
-	chip->gpio_chip.set_multiple = gen_74x164_set_multiple;
+	chip->gpio_chip.set_rv = gen_74x164_set_value;
+	chip->gpio_chip.set_multiple_rv = gen_74x164_set_multiple;
 	chip->gpio_chip.base = -1;
 	chip->gpio_chip.ngpio = GEN_74X164_NUMBER_GPIOS * chip->registers;
 	chip->gpio_chip.can_sleep = true;

-- 
2.45.2


