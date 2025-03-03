Return-Path: <linux-aspeed+bounces-909-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC7AC282D3
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 13:18:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5zsn41GCz3bkg;
	Tue,  4 Mar 2025 00:18:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741007933;
	cv=none; b=CjmlJOuldy6OSJrAho8eBuRSyuBAuKDwE0pim6qJfAJkxxgk5AAvRKqr+hZk0YnH46zAVSg3wNXiMN5ZrA2u17f5PYvljcvtodqlI7VkB9cYXOZw7aWNBUPtHLJp5hIo2H0W05xVyLco8+J/po3mEyckhHkY99+IDG3SMqiMNlcLAUuUF42EcgQyL5em2TnI/SqMXnLmjGRc3MA58dTsivR1qs9hWqiNeqUqXSUbOmz9OdwH1Tfml5G08sTriqv14z5hS3mhdB9bpD3yHVsdou9IpcN+df6vRfTqvRTLZP64HBSfSINVJaFkWlgT9gJ/JStx0Vh9ryV88D2z2vnd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741007933; c=relaxed/relaxed;
	bh=5Axi8YRJzHoLHKP7VK2GqIyJfaSqTW3LqYKFDfDPjWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ivau2LyOoLaeJMjkhopMXDvPueVYKK9nCGF7iQAYpNxqx3QICQLPudbT0lJMi9dvrQvpA7q1/xT0mcz+Xw89KVbjhA/OL+H3UY+CJNcsgfMhKnnlVbizSngGa0NawkViLMHZ1I4T/G2uSoYnEB3beD75OTM655Yd2JbC/VNPBcWHOkCRLuHXfNrjvegFKQTtH8rPMu09DEJBDmgAU6va065YS5C9tzjHVoYm2s/CKhCFRkmvrlga+KDQj14ir4sUw8veZVrR3SgYHEIH3yWoqlry2GU2PDQ8Rcaczfp7QmLo0huOIp0fFTj+9HTiu84EY3XqDCYlJVYgcRX0Yp0yLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ux7gf5Dl; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ux7gf5Dl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5zsm46Wlz3blK
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:18:52 +1100 (AEDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-439950a45daso27922495e9.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 05:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007930; x=1741612730; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Axi8YRJzHoLHKP7VK2GqIyJfaSqTW3LqYKFDfDPjWc=;
        b=ux7gf5DlK2QLJyB9hAitn8XvUHQPGqv3sB8kWUxQ2FM1799KdCy1NqpemV66jvk5N6
         Wa8MMNnqUHNDLZrdxERMICHD2LmHPdiEqSvRPty1gNrFFkM9bBHWCVt/LYK6JpnbqYQU
         vTZZe6lLB4A7KjcoWx23mZnVgywu2uFCijl+vr6gojmW1/JKfiX90yzAr87tWxYOLtKi
         fOsdB2kwV6tO7/sCXJNrV1cz2stL3cmoeTYNBzpidUNwzGE3P5biQs90MPwhEmBcJFWI
         7FbBHXvUAsE5j0puwp3O9R22xntgIDSZ21PLyUpUeQN2Uo4iTb4oMnG4ROi59lNaAeAZ
         Pi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007930; x=1741612730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Axi8YRJzHoLHKP7VK2GqIyJfaSqTW3LqYKFDfDPjWc=;
        b=EslSU+GiWAlpiekknWxM5x4njjGMHYyF2jRLWDN+UxCuASjk7p00tKOJ3tR8MLLDIX
         1XCht6TUwszE/gRv20Vyr0BZVTQzOJu/p4yLuaRMF5slguCx2JrM0ZSFxXVABeIuIIkN
         b7bLtTxU7H6JFodubidGPXyDKhzvmSF5PWg2gXINuMh93Jr6BjEX16xI6vrxyXMi4vMC
         FSn6RTACABVtWaQ3oLUxGG7DuBxYY00HfZfuDCpqcCV9pKT68P+DDcfmMp1B7g3cSnSV
         NlLX+mIww4eUbYylDddcxAXa19Zhw90oaglCtFzOLOn0XiZlCKb4rzO3jhBJu7x2nG/o
         4UHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6uhPz8DWDesJNr7VZ4PJQZSmsYnfFaYdVtFUQecLOjEKLsVr7ar0el3XzOEI/1QitFQNaCph6KQsRfJg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxbitTmH/1jp5ZqRfYEqjuZuZOEhH0XultqKE8d05FuV9zoXGvU
	51DY8vWKLmZqzPzMFzePsw+nwEUg6SOghao4g9Z79ikwuDoWCtPWvAiePJWQW0g=
X-Gm-Gg: ASbGncvVF9XZMPTAFX1Y2WmdbFfE/DgtBs8i74Xte9fQw4X+2T4LZxEZBNUijDEIlr+
	KKKUZ0IHBvZtw9is5ww6SLR6svJOgdoPTvNk1Q0+edceMuRUvY4eZyhmzVMEZafKktdg7i1ODVW
	v2TUuYyZd5LGOHoGIp5EpLBVhGCo5+Wuc1qmIBDAldRG/OWKvxirY5Y/9xCT18sN6tPSBj/ejPR
	AVZTkAPgCdLQz9TPUJ9KMpcYlSk3R+ArIlsC4WxUtfuEhnA+TQIcl1ZAoFGBH+Ax1GDBO/YYyqo
	vvEOPq/6V3u+92S464iQKmyib3jlae2niiEZLg==
X-Google-Smtp-Source: AGHT+IEYGtm956aiE024ARJ2YI+wm6oMviFmiaVF8KsdIN5Clg89Ip+CqvEtma0/pMlgb+be7pTlmA==
X-Received: by 2002:a05:600c:3ca8:b0:439:84d3:f7ee with SMTP id 5b1f17b1804b1-43ba675d56fmr88856985e9.24.1741007929922;
        Mon, 03 Mar 2025 05:18:49 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:49 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:36 +0100
Subject: [PATCH 11/15] gpio: arizona: use new line value setter callbacks
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
Message-Id: <20250303-gpiochip-set-conversion-v1-11-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=/sU8cBlWkrzRnahs8pB2nRSYYvpui0zCRmMzsOLe/tU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawraFYt3OLPOcsUJTdWtbmDf7jf8fWbJTlqG
 F0x+3X77liJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKwAKCRARpy6gFHHX
 csaTD/9Lb0FTC8KUiNCwa8U+38+asQjGBBJIpJ4m2oHxZOZqIc4wVOq47KeugpmygKJZbDzH9nY
 VokyB5RQQdWl9/JvjKQkDl3oDwemi0Seq6VX97lRYJ+aTkwO7BQjHHEEVIP3muwuoNhsXDPa579
 7wAsmgYPxunC4nioaY9ezXw4eenqB88jwUU/o3+BqgopQAJ5e8X/2JoxQZSo/xAYurmoqiOY6wd
 p73NKeItCF2pHZyCLxxR6p82URyBidDFAHMLpCd3HfTvKxmRBNm6Ce4obmLcD3HyhPJSLtXiDhZ
 9TADKmuz64mhdRBi2DnAlxh2m0pxFAyAt495sG1RU+RFeiDmoqfTcLETX01ozNEpfQanlH2Hu2g
 srX9bkbJu9VNN5aVa26Uu4H2jn1vnWuc21drG00Uff6xB6M0MhwXu96GWPhbCkTxXPUz4CFlDN5
 rNpsy2TmVoIqAOdK/ikHR8/N+/XlOkpvUZzLEwREHABI/4GLxoLb0lACmmtAamOHcDr0JlPrbhL
 UyNV2+Lmcy1PkrODKfKTXG99i5mDcXnhnbMjTP8DVFB8gyg3nfYwrFUJ2OE98ffd+bZBl6q8Q9m
 C0z8DgLTTNUabyQIJqqEx6wQDenlo2nt/gKTANo0OX/oLyK0VWh4qHPLHtqQY1XJ9zgAioTCALv
 zkNFecD6T7gJS9g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-arizona.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-arizona.c b/drivers/gpio/gpio-arizona.c
index c15fda99120a..e530c94dcce8 100644
--- a/drivers/gpio/gpio-arizona.c
+++ b/drivers/gpio/gpio-arizona.c
@@ -121,7 +121,8 @@ static int arizona_gpio_direction_out(struct gpio_chip *chip,
 				  ARIZONA_GPN_DIR | ARIZONA_GPN_LVL, value);
 }
 
-static void arizona_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static int arizona_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			    int value)
 {
 	struct arizona_gpio *arizona_gpio = gpiochip_get_data(chip);
 	struct arizona *arizona = arizona_gpio->arizona;
@@ -129,8 +130,8 @@ static void arizona_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	if (value)
 		value = ARIZONA_GPN_LVL;
 
-	regmap_update_bits(arizona->regmap, ARIZONA_GPIO1_CTRL + offset,
-			   ARIZONA_GPN_LVL, value);
+	return regmap_update_bits(arizona->regmap, ARIZONA_GPIO1_CTRL + offset,
+				  ARIZONA_GPN_LVL, value);
 }
 
 static const struct gpio_chip template_chip = {
@@ -139,7 +140,7 @@ static const struct gpio_chip template_chip = {
 	.direction_input	= arizona_gpio_direction_in,
 	.get			= arizona_gpio_get,
 	.direction_output	= arizona_gpio_direction_out,
-	.set			= arizona_gpio_set,
+	.set_rv			= arizona_gpio_set,
 	.can_sleep		= true,
 };
 

-- 
2.45.2


