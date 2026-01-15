Return-Path: <linux-aspeed+bounces-3335-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA05D3CCA3
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Jan 2026 02:41:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds6gG30w2z2yFl;
	Thu, 15 Jan 2026 13:41:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1231"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768441958;
	cv=none; b=chg7F1XSlu1vvViXUK4pwLAf7NQ+/Gzrunag3epq9ZIMClsRJFiy9JxFr+5iBxqtwARxHV3Wa+/cwHnHRbZflwb60YQxcK5fibloKRziV7X1byHmjRd89rJ5M3IFl1um5qSh8G7cwvOw82tuqWoy+4wCsg0CGGztSiFSXDHuhjW569+lkoOHBZwNhYfmfPhflzKY+FbtbItohniGkW4iQAbbP1MoMokknA5YBvXMbJBv90bH40cmgIlqk8NlEUa5/ELSfowv+ja//QTgvwnIMfBrUpxYP4dH/JFJobB5p47awnxBsiL2wnXz01rlD9GHmXnWwsGNO6T4OACnaa1JdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768441958; c=relaxed/relaxed;
	bh=eaGsIuvEkZT/0ZxJsJ40cQ270Lj1PGkWPT1RajGBoys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+noXL1Sw7TCYjmMJBVPDuoiQjmMf8sIeTE+JuNnTYoDpMtmf8v3f1ptL71M4JIVDVK1GFHTY8LQBCsqGk+bDKm7XluUIujjp7aYrAff+TEuMqJ04VKpbqxy1e0pRXvjgPc8jL9aX5Tm9nCP3GMecFrqnq1JaQ9KR0wyyU8CBbiURU1ULG9ChM+UCUkBAXJSNlN7YO6yxer87sztgtgEXeM94vehuNvl61CQ2i1ZdPph1Pn8yvB230PlkAGg1GIbECYpzkFOgyzGtBZtZ8yApgH1Y3pySeOAMyCUfl0c8uyRD4bLiF2psaYGqENBZX+xFztcB/PDn1UYnaFPkLeiSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=R1rxVBtL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=inochiama@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=R1rxVBtL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com; envelope-from=inochiama@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com [IPv6:2607:f8b0:4864:20::1231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ds5b82dTvz2xHW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 12:52:36 +1100 (AEDT)
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-1220154725fso308782c88.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 17:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768441953; x=1769046753; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eaGsIuvEkZT/0ZxJsJ40cQ270Lj1PGkWPT1RajGBoys=;
        b=R1rxVBtL/AF3DZ8zyp5Y1tt00k3hDC745aEh0gVHC2y/N+vY+U2dg/oD74bY7zYy/N
         Erk1yEvd5oIJ4005FGUqeM2k/TuWkX9VQ6pOXgFwH3VrX4XEkeqt6UDSHGOjgqG1f4ib
         odGHsCWRXW+y6OZAn4W2hfw26VrTMPoupF6MDR+D6GbK5tXvkZTJORFqTdxVnFtxBzlO
         7jvfd2g39zWAQUzKwMRrqj8s2oPzYPDYmHJwA3WOFk32/NXN4jmpkH8OA5UzqXYpdB5l
         tf0CNaeR6ugc/Ox+R7rUIJZ8DeyNjmA+Ft5hzxWLhPDBuL8qVya0dqeRqEFqJjcZaypx
         jmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768441953; x=1769046753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaGsIuvEkZT/0ZxJsJ40cQ270Lj1PGkWPT1RajGBoys=;
        b=QsFn32iVOKpnx2MU0xP8gYYtqLFbWXPgNFc7v+vGfrVp3b8hsj6fLO9WTLcH4j6fKZ
         r2BmC3LYOTFoL9hqHf8Szk3I2PTAO+CbJ6wN5D+WAjRiYLYhwIjOxJOU72ztd6+VAjvj
         qH9AI9FuTDjjXbEMuCxzG6zLNO4VmZF5JoXzKWQsQ/TgR+yuv5WTHglX4SFkQaa1Sh6y
         WKvMm5FqluscDyLECkd4Lf9ibuh48aUh+JHiM8NSzzMk1tRr+K27FMOnvO2eDe6RhL0D
         xrsqlzFaR4ZADbjxpuDWr1EU79nn9qG4KcyPnDyzSayA3+24OTWF8iiHc/QlJ++J3NAX
         srlQ==
X-Gm-Message-State: AOJu0YzFSZB81zh1eENqG26EngilKSkc5MzjqI3UTA9MDqUjmOFPgBNz
	AdxE9hg7GOKjIDbiTFYcIihqf0k98Y7LML9BnpONutBn4322Zrh/RJpY
X-Gm-Gg: AY/fxX4iM04WBT80OnhxNJDLZZ+kU6gScpImZEzyZBk40l1O93U0c9Jcx0cjJA1M4mm
	Y+xb4ZjcI5Pm4h52K7BuCYTFiSXbkyTxtf8aexebNs1+QeGJ6aMD2pPte/tGFnjRTvyF69i/+wI
	hZwhO9jd4ZH79HpIqJq0foMUWwllp+3jAJHxzL0psGxorHb4UYJA2+YwW0ZpvYsmzHK6NbldvH3
	AZHTijvmVkJw1Ko1GX/cKi7idFILqOcK3rVz2ZDisRaB/8gNVPt2CB7sXCuijEj48TPBg9nt6WQ
	ojeNFWJDWJVXOB1Se1O0J0Xa0d7q4AB0bBJmXK3YzHtIleNsE3hDm+ChROKJdXdcJC9ZZnXlexm
	5Rrv3EAWqz37ggGO2IerlhUPk+01OMbo+ZNnon9aXHpQ8/TarJDWGvrL6FLkQVsh+U5FqGzlMqt
	ilIoYCmMWj0g==
X-Received: by 2002:a05:7022:6708:b0:11b:9386:a38f with SMTP id a92af1059eb24-1233d10f432mr1505698c88.22.1768441952848;
        Wed, 14 Jan 2026 17:52:32 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c246sm32727140c88.11.2026.01.14.17.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 17:52:32 -0800 (PST)
Date: Thu, 15 Jan 2026 09:52:28 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Emil Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Heiko Stuebner <heiko@sntech.de>, Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 03/11] pinctrl: sophgo: Cleanup header includes
Message-ID: <aWhIOYIWnJy7mhkc@inochi.infowork>
References: <20260114-pinctrl-cleanup-guard-v1-0-a14572685cd3@oss.qualcomm.com>
 <20260114-pinctrl-cleanup-guard-v1-3-a14572685cd3@oss.qualcomm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114-pinctrl-cleanup-guard-v1-3-a14572685cd3@oss.qualcomm.com>

