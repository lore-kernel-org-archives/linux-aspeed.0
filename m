Return-Path: <linux-aspeed+bounces-2547-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81404CCD184
	for <linux-aspeed@archiver.kernel.org>; Tue, 21 Oct 2025 09:01:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4crRBG0TBNz3020;
	Tue, 21 Oct 2025 20:01:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761037318;
	cv=none; b=Vkj6BNiLqljqs7N+xbCUSpAwc2XyNGXwzd+XMWwP++RYCNAi6DU+ehIaGU33akhB4W6K5CCmNiGa5ptApOESA/PGtO3lc11u5bGoR4fYeX8Za+gSGnKMWlEMU+8hU0jsKaMGLneinQ5vziTeAdXSbZ7UI8XJT4IwZFRrIPJPu+iWkvXwY+Y4ndi2KknGAyM1p6Pjg+OHC6k2a0zBmQzK0kba60YNuQf4YAxpSln4riI9hoNzwPFd8JU+YgBrZ4tSHZAfJmDTSJAN8v05AGTDGEQX00GY/MrZIje5DeoSCM0glPwZBR91cmcDJGCt0id7QNkGgYwNtquxKGy8jURMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761037318; c=relaxed/relaxed;
	bh=a7hM7uckFcu+8xOxYahCnfJuF1kzdKDORaIviV98zX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aS+1qnxbBfC983wEPkPVyb4njUrWyg04EmoJ+U1WWFZ5uon/5F+LgpKwsQumdXGeOjpH7YgGtVMWZzdhDssKGc/ruFEtXBp4yxHdzaTMC4Gbb0a1tXUO4La0McO65dhX8mMhSKQ6rQFB30XQKXHzcaP446zboYv5RJWcd5iTa7wdzGJzlIHOxm9fa5pJy05mLOuS3RLng0X3WF9idnmbY01VCdXwP02aeMe1pkOZ275+LCgWHP+HgL/D2kmOxKr3EPdryJz10Vt7i0+7F7rDN9z41lIDO62ZTd0FwcvS5JvEoZ0KDL96ecE0xpvMrJYe0dTjwr1mzMnq7Szl8BiU5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=bo3dJoEO; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=bo3dJoEO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4crRBC5KPQz2xlK
	for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Oct 2025 20:01:55 +1100 (AEDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4711f156326so39942795e9.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Oct 2025 02:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761037307; x=1761642107; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7hM7uckFcu+8xOxYahCnfJuF1kzdKDORaIviV98zX4=;
        b=bo3dJoEOWp96McGqtf2PMOILhwapoFj0CPlUqhKGn8R1JVL7OCesvTnxmqS/1hpYSZ
         MktiFMnxF1l9F+IRrmRJSv9Mhqx19eKvkjLt6DZah8YLjFd3oacL3i6xeVB46/Rd34HF
         RZxJI3S6j+BYf8AJG470ZcYu/zJ44il66ahPSclYdzFJmMT43097dF1ezDHLMneHaEG3
         UzoJJfGXF/Rvax25KtNUhmRWeimcOftZ2WcNx+nMGOUo+Ae1z9c7sFMp8wfuymGyGqaI
         1jLussgPnW4Uy0BbcXChRdnoK3FKIJHxaQ1qKHirVtMVLROkbljyms9XXZD90IIYze6F
         jw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761037307; x=1761642107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7hM7uckFcu+8xOxYahCnfJuF1kzdKDORaIviV98zX4=;
        b=HMEIQAQrjL+4/pdtwh7yePl0fDRRtz3VPD8bFzhYMlLA2lOJc0QxxszOyxHOQWdKB/
         8FXrf/1LLt4E55Sc+8y99ShDSjS6strEccxbMnm1fOSNZzpYqWgJZfv8HqL/1c6bJL/K
         9EWGHj5ktaXQcBxzYjm7BHG99zY5I5hmAvx8elIWF/XiZSEdoBUJHFlk87OOblvJGCU6
         b8hDt4a569EnEBEjm2sMcfelkLaIjZVsDyHLIVtMyztFMO67Q4EEoNhvUuYpShZOtJcr
         nbQZZtvZPbNs7l+Wev8lmdGqPj7GayOPW1uqB1cfn5jYboXJ9aksQvdAC9lmj0z3NbAm
         MKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQiFejOR+dXYfO8auY8B8mP+pGfZrvpoOT6GkAHofeYkaLb3vZRFw3Hxqt9v7Q/GivnrwuM1jQaqvu9oY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzuyo3v6scvATXWezTCfnvPzTc19Hetdw+Rv05QA1+7a9dWNFml
	XP30ZsU4NSKb6mBdjl7X5m/ugdAJIHcHIbl7Qo4XED8TPD3u4wJcZjWmXx5OlEfMxXs=
X-Gm-Gg: ASbGnct2YAhkJMi4yfyqRdQjLdixta5EfsxrO3EFXRpZf7nDC2VCdwrpT7yfAx87cPL
	/vpsAhjWwNCtTZ6q8IHYnAb8r7XyURaWByKv4bCWomYaqEXcIWw6BCTMfOchFYWmw2+ZhIvGk1u
	VYu3FAFiOyYsy5eppJbDiDwRCd2FpDqD9vA/OAGAHhC/pzDvQgWbwt72GvX9dRNOsqHlFwXX3//
	knLGGn0A0dCw7ErQsdC5jxOpMDq9qmw64/6sFJFKTS56UmNuiz8HFmSREEjc4n13dI671fHnIlI
	yDCKsE91hswwFdjc+tB2ONLISVEDTiqQ0cbHaKVrBTJ+Cww9DJxh4aO3xlyBOpMGYEpX6c4BCPj
	9q81ffdNxDb973AwMoQ47thcFLF53kpDo/9hfKzxHFuKXcEINEg2cCjuHn+22BHl4MUtboXvYsR
	Lz6Q==
X-Google-Smtp-Source: AGHT+IFwaSBjtILyooiRtf1Ykxp9UxcePTyTy4SgHykASPLMYxBKsOoz1/6AxkfVyxkle8GOQXe6Qw==
X-Received: by 2002:a05:600c:3b22:b0:46e:4704:b01e with SMTP id 5b1f17b1804b1-471178767f4mr119724175e9.8.1761037307000;
        Tue, 21 Oct 2025 02:01:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2979:9ff9:6677:97c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d972sm191369065e9.1.2025.10.21.02.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:01:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Kent Gibson <warthog618@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] gpio: aspeed: remove the "gpiolib.h" include
Date: Tue, 21 Oct 2025 11:01:42 +0200
Message-ID: <176103730245.11215.16894410168920796474.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
References: <20251016-aspeed-gpiolib-include-v1-0-31201c06d124@linaro.org>
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
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 16 Oct 2025 11:09:24 +0200, Bartosz Golaszewski wrote:
> gpiolib.h is a header internal to the GPIO core. Drivers should not
> include them. gpio-aspeed only needs to be able to determine the
> hardware offset of the GPIO given the descriptor. Expose the relevant
> symbol in the consumer header which allows us to stop pulling in the
> private one.
> 
> 
> [...]

Applied, thanks!

[1/3] gpio: rename gpio_chip_hwgpio() to gpiod_hwgpio()
      https://git.kernel.org/brgl/linux/c/df900536e85819f6168783d5f6b3908d47811fdd
[2/3] gpio: export gpiod_hwgpio()
      https://git.kernel.org/brgl/linux/c/d19f6451c6feefd6537b97efa5f3859681f243cb
[3/3] gpio: aspeed: remove unneeded include
      https://git.kernel.org/brgl/linux/c/0efa5b2ca6fa7baab4c523b34cfb9495ec143d61

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

