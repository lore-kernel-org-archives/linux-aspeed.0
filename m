Return-Path: <linux-aspeed+bounces-899-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48115C282D2
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 13:18:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z5zsc4BWZz3bgV;
	Tue,  4 Mar 2025 00:18:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741007924;
	cv=none; b=STKgI7ROcC7690DsL7mBiaGO+bP9llwlMYCEj+7ijqRutNhR0kvhq5Y2ZDtV8E++pGjBX2xQLo8hHmekIn8h52GROfebM3D+JOlUADqtiCVrN2myYw+p1lVDZqZoWXJLM0qgZZCd0IkhDGQ4NUx3OaImsg89+8qVekyiFC7FCZ9ygjKJ363FopBjIo0Sk3O4w0pII7/f6XlbYrc5spZ+oVsm0B4oueAgv7zE0+NQL2hXh3ZJjquiibqeqOwvcfVVsfzPAhUs/hO0MNSHjbXG7Ow/n1cId3jgkUQ98nyi0XWkioWMU6Q6BMH6MacDNkIPVLCgQUL9MKWaC+J7nDaK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741007924; c=relaxed/relaxed;
	bh=yy1JVRlXR6nmaQaZdHV5up9VNNk75+ZYeI4CrMOgdUU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lk/daY6UYrrFtT3uYSIbxS+BUIU2R/zuH/LRW67QQ2ybSHiJ/NRHvV6GmkMHqtMMOj6q2SHAOjD8YQ3bUxQCcHF65WfzTDF6yl+nfhVlhSj/4he+LHrE07j1B2cEzjKRRAWHOdQh5pm11bS7sifCPw+xvLfEXeQGuSkMt/FDowhjEvQYf02rSf5oOl3dRlQkUxHQoPfhiWSvASarsYACPT21NF7O5y7oiIgR4UqcW8VlHD4gbEX2GWLLkwFrmqCU29S536s4ugyymfuPv4VLnuT+xz7r1J8PksUyydUcVlq4y1+hJH1HNTqIBx7T6MNY/g9I7Dd+3ZYM2eaTvbNycQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=IGvfnyLZ; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=IGvfnyLZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5zsZ2T7Nz30WQ
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:18:41 +1100 (AEDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-43998deed24so42056715e9.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 05:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007918; x=1741612718; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yy1JVRlXR6nmaQaZdHV5up9VNNk75+ZYeI4CrMOgdUU=;
        b=IGvfnyLZQhvSTd1cuMSTUI12BWV+c/4kig6SkPok/dw13AIwwifSFc6rUB8Xpo32Vt
         tOvVjlzLoWERd3HSFTanemnGmGUvzphbyaVtgA2p9/+jvmyj/QqGvEw7n7rKQTicpL+Z
         XTIF8+ifvvs4HEzrzTQwIkLDokBkf073eZ438E7pwacHwKOxSNO6nZnMzCraomw/gMeM
         aYgycYR0ngUqYMKrCXOQ8IMLJzRmR0YVmudT5hGjItzpPdNHyiz1M4t8x6k0Wtos0Yly
         H7Ui9JK+K7Q5lxi8Q9u5/fRSTxBJM+scJK0mbCPZT6tLRbcfACrdt3cmalvhmM2ToLWP
         R+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007918; x=1741612718;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yy1JVRlXR6nmaQaZdHV5up9VNNk75+ZYeI4CrMOgdUU=;
        b=wAkDRUU7X6vxuvM+RueVGf7LqTpmO1rjEdBecvsfjNh7WN2y00IjKOmPkhtHghfozT
         Cvg9WM/2uuUPRclQ2vcBa99M4mUf1mdELHpEVmd7LLnT5miXukEu8Rip4NZmqQ3y1cns
         DDHrRXtz8ec4RtTPcAzkXW4lEuoOYXw6ficYHIokBZKDuMdqSDUDr7Mr6e3KhJwBKoEw
         rGjE19StbRMtI5aUgO/QEXZ1rHc36a9CapANAwkdlSn4UkMmmiGHABs8PAzbFEr/2l9J
         yXaZ1IWfko+xrNOWJKR1n1IfqWQJc447UkeBsePrH65QJo14p8gaopkKtUMylYZL3AWn
         OhGg==
X-Forwarded-Encrypted: i=1; AJvYcCVVYar459OeikglnKIqmMN2yyav4rjBSak/WU35y0iH9BSd2aye+EhbhyPO22LA6pgBwqsYvdxJMcUd1Hg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywjpe9WJ9FA2qGXBy+fqc1GJ4guFEbc20USnKuNmphj5jTRIcMv
	N+rN/AcfmTOrG9exEeC3up81Ca5F9rVYfR7NutEgvlepPCb9sTS8eTDCrmKQNrs=
X-Gm-Gg: ASbGncvE+azzyC3gH5KLANZ/PtZt3eprlgG0JNw//xr9i/PGK5Ik/hAk3UPA+tyML3D
	dOLwFyeqUvTiS4+ozZAk4eB6j/7s2jcoN6ZdKAvliLLRQyMPtn8GvdfM9PrYg4UZJ86mBhhLm0a
	jh6mO4/EXCN6QK55NbLBSNWcv3OyCqnOmU3tDFXz7goviZgeRcP7vQUH+9iDwooNyj2qH2NnjAW
	uFCwN2ReG6Z725nYr+SpJLHyDuh5+TxDArbWGxBZ9FoqeTWvhvKgaOd1oYmFAVK7MyAZZTCTJfv
	59RxKRCNCKeqlDENreR0tu2lTqiHcMiiaGGQ6A==
X-Google-Smtp-Source: AGHT+IEYSoFbgh9Yo6fzCpbmc4OD7ixVh8/Qc+gBT9GOh1lnAk3c6PmzNiyXxz2KhEi+3a6qb7fiqw==
X-Received: by 2002:a05:600c:44d6:b0:43b:c0fa:f9cd with SMTP id 5b1f17b1804b1-43bc0fb007dmr31862825e9.7.1741007917860;
        Mon, 03 Mar 2025 05:18:37 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:37 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 00/15] gpio: convert more drivers to using the new value
 setters