On Wed, Jan 14, 2026 at 04:30:04PM +0100, Krzysztof Kozlowski wrote:
> Remove unused includes from internal headers, because they do not have
> following: bit manipulations, mutexes, spinlocks and struct devices.
> These headers are included by actual C files, which seem to have all
> necessary includes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/pinctrl/sophgo/pinctrl-cv18xx.h | 4 ----
>  drivers/pinctrl/sophgo/pinctrl-sg2042.h | 6 ------
>  2 files changed, 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/sophgo/pinctrl-cv18xx.h b/drivers/pinctrl/sophgo/pinctrl-cv18xx.h
> index 759c0e604acf..973ab9a38fcf 100644
> --- a/drivers/pinctrl/sophgo/pinctrl-cv18xx.h
> +++ b/drivers/pinctrl/sophgo/pinctrl-cv18xx.h
> @@ -6,11 +6,7 @@
>  #ifndef _PINCTRL_SOPHGO_CV18XX_H
>  #define _PINCTRL_SOPHGO_CV18XX_H
>  
> -#include <linux/bits.h>
>  #include <linux/bitfield.h>
> -#include <linux/mutex.h>
> -#include <linux/spinlock.h>
> -#include <linux/platform_device.h>
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinconf.h>
>  
> diff --git a/drivers/pinctrl/sophgo/pinctrl-sg2042.h b/drivers/pinctrl/sophgo/pinctrl-sg2042.h
> index d481973fcf97..1a2b00dde1fa 100644
> --- a/drivers/pinctrl/sophgo/pinctrl-sg2042.h
> +++ b/drivers/pinctrl/sophgo/pinctrl-sg2042.h
> @@ -6,12 +6,6 @@
>  #ifndef _PINCTRL_SOPHGO_SG2042_H
>  #define _PINCTRL_SOPHGO_SG2042_H
>  
> -#include <linux/bits.h>
> -#include <linux/bitfield.h>
> -#include <linux/device.h>
> -#include <linux/mutex.h>
> -#include <linux/spinlock.h>
> -#include <linux/platform_device.h>
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinconf.h>
>  
> 
> -- 
> 2.51.0
> 

Thanks.

Reviewed-by: Inochi Amaoto <inochiama@gmail.com>

Regards,
Inochi

