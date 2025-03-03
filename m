Return-Path: <linux-aspeed+bounces-901-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44F2C282D5
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 13:18:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5zsd4tlHz30WY;
	Tue,  4 Mar 2025 00:18:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741007925;
	cv=none; b=XosQrbZiNyYQiiXAOJxyCTpUOeDoF7enXB62054mpHi96LqEBLc8dHSt8OX7Ut+tjdc7Rz4z42tjlDtgUaU8aTeLwENl1Jq1Z4r8fKlM8iYqKl61r/tk1HpcFM6A8mZoB2d3qhkLV+lQlUs7RnPxtURxAIJgMKzZ0lIwQB6Uug/bVGjNkV9T7ZtJt761FJHO5DMeSdjDjw/xtdbPkI3CiWmvDeFXWQBykSnvGt/2029A4a33A7JIqrUONqlJhMb97LXp1jmS/is0z4aC9HX5fDpuQhke2+va5fE38AIKFQc7mml3w1aIZg359K6TN2AsHzVjpWGDO7rWYFJZpYeTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741007925; c=relaxed/relaxed;
	bh=X8hAv7noimuIZZQmeIe3WLO3rZ6iIEPRpuvmg5XIUhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X8fb3BybDp4mXs0NOFfFB5GojrDZGnDIhOXQ2WMhlX4wkIo3YM+mo677fVAoS5UbLP6CAN74LdBO/ad4bOYgRKM4fBLc0DKssLEly6DyuG6YLuihM73wmNMU7VX4uZPi1IZHM3oVWBIf8ciQzBvkzbY5JaEKMTyAb/JYXHoiEZBAYBnDGOu5go/GFSjqSGnoEDVAn+s/6qVgEYtkcNqkM0sSRHKjuKfHL2AXqkQgSk7KNac117fSTWBfF5p/havdLLytrU305+sG5c6QuVxALMV2ii/BJrOj60zuTSSi6a678QXRUv56Oc0o5pNDMSiVr4Np09u4PLiTYNiczPfgRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=bg19v7kQ; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=bg19v7kQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5zsc3lDSz3bV2
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:18:44 +1100 (AEDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-43690d4605dso28098095e9.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 05:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007921; x=1741612721; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8hAv7noimuIZZQmeIe3WLO3rZ6iIEPRpuvmg5XIUhY=;
        b=bg19v7kQHtxZG/2GVFjxkIRAvmvepRiQM/GYR82/pF3h7LF5EGXpQZ/vUtOit1BGgN
         4Hiz/AZ9e4ZOy1rFsfCY0KS5Eg0427hOj342YIfOoCLz36LFMN67cYAUEREPnLxibOQ6
         X8E8gzytEHLEmW+Pd2mger8noROFtyoMkNCyb/qamKl71R8m/QkfZ3QdKrAETmfp8gMq
         EeWPLak4TgTfOduDIf3bGGo1WeBEHlSCykckcZJ+RbK1hjtKU8mFACD/aX9ZFjaVPK43
         a8szTJZzmLOT/fqOcD0El6bPn9zya33b7g0dDh0lA+zTWh/CKjlO/M2ZbOLkgXPx3uTw
         /qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007921; x=1741612721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8hAv7noimuIZZQmeIe3WLO3rZ6iIEPRpuvmg5XIUhY=;
        b=dMk4zloa9rL8bcCN4jPUg8ovcI2utyYHZxSZh9xFooxhtE+r9ri3IysZGVuW0VpOut
         EdvDmZf2veAqMQ2hH4X9x2q0UK6TGh3GDAEFrrxWKZ6hYh4wfLaUJ+UCQb2G3700+7Tn
         aXWZxKN9Hj1NMwofEoGYTK9CVeK2isSpcdDMaoeIdIkmJ/a4892CRAkjRqz2IJTYVmY0
         WLqYnuDDnBaDPaCJeEjqokmzx40utdABE8PE46x7QN+k6VEQVdvRvZ5YNVRh8GmWxhQ1
         xrQC+sdmWSSh8yT3QN3QB22kYFcOx7g4CZ+P7N+BHt3W41ZMopE8Lb21jYNAwhHie6zz
         /B0g==
X-Forwarded-Encrypted: i=1; AJvYcCWBDyYqQldAWAQpqenjwGoAnMcBok/VIcJ5fISallJITrWic2F8MkxnccosPrRyg1IRaAam6TaLexSW50k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywv5yl6UG/XYl2XYyolPS73UIY9Q0o0Jt7lInGDcUGCyG48YzE9
	9pVl9BR6vwh/6KFpEVD4anyVXEwbjpjagm8pXZYzZN0A8HXqSKNtmFMqDEqnDQ0=
X-Gm-Gg: ASbGnctXrxDQH5Q9uG/HJYC9iN+l50wg0txI3HKcLCWCejaGISsUt3wwJ8y+imJTGTS
	ZiSg17GQsGvM3lVd25QiESRwHBGgJT2DXRWjt3JKuR+1nsAtVNCHdD6NFIXU4b0pNjKCYYAGiIJ
	rM6aRMz40ADcFGqpfSSznRJZQQn4O8d2+1aakmV03qfDoJLQlaphhfoTCeDDMz7fujdpoL6u9os
	Ih7mclVa1/W9aRi00AnfTZ2b5ObRtJ4/O8CfxB8NDHUp2xL2Zm+yegE1swe2tU8u9S3d0gZESVA
	L+cq2p9VSk0hm0QbOaq6U30fF+TU5eDM9GTa5w==
X-Google-Smtp-Source: AGHT+IENjU5auSW6uBydmqpRlN4cRim5e7ftx75e07xHAIh+YvS9KyaVM39ESiF/66tXbphMfz7i4g==
X-Received: by 2002:a05:600c:3112:b0:439:99d1:d4a4 with SMTP id 5b1f17b1804b1-43ba670a870mr109103405e9.18.1741007921076;
        Mon, 03 Mar 2025 05:18:41 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:40 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:28 +0100
Subject: [PATCH 03/15] gpio: adnp: use devm_mutex_init()
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
Message-Id: <20250303-gpiochip-set-conversion-v1-3-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=rVvnRkyDf21RjdggCKIxDxEyQFvc1fgcMj5lcOy+gbw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawp7Yvsyrv6sI169Lp9L4rRvfe6m5SnbOO8v
 UqoONS7cQOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKQAKCRARpy6gFHHX
 ctf9EACVXYJIoLFFThB1bopDzr4Y6565Nv71gHd7ciywfLXPYQ6yTBNpZh/2RSmBQB+e+ja86PH
 CUip+9SBF9kzpxZiGkp6FhfuDN54tAmirDRWrtRODLUV3iHyzK9uH0jo1tXljQOt1NYRquUBhgN
 bGB/C2ihy4oE6qHKnMakBSbtacDEQp6fbBYxfNGH84kysXmJQV43Mv1NUjNnf/aHFKvNkgWDtin
 vHcT2e6jtYK1G5qPaEchHbyTOloRaGL4KXF+r87jQrAvoJFh5Qt7IswZ/Fmv1p+Er+tsRg1Dn4Y
 yYvnyN2mVheduT8LzO4AzsbzrjhkjYvz+vNbkfnZ450m15iY9yEiaCFyFc9WzGuR4PWA4+Vqbtb
 79F2tyV/LUQcR35Okda9wZAqhOGnH1EsdPjzfoAjV9UaqS3Dl7KloSMDvc1a5nEL4sX4JzhZgHf
 9ZF2kvH0tk3HMIpOQQR/ZbQ1CTCAxX6av1Qdbniwf08+kv/DyzDulxnlVG/qXDQ5LhC5fF3iUpM
 hdZiVTFUbzMvEXFScb9AF/4l3uK9w2PgNEZjDZ7aIzESl4APeYcOLcMK+vKAIPJUlaOYbOwMBZo
 lfhFveb81B6cBFCYG0aoXsPcfnT2rUfb4+52AfSHbC6d5HEiyQpdiT+5q5UoentxBKekBIrFEPc
 Y0M8FNdhHVNmC2g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The mutex initialized in probe() is never cleaned up. Use
devm_mutex_init() to do it automatically.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-adnp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index dc87768276ec..d6ae9cf1eb54 100644
--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -482,7 +483,10 @@ static int adnp_i2c_probe(struct i2c_client *client)
 	if (!adnp)
 		return -ENOMEM;
 
-	mutex_init(&adnp->i2c_lock);
+	err = devm_mutex_init(&client->dev, &adnp->i2c_lock);
+	if (err)
+		return err;
+
 	adnp->client = client;
 
 	err = adnp_gpio_setup(adnp, num_gpios, device_property_read_bool(dev, "interrupt-controller"));

-- 
2.45.2


