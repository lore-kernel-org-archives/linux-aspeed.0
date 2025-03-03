Return-Path: <linux-aspeed+bounces-907-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8248C282D1
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 13:18:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5zsl2m8nz3blH;
	Tue,  4 Mar 2025 00:18:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741007931;
	cv=none; b=Uq/R6zNhBrbe2Hh0s/q5XvTLmdnVRhDfGKrAJ0DDa8Ahgob9Hf39KE0+vTAvXWv4ul7g6PJLaeK9V1L1eYotzKnQDV4tWRyQ+ksIY45fJXSaBwplzuqKUmmEWhwiXNcmG0wMmCN0hy0Vjkk14SMDw6y8qEdktQpr46R8AOTf3vDy4ATus1Mu2eJR2WvumdAnahUjyiD3wOYYiyThQtVDI5eTWVpDuzFsLetniT4kEnl76wJseZLlZ7rQUrvgk0lVkGEJJZwPOLdIUlXPscKGEwLf65P2JE/sDOfEdlaN9tuaXO/5G37WVvANbr9AMLGWUKSRLndlp/O3CmCZ+s+n3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741007931; c=relaxed/relaxed;
	bh=1Eanl17qUXG71sYy7CwEaQ1Eemxd4O2oMCTK+HJwW1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+JVsvh88mkDRYmMol9yeMOGbqd6BqwC3t7j6ztrLBqtZOJv0p+UMp+eaATwOw0ij6ViphHdrF2RIXzEyCuu5lFuEUJumMR3oQdxWuA2aO2WUP6Hfo9ePzEwQyPBEUMLg8m37sVeTE6qgr8Kor7cG1N5JOJIRmkZhGy5/yS+6DmcoHukl3N0Umy8vJNR5zOsn6/9ZaFrXC21/tEeNZTLmcrCu9MWA/mQmuvOCOSE4NIhJWpAgIKGm1ho9aYlOsO1vbJjFtiBajth7vJmfo+FnOZo6g62Al39OogFL6Edq3OAYtE+E6BDc1TetCYYdLg6xGS27d507y3tzu/zXatj4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=MAzQZUom; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=MAzQZUom;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5zsk2m68z3bkg
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:18:50 +1100 (AEDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-390f69f8083so1966523f8f.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 05:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007927; x=1741612727; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Eanl17qUXG71sYy7CwEaQ1Eemxd4O2oMCTK+HJwW1c=;
        b=MAzQZUomukWTCAZvVlIeBhp9cVwqnc/Pgvji7pRcZaYiYuhvzclN5px02lkurQuGSv
         QBtFLu4Rqt5ANM5fzD+ipZGrzE8yBYnMsp9+l/QKnAMnp7J2hLRoTm+J9tJV11+zeVcc
         DUbNpiVJNRPqJHqbUr0AO/GkEDeL4EL9GHL9wRcet0NNQsD78b/C+DPgg/Wj3Yny4hAQ
         4UdUC9LtiSsUQkcnXytNgFfcX87fn7y2DxvQ3ReQdr10YvlqntbOgO3wlubZ8MF2Bw0n
         ktW+5xk8lwu9+cjO+ZGRKZNbg85du0CpKIUr85w0E+4mT/pj8Ts54MyeZ/XtB1m1kQYE
         hCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007927; x=1741612727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Eanl17qUXG71sYy7CwEaQ1Eemxd4O2oMCTK+HJwW1c=;
        b=Fwn6TTiNN02MuaQnHvj67m4vFcF7NkOLbgsyfEra3H2Yu9+LqatyJt9oMFHTwPD9Z8
         cL0KIlH+pDzF2Dhmnqkw4+vW/0bb33pIYFeD+SxPilrECSnfuG3TXB3ClXl0JuQ+z3lx
         m/5gwk7CF1mwhVPM6xVxO2zgonxtmNmc+6h+VLgNGZXtGuXDiY6V5pfHRs+XpUzzAQ5b
         6uAOgLy45CJ62mzMwYDoGXRRQmUWS31DQhkyB6O2U8NrVGZ/EOJT8caMzitmndUJLcFX
         TOmUhKtwL1YCKTSjjPSmXaIS56HI0bFoHwvCjYUuvF5FYwy72p+tZ4s0e//tGE1CYkyO
         Nmag==
X-Forwarded-Encrypted: i=1; AJvYcCUzQ3hcqbL6Lm+tbaQbIqtkY0LKN10bIrMwL23mONuhD8MowUn2sdjfRTvMNJUFOG0DvGSu1EvhGEzO9Eo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy2lTdyzQ2fcHLQ9ICbbEyzyyu5he81PQ8u5Tb4jKsG3Ga8dovx
	UvIaWT26fKm6yEeV3WvA2TlhlgxOTiPFN2qVsmBP5BZLEL65X6RNSybTfrtUYq0=
X-Gm-Gg: ASbGnctPKB5YHlBYhoSsTqpc7KYbau/1Ddb1jAyx7kFgCAfgKUJVKNlWxsjxv4NYbkd
	fFMtX4pIW72Y2CZaRQ4j7WvGc05qh/qx2X+W7m0ZSPzVH+h1SUQ8EG8sxwQ82S7hm8k0Lz//koP
	PhxFVG9ItX83+A06Za2rRD6gQ4aZaK3tvW50Fh6IffTOn25Ft7e5WR9p+r2GZmRmWWOo/6q7Bad
	XjR2lBbgB2tZmtsH61R6/JJBZrlQb6Z6hlPT3WOPm55WYPneJOWQBXbAVbJlc7IR+MjN4xZYj05
	TRZlBobhL8af5iDbpcx9IfF2csyv+Sr4Ttx92g==
X-Google-Smtp-Source: AGHT+IG8W48OymLU+IHB9XFSJz4Ws6HhZ4oe3cmcpMbwh3yAlmIGNVglM90Lo5CWs6gLp9klDtqeGg==
X-Received: by 2002:a05:6000:188c:b0:38d:e15e:17e1 with SMTP id ffacd0b85a97d-390ec7c6743mr10583036f8f.10.1741007927451;
        Mon, 03 Mar 2025 05:18:47 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:46 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:34 +0100
Subject: [PATCH 09/15] gpio: amd8111: use new line value setter callbacks
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
Message-Id: <20250303-gpiochip-set-conversion-v1-9-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=IGpiMZp6L9gGWujO4qnSAPvX9iEEZxJHKKOMOCB/YPk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawrsUI2RWcy6gYPrX/W+WpNP5fdKL0VhBngf
 HbvtbNwL0SJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKwAKCRARpy6gFHHX
 cn7uD/9fLib1qmXJVVjOojHi15zCxHxK9YZHqSAzCp7rH94PpJrQVFK0/4M/9A5SA7n/43yhQJt
 q16nhbWNsd656/N/6DKOmlP3alKPdHDzsIIJLWSCtEG/DUuKltm5rByCe83Q5WN+j72Ppw2dcXM
 0QndwPOucqxkqiqLUXTCx9n6rgL9K4/A66JfBJ3k+fnOIKWlQYRad+5Ja54geRp5RofS1D/RWVr
 r0dy0roFTTJ9ZB4kRj0pkWd7EO3pEYWcI7kSIl0y2+RjrvhSrYLQftUvg/JPPXEXds/8aiJ1Ew3
 xURb2djMwd0qp9hk5BgCX8JH8I20ZfXCGI4qWK80k6cMIMu8O3qyTd4CapXeIhFIHj760lTqZLb
 98+Poi2DamuEmj56LQN6R0v4nx4PIQWNEWYclzSyIMD/ThQZwtG9+MThzU9Baz+XhENutJBT5CO
 YRWrfqqV+XAKVNMeeE9szHW2C1uPqGMrLIar0g97JpGjqpHv3qPaIaZHWlq6E9tntQctjiMJ4se
 XimBq7eoM6qsxJRvRSXx4GSUb0TkysTs4XTpOZJf0LeCfU1UTnlQrIAPP5scSCe57es8PqKeVM4
 NhHNMAzFCUJvtRyNFSbOtJziCjPmw/weTEqrkCmM3p9OIBCRqEtfHh8aCuFfn13QvOXKYFsU9fZ
 vV6G4nC/fyB2SOQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-amd8111.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-amd8111.c b/drivers/gpio/gpio-amd8111.c
index 3377667a28de..425d8472f744 100644
--- a/drivers/gpio/gpio-amd8111.c
+++ b/drivers/gpio/gpio-amd8111.c
@@ -94,7 +94,7 @@ static void amd_gpio_free(struct gpio_chip *chip, unsigned offset)
 	iowrite8(agp->orig[offset], agp->pm + AMD_REG_GPIO(offset));
 }
 
-static void amd_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static int amd_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct amd_gpio *agp = gpiochip_get_data(chip);
 	u8 temp;
@@ -107,6 +107,8 @@ static void amd_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	spin_unlock_irqrestore(&agp->lock, flags);
 
 	dev_dbg(&agp->pdev->dev, "Setting gpio %d, value %d, reg=%02x\n", offset, !!value, temp);
+
+	return 0;
 }
 
 static int amd_gpio_get(struct gpio_chip *chip, unsigned offset)
@@ -163,7 +165,7 @@ static struct amd_gpio gp = {
 		.ngpio		= 32,
 		.request	= amd_gpio_request,
 		.free		= amd_gpio_free,
-		.set		= amd_gpio_set,
+		.set_rv		= amd_gpio_set,
 		.get		= amd_gpio_get,
 		.direction_output = amd_gpio_dirout,
 		.direction_input = amd_gpio_dirin,

-- 
2.45.2


