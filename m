Return-Path: <linux-aspeed+bounces-913-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E15BC282D1
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 13:19:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5zsv74l6z3bm3;
	Tue,  4 Mar 2025 00:18:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741007939;
	cv=none; b=cCmszrFo2VU0IN9IhI+6wdxITfbZrl4CaxMrH1Vf8YXp2uwbGFeuL3I4uEtcU3BjEAoW0AHKJZqp0d3aHoGLdEm0OqayyVoMBXolewvROBAbX6nBM4O7odTtEqWZyx64ImtP7F/xFkJnYwaQNsMfsyc0ZlTN9k5W6+WNZd37RKivDE+L1uU05BRL2uv4975zytKm2Bcw+bH0PSR700VASDmFij+Zy3aMaT4eFtTXrAokYkVaZy7AcipqDsuYxw4+wy6DFLXkOcPVdxx2uv6jOjNCIJBTZUyz/TTqPlCAHXQOJ6IvDwPOSmGxKg4IZGoR4Ia+haky9T9i4Rf4Fnx5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741007939; c=relaxed/relaxed;
	bh=qYy3OxmCTfeXmKWW1VbewLs6rP6H3oG1fco894i6r5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMPCIJSKRFZueNdrEtLBCBYgQ1MFH4oca05al19yJksp79WU3I2Lt/mhUmTlIKN7ipvxhMdXy5GpFcU46U8CdSUPb6Ptr3d7So8zMf3yM/DQ3e8v3i1+rMOCBbnOU51zbzK3KXQPoLUyHTX7KOV9SHB0jk30jycQgd/oNzAzXmbwiavJ95hFR8GUlnEdKWG3UrMU3+Evpc6zGkjAWGb6umt6WxiwPs+dGRzvuiFsVSTDuXNw4R2D5Lqtr/uarkA8zmAycb/tiKR+MuPEBkNrnW8Ef5/LEDkVJ3MlQ3ulQSVu+vIRL84XQMZCUacVo2KOaxgQ7d6TfRQG4y+rnUpiOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Z/z9s13y; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Z/z9s13y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5zsv0B5Kz3blK
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:18:59 +1100 (AEDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso27979385e9.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 05:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007936; x=1741612736; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYy3OxmCTfeXmKWW1VbewLs6rP6H3oG1fco894i6r5M=;
        b=Z/z9s13yL7ZYOaUIeUkUp5zD72rV7Bl4VhYPGNvSBHqOXnh+zs3hpqYRIKNUpT3uCT
         h45NZ6ZQrnSMHJTlDvE58D3OA4D7cFdJuwAWtngUfQUJnb/hl+0P+rih/rnp+RyJg01t
         21vO6BaS/CyDIcDzuzJSR4JQUkiCCbyn8SlbfGheHa6RY4K06DZh4nS4rHh5Wwsfkwe6
         5tLdnsxc5CWwGCI+ihzNkaZPdRi9M1GBxIeMcNvCqnyczqs56JJfvvGouBF5Grlgzx3L
         391j9xjzje3X2bFwhbDYa563S7q53g2nC65IMICfPzkTfHypnpe/ifIjeF9Iqx8SBcyz
         UMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007936; x=1741612736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYy3OxmCTfeXmKWW1VbewLs6rP6H3oG1fco894i6r5M=;
        b=MXrivVHmc91zR6o9hs4ekKddoxTVjMjshryYHSRNUhW1+9WidYsVstYn8NrMMJ2Pj5
         K1jUOZi6Hg3pZSdAhLGUKnlnArQcCeCOR/LnuXdWsmDpS61VJFPxEm3YVlH2SeYfz6LU
         cUt+ADkj9CbbbHtuU56dX++NXTOi3E6aX7/xqjfzGDTbWhP2cCZ18T+dmlwdRJMbF5Cb
         M7HV6NXMdXAh7s/3h+BNvIn42+GEBmEMXcaZYddZhCFgSN7pbz2ORpHpLENz6muWt0wL
         dw+aiAmChg7c6ahOitOG/QmEh9wpA6rbgtMP4O8QIn7AKK4LgPh8kFlMY9YWpDa+j/r2
         EW3w==
X-Forwarded-Encrypted: i=1; AJvYcCV2Ani4pDo0+qCP8WZZcfOXvB+RWEv6DnBSqFdatqKUsLaP6en6g2lfo2YAgMiqKM6AYhcbqF/wn+cxx2w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxBeN7a8LQnHQkXVljGebns2c72eP3T1XopSPmeDD8TvmAbXdU+
	PdXKZyFa30vq90hrVka4eTPduipisuC0GbwgkI3QziJnYPggKqeJ6wqcWok0KC8=
X-Gm-Gg: ASbGncsd0lJPDknI3nFX7pIG52GvQmOK1HJN9C3WA4zufiUT04lOqIaG4ea4gIBosdB
	IXCQsxzX2qulmkav2miYR58reB0wf2IQQZG+zQqAl0Wmw3zTNU7i3fjtyZlCOIYDOBMu3gg1ZZI
	r1+OYNIu7KoieKFoPhwUYbW5AllrFqVXUAaAIPHuKFMnsyoknkWyG/UUZrUofDibebTINaxkxb/
	exhYtsVOQ5GmQytn7n/DwQ0Ny+XWTSti6/dwyNrMsQ9tLD34/W6g4NgpNhYmY4nWnE+sjKGLgm1
	yVtLCgVqLnquLu/zYb/UuuqnPZ2eIV0+/sPkCg==
X-Google-Smtp-Source: AGHT+IGrzVhEnfUuDCVxi9rV1+Y2pAX00HYe4ND5tnilxpFNSHjqZm+Q1tO//4HTCcPKf55lo23WTw==
X-Received: by 2002:a05:600c:4ed4:b0:439:98ca:e3a4 with SMTP id 5b1f17b1804b1-43ba67475aamr98841885e9.19.1741007934650;
        Mon, 03 Mar 2025 05:18:54 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:53 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:40 +0100
Subject: [PATCH 15/15] gpio: aspeed-sgpio: use new line value setter
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
Message-Id: <20250303-gpiochip-set-conversion-v1-15-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1486;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=o1RQkjcxzC+TGloaGMTPuFJzidyh+RPMXxMLz3aV4DI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxaws57keqtznwsHgFtxTpm4rRaKKUe8Z3RX1S
 ld6SfCwJGCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsLAAKCRARpy6gFHHX
 ckXIEADQhVFh09Iq4tEU1jISNlnEkfP7k1ELSZ2IXMcW2dvNP7VqR81V0ZYPQcclqaZcCttaM/0
 1t5g/NVwoezK7o4qVsmqkqEYmN/nvkOX0UsVySyJw/0dXUPT/CQHlKIC/erIqkDom3R1svtUd31
 J8c4lXQO8LVXCkp4nJAkRYT4Pp8L7ABPoI8raUIP2VV8rjcwdbiVm9WCmlKM4tWAcJUCSL+WNdq
 P08bBozKKrLOq69Uc92O0nJlOwBqmO4bFPrWVqNuqZLcX4lyWblxe8aftcHYJPVLMNkJ/VGuhSd
 scoDcPInDpwb45deB+pQKPmVX+r5jj6vzMfSsD3gtmzzVSbaRkjTrA9B2rqjxRO5+w1AwLup7eD
 dcPbHDmqiZewAlMFEyYu18B6DBXl0+p/kcCHFQHuX+RX7QW5f0TyiwikwKokqYPCvwXVRCDPUUW
 8Ro4zYv2Q4eoLzFPK7GbnD8MQO83Fy90ZIxjT4Hsw21lBZiOmicK28b5uSHvoAziBQurQ/M9+r9
 tMPeMyCpRPfCCwKF4H7RofC7RJGan9UoZtnZ66gpzw7ne2jNJ0rx2YSXzVoxYEwFv+RX2NRP0UD
 SxJc01SMF9zx33J3w0C77IRMrapFhhJcw6Ls1/VbuDECgOkpKtB9qH0Cr/4U9XQuMfQ3uo+w/Gt
 pwY99gL8+uSpR2g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-aspeed-sgpio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 5ce86de22563..00b31497ecff 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -209,13 +209,13 @@ static int sgpio_set_value(struct gpio_chip *gc, unsigned int offset, int val)
 	return 0;
 }
 
-static void aspeed_sgpio_set(struct gpio_chip *gc, unsigned int offset, int val)
+static int aspeed_sgpio_set(struct gpio_chip *gc, unsigned int offset, int val)
 {
 	struct aspeed_sgpio *gpio = gpiochip_get_data(gc);
 
 	guard(raw_spinlock_irqsave)(&gpio->lock);
 
-	sgpio_set_value(gc, offset, val);
+	return sgpio_set_value(gc, offset, val);
 }
 
 static int aspeed_sgpio_dir_in(struct gpio_chip *gc, unsigned int offset)
@@ -596,7 +596,7 @@ static int __init aspeed_sgpio_probe(struct platform_device *pdev)
 	gpio->chip.request = NULL;
 	gpio->chip.free = NULL;
 	gpio->chip.get = aspeed_sgpio_get;
-	gpio->chip.set = aspeed_sgpio_set;
+	gpio->chip.set_rv = aspeed_sgpio_set;
 	gpio->chip.set_config = aspeed_sgpio_set_config;
 	gpio->chip.label = dev_name(&pdev->dev);
 	gpio->chip.base = -1;

-- 
2.45.2


