Return-Path: <linux-aspeed+bounces-902-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F258C3DA4A
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 13:18:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5zsf2d77z3bjb;
	Tue,  4 Mar 2025 00:18:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741007926;
	cv=none; b=LE1XibsCVTuHyNRXwIY8orG7RRJl7nrvecSWz21/LQIsPNCnXVjG7gD0HnpJbnJefCeUp/4mlGsNVIhgNZrnJ8v8HQb/0oqwvrZCn9kvitGg7jMyAhK1V2XDS+s6fyHc/HLK5QB0PnCv6U8ITvBD9xgx/KdVB84mBTPZmlB4zso36sB3begPVZJPf79GqZyNq53q/5UDwYz6YWpZieeWRgILtYYZtGUBxuX7j10x8UzoNcsIA+wWIWK7FJU2gXqH4FG2kKY0xL0wjtpNp+u23IcRtt9TSxT4zww0qFQUF4+mi6qcI6WuZZnBs9Y5EMZeoqseg7itnu3PEg4CRPx26g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741007926; c=relaxed/relaxed;
	bh=hFP6OzlnsfQDERRUw+GGdLYipfzpI50/ga4CvHUlY5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lv5s/kgqgL+VcA9e6M8r3H39+hkyXbdvwuyJRHf1ri+n7IUaTg+rPVMklGSg6xgHdACHmimna7VZnmrYWHs+cssiIB9PljOpW0/jZtpi0Ko7LTp3vPTSP6iTpnYI+1wqfg1bZGgi21HnD3oeD0LvEOo+fA/GyPwKhi8ut3edHjBcE5+N+upzgmxk3DIWjsBPQWmO10VuB7BrZ+mmQU0+e6pDVfcdN9YKPycwNzX+LOFlc4UF/XTMVX+sJ4ojsS9DHLajQQFQXYJRSVOKZj/rBpqQubOLFqwmW6OrG0QKDBZCTd2D8Sqoq9uo3yDM2H8O0YcbdbdXuF21U2BM26EHig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=GnJYT2Xa; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=GnJYT2Xa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5zsd1v8Gz30WQ
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:18:44 +1100 (AEDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-390e3b3d3bcso5317955f8f.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 05:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007922; x=1741612722; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFP6OzlnsfQDERRUw+GGdLYipfzpI50/ga4CvHUlY5w=;
        b=GnJYT2XaF/Wldb4G2g3f4AkBqqAR4ElgMp/euu2PHdWhcX6q8yNYF/JgU3OsNo+kSb
         mifXYQxOdtBT9+Ifyp/8S2zAQtan6N98cP/6Ni4n2HxK7pvGmVDOkQbE9kGMI8RuIyl+
         7JAiKf01tdMQOQvod6jRMrtJqM8fwar9+qcHGk5SAG22dpwvHKZ+6i9Z5v2nX9/1NemN
         UhcaCd4APVHzTnm8TFiORk+HcOMR+UDKQX619kaMLEpHchKR507kZ4pqsNQ2Pkc2HfZf
         C4RLNNgfVZiCa66UTGhRINURnzLUY4Uvp9YrM8Pdo3kBiNOZ5ZI9zwSLi/qtKUP+g5NI
         qp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007922; x=1741612722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFP6OzlnsfQDERRUw+GGdLYipfzpI50/ga4CvHUlY5w=;
        b=tDMyDRuH7QFQ8zU66jh0sssWEjrymEPoaKgpBapqfRQXeKbHckrfFxq/mNC+ael26U
         fwnMMEVDCX6HpkN6R9Jz9dY+dKnwKjAQNyF4q1akYVRHBESM3pCGKi/c0azk8flrpZXa
         lVCM99LNFyihwlNr/kWXv1Vna2PkbTe/zSRvZvF8AzMt0+5lcF2qcyYlHbL+5RnJotig
         XFAMbjfuCW9Cq+jBnnPTVJGzcyQg2g/WdrD1WCvcTvzDkHpigij7/8MKUwx/x0FhHKtX
         QcmE52cotUI3vYRzjAM3CxoIEAg4ohIm43H1JZF/QMEVOkIbXqKevZznGcQSFOYB9pjA
         8cAw==
X-Forwarded-Encrypted: i=1; AJvYcCXDvXaFnVtXxZF4qQr84JQglKKWFl2/FShkbSPpnVA78V+ZIgfKKkS+PS4X5FfTneFXC/o3avUra+BBUDY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyd3shWVqf3vLSOI5dVBHsjDxFgtetygPnOgRknv/hztgekPXBt
	YZQmv/yiUzHxlgq0lu4LRSbCjC9z1L66Bh6a6DwdwDFjPgVnh+kesttQVbhAdQo=
X-Gm-Gg: ASbGncuUjgyq+kMV5ECUAvBRhmk4s9tSNL1dbLkm7aul2HT12yGIKrFx1pT7ah16DKU
	0MjSnDS2A45tRST1QtdB0D+2NUnkY3MHA4b5hG28cEIwieHr3VqyySSI5lcrESMBciqtYtOD1uL
	uhrPYCJUDkU29IXyrg7wGtuP4BKXJWb3GBZzjIQdROEO7WZVG+V9aYwFheEwFPGVpZtG+rDcWYk
	+4JhormWP/JJG/vcKCaA9LEwcKMlBzd6V4rsMrNXPaj+S5cYYbFNLCIu57LE/7s/f+JF+HewyAU
	O7rDjz4Zec7zS5zPRMaO++Gbo4gwPe3CPoPNEQ==
X-Google-Smtp-Source: AGHT+IH4JWES9ARnc+bAEeGbW+TGmzRI13+v2x9lWq0KdFeC2YMdrtpeHPu9rNemD9SH+Vsoyms9pQ==
X-Received: by 2002:a5d:47ad:0:b0:38f:3791:c1df with SMTP id ffacd0b85a97d-390ec7cdcd9mr16010467f8f.15.1741007922072;
        Mon, 03 Mar 2025 05:18:42 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:41 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:29 +0100
Subject: [PATCH 04/15] gpio: adnp: use new line value setter callbacks
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
Message-Id: <20250303-gpiochip-set-conversion-v1-4-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2053;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=kaPruJN9Kqnj6pYgKtiRCJyUBIyZUBSHWZ9yCXz+XTc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawqMe3ivpxHTwxjmRFDD+r5+f7Fb5d0Noi1G
 O5lxfuzzSSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKgAKCRARpy6gFHHX
 cmp4D/9jaHcQF7O+UdJIKHTVsZUWHdT/ZGnlWy1V3W1/TlaMF97G5wDnkiNu8Abc/PxBzSIt7Vo
 KBMyBZrdnswEDYNm04jbPBI25aQfX6tWozJEZf9iYmpe9wFlcFTzksQzJpUFBtmKqd6vNbmfItm
 fCi1KIafodHkdb9RUDWAvSu2oq3iv97mq72cqDYzqnwYTFGE3sRihwrVxQf/zbQxdJ+Bgggp8Zh
 bqOoleGxS5pKG8fcqro2cd/HEf4VsjNbjq0tFes+XRILE7ef4PWHacVJFLwiHuR6mgfskXZgqGm
 o0O3Q5FWRrbNpDJhuPWkvn/dR7gqcipLj5GyQgSL4t00/D2oFvkYW5n9LVPpPADv1N/YKiWNr2j
 HInoAV+f0REw8KC8InxkPcpaErGNaaXwgnrAu5Y9HXWkhzcSjYZfS/1xCmXXQKXwZN+Ln+fX4G1
 YccNjDF7ZFOmxClF18WPVkMu9m5kvZjyIqtgnvo/H8X+kMCpX9DR4FsmqOa6rl0KO8IKcge+D7d
 WobcW2JM7A49kYe/ZlTxhEX1pTfXKAIUfUuy1/o3ocVUdiIZjPjBbkaHyimA74usFeUAxDL1+q8
 k3cJxwl8jpJDmJvWpGCh5g+HLssBC0WNpo/UvXCxt3vqB7Wnl7G6Fmsfv/4nQk5KRv4/pPF4sj9
 CHJZ/DGf3QGZI2Q==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-adnp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index d6ae9cf1eb54..b31ce0e337ae 100644
--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -80,7 +80,7 @@ static int adnp_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return (value & BIT(pos)) ? 1 : 0;
 }
 
