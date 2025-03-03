Return-Path: <linux-aspeed+bounces-908-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7210AC282D4
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 13:18:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5zsm56Jmz3blR;
	Tue,  4 Mar 2025 00:18:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741007932;
	cv=none; b=f2YEYdlbS65n8hlfuvwgNYHiEy88lOhfsgtte2CTESSlE5yqoTGA8Pj0/n11kUqaW4sDhUwNezOc0FaD9GqVHxsW3pwYvqPVh6mSUaHS23a8mCok/7do4MQkB5K1wHnfdp4CND/QvjwD6n+nCnDrT63qATka6ZrSWoEfiRek8xB+WlN3/F3jaN+UbFI+Xm2uOGfggWfgjRWZPQ+E9UIBwCdUMeYmXcbSSna3BZ45LoX7lp+VPzOtf4AP56KbJmbo7GnQWLObPseAwCznNCrM1OIK++e4SCQhhXwPmhv0fM9N8Mcrk1H6tgaFLL9nflfK+fB4Vj8U8+s8w74p0oAGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741007932; c=relaxed/relaxed;
	bh=tcjPMcYJBZ0o2cTrKN4oQq7L05UvaqKLS11WKTvT3CY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k6ZQPkoCjUanbpfvdmJ28ZERzQLpmy8dF+nnzvsx3FSatPyw2mDxW6m154D9TWoW6PilTb49FvmgDkz5fgh3Lvmvfj3NJLwfSHWByEqbfpIn5IMkSL4gmvoYhaQr7ZllWKhXduW0or3JUIy73LdlCyFgBZHSFu1IVtxgnPQnLd9ATSd7VaFLRzqMXpac7xHpFkkYHo1UMAsHPlA7seP0cYpi7NThbGlWnQp6cQ5vtMA9yqTgeEKgU5L8wmIESMm1qKq1wcqtzsgiYWeTXc00BEW9/6yVpaKdjcRJ5HdTG47HoHyxM99NrsUD5pw+3IQlMhr1YQvk473gIV00pAbtvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=xc8/ZK/0; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=xc8/ZK/0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5zsl5gprz3bkg
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:18:51 +1100 (AEDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-38f406e9f80so3402462f8f.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 05:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007929; x=1741612729; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcjPMcYJBZ0o2cTrKN4oQq7L05UvaqKLS11WKTvT3CY=;
        b=xc8/ZK/0udU6YckifeOJjBiqZV6dPqVAenilkoWBs26xViuNL0ZqrfJc7O27mabC56
         AU9iQ1j2uLjJoiqLAsB1gtSbuUtizwdP/FyBulnvqfG5+8/9mZAcW4v3nq2yVu6l7pE6
         rzMtPkiLs2yT92QM8EgfFIYeC/tSl5JMClTe/14gWzt6PB4bwh+TP3rqcmOmX39uw4ly
         EvSWKikDgV6B285oPLVCidGtMhQXOaoi1+fuTOA/ugHBHvell6Yy3EB3YYzQa4q1DyTu
         06xIPRHiAUV6WUzZEQDYdEwECKYqZ/qCvBnmzL1QCbzH6BFipsJUQ+ovDfKDpfO6k7aK
         9FFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007929; x=1741612729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcjPMcYJBZ0o2cTrKN4oQq7L05UvaqKLS11WKTvT3CY=;
        b=t4ez6kr9/9RxwjpLLMjbBuVcavv2EQEswB8EKQhtaGNCujfdAhBJPHdrAclsySgSsv
         9kFuydWZVwqRunNQcSZR1ovUl33hopAcLRoe37RCSlNxBmOtLLpsmuMG3taUJQS2Ic2A
         r8GEp8TQ9Ify7/D1GvUMVUL9q3gFhULhXMhFPnWTyUcVSUhIpD+/ool2CVw7yhxcbV94
         qoMZSFyyGVUiiNcAAIurpKIIV3k52rxagTzkqeztUxuLwtdVrjkII75aMIqi2bKXjJH/
         Z2SVz3s6rtgih8X/krf1AAX74y2D+glu8pB6gmsR86G08gMw4aWG2/xG5k1hLgdmWk5o
         gcAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTxKHaNJ8V1okQhSk62mwu4q5SF2H7YS2suh0FrT40YXiEbkJc+zTVj7Z43UiVLN4QqoRUB3PXP+oPf8o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy8KNqRuH2HK8sqJWVaZvVxctkxyetROVfhr790SawsrdktJnnP
	cTaTRU31NiT15KFG9T9ghzHdwQT1YhaUtgeUVbehA8E5YaLbs+b8HROZdkiisSg=
X-Gm-Gg: ASbGncuMFTABcxCwwDeL5i8yCGwH4Ify6FhgNyUKSbF/s7mgeafMHJuSecPasQUcO0J
	tFsV7RorwP5mhzrpveAQGPRJeqBla5L+ioc/lAoJ9yoFskxyp3AXmwPyKUmHRogA9+Z32KAdF0I
	ek2XbIKIM8iF9X6+xg6dtb/Uc3Qr/Kof++uTGsx+tasAqhGqGDkspxxRdNIM8Z3oEihknCX/Sig
	A+uxAIhFS8zfuxk9DaDkIoL4SDHFM0YheJSyzopAAW9id/jn7vw6wOvxbaDHggr2sUVwRt66D3A
	G0EmlHt6+zKlJwpxiZFtqqNHtv1p3m33dhH+aQ==
X-Google-Smtp-Source: AGHT+IFhho4idDCteO0g9jy+tOrP6KrDeOVzx+yLtKrh7942wsW3Cz+EGc7Oxn5Z+QFnIfxYQ2MoJg==
X-Received: by 2002:a05:6000:402a:b0:38f:2efb:b829 with SMTP id ffacd0b85a97d-390eca815a6mr10808948f8f.50.1741007928914;
        Mon, 03 Mar 2025 05:18:48 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:48 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:35 +0100
Subject: [PATCH 10/15] gpio: amd-fch: use new line value setter callbacks
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
Message-Id: <20250303-gpiochip-set-conversion-v1-10-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1534;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=9eVt33K4IbRQUOdQWj39q7CiV8Th/sXfepGKt9kNNRE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawrbxiPGpQVYAB1cWmhKX+ZK1p87IdH7rSqD
 6Mm+ENK85+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKwAKCRARpy6gFHHX
 clwvEACG9rCLcmUYrp6fcssfEz6AE2R/ukaohKncxCYYbAX/rW2pV6g+qY6GaJWEFP/n+qRUCca
 ImG6zhs+hxyTBrKTa/UlVdYUJMjn4SC2ZsshH4eCzDYkBTiomLn58bzkxBStRBammI+K8qAMe+W
 dCldrLdfZs5rcbotRVzZ5euHIH8eaxeLOcc7+h/rjfEPxvoo9Q9OW1xkuXDdlGC84fhe62YuFQc
 WXdlZUhLBFXpS592viL036bqrGlAxbLiyeipEndPdG55Gjf4PA4N5d+gk/7CTfBaKVfogJoAJpn
 HXL5h4V2j4ZYkhM162i/zGVjbCjPAAGyLXeXM0iKK2WsHFw7YK85chRrCfeNR27SL+KAggdJFDG
 x6Sj/xaJb5rI2J6b3G+kLy99d58hPQyaUVABsOxZHbaz1Y3gn+esMOnlMvCmFY3t5/8CQBoaZSz
 6XuVOZi5+dPUcDuKWKd7+lUtYO6o6qxcDz0ihzBmZTZHvZ9C/UjaPSGEyWqFZA5uEsY+M/BxYn3
 OmTsQWqVYC3khOl1eGCcdDsPjXVl/JBSdtQkwkLTm43s+Mrcn3DM/Z0y0qbEhYFDmcFbEnhvF9A
 w55Wpdx320FOGUTebh6MXxEg24zWayCUlfM9fuESpR/+LoXYGDpe3LaVTd+KG6tcYr0WqBZEuvy
 9Imns1QzMQEPTcA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-amd-fch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-amd-fch.c b/drivers/gpio/gpio-amd-fch.c
index 2a21354ed6a0..f8d0cea46049 100644
--- a/drivers/gpio/gpio-amd-fch.c
+++ b/drivers/gpio/gpio-amd-fch.c
@@ -95,8 +95,7 @@ static int amd_fch_gpio_get_direction(struct gpio_chip *gc, unsigned int gpio)
 	return ret ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
 }
 
-static void amd_fch_gpio_set(struct gpio_chip *gc,
-			     unsigned int gpio, int value)
+static int amd_fch_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 {
 	unsigned long flags;
 	struct amd_fch_gpio_priv *priv = gpiochip_get_data(gc);
@@ -113,6 +112,8 @@ static void amd_fch_gpio_set(struct gpio_chip *gc,
 	writel_relaxed(mask, ptr);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
 }
 
 static int amd_fch_gpio_get(struct gpio_chip *gc,
@@ -164,7 +165,7 @@ static int amd_fch_gpio_probe(struct platform_device *pdev)
 	priv->gc.direction_output	= amd_fch_gpio_direction_output;
 	priv->gc.get_direction		= amd_fch_gpio_get_direction;
 	priv->gc.get			= amd_fch_gpio_get;
-	priv->gc.set			= amd_fch_gpio_set;
+	priv->gc.set_rv			= amd_fch_gpio_set;
 
 	spin_lock_init(&priv->lock);
 

-- 
2.45.2


