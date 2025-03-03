Return-Path: <linux-aspeed+bounces-904-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79448C282CD
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 13:18:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5zsh2565z3bV2;
	Tue,  4 Mar 2025 00:18:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741007928;
	cv=none; b=C7tw10LmPhtw7XBWeWTKCqU07ow1/CxfbeB38AFK8FYTTU/EWquYbF8R3+zoV7biIkuULKTMlS1+VcAil9K9/O8A0nB8oi44SK+zVrTbPTfIPIhXVJv+ywTTVW0Zz0SrBMz9aPlTm+klCkxGuI6zmMu37xv9RYYyAaWquiqC+Nkb3tlQVarzPQhJGhov3YOMyTRNL/d8us9DI554Y8lC7BMgScDc/tt/ZWxVa3hszRUHiv1UL9c7SYK1gfbqL8Ti0SHALL+csCm5igPsnFo0170wlS9gNQpfCfMEHQ4x8i4PZTvQ+TSDvLwH2Bp6F1xC4RRykPQlazD98+Pa9mWl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741007928; c=relaxed/relaxed;
	bh=vBMDp7aHXRNt/RwICrg1q5Lp1fT8OK4mUnztK4V4pSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6a9YL/wELVaOHAodhsowJmSB7IZRW+ntnpSq0UHVMlgBg1Kp09mBRcdDz652ymm8RqfUrOxZbQ+0k8Jns025XF9PqVnfcWGaz/exHO6MmGRYP3zor/8lZ4gnAQnqZd/InN5vKkG/z/4nWU/uEMxjUckd6L5gSODWhzydkDXHFn2OEiQO/8/JD4sCQsuElQQ2iyUmAL0n3jQqauIJVS376CxovdHnt7S9myTjZoUp1j1ghwi221W8Sr6eZQL9EAyCNOWTGJY6kjIVYAUfxsV09+FIgYQJK2z8G+K3rjfvSFE3mctbVui2o3mFgyZ+nbjJ3WxwvD0AEzBtxDNOOBc6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=GyCmm8Tc; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=GyCmm8Tc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5zsg2bdWz30WQ
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:18:47 +1100 (AEDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-439946a49e1so28173395e9.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 05:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007924; x=1741612724; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBMDp7aHXRNt/RwICrg1q5Lp1fT8OK4mUnztK4V4pSU=;
        b=GyCmm8TcPjr4S0BmABLWbbIWeXCcA6nnAya3h3TTPaS7B3jG6WHy27c1CmlOQCO7LV
         mzjwcVVLLJHxY5k9WZbNVwBaVZEKDxhNpbYzs33vacDcDdZ8hwxt9gHfhjmoRXBxgG49
         lzhxMtOZTU6m/1Gkz+vOoPjDRNtmBkcFve7XTWf27ajkz31urTavsP6IeK4SDrkHza5u
         C6njTTSa2NgtUJrMs7csmVcTmNMaGrqoq7aKmNtpIZ2EzU7CXIos5YHjzdL0qsmqTAkR
         8+h4ruhc+3c+moxuwAQb+2EZ8j8yPcUuUuZuqWJQYX1j0Z10pG1Q4s1svHEVklsGS6mu
         wsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007924; x=1741612724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBMDp7aHXRNt/RwICrg1q5Lp1fT8OK4mUnztK4V4pSU=;
        b=S2E/od4n8DxhpeiT5b4khcVHCJWUqHSVdpjIzUeOiXfRACkyAFzOsULLcvIN9zQxAb
         L6/m14t7hGtOEntVdb06Lo/WI1jQcGOJmncjzcviY6ei3c8x3hdafxqTdKQ0D10w10bS
         SYq/iyEdUDTkb1mhMx9wNZU9A/UmzDh7iMU5lZ4Rv6N30mfG03I/5/a2Vq1YFet2beY2
         zexFOMQpyXCFYlfeZkD/3VgodrQpj12hnMUimgPHfDaYa6m/zzYW8NeMqa+kGt//PYQX
         G8MiOQxwunavKEnSZIrBXc4Qf4EHwxfbKUeffm8SHkGojLU490KgjPGoT4PzkZ4T0jld
         zwdg==
X-Forwarded-Encrypted: i=1; AJvYcCX5nFmv0Ww8TCDO2w5TtAIuig3WwpOAXFZZvMQpMVyiOWUSAQPDyWzKPxavIdqsRVdeTYXdKsXCxTX7M7U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxFewT8Ih9EK7R3EPmzKDA5c6Zjd3v6hYOzwkc+OggNWyCJarPe
	0WEx4j78Dn7ErqyEfsPQRSxFfYTPWspj1WvrvrUweLkxcKzz1/gVrfk2eXtbP54=
X-Gm-Gg: ASbGncvzmWf6Za9dwko16753ukmcZ312JIlCc9zEZ2Pltk0yIrWZL4Ty/E4YnZtzgDr
	NqV08yI8saM7awakeafxeVtP47W8twCczGzK8wzwBld1erwb1tET58Bw0I9/gGHHxt9DlW/BUlw
	Lt9ELZflrkZgcn91O/1nrMsoz3GTY6JEXplaHYOFzcLEupBuKTI7TBJtZKw0noEqn9NYyjnquls
	chuD3IMnhca8ZreF4f4huww9HBf5NLpMj3fU0l4dyhJxz+dzElng36jNQpryVJRDyPxPAdJgXgP
	xqE7Fxj3m385yL4U/0pzVL2/JlIB4DuQHY6weA==
X-Google-Smtp-Source: AGHT+IGbJY5Jo+WiS4mPjsCw+ExPOHOSH2GviMjPeJvWFYMKh5onFXn1ZivjmcF8FlnAaeL3hMO2aw==
X-Received: by 2002:a05:600c:3b97:b0:43b:c7ad:55c2 with SMTP id 5b1f17b1804b1-43bc7ad56cbmr14809505e9.6.1741007924329;
        Mon, 03 Mar 2025 05:18:44 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:43 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:31 +0100
Subject: [PATCH 06/15] gpio: adp5585: use new line value setter callbacks
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
Message-Id: <20250303-gpiochip-set-conversion-v1-6-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=rFPESwnteTAwQY6BOrgrkBqbk+imePLRfwcTrSAG+yU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawqPjfHUJ4WPy8suyZvHErNCeJlzfCBlVJei
 RnIRKpHR8aJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKgAKCRARpy6gFHHX
 ctpjEACiBsM6B6IoFrKlVbwDZcEaVstk/hylqUDuoVuEF8O+FEE9xkLlNz44NsSw8kzO+pguH4u
 HKN9AaGuVpIcI4vAQv5lislBsX3xuBv2zHzm49rk+yv935TLT4MKXOAnVI9S2TLfvlEFdCUqjYy
 xakIdKPXiHkiWCmNrwmy3tqB5HwwbQ9p2NEM8l2+W/TCkmT+Pz2NJ3R4yT6JAjSeZr+2k0d5a0u
 eB6gdaikIt6DKTSX6pjOtXYEszgjOhzEYBmgB4l0cF5S7EuY3tn9Dnr9UA+YHaCbQ80J5IrMP8d
 lRK3fBqv5nJHcj51oVIgAUqYZ6xp0rXFaFCfTNRpbgYiojTCkRsX5kp/E0AMt0pPzA7HhXfsdvw
 0i6HG/qKEnEk6oOw+kUQKCQKZMKIkHKjvuNgPz0i6mVcAoXFGcP8qSyMEVBIGPdpMlBVkTXxqk8
 HI4W0A+4wV2DnsAZIfTNrPfj5kzl/PZ5znHY9+rglJipUo9/pnLLBDLrvwNtJUAtRrJEqVpJcRf
 Dt7hopEPcrdBWBcaJdswJw2xmw1GScQ6wfnCpvkjveGWaZFpnijBCLytD96kbhMOzY8qneMcr1t
 yXEogC9FoR/nvMjtW9skEXcr1twoXt1t66yuuNXqbz3LYy6olZT9klECCt3qO5JXfkKmt6lzIW0
 4rFJI+Vr50GJimg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-adp5585.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
index 000d31f09671..d5c0f1b267c8 100644
--- a/drivers/gpio/gpio-adp5585.c
+++ b/drivers/gpio/gpio-adp5585.c
@@ -86,14 +86,16 @@ static int adp5585_gpio_get_value(struct gpio_chip *chip, unsigned int off)
 	return !!(val & bit);
 }
 
-static void adp5585_gpio_set_value(struct gpio_chip *chip, unsigned int off, int val)
+static int adp5585_gpio_set_value(struct gpio_chip *chip, unsigned int off,
+				  int val)
 {
 	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
 	unsigned int bank = ADP5585_BANK(off);
 	unsigned int bit = ADP5585_BIT(off);
 
-	regmap_update_bits(adp5585_gpio->regmap, ADP5585_GPO_DATA_OUT_A + bank,
-			   bit, val ? bit : 0);
+	return regmap_update_bits(adp5585_gpio->regmap,
+				  ADP5585_GPO_DATA_OUT_A + bank,
+				  bit, val ? bit : 0);
 }
 
 static int adp5585_gpio_set_bias(struct adp5585_gpio_dev *adp5585_gpio,
@@ -192,7 +194,7 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 	gc->direction_input = adp5585_gpio_direction_input;
 	gc->direction_output = adp5585_gpio_direction_output;
 	gc->get = adp5585_gpio_get_value;
-	gc->set = adp5585_gpio_set_value;
+	gc->set_rv = adp5585_gpio_set_value;
 	gc->set_config = adp5585_gpio_set_config;
 	gc->can_sleep = true;
 

-- 
2.45.2


