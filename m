Return-Path: <linux-aspeed+bounces-2800-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC06CCFA19
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 17:20:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2TTd4bX1z3069;
	Fri,  7 Nov 2025 04:20:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762449605;
	cv=none; b=Fy7LebfZLTVv6KLjITAkFYI0zbXY6TdTHJeB5JJNlpR17eW+bGlTf5XgaCFWSeiQbvrEOCuoyVuOjKq86ylgzOkyAsgRlWuyqMevSNyfCf+C+EwEGiYXCAzy3ZAHBkrB1ZzeXorrCzEgWw1fWhv000sqRx7OwKCE2kJ2rrOZrtZWuGZs4GHsdtvyRwJ+gq6noiqgIvc83E1vgvvk+0Kr6gqzQPj9Ol7ZRioLmSGrw99IaFGBMVZ3vXLSk5KJpqi1SQ2t71E2qQMEuAPCGbMCdLGoUkJnMpf814DWUoSBCJ5rQXC22nMly9WxoSUE0pZFwflbUO7gBWqnLRe5F8AP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762449605; c=relaxed/relaxed;
	bh=CF4ODf2wTRFML1B4tRmpvs9bZoB7DEQ9x1Ify504Ygo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXKfBTHUgoWAtjXDU5wYv6JH6clpxGOkeOvaps/XJzyooqzoXPGdwzkgSS6jkfYrS+y8oIy7tV517pBW3fCUlxbLpuVUUPlpXA80iY+xuo8ZFWkIuVMCMgYtENW93O0qvZ6rkQoph37TZLrFItrVniCufF8T5HZR7a8wuXoSVoPzVrFPS9YV6dJuTQ3efYTWKhFqbSOggQo33fITHjEsegfakYutjs5xMxvV62zN64B43SHq3JUKLUGflyDes6FMzf6eTXGogOSXWRbZdSVjCA5mwS9d06Z3cJIm5WjqLqhijS+pGnHUZAww2UsQZJlkRd/81k4yREIBQuO53loBaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=NvNgw2gO; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=NvNgw2gO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2TTc3ymGz300F
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 04:20:03 +1100 (AEDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-421851bca51so998175f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 09:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762449601; x=1763054401; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CF4ODf2wTRFML1B4tRmpvs9bZoB7DEQ9x1Ify504Ygo=;
        b=NvNgw2gOwZ17CUq+ENE29btraUyg4Wukz15Itn0Dzr+qCx9zm7MS43xCwn4j6jvyDj
         aBKP+OyPnY/5mvn1uRK1Z+mu0Bss12S2Y4zu6A87x+fApl8S/UEPX94FC92qDu0QDcMK
         JuDO2ezuNO2iC1ywi1O+lFwziSJtF/AeYlNH54cTd2eXi+AmqXnyK8vbknyOA4pINgFV
         TBOW8LRZNdNONTjUTNO2hn51cySY3ikmKFoo7SBJruC+8C3Ce4vt+2XeUXwVjA3m9uiA
         bFzuxQ065l4cBepoRsLMrJ8WlmBPAtsxNKTd5fOGBohoaBkO0MkASM736UJ3GlnqpMeJ
         j9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762449601; x=1763054401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CF4ODf2wTRFML1B4tRmpvs9bZoB7DEQ9x1Ify504Ygo=;
        b=GhX/H4GZeyMSavLlt5QmNpVYBDqH59DnzX0kZnY88kI+wD6d5nuMgr24ha4mGdwcmt
         PAtDWgbOKMq6rPAiyfgUOZe1FJnxVockTxcuatY1OL+LyhwJi41d+QpUSvSuxqtzrK1B
         TW4u3RUAXmVsVGeh+kXcY42PsD7xV8B0474LptaJtR2qYBQsSqzsaTZWLrE8GLxdpufy
         qoB67X0M/yrgl5OSXVVWncP0h6dORVQrYAcfSiDdmu3smNMhHW89tf/DQgLt1LLTpRgB
         FtYpnIY7Bt0AhZI4BdfM4JAYXpIAxTIHQ0MInLz+T482lUaC2duClXzbeKsxEnBlZthX
         IymQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoBiOidsZVcMe2UIrlyxh0dYXIeD+B2auvfaQWnP5SfNaZXtucnoZhJxoHd8jeseEOEYF4n2jh93Egvbw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwIURuQrnlAXUtTq96jrfdCcO4XyJtCaBtMUmyB+TBd4EVegSwY
	oq1A5nMZNPF5eA6f6xLzGzKwRdj1lzvXaXe84NYzd/NOZ77s07CsbAyUPGCoFkrYGQg=
X-Gm-Gg: ASbGncs2GYvPRlmKIw9xT7kx2i2ezLMvf2rgkdDnd92h5x1uq1VQszKa0TQ4keZzarO
	M7F1ppaNOh3CEXlg2VP2y6n3c0V1K1HeXdMrUIWfGqjfXkhfAGYv4hMiN49gEM2aC8FlycM6pb3
	rYBY6E7S9/M/rC9NaIlxo0SXt1PBDhrNbtFV/1Cp/Jxk9QqraiaIjhEwUfxUqlcSx2kDGzd/e6Z
	wLL8Mt9K9YdKH/TkhzMVQgWYT4nmlGh856llnV1ekV+3GBPRVyeWdn95+/E31zjXGirqO/4TAia
	TxsK+re8myseJcEDeO4fOTSdb63ZKoPEYxwQSX8mwR6bkexPl3EEYC3ZTLaTf4gpCfzbEkzWfUQ
	1OpOafPPiBvxPhu2rmUaqIkFWwLYNiB7P7qCGGghemuu+N1XKg3pBD18GZZdunsi+GJseHg==
X-Google-Smtp-Source: AGHT+IGv3ddFv7Ixmi0z+24Qd5qosIPKUTQKcEJpg9ieaTfBELOhzQHfNLOSGn3SU4H3SmjfT+TvKA==
X-Received: by 2002:a05:6000:22ca:b0:429:cd3f:f43b with SMTP id ffacd0b85a97d-42adc68940bmr1528f8f.4.1762449600670;
        Thu, 06 Nov 2025 09:20:00 -0800 (PST)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677b41csm215368f8f.34.2025.11.06.09.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:20:00 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: Re: (subset) [PATCH 0/4] gpio: Simplify with of_device_get_match_data()
Date: Thu,  6 Nov 2025 18:19:58 +0100
Message-ID: <176244959622.43499.14570364732284486996.b4-ty@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
References: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
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


On Thu, 06 Nov 2025 17:16:24 +0100, Krzysztof Kozlowski wrote:
> Few simple cleanups, not tested on the hardware.
> 
> Care has to be taken when converting of_match_data() into
> of_device_get_match_data(), because first can check arbitrary
> device_node and the latter checks device's node.  Cases here should be
> safe because of_match_data() uses 'pdev->dev.of_node'.
> 
> [...]

Applied, thanks!

[1/4] gpio: tb10x: Drop unused tb10x_set_bits() function
      https://git.kernel.org/brgl/linux/c/4436f484cb437ba28dc58b7f787a6f80a65aa5c3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

