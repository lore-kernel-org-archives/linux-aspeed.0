Return-Path: <linux-aspeed+bounces-2794-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6758CCFA1B
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 16:16:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2S4V6PNKz2xR2;
	Fri,  7 Nov 2025 03:16:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762445802;
	cv=none; b=OzCi4hw5cZey2Z1Cp/8EMqS+HuJ/BO7rf1OZyzuMTVKMttjQduNkL1hvxZxBPkQIimJoWLoHcgwqeqpc+F/1KfSHG2ZLmvsi38hKPoMtz4sD4303fJux4UgSV0zhXcZoEdvTwJEP9MZLUrZiled2c3/0ncNkzdokL4PBIDyqIeAjYC+FC8PDhxgV/BfA0exy3P4jBmuvhC1Jo5eWcDMvpTesK1zOBQPJQr8Bag4FnYH49P4mg6YWI2UIIqOgHtsgdLkkEeAhlpwNoU8bDsyfTQY0KDIMDhPOEqgux3iXOYmYSJVThbKo6CoJmJ5BuJWVf49r1ZHjAIa2aCjFneILHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762445802; c=relaxed/relaxed;
	bh=iuhfmQr7uINSDkC4BFuRhNQ4HVMgm7l+cfZeaeFW1fQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e82cF9URgG54PqA2XKgPpPQmM/YKZm0mkfYbtcy1VDZKQyEdvDyGr8fc/vu20cfA5faTJYR21/6e+NmgZoee9dQnZU6lKgvpQCJ5cIE6dcdgVFuXoFrIApJTgWJq3nvCsjdYH5TFcZv1Lv1l3Sk8fNbYHT+XnYvl5TwJvbC7o7PeqKJEtZ7E1a9h1ZB+AaBMwzIBigFrE1y9DkaA+snL/fK1TTWyNeU830vRIsrPNfosscZPOs9NkHVwmRJp8eM5RKBOEc7CY1OdTLcch0VTSkyqf3L622pRkcnQqveGp+1t2Rfwzyq9WJFsBBB/phDgFZ4Z9Lhgbd3V4WdbZX2N8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YG4QGk89; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YG4QGk89;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2S4T6dplz2xS2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 03:16:41 +1100 (AEDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-640ef45546cso203909a12.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 08:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762445798; x=1763050598; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iuhfmQr7uINSDkC4BFuRhNQ4HVMgm7l+cfZeaeFW1fQ=;
        b=YG4QGk89Tv7TQnVLasCcgKsSESn5JxHw05sKjFlsiCPTXTVo/Yk31dUYDDcRvZJryr
         QDMsiCI5j/xH2WSnuEc7Fy0AN5gnPaDvJ846wekbjqRHtYJnzbfUkTj7OilmKAcRDVx9
         Ijnvh8+S2aUlYYHBGHMO/CS03fhOWaROrqE9Qwp1iC+Fdu8dkJHfurtpS4cJoTpuHwev
         inyQmKdU3ntjh+Mh5yfmPyV9j7LgYwL0YXq1uezaGQwpqN5ETkfnB3cqIwdIlPUA6Mq/
         v8jmsY+Siqq+bZzRLah4wbH7yLw5B5rPUi7FlVdcS7HLD26oo6xNKi9ovzSdZeETfSKO
         p+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445798; x=1763050598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuhfmQr7uINSDkC4BFuRhNQ4HVMgm7l+cfZeaeFW1fQ=;
        b=wDlqA6wGyZRUCBwYi43FlDpuJV+B8JpFt4kGVqfZulQzrtUOhNvxHzHXwz0u08XF4u
         2PCdoC8URILtXEZECL+Ww1p6l7XxkefhGrWWwGJhNI4nowHe9kBg4ECiOSsFYRe8Purk
         blXurMeBneZy4as1vEY+Dty1VjtEQectQikf+e8GbDHmt+TBHDUHxN3NnDXE3+SenFJS
         FsayltxuWo4srHloqjC0ql+AUbBsBGMIzkzTLlVICHk2r+u1e8f6bS0QcNty5C/1lioO
         6tHzEjbmnFPWlCRqf7jaepLblMhs7aCjny7gzuPNuU5QMMhWVB8ePBJQUHDainDdvZLt
         FJ9w==
X-Forwarded-Encrypted: i=1; AJvYcCVAeOO7HlyPMYhFYYXfAPY2zShUOa/0/rLiCaGQ/afT6vpOqvTpbCNfpsVJmjieajFYg4i2RZzOVyJnFlw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw0DUmMCBaEBQWD+qAcTmcKwST7hI1at1Pi6G9jTjEBS+l9VP30
	aHkWgtPqztymJWYngmWJeJfmDgkYktC4aftH44we50Z9gR+1c67TvHLxObXH9LBoEV0=
X-Gm-Gg: ASbGncvF0eMfBgXnVIjDnV/PJnvZgDzabg5iF1ugRSz9xLtxNCzNNK60YSBWmXiSIgy
	uiK7eQUm0Vj7CH2Romeybto9A8OuQhk4k1vFVRZWikwePRJhUX/pq5zOmzGrrycaoylUDMaSelp
	0qNX3Bn9w4Gt/8kFz3UttO952E8i/fQUT9/H3xlYlDIt0BvjP87Ul0EzYueJmltmb33kGfJAZNL
	oE3YxIrg6nntgaWdbq/hKNXKLPwDL7Bn/7FMLEQTnM3d9r9H+BYeXJqZdbqGhrpyJUsaTIdDqUD
	Qtux9oNyHXO9bb12yY6kxitvMvhBJhiEvKsxdqPRV74afOK770y0I6QBa4xfWJ3yO5Gi3MtHRR4
	Hu+SPoCT7RCajZ0UJas4FT+MK/XTO7JpUJ8OtBB1S+ar+nxQDi5wyuMxxHpXRhixqjGhyBxS/L6
	hoQG5Xl7FjlGVVyqCBSDtkdZAVYb8=
X-Google-Smtp-Source: AGHT+IGnKjqzbkhuvdWC2zI52BeV7MMIvf9OsVAI4XiKB15JDfOLSX5YIo7aBUdC8ZUdmjSM/iA6Sw==
X-Received: by 2002:a05:6402:358a:b0:640:be87:a86b with SMTP id 4fb4d7f45d1cf-6411f6b3baamr1693540a12.5.1762445798504;
        Thu, 06 Nov 2025 08:16:38 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eabsm2113408a12.11.2025.11.06.08.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:16:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 17:16:25 +0100
Subject: [PATCH 1/4] gpio: tb10x: Drop unused tb10x_set_bits() function
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
Message-Id: <20251106-gpio-of-match-v1-1-50c7115a045e@linaro.org>
References: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
In-Reply-To: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 Srinivas Neeli <srinivas.neeli@amd.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=bV1csp2rWHEChhH2wtc+ipip96VeBDB9QOyjlvKNG/s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDMne//1G4nx6sAjk0fip9F0NwApN5hshBoZuD
 RHWNh/iIoOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzJ3gAKCRDBN2bmhouD
 15IED/0XzrXZAYuaXb8FfmaclQ0RY6jfzxQrHGsf/WmuK02ww2efB75Exltpwwtm91fHOTkDU+T
 d2Kykn+OUAn6bPtd7LG5TSjCDI1tyM+/Nmd1wpAecJLUwG74wFPmu/ofjaxFh7lT6wZihV7lyHt
 8YmM+qnYuUolGhcqcfv7MDurJ8J2Bsqpat4m7N5nHOw++bPTo+SUOojVuhOwrXUI+9kKJ7myKLI
 cKXvLFDL0IOZDKcsJ6iq5nunmneht/iT7YFCKW6+gD1WTJpoziwV/6SXm8XJ6upKBSlnq9KxPSj
 NJ5fAe4+xkXGcBrd5oN7v7sbLM7FSPVyKlmrmHlv8YD3Vxl/t+0CwfwD/YkXVuUYFGOhPzRq1p1
 2eYQ0DqHsM9ulF4ZqHMFaRpLmHwNu1noNDT8MzzuoMNAWW4XN5JJtqeYlHHvlrcSFufrmyWAMpm
 5gZv8IPPiJx3Zw/XyFAwIepY+evhUcdg39kj+D/DVwWnTUGrdKgT/OYrpvvcE3Lxa+MjtAD3lji
 3DB8a4wIM9Y6xyQDaN3gtz5pxIPJGG+kyoN1ctUWXZlnUPRzzb20y01PoVvuhmiyPqOvVHa4+8O
 qGOKxXXWJBJOE+bPEc1yIlencBqk4SY4CpcNcxsvQ8A5Av5IswK60aumWzlZL+3v+oM/XHcxZeo
 xNC7jP93MIRL56Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

tb10x_set_bits() is not referenced anywhere leading to W=1 warning:

  gpio-tb10x.c:59:20: error: unused function 'tb10x_set_bits' [-Werror,-Wunused-function]

After its removal, tb10x_reg_write() becomes unused as well.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpio-tb10x.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index 09a448ce3eec..3c8fd322a713 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -50,25 +50,6 @@ static inline u32 tb10x_reg_read(struct tb10x_gpio *gpio, unsigned int offs)
 	return ioread32(gpio->base + offs);
 }
 
-static inline void tb10x_reg_write(struct tb10x_gpio *gpio, unsigned int offs,
-				u32 val)
-{
-	iowrite32(val, gpio->base + offs);
-}
-
-static inline void tb10x_set_bits(struct tb10x_gpio *gpio, unsigned int offs,
-				u32 mask, u32 val)
-{
-	u32 r;
-
-	guard(gpio_generic_lock_irqsave)(&gpio->chip);
-
-	r = tb10x_reg_read(gpio, offs);
-	r = (r & ~mask) | (val & mask);
-
-	tb10x_reg_write(gpio, offs, r);
-}
-
 static int tb10x_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
 	struct tb10x_gpio *tb10x_gpio = gpiochip_get_data(chip);

-- 
2.48.1


