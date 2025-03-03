Return-Path: <linux-aspeed+bounces-905-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBDCC282D2
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 13:18:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5zsj26T8z3blB;
	Tue,  4 Mar 2025 00:18:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741007929;
	cv=none; b=bSsEue5Nx6iLapL83yqnT8ojgb+BU2OgmfhiCksSvegi60hJVpR0BkG5DhsNI6jqJZC9P8VDEIOIxe4jAlo5bWJ5ecc58OnJnmU4+p6jrcQIF5Jz7aiQxl2Rmtlj8Oaqx721hzaCZJKbqykAnzaudjegbGAe+h1BXwnBxENqB312q8+XHwKHWgb3TWY+B9Azeg5BAFW4bUXhGSSHdNUT+z//rDFLBTcYwUTYv9zIjFRBrBjgu4hqxaGo0O6p9F1ViAMVe5KzqLzuxVySO97swxjj7tswtBmkNvfssyyP8HePs+pb1W7vB/G/J8q0tL8QDBefvefJixGp8Git1fcwsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741007929; c=relaxed/relaxed;
	bh=gz+znbWREsKmtzW3OBAmXUrUOCp/yw4x3Y/d/8vV1Bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b1TWYI9Qf5FCXHBo1IhKbHvkCzGy6/5eot3Y3b1uinIbiu8SkyyPePTcdfPaJI87dvAv3+rR/E2ncGsMUNCWT6623+1sN1Y1/YhaYGZjxyBauvnN1C2ozhVsdrpnpB6UgpjwvkbsOdaAkAqS5UYgr2wm4SuqWC/gFe3TtSCvwB5X/LQPidROXw5K3GntyTUIznmfuxK09nRoUzbnPDHH9+rcI1PgBdzt9i2+rMb6RdbMgL8Ux6U27nu30Grph2Ezd2m58mcJvd8qOEbJ22mgL6CwG2497u7k+LHJvBEpNvcupCkoCEE9oETIidg8RdOs3Tc89lMcO/ZmLLzu5Bje5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=y3xpnDR1; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=y3xpnDR1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5zsh304Jz30WQ
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:18:48 +1100 (AEDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-438a39e659cso30152155e9.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 05:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007925; x=1741612725; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gz+znbWREsKmtzW3OBAmXUrUOCp/yw4x3Y/d/8vV1Bs=;
        b=y3xpnDR1Fl9dYob6fj6grb4OgQ+2THOXUOeaFNg4Hfa/Csi3gKxZmpSwJs31FedcCw
         uhETlSt/UJzCUqsiFs6RlzQzuPlN1+UL73IJc+CbKEjkMyMRc+7jGHdByd6FGi2nImYI
         K2qaMBQL+tv8iwA/+HPPEN3T8OohiHWYPdyKnw9RGTyPYNN7BP9forL579yfmdYV9gvT
         aCj9U4C0S9oA01q66lvDkPQcNRLsy58pPLvCLIAe1IaoJjdTiDxw7VE+n55OQYZYUsui
         ovN9gQXahpy5NfDxQLfcB7m/vCT0Sajs6vgqgegV8xFhNGR+rC4OAKg+BqkKQLSF7p50
         xa/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007925; x=1741612725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gz+znbWREsKmtzW3OBAmXUrUOCp/yw4x3Y/d/8vV1Bs=;
        b=Mpn8dWAr0I49uI5+dh4Cj4TeeOxOcK8tHpwiOrXAahRQ+tyKxJ1WmPgLV3dVymZ8A/
         YcDLdmb0mbyyXApl2hZaCkOIUf/zglrWFuCbERftsmTJfpF9X68XJ4JL6Ao0etzUzGhQ
         5GphYQZa55Y9QFOtLrjgOLYaZrzhtZr7wwyYWMDSN3ZTQknAC5WiF7jhypu8fV89TKrD
         f6DiEwpHPF9diQVl3yeLPKmCAWogO0VveU/wzkaq2gWWcEOrtesic2LP/a7TbvJFzIc2
         EJAfGJiz+g9q4xW+EnGDZoCY0n69sz6xFrdXlSYMmGkn7iHsQ000ArWu3QOvxGQWWQZ9
         G5oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgV/azKyM9tzTC1bAdZBWHJlOF3KkEfMaDg9WiR17uPzTp21Nzqfpx+ETQIvYp7V7YgXVOLEH4uye0I24=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw1kEzUm9sHvRbJP2cL+hSTcV8n7aD21hKK0Fr2oVCnL5aX0TTm
	4I6sO4hpR62b6ZkpmKLJ8APRTPkM0G7xPAiOV7NqWHx1Exzr8+FKuL4aYevmi54=
X-Gm-Gg: ASbGncvKM9iuchUv1uUz11UWJNINMgYchEvu/c716perNkvn655uZbyNh1ebcs/MkL7
	tKG5GrbrllbOm0LISYemu4AXStdX5oB3P+7U6FAElB08rbpIQkN+uDRFMFSomYo1YyyqkZTAIhM
	d6FZ6aTsoJoVpmH6nQcdstPrieGZKYBBwJud+eBhnkhFb+PwZS6JBeh/TQNoDhFcrKoiJdvDAya
	z8jaNLulAlI7Q0tzHIm4dm51ZK1NnblultDnwR3IDowJwJSL8mfEwX7PyTt8xIiXoQYqwqaTMEZ
	T2McJkFF72gTP3K3Zplc7TAKPT5w7nv1a6BAoA==
X-Google-Smtp-Source: AGHT+IEQW7YZHCrSLWSEknFmca2KCALoGeG/H70z0XerHtGSCpqthigF58jSy3FNcBdb29iDiMLtqA==
X-Received: by 2002:a05:600c:5493:b0:43b:c3af:3304 with SMTP id 5b1f17b1804b1-43bc3af34c2mr18251825e9.28.1741007925218;
        Mon, 03 Mar 2025 05:18:45 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:44 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:32 +0100
Subject: [PATCH 07/15] gpio: altera-a10sr: use new line value setter
 callbacks
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
Message-Id: <20250303-gpiochip-set-conversion-v1-7-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=92motqkZmcdTqKDZ0pbU5Fpe7KR5fxlrz4Z+U7eO+v4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawqQygDSg3gkaKutuN+SS1W5PBDPQ7axtGpJ
 lUog7E6preJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKgAKCRARpy6gFHHX
 cuH1EACxW2kuBBYKDwQHK83+US5eYzcAEXawXkCLyQoz2XEfFhdxD1QimIFJm1EqYBPUh5CBWOL
 zxkL3aKSAQoJY9jWFS1zvyq4/gZPTJycJKRXlu+HFjzqz/79hvUZXEuHFyTtXR54uhXDFki5Mb0
 4o2PkqsrKtU6lKxwTvH0+TS2/iEM0KOfbz/v95WtFK1jQdXS3aQ4h8CWtCMk38CElYwAVbvkEin
 FUO2PFSqtIULt6+l0Pz2dCU4CyDlX1gtFbx8WCGsAqEZpCVy8auMyCJxXJKdb+OxQLaHuBviW6t
 WYshDG8yH/A4XF8qXXQVjKun41VUgQERbIG39PWLFzBy57Mt2aPTwQK2+++qcUzuu0WOIRqiuoA
 pX58nz5K2Ygn+zXT35ywaDi1a2P0G8L8+ErRo2EuKTZ8Jb20BR8tf7oeKLNu3Bls/15jxGHfaS1
 mO8QBHt3R0bLpwCpgNeRiBtS6N7cLl3iqAqhdn7k21X7n8mvTszallAnm3vrD7sYz9ocWHaSA4c
 CvGPG6EjE+KhtsbPaTm87Z918cA8JFDaq8Ey0dvM2ITRG/Kw7hUBZw7T61YBjIXYTWgun/siEhN
 QHSXI0VHOtUW40UFWOcUyoi9vM6C3GVuTarMHdLs2kvL7JyDDe/b6yX/ILTUitQx3Bm6dWAdZ33
 MEJlJpdfI9kdwAg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-altera-a10sr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-altera-a10sr.c b/drivers/gpio/gpio-altera-a10sr.c
index 11edf1fe6c90..77a674cf99e4 100644
--- a/drivers/gpio/gpio-altera-a10sr.c
+++ b/drivers/gpio/gpio-altera-a10sr.c
@@ -35,15 +35,15 @@ static int altr_a10sr_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return !!(val & BIT(offset - ALTR_A10SR_LED_VALID_SHIFT));
 }
 
