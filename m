Return-Path: <linux-aspeed+bounces-1790-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45997C83F1A
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 11:23:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnBb65Knsz3bjG;
	Wed, 23 Jul 2025 21:23:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::22d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753269810;
	cv=none; b=lEMkFwyBObEr/jfCR0sI42znj12JyrB7banqsxCO/4K3t5VjdTd0o++t4qSQaC8VX1rFlwUeljSqUUxg0WI4VQEnvEwxeFngiToI0dTBd0BmChvfp3S7rGTgkfFoMC9By0HNtVTh9byCXkKmLgZqD+lYQ4Z5wtpaljI7p6/g4ZoQWrvW6etrVWHuOnPi/rg5E9/HHRZkjYgQTVNRZte9cm6ClA3+8Oi06x7T9eBBwU+Qz1acp02ido86TTO+VFbERhHqZmXdxVRUrY2RrxW3lwXHaHMXohHxtMIOHS/S94FPzRV3YC6kq4Vw9iU0T/uGTFZbPQmBMIZTR9rI9QsLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753269810; c=relaxed/relaxed;
	bh=X1YmU1ykvA77GIulXJEMJLdju3jM88FFVo/Kazht9VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUvbiVcLhsE7l9CoS0JzMogDBLw2Jkt+kDwTuxiUTClcnkzbyExW69XaOB1k4TNgh1UC8PkwcuHx+TfgFrxZj5CxSaH15nrNUWGj6SoI/7RXPe73stYkCP9eoSaTdXmIrLFuSnlwKVvCKVx5g1yjgC3D/JjPvleRKM/wR9kwwfPAJvNpG6o2Thg60dCiEzSXW14WaJMHDjcrMll6wNF45WX4njfXyYiJfKaY07Np5BiHjNVaLbtQ/QDaFruogYyWM/J/EMLZNqwtuRrtvvGIyAUoei1u7PYZIJAzIk/EiE2O6/UY1bZJCJLnB8Ras16X99HywDYB0KLfWs+FQ9qAew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YsqI9paK; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YsqI9paK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnBb52NxTz3bh0
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 21:23:27 +1000 (AEST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-32b43c5c04fso8656231fa.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 04:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753269803; x=1753874603; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1YmU1ykvA77GIulXJEMJLdju3jM88FFVo/Kazht9VA=;
        b=YsqI9paKjQaFRdY9FzadOsfGbtc8BVDpIFYLKtnJlLNo+7euDndLZV2QB/2l9KMmVN
         77tPtNmQyBSzbFUcsSi1iAhcvZfYGlZIHzxfGjJu0VWoZQCxfgeYpFP804kRnVB2CdVv
         xp52kHhEJ2vXSZFLAAJsLQGFQxIy7Ot2H6khXC4ARhlI8O/NCoL/DOVG9hvgfBpqj4xt
         s4aR+FdG3gjFOXwKrqsJushysLkwmYPSmuO/N8zrYXAh3OfE9IbJMpyln9JmvpngO9zp
         lXYicuYLMvIXlYWQf2nmszz6SkN7IY2tXjJ92egfGnV4zFIApX8AYg0WDMthnLvsyccU
         30Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269803; x=1753874603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1YmU1ykvA77GIulXJEMJLdju3jM88FFVo/Kazht9VA=;
        b=vW5ile8LwmmJAo29AIXaJ9F5FhwiOCpFFOun1zD98+qdHwEiZajhqNgXbDnhhcGUHd
         0HT+46WhUG6pSMwl8Hmh+NIoV54HS1OSNcn0ZSDnzWDDitF6R3+mgUXeNZbJCUMdSLIr
         4x4ycLZefp1OaV2ZLquS009DZPriSuBAkmKXqAdiMZlyi9xbkoTeXsVKDU4380wdm/Sz
         +PQnZxfg0tE3/9LF47kA6k/KyKHGr1hVbDlPTRox7jgC7Vdayv/ZwPvSymEuMymKS/z1
         S9o4e3ChhK5RP+qcDOW9spsDQXMitmOOhRfQIEqcZ9Q3sxbCWf5tYwyknnTq7uVMjAdD
         uU5g==
X-Forwarded-Encrypted: i=1; AJvYcCXHHtpibwB8IkgMwy2AmfGYTIVIfUqWFBmZk7/bg1R2RFFMz/kFMeMdlnnE5VKl/HFP88tcqlCPPaQd7J4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyB7g9w8jUDJbEyF3P/EEubkuk9VCVY3/UTfeHN017MGrwXxJJh
	qW1SP6vb9bo2swjHWeuw0UFjf7728hxRpkXgfTZD33D2sSvX2/SEVUtcKOgHCxwpCTjfRuqYUX3
	uDbPHFnXs3EG2aLl7+3XJmnkuTHLOlmVZ7zINVGOmmw==
X-Gm-Gg: ASbGnctviwASUz9i+uPZ0MVGWw+FoFKYlok5GpRCBKrm7dZaXOm/Q3j+/IrJL7S9xpA
	PQjKtqghV+8db9BEm9noSdGUyk32wP9stqgI93IyiQodcaZHX4H6wrQM4YT8BAk36apefRUKSR6
	d5FXEoEK9e1wedpWJYXecYB8hlPszpwNEGjledqRkck094Osj7XIvVzCiMc6ezWfzql+YpnD3st
	sqGgbc=
X-Google-Smtp-Source: AGHT+IGJe5Uxr9HPFMmzv6FKaMGGq0DeXYb8MEs6LCeEdkH2Ux3eyASfDB2156qvlMRtXLw+FwseABeguK4wIAj2U48=
X-Received: by 2002:a2e:bc1c:0:b0:32b:4441:e1d0 with SMTP id
 38308e7fff4ca-330dfb33727mr8322611fa.6.1753269802839; Wed, 23 Jul 2025
 04:23:22 -0700 (PDT)
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
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com> <20250715034320.2553837-8-jacky_chou@aspeedtech.com>
In-Reply-To: <20250715034320.2553837-8-jacky_chou@aspeedtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Jul 2025 13:23:11 +0200
X-Gm-Features: Ac12FXzMES-g3RTrhXb0FNTMk2mTyN5VcSrw3I_gOJGbbpbB-aPDVFXKwi-6bIg
Message-ID: <CACRpkdarn16N9637dL=Qo8X8o==7T=wBfHdXPczU=Rv3b270KQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] pinctrl: aspeed-g6: Add PCIe RC PERST pin group
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, p.zabel@pengutronix.de, 
	BMC-SW@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 5:43=E2=80=AFAM Jacky Chou <jacky_chou@aspeedtech.c=
om> wrote:

> The PCIe RC PERST uses SSPRST# as PERST#  and enable this pin
> to output.
>
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

This patch 7/10 applied to the pinctrl tree, why not.

Yours,
Linus Walleij