-static void __adnp_gpio_set(struct adnp *adnp, unsigned offset, int value)
+static int __adnp_gpio_set(struct adnp *adnp, unsigned int offset, int value)
 {
 	unsigned int reg = offset >> adnp->reg_shift;
 	unsigned int pos = offset & 7;
@@ -89,23 +89,23 @@ static void __adnp_gpio_set(struct adnp *adnp, unsigned offset, int value)
 
 	err = adnp_read(adnp, GPIO_PLR(adnp) + reg, &val);
 	if (err < 0)
-		return;
+		return err;
 
 	if (value)
 		val |= BIT(pos);
 	else
 		val &= ~BIT(pos);
 
-	adnp_write(adnp, GPIO_PLR(adnp) + reg, val);
+	return adnp_write(adnp, GPIO_PLR(adnp) + reg, val);
 }
 
-static void adnp_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static int adnp_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct adnp *adnp = gpiochip_get_data(chip);
 
 	guard(mutex)(&adnp->i2c_lock);
 
-	__adnp_gpio_set(adnp, offset, value);
+	return __adnp_gpio_set(adnp, offset, value);
 }
 
 static int adnp_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
@@ -430,7 +430,7 @@ static int adnp_gpio_setup(struct adnp *adnp, unsigned int num_gpios,
 	chip->direction_input = adnp_gpio_direction_input;
 	chip->direction_output = adnp_gpio_direction_output;
 	chip->get = adnp_gpio_get;
-	chip->set = adnp_gpio_set;
+	chip->set_rv = adnp_gpio_set;
 	chip->can_sleep = true;
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS))

-- 
2.45.2


