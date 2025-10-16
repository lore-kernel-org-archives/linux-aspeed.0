Return-Path: <linux-aspeed+bounces-2473-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40150CCD19E
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Oct 2025 09:09:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnMbT2ptyz3bpS;
	Thu, 16 Oct 2025 20:09:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760605781;
	cv=none; b=Kz3rdlO5N7Gh0M4hJWnvCPfGYo79dFFV9CAS0uABuWVUxZuDaEvSK1AVZ/tyY1pqL/+uI2J/fyxLpY9qG9TAbnTMSWXlNd0hYSNMez1AwBn46lFKg15tj5EMow1czfXYjl5aJaQQ/g4IqycNSgu4J/s/D7iESbuFLMUnUz2qfgrRujHiz04ybA6ODyjm2eX2+pmYb0Ypdi6nfyH02LiudqWJs/chpmUW73AmwyLXZPPCH4YFyQlMYklMqDmC+NRxh98rVVAA9NhcTauU0kr24ExvQII02jw4DfsusWR4CmMXaRKPTM4FmWuOS0aQzCCNK0YYz3iAdxv6oYENlzXC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760605781; c=relaxed/relaxed;
	bh=OFJZE0pKNCv07L2HqBXLecNS6deU/WhVUmv/yCRIV1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TfkwS7A5yQEJ76MC5n/BUDXjh4Yl5QEmwZ0SK9fV92Eo53l9XbfIzW/chRGBqydG1gMbWzqWZAiGWbZcBeGWURlUROY9mnaBEI3AgwSkvgraPkFb5D/3WlySAJ6JOoShp3QUROxFIerAWiGSA1phq7OCw/VdBrjfBy5kO7GWf8DWJOkMnodzE+3vbcoLmsisild4R1On/PUPnj8HUvGbi8enZfk5KfRQE/W06I+mMfszNs0jGOJ5MydHSEUACno+Za38mg8vlQwXiQc9/akAOtItDywazap8BQ1qtEVeadQYC27pXp+5zRTkUGMmks6HruRHnWugpoaEuPCLbQWR6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=W6F03A4N; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=W6F03A4N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnMbS3Hs2z3bvd
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 20:09:40 +1100 (AEDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-42701f2ad61so140612f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760605777; x=1761210577; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFJZE0pKNCv07L2HqBXLecNS6deU/WhVUmv/yCRIV1Q=;
        b=W6F03A4NPu9oem9g30vof0anyNC2FyTddpYPkFZ9oefkz1jG0jVgcKjFR0pkfKRMcO
         MbtBxrABIosHccWOlIDS7/+A1uTQYpwGEiAK5gdmC9ryzZCxGN7JCSrjWiOVMJ2VhRXT
         LMNgM19CMuwCb9r9LCutSTT5hWioW11rmXvF/B0D2zCzFxo715XUIdlzSq7REho7upw3
         chAgzDtCqc6HrQa4Yh2xJONJ5BSx4/KfiDSdU1wOWreVwSUS6vKbQnb2EEihcm/b1QnH
         AMzMLrwmPmFG8ngiIDFnm1obuYStIzJ0SPCe5FHr7BG5WSoDL5bGEoIMLVr/I71FmrpI
         T0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605777; x=1761210577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFJZE0pKNCv07L2HqBXLecNS6deU/WhVUmv/yCRIV1Q=;
        b=hYPDjnU+fKw3OuSKIXIzSOR8paG2/bGB5D32ipvtHmMatsvHlqy6l0zxXuaSN8i/MC
         B9VoM30eEDaNIv3+fQ22sWFAti13Hex8JWzOAVhKe6NQnN+9m/9gqzBEortp5mJHdgti
         yhs53shZyKqML4e/H0EiiSadN5gWLqX7mcEniBUrsrXAvcQrh2l0hfwLoZ0KiZ9oqmEl
         lBe59TmJHuQ3DB2X/I5NKRlE1hr9SBsS3BGn60Mo0FiTPBLsflpbNeCgJ99Gnjk4eU9A
         37tSEKMrU2ibg9uCWcssif5uVwEU74RQ8kl+mq9mooTFZX14lj+wywa4R6XOuP072pvw
         iIpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/+L3DHCfdETt4de64JcCnXWzCiu8UbbeBepwTOUAom1ukr3HcrASY8IcnlKVJt5z7oTDze3gLOrxRAjY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzBLt/kpbaloZs2+CiZr0s0X8WyNt+ute3FAyK4ublxwrgoP1xs
	YE14jmNy/h51hDLVCbe6qlCkp5Zbeerb6vgQDBbVHpLHLhkC5dSQculgBUCKNKY7HLVW4G5LyvS
	JlkGlqhYJaw==
X-Gm-Gg: ASbGncvPeEVFjHDiZZOodFGOUgQosy61KwKNVPI+MOAb+ruZ0PpWuoojrmUR8ZUMmzu
	yuNIqF7VA7zx9OsWm3/ACXhyYLTBQO4y8TzH8kBCpXV7tZ+h756rupAZLbG1i9lrIroc5CWyqVK
	+vnn176P8F72HSn9fvsFwLSPGsCG/9vOLLYUNi1yyzSDU+E4gjkF9iTUDzUpb9pWS4OlRhhqTsC
	RzR98GB8+IbVxehUc7aEvzFpKI36i5Lbgpes0rY0P8NvyAskWLZNLu4kyzJPLvYu5dntif5phvo
	6AGYDMnUh1VeK8P3Py7dnvDEfL4Ae//rVA+HnoRdpMrnYihQYLtngUCWJK3oXKu0TGim6nyxzZZ
	V8WYXnCwWekN0cN2DcOLSsfT8fIhEwFd9G/+E8WDiBP8QXI541SWFkDuQ2kNqh7k6dY7xZQnuL+
	izoTYdsiJucYM1Hq2Q
X-Google-Smtp-Source: AGHT+IFdyzKUrKRAlW14tVUX4b2aHHspc9PvsRC+rGSFJEZ9Pd8418vrWH6Ug7r4l2yDUGoozqULLQ==
X-Received: by 2002:a05:6000:4014:b0:3ec:e152:e2ce with SMTP id ffacd0b85a97d-4266e7e0149mr20224020f8f.32.1760605776501;
        Thu, 16 Oct 2025 02:09:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef97:57cb:86cb:f7c4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1284sm33191287f8f.45.2025.10.16.02.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:09:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 16 Oct 2025 11:09:26 +0200
Subject: [PATCH 2/3] gpio: export gpiod_hwgpio()
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
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-aspeed-gpiolib-include-v1-2-31201c06d124@linaro.org>
References: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
In-Reply-To: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2579;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=XUEzgJKIWaOU7M01Lj57Hof44CTqsVlDHoOHP1+/564=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo8LZLfz4E1D7KIi+IF13RRnzlttgMRQMtMTXyT
 T8pl1U+bZWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPC2SwAKCRARpy6gFHHX
 csGsD/9IG3JL4wNs996oayX3obUxxPuPx7WtnTFG9Zz/7STe6Bs3vE7iYGDEdB+7w7c0usFGx6H
 f6bF4sfw5xMl7/nWM/BZhreiMkZ/5arno7zwm6zSsUJdhSSDf+LXFe3TUcoEF1SJCGK05XMOkDP
 FfMMW/lggT11D2LyLxFwwz6Dndun07u/ARkuQN2lVIsVuBZirAkxMhglPJctetYBczNNGK3Y05N
 EztIen5eCJ64VX0UFV7ZRSHosveM3eVSOMooQo6KFWqJ7tHHKxFjsulCtbWRSR5Msho6qHxc8cp
 G38EOz0ojt7EXrSNICnK4wGqSMEx8OiWLC9IveXoWkI2D5Pcj40w0uQAVqWH9t9oeXjDBlCoKXs
 CVCkqk/6t2wI3adax4H14MRqGsAEspJU1x3ak3L6WrnL5Zxo3FtgotN/dUIhdC/5j2q85v+oIho
 qXLZE1Pn7O/yNa1jAEk0JTCwbKRLLFa0UXGKJ+Dgffeae/KEmGXTZw9yGO9T85be16egWax+jVS
 cwrg0juZgZKe1A6zwlrctxg356u0V14r2yO+zGmjbVkcB7E3V4wWAHq0hEM82sbwXaa9mYK0A2K
 tmQroP4qMsKE1onX2wQ9SYB0bJHw+z7/IHutRY/XvVAjwZyjFKOLT2MvnVcgB8J4g3xpnU1h10c
 lzMNmtNCPdwKdNA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reading the GPIO hardware number from a descriptor is a valid use-case
outside of the GPIO core. Export the symbol to consumers of GPIO
descriptors.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c        | 13 +++++++++++++
 drivers/gpio/gpiolib.h        |  8 --------
 include/linux/gpio/consumer.h |  2 ++
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5a450dac8f3acea3e381b09767b9fe9c9dadc2f7..a81981336b36db49d899634feafcd9bc25edf96f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -235,6 +235,19 @@ int desc_to_gpio(const struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(desc_to_gpio);
 
+/**
+ * gpiod_hwgpio - Return the GPIO number of the passed descriptor relative to
+ *                its chip.
+ * @desc: GPIO descriptor
+ *
+ * Returns:
+ * Hardware offset of the GPIO represented by the descriptor.
+ */
+int gpiod_hwgpio(const struct gpio_desc *desc)
+{
+	return desc - &desc->gdev->descs[0];
+}
+EXPORT_SYMBOL_GPL(gpiod_hwgpio);
 
 /**
  * gpiod_to_chip - Return the GPIO chip to which a GPIO descriptor belongs
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 62d4c15b74f580273412e6d432ab306a2d2fe682..14e6a9807a89da6d7c6594a0a2de5f5032c49e0d 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -273,14 +273,6 @@ int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev);
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc, unsigned int hwnum);
 const char *gpiod_get_label(struct gpio_desc *desc);
 
-/*
- * Return the GPIO number of the passed descriptor relative to its chip
- */
-static inline int gpiod_hwgpio(const struct gpio_desc *desc)
-{
-	return desc - &desc->gdev->descs[0];
-}
-
 /* With descriptor prefix */
 
 #define __gpiod_pr(level, desc, fmt, ...) \
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 00df68c514051434e6fa67dc2307c6a8ce4ce3df..994d46874d560416175c9099e18180237839bd4c 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -171,6 +171,8 @@ int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name);
 struct gpio_desc *gpio_to_desc(unsigned gpio);
 int desc_to_gpio(const struct gpio_desc *desc);
 
+int gpiod_hwgpio(const struct gpio_desc *desc);
+
 struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
 					 const char *con_id, int index,
 					 enum gpiod_flags flags,

-- 
2.48.1