Date: Mon, 03 Mar 2025 14:18:25 +0100
Message-Id: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIACGsxWcC/x3MTQqAIBBA4avErBuwTPu5SrQom2w2KhoRRHfPW
 r7F925IFJkSDMUNkU5O7F2OqizA7LOzhLzmhlrUSkgh0Qb2ZueAiQ403p0UP4Ot1NuiVdP1rYK
 sQ6SNr/88Ts/zAth7bp9pAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=FTj6xoyS39LnNrJXGLhXAeRS3nQ1U42Zly5B+pL7Yio=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawlRSaTKbF/S2ubujlU+T5mOtA2wT+5FfqLz
 f0O24SM9OuJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsJQAKCRARpy6gFHHX
 ckWGD/9u+ceNcDwkzEAzs9WbMfq5vXhzHtIGaKqnxBBxx8KhWYFPKP7Se3MIVRL9v0JnhQ87GKy
 HDgBiwVyHynXsOKVlQw0APVr2LPRIaJaggMbPEmN6tfFWYJFXsseLQH6tF86XmqyVRZFj6c3Ony
 a2Ji8lD8KdpKO/hTUEHaEk1Y7QRzZR3e8sgS3FMq9xzd5GWdbGNLbVCi3bIcPaowv+oqGTsktY8
 IxJz2cM8pV89YbZvcWD4mJlhwti/GUcqKMlzqaiaGYSviLcYsgCdCp7UsOjsNZa9+BRiFp6+u2G
 HEc+at4+FRdvN14vwP083vAkOasL2iFM66uCpowT/QcpOV7uFMZsOYtaq9yzbx78N6FWFdahWYh
 9JwMY5WrPG9p4eUzMdEsDKKQN6u8tgZk1LUGg/uq3c4jH4NXUarz+uzydzMFxqXfRi/AoL9g+60
 VUkNIpSaLu1JefQwXm4VOq72a8rl9Ko95MHqVnuwKQJFNCyOieV5D07Lg6VTQwq3189BSB8faoi
 zlWMU1AEuEHIsLPV5ccoXeZEXD+S2JuM4av48cV6RU4YuT+xCqSPmjnhzwnl4JOxdJ7CFu72AsK
 SoU70k9bxmFIe9uGlfJiCdi28nlSkLv3bW09urYrHNMjhGHjTXNTOdEJ32yXwu8R2VpkIqc9rs2
 0+3p2O8qDdv/SiQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

New variants of set() and set_multiple() callbacks allow drivers to
indicate failures back to callers. Convert more GPIO drivers to using
them as the old ones are now deprecated.

This series also contains some additional refactoring to the affected
drivers wherever it makes the conversion easier.

To: 

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (15):
      gpio: 74x164: use new line value setter callbacks
      gpio: adnp: use lock guards for the I2C lock
      gpio: adnp: use devm_mutex_init()
      gpio: adnp: use new line value setter callbacks
      gpio: adp5520: use new line value setter callbacks
      gpio: adp5585: use new line value setter callbacks
      gpio: altera-a10sr: use new line value setter callbacks
      gpio: altera: use new line value setter callbacks
      gpio: amd8111: use new line value setter callbacks
      gpio: amd-fch: use new line value setter callbacks
      gpio: arizona: use new line value setter callbacks
      gpio: aspeed: use lock guards
      gpio: aspeed: use new line value setter callbacks
      gpio: aspeed-sgpio: use lock guards
      gpio: aspeed-sgpio: use new line value setter callbacks

 drivers/gpio/gpio-74x164.c       |  16 ++---
 drivers/gpio/gpio-adnp.c         | 136 +++++++++++++++++----------------------
 drivers/gpio/gpio-adp5520.c      |  12 ++--
 drivers/gpio/gpio-adp5585.c      |  10 +--
 drivers/gpio/gpio-altera-a10sr.c |  14 ++--
 drivers/gpio/gpio-altera.c       |   6 +-
 drivers/gpio/gpio-amd-fch.c      |   7 +-
 drivers/gpio/gpio-amd8111.c      |   6 +-
 drivers/gpio/gpio-arizona.c      |   9 +--
 drivers/gpio/gpio-aspeed-sgpio.c |  82 +++++++++--------------
 drivers/gpio/gpio-aspeed.c       | 108 ++++++++++++-------------------
 11 files changed, 177 insertions(+), 229 deletions(-)
---
base-commit: 9778568dede2166c7bd124d473f9ec365f782935
change-id: 20250303-gpiochip-set-conversion-736fb6548975

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


