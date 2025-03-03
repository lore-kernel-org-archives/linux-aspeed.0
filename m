Return-Path: <linux-aspeed+bounces-911-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDF3C282D1
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 13:18:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5zsr0gyKz3blv;
	Tue,  4 Mar 2025 00:18:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741007936;
	cv=none; b=liASRVc6WUc4Fsy0hkKiLTzEcA7Vgm2vYry6cuUZ+n3na8fPSWMuu6UnYzJD/kb55iBQgc9AkgDLQRyyziuI8Zk2AS/FbxbJu8miMmVS4FKSIdiLTbqs6KNA6p8yNtAtTpTA2yj1SQUypnaMdqLI3cY88zYCuZPe/pVeicW1HCbTSsIRLuR0ptbl/pO/3kr4f76Yts+gylEEqLFhb6Ecfw0W/AHcg7shrQdih9XKKdjZGHI1npdLNzlZ5Cary9jqp1q8tl9j91+65XMaP3AhYDq1YIhD4Cw7lGAW+/hHwE4QZrh/W423V7WEn6hqIvgIgZ43V/bHybSDzWxvrabEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741007936; c=relaxed/relaxed;
	bh=N2T+qUj1+rhYU/lDMmm7CtWMW53IZ3sreca30Qhdgoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQQiv7EF6SWPGJYU/xGDDTn4tY91G+V3TCxt8s0ZjIX2/6pXmQfKEMbNnXnCPO8tnsrjyYLg8QvVu3VXNKXGP+KYhPDGx0+wejN3VjAj+OEYmstDGMy/AszfmwcJFtZhkYGuXE7MA2SuYE6uAExVco0pnSBylUfnbYrGIvRgA6Yyn06O3deDzO5i7TJgVV3XIlULSbb/IdqF6yCIy55OhTXgbJgIurhwtrfaMlu6tL0pKuQ4v55sh4hZciyilwCNDcghS6ZeGoPSDZs4JgKdQKzZ4KD6Au0gX3+FbLvfAvfbmat02Y1Y5S5kbyP1oh0tPH3pmeWr0s4l4/br2u5vdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=u9yugDVN; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=u9yugDVN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5zsq09LFz3bld
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:18:55 +1100 (AEDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-43690d4605dso28100345e9.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 05:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007932; x=1741612732; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2T+qUj1+rhYU/lDMmm7CtWMW53IZ3sreca30Qhdgoo=;
        b=u9yugDVNwKVE8NgGVusJ8kemcIkgH+jsJRFwf5nlTjTvbRFHOxIoy3ABhsNnvs6olM
         VmHrowRHFbF0WCw3ft+pCJVElgAxm2HhYtO81W4YIRq8YU0CxNWZim6e5SsPtByBZJ27
         2Jv8AMDqVNweWwKNNOIHlODh/R+8AxKFGad5ioJxtlLZIcniQdH3pU5fKR5d4zzprDXV
         nUBGIiNnBn8W6qquWbsKXE+bHMVi4KN1fS/KsYQZryDJ00Qlbv8Ik20Xlr9O9lT9wMT/
         pkqIQYEcbtYUu1DnqkLAJ84LiSpGSh7Y+32//lNc/NcMjXcr6ys7Eu7zr46ctcFiLsTs
         d7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007932; x=1741612732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2T+qUj1+rhYU/lDMmm7CtWMW53IZ3sreca30Qhdgoo=;
        b=XghJDtJcgJHohflcieFNGLLIRbO/ii4uRHeI2PSRoyXCeh4Z4eu0zfHKo0grav4JhL
         D0ICrCXoZx1p23WPb21CUfFSEBPAWydnpBM494VrWcUhahgDqz9M4QNCCvtoiG9shEWz
         z5SfQW96vNNzeCZ1A1VXYCiE4uWhUhsw5aTMno2v+KFLu/chD8JLo/qB1xoXTiKR0pWt
         BJwr2KAPmTM3Uh+KLlLy+/4YUA8ClClaSWYBR1T4q1dMO0tHF81TsGwmyyLQDhwLTQkM
         HHI+HikE1wWYujHOf3eeRU4x78FDdFBt9QrFgnlY0I1yrx9afDBvW+d+OIYA8SHvKtD9
         GNbg==
X-Forwarded-Encrypted: i=1; AJvYcCX/igkUPLYA7p2gjCOCeKbg/NV6DQ7IGvJHWCgvIjiCbfR093AgXnjIlBxwBlGMHFRnUlOD4YHmBtud3Lk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxcKpgV9fvtbm1QKL+ChpJP365k3vWrdAD0KM4vH+xvz33/K68Y
	fEuSpW/zMBrwBc2I8QLnn3bnv9KVUW/f18jjGT+N8CQRobTLWYuwak2AaY6gP4s=
X-Gm-Gg: ASbGnctRtrHqgbeN/0NBBQ6nNLsAmOucZcvCptyUwMmMIX2vXb5poE03pJpe9wzDtrp
	4eljPZr95VFdoPMwpq3934vbUl76cATtHjw8YR9o9PoBafbptV+Pe1Rx7kA9KkWurYQ5iqkYJMj
	Ny7F2mPA1njZj3JwFG/uFylwi4H95j8GkXA1Y3sKD6u1A4eAIWdDhA4cQkz32241+Cs2HmqfJuu
	H1PSQ96z5LHhD9gFAwZmB8R11J4SpvV5v/3pv9WerGTNVRGKtmgEkZOGDxuPNRaNKxIwroa4Ak0
	vEwmomL24u6WDbun5OTYOqbvELxL9OrrjVxbmg==
X-Google-Smtp-Source: AGHT+IHrsk8va2f9jUFz0ftD8VEqOjTpXEeQwyIxP0GRFd+ut72EYxcmyfAXXHA/8ZZERm1Ku2/BTQ==
X-Received: by 2002:a05:600c:4595:b0:439:955d:c4e2 with SMTP id 5b1f17b1804b1-43ba66f9f99mr109740985e9.13.1741007932175;
        Mon, 03 Mar 2025 05:18:52 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:51 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:38 +0100
Subject: [PATCH 13/15] gpio: aspeed: use new line value setter callbacks
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
Message-Id: <20250303-gpiochip-set-conversion-v1-13-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1579;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=LYFIGRtuwl4aJkBrIp7QZ91bKDFoO6rlmaJc/Y3YEoE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxaws9K4avm5a3/nXOZWmIQcBvBwL1Vb6W/sh9
 OznmQXSmESJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsLAAKCRARpy6gFHHX
 chT8EADTj6ZZXdeJj6Iyu1AzAb4IyTbPKUbO8J/z8nzq3PyDc5bnoj4WHzueOKKmjcxZKh/WYoI
 FFA/pLjrW+4GZKcD9eBnMz4mRz8lpCmTpcNAFjkQQHqmQULsLzb+wtCk9oR1vgC13G+/mWED0EC
 pTlhcx4vALIKG+WXXE9jWt7TlQvoM0lE0PXKW30/ll3nG7gFQOS7PA4eNP9PgMrlv7jX0HurDoi
 KbgabP3JdgvBY1MD2E4m+O3cRHM98gJTDS5qKQEvlC3GzHeppaYDJDPd03NBaAwPtLZ7as52saM
 +vGxlehYqbNPl92p66PzhTnKVa2rmQy/9MnGUrxoDJFuLkLi4S8CkMbqZRu+qy+yt9tpeIzFUL1
 eXoBzY9hs+kO9qq0cPab32Cs4kvJ0pj6cgWnTlXqwbpk8isnBLDd5Dvy8O5E4y6zlGSWa5qiTC3
 MBRxF/68eGz1AeVeDcCuH4xz9FZd0EGTeNoH4nuC5S8kVMwn6hD1lD+nCEs3Y52xMNLU6PHLk5F
 5lCN56djX30Hd2YWYLdCvEYrZzprzHncFQgl6CmHJcvnFt4Ln7gVNj1zjO5eY9ZRw9z0JHHY6F3
 GUnF5ZKdktPzZ+VnH9pYOOyEqrPpcBmkG24xaMnAg+8iGk6JJVKLigkXXE4Q6aQOsSnvnLWmH32
 7R+I4hEhoMhBI9g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-aspeed.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index e2535aad1026..2d340a343a17 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -424,8 +424,7 @@ static void __aspeed_gpio_set(struct gpio_chip *gc, unsigned int offset,
 	gpio->config->llops->reg_bit_get(gpio, offset, reg_val);
 }
 
-static void aspeed_gpio_set(struct gpio_chip *gc, unsigned int offset,
-			    int val)
+static int aspeed_gpio_set(struct gpio_chip *gc, unsigned int offset, int val)
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(gc);
 	bool copro = false;
@@ -438,6 +437,8 @@ static void aspeed_gpio_set(struct gpio_chip *gc, unsigned int offset,
 
 	if (copro)
 		aspeed_gpio_copro_release(gpio, offset);
+
+	return 0;
 }
 
 static int aspeed_gpio_dir_in(struct gpio_chip *gc, unsigned int offset)
@@ -1351,7 +1352,7 @@ static int aspeed_gpio_probe(struct platform_device *pdev)
 	gpio->chip.request = aspeed_gpio_request;
 	gpio->chip.free = aspeed_gpio_free;
 	gpio->chip.get = aspeed_gpio_get;
-	gpio->chip.set = aspeed_gpio_set;
+	gpio->chip.set_rv = aspeed_gpio_set;
 	gpio->chip.set_config = aspeed_gpio_set_config;
 	gpio->chip.label = dev_name(&pdev->dev);
 	gpio->chip.base = -1;

-- 
2.45.2


