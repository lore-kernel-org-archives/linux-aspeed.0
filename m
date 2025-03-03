Return-Path: <linux-aspeed+bounces-906-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294E6C282D5
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 13:18:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5zsk0p9pz30WQ;
	Tue,  4 Mar 2025 00:18:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741007930;
	cv=none; b=cV95rfsSvKVqU780bCaNRNXCVDMETWOUAH08IMP6X0i2M5zReeCfPlClhBbOMqsjCYuMahHCz6gYaFzGj80eU112xLM71nORjrmrkSIaT5N5POiRQpALgJ/L7ax0QmW37WT1lQHZrpy2djTkCZT4c6St10kE9NtUuJuR9m+9iInIZgNA8vxWUBYlGu3MuaO496tu1GyWypCC/yHbTW+Ho2UEWjaoANKIXJgKzC0XcrIFGcQ3lMoZrqmLVlvc8/syT4KYyQtuPu7J9rqoNU3UMWgtqjrKc/gP9lzj1IBzRXdWT5vh8BIxo+wBMgYDIkRkvlEvm29RM+4uv9XBK4HmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741007930; c=relaxed/relaxed;
	bh=/r0MuZTH6RnCwiU0BqdZFY1e9Cm3LvOPjQ1muaLpSVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMIwrxoke0klgyVgRoiD/Y814FMW28Izhfl45G/HP8lIUW7jS5p5ifXjCiAN5BwE+9/WQPKikF59KOUWEa8lEhVh+vmquBIPSCz4JNJz0M76dSHyDK7xziBX6suJoN8kWo3YcccaP7hkCWVBV2iJhBNEyLnucg2E65yFpvmvc+8u4p4fFCJSIoVW8xO5CBUkU+1Df07OW/2lL/yfAHm5I/suMWxlU0HHJ7dn+ukNO81iUJpAxtdB0+NTt1Cl6GL3hoV70db0PIs6DW7UBPxWHxihlYbp3YAUIsD6v6F8KFaUAIW44d3d5nbEUesU67Tbp64OOOE+nOkojZMJR5zZ3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=P74CwnzK; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=P74CwnzK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5zsj1P1Nz3bkg
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:18:49 +1100 (AEDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-439950a45daso27921645e9.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 05:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007926; x=1741612726; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/r0MuZTH6RnCwiU0BqdZFY1e9Cm3LvOPjQ1muaLpSVA=;
        b=P74CwnzKoITwu8V1JKlmDVSX/0b1BMjGKMYp86qEbsgNqKBfBdmopCBr1+iiR2+Eb/
         2cj/5GjD8HoKcQeQltN2s7UblkmAREhs+SeLALKxKjB9NTwQjtLEHxDJNULq5+B5w0ne
         Wh3+VQ+fNTrtJZw6CyoRpPeQ9l5PEAeAxJGyi3785FnpQ1D4ytF9qvF5P1PoZ3FzRujA
         z+DC1h/8V9K4eM/DB/Yl7Af1+PgdDxU6OWNzxTDlGzHOqnzAGhAOROdZDafiKoeJ+MV9
         GiIcJxayK7SnrPLSBV1lzTu+lw49xtrTIFrpTqL9vqzB18tfTqMy5jBtDy7/OktSJC2W
         Dh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007926; x=1741612726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/r0MuZTH6RnCwiU0BqdZFY1e9Cm3LvOPjQ1muaLpSVA=;
        b=p8dLHecGnQpvc0y6NTcyKrt3GNthKSF+H4adhToy1KZzxK7XUKpQXgsdzr6MPyhX3P
         2bnWkS6w7dDgxa17LWTSESEgd5wUq9LbVYVfCH3p/CUQNCSvwPG91hI0ilinc6UAJmPx
         ch3LB8Zgo3ZkSqlN1Gszjq7jfvH1mQwh1hSntLwcMZQ/f1yibHa36hQbrrC4HpdObBVW
         h/pZgqdiqCT0L4sqGsM/jN5SUHo+72akCMFxJD1P9UuVoqaftvD606QJxkYG1K6JJt32
         eQX2r6nHoUgEHdLHIpydXnTfgmGXYxvblaXdk++Ls8nyMn0XorZohE4ayIqV3g6pKunT
         M8Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVyXDqHt1uWdexZCpP/pu+8/fwMlPf2Ew630gEoWP2cJfwVxttgbsdqMsrVhoJSp5qDTEEUsP+w/8JyUio=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy7YpLrOVQ0/JuSQgLj5FhDcwMZFuSBFoLKEywoSuyV/h2Zy7ra
	ndrpruh2bVe9eUeUDMGUf7xxyc+2VYxlIallrlod+AptydQBnXDgHZ3H3FSHPPk=
X-Gm-Gg: ASbGncu3DXL/yuXiV0RbhH+TX/giXv6j/PP6etzemZCV7Y3f+CUMdv2TLds5ZbhKDo0
	2Wf9WTaMxXRbTOHezhnhP5/22RBhM7g+R8Q++Pp9BA0GMW5h6Kw6645+3xA4qQogSMjdA+EPeTH
	Nq9GeV7VnHyFAtp0bfjcwrAtOD3oFpu9Y7DCQ7ud8SQboXxen2j74STXU0LvsCZgpBN7VP+mSL2
	JCMKB6fT6FuX+sqGOETJc3MPQ2Fc7zVITVzKkS3LclPwumLCEevX18A8aNAtFo5VoakN+vE1MvM
	M7wFSQbVIoourr8cl2Z8VqgEgpyjUL4tYpjhWQ==
X-Google-Smtp-Source: AGHT+IHm6EaYBn70SJkUBa0sIwAoFeDNkswqub4neNrYccFomXUwUOGpuKJlkXEU0LDo4dNArOpzqQ==
X-Received: by 2002:a05:600c:3ba9:b0:439:9828:c425 with SMTP id 5b1f17b1804b1-43ba66e0a61mr112280175e9.7.1741007926409;
        Mon, 03 Mar 2025 05:18:46 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:45 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:33 +0100
Subject: [PATCH 08/15] gpio: altera: use new line value setter callbacks
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
Message-Id: <20250303-gpiochip-set-conversion-v1-8-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=SMOq2xgstETx1JyBNH5vYamCTElxv0DKa/FsWx+nPds=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawrqlWF7E8xNzhaiQDDre2OcEVZwl9/RTexY
 M26Lfz22DaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKwAKCRARpy6gFHHX
 cmqwD/4phcgUzCpl6mKnD/IdnZIH9RNk3LmcqASY0VFf4EbXRAfUJVTaMQeDgSgk24dtEjEosuC
 bpBw1QzXfAFamKZKIQDyNKjXPzE/Hoe1EDCF34rZuNHNHPI0UBjmxJ1HQiXsaiOvcp6YuN90LqU
 IruTx8dSh8NomvJYZNovzKeon6/LRWzKlWb+uZYczW7uUFTXZL+T5oLS7DO99kqZsTCTfVU6Ul0
 3OFRD6NQ0Ihy9l2k1V7lqCDuH+qJyDeuUNq2LtUBuuX+2I8AY3ESBJp2i+MBGELCLWfwR6b1xxT
 LeM5r6nSFUOHN/2f46OZqPlXo+/06oFEI5JqVGow8tZdNrM6mq6cPa5erpnMrWDBhkLZOUeMhCt
 DWHujIwH4kTX+GRjsbuNjNbgHqGEDhX4l7xuIqaQFgkjS5/dRaSQ62lfMxG5PRYtYAOb417XaMv
 6t9tvs9wnV8Sijw4pvvP23BSDop9+n7LfOH20zHB8z38ZXbJcRKZJoWG+Brj5qdvrQmskwcQC0u
 MK94saNiUr6TGH1b7JaI0RM1SXCnT+wdiP5hdJBrPc9ZvTC7wVF5ruvBjzyMXjf9DAdh/hou8W1
 S4LR1Rq4rbXXTZk3VddxFwUqAmWQKWmlpqvYKvAjKmoq6Au2FAByQj/JHUPyd3iJAIjpfvDLzrN
 e1HgWPF2h6MAoxw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-altera.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
index 17ab039c7413..1b28525726d7 100644
--- a/drivers/gpio/gpio-altera.c
+++ b/drivers/gpio/gpio-altera.c
@@ -113,7 +113,7 @@ static int altera_gpio_get(struct gpio_chip *gc, unsigned offset)
 	return !!(readl(altera_gc->regs + ALTERA_GPIO_DATA) & BIT(offset));
 }
 
-static void altera_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
+static int altera_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
 {
 	struct altera_gpio_chip *altera_gc = gpiochip_get_data(gc);
 	unsigned long flags;
@@ -127,6 +127,8 @@ static void altera_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 		data_reg &= ~BIT(offset);
 	writel(data_reg, altera_gc->regs + ALTERA_GPIO_DATA);
 	raw_spin_unlock_irqrestore(&altera_gc->gpio_lock, flags);
+
+	return 0;
 }
 
 static int altera_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
@@ -257,7 +259,7 @@ static int altera_gpio_probe(struct platform_device *pdev)
 	altera_gc->gc.direction_input	= altera_gpio_direction_input;
 	altera_gc->gc.direction_output	= altera_gpio_direction_output;
 	altera_gc->gc.get		= altera_gpio_get;
-	altera_gc->gc.set		= altera_gpio_set;
+	altera_gc->gc.set_rv		= altera_gpio_set;
 	altera_gc->gc.owner		= THIS_MODULE;
 	altera_gc->gc.parent		= &pdev->dev;
 	altera_gc->gc.base		= -1;

-- 
2.45.2