-static void altr_a10sr_gpio_set(struct gpio_chip *chip, unsigned int offset,
-				int value)
+static int altr_a10sr_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			       int value)
 {
 	struct altr_a10sr_gpio *gpio = gpiochip_get_data(chip);
 
-	regmap_update_bits(gpio->regmap, ALTR_A10SR_LED_REG,
-			   BIT(ALTR_A10SR_LED_VALID_SHIFT + offset),
-			   value ? BIT(ALTR_A10SR_LED_VALID_SHIFT + offset)
-			   : 0);
+	return regmap_update_bits(gpio->regmap, ALTR_A10SR_LED_REG,
+				  BIT(ALTR_A10SR_LED_VALID_SHIFT + offset),
+				  value ?
+				  BIT(ALTR_A10SR_LED_VALID_SHIFT + offset) : 0);
 }
 
 static int altr_a10sr_gpio_direction_input(struct gpio_chip *gc,
@@ -69,7 +69,7 @@ static const struct gpio_chip altr_a10sr_gc = {
 	.label = "altr_a10sr_gpio",
 	.owner = THIS_MODULE,
 	.get = altr_a10sr_gpio_get,
-	.set = altr_a10sr_gpio_set,
+	.set_rv = altr_a10sr_gpio_set,
 	.direction_input = altr_a10sr_gpio_direction_input,
 	.direction_output = altr_a10sr_gpio_direction_output,
 	.can_sleep = true,

-- 
2.45.2


