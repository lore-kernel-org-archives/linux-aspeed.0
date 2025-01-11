Return-Path: <linux-aspeed+bounces-432-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89259E7719A
	for <linux-aspeed@archiver.kernel.org>; Sat, 11 Jan 2025 15:52:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YVjhl6YFDz2yjJ;
	Sun, 12 Jan 2025 02:52:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736610759;
	cv=none; b=ivu5BeFTuV8TVlEkeL7C1VH+WPn7vNKB4uAjoGoGloJQWMoVunoYkwsMQleipCppJeSYWoj7qF7keeVLy1PHvqLFcs3CnJMW5ah7i9ngJbSL8gEUfUGAuJcy+Ype4NbjUtu4c0v6iQ7KnAeGYMChJDVIOweLhf6edmTnK7sxciNWNWBBy+SoC32pjNSzcAXqXPg1Oggw2jFP5luIU09BtNs8ZkuH5lZoM9Xm3Xxj3tMtKGL2X0OT70S+Qh7Im03uDLn6c/JdDEplrOzoB6/c8xhr392yyChRnyUa4wf+VvfHkAW/DyHoV7sM0JpxT2EhfPCjMzPraETYUejnfYtpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736610759; c=relaxed/relaxed;
	bh=MoJfdlGOlAHr+H5NA/vW7cVTxQr7rVCeLq6oN2mkwlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0AmIqVPzBOH+mQZGPj8L9CCxJ0+CAthwmGn3fW09Nj8SROcH9R5V/oVHWBs56rWTLTVIVn14q0P16FTnVyb8+IQEZLNKFF2pWn00IMbS6pVcu8CzHU+KxOl3gkS4piFr5mbcOqLdcKM3ku1jDRrZHyYQiynY3KCnb9cHMvW+NlYul+7Y0bJpKbGRvHexOZgoyzujCdgsHveqx19yFN/SKIIgO+uaqswwnpSjICyAzqx6JfC0zTfMKcdKZF6WWn+5oq2n9FuFSrTjIiyH17wkUBYc+OByZuw2aBc2wUI4YFRkNEuhNzLZojXxWjNwUJKptMbrez4lz+5ug4BisoiXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dGNhpOcY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dGNhpOcY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YVjhj4z1Xz2y8P
	for <linux-aspeed@lists.ozlabs.org>; Sun, 12 Jan 2025 02:52:37 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2166022c5caso46777235ad.2
        for <linux-aspeed@lists.ozlabs.org>; Sat, 11 Jan 2025 07:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736610755; x=1737215555; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoJfdlGOlAHr+H5NA/vW7cVTxQr7rVCeLq6oN2mkwlc=;
        b=dGNhpOcYTXPDG3SIfy2HoZrwTqoMO0E5JZj0+PcZyFxwbZFISFm96lNfQw+vki4Vwt
         N6mC9FOfuLvC6S1f671T0ibhcI7+Nmm8wTozyHs1JiJOCi4y5DO2wHaIeSvfjlVueUg3
         xjfqIJ47NA0vrG8mWCiixBFETSU/CKgc0cBvRzV0fMwMbiRk2JQKOQVndbDcdM7aZghm
         SvjuGhQKnBceOgvOrPWHycAm85FNWa5+5A+CnROorK/nyHyTOYLgqdGM1X4nXGBCaEEQ
         ePhj0RnKJxmG69GabrlIJ31J+/JYnEo2ZGTNl0to5crsn2sRYCsmXvqQ7Z+4DY3jSZUw
         Homw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736610755; x=1737215555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoJfdlGOlAHr+H5NA/vW7cVTxQr7rVCeLq6oN2mkwlc=;
        b=D8+9eeqUwLns9GvvKH/bPvCxh/SXyfYfWzM+Cw9hs2uSjLjH6qQ6Hdg+P1KMsBb8aL
         ZxO9u4GgSS+75hu7qh85u1ET+zpo8azbgenBiK3bWwg4cd/ViTa89ymm9c2+LFIQENUV
         4EYL/jV6w3+LeTse9mmlCcSqeAm585hxXcJDEewxtPlntQH/6+xJ3R7usZmD6khkTCCo
         K/FebCpdOd3mnUrHpEhDlbfeBsk3RxXt8yz4rnQ6AZv6sp9YKvEAZyC7v7n9O0zL8W19
         V7PXL8Oey78qDy0Kk3t3PYUDck0AuKLrGvKOlvbwdooxtWOgYxWp4g9QAzJ75h7tROJM
         IR4w==
X-Forwarded-Encrypted: i=1; AJvYcCUVHjEXeM8YoRADV0fcpa6QekskAQM1M90hzYv98WH0AV348uYa+TkxyY7H60U19MmEi42znEjQ564558o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwZoyES9Xi/rlbb2MhqKuboTCVhOtc1Te2r3aAhBRdImQUbeJBS
	r7wp27zFSxwow25waBPj8geUEH5QDf9WLOO75k5Ho7G0ICxXj/mZ
X-Gm-Gg: ASbGncunSdEUZrJw+yRE3BpUMkrAzuWDI1apBq02UL3Qr+Pa5SP4mORqF9XONNZ6t4+
	IRkqGke5k0IHr4u7jFNmJr+Uoy4KyLACHAS2chBBGHhrIZanKrf8OHlxvYm9qkXIEXhfWPtr7tn
	6F7mN2l2nedTIjbOglE0RPxiovb8+5PDyKbR7ISZ1lJBUKtsbc7nTeqe8EzwLMwgnDnwxQGYoIo
	RkxE15MZUb4Aw/g0+84FDTvE7i+ob3dIflAgc3uYkr9HiGW5BDycYpADiK5PmUuRO+Rxg==
X-Google-Smtp-Source: AGHT+IGOysrYTdg1RmL1T+f1Rt3qzH+hhV2d5ecLPOlPKmS77OkqFVsRm67cMKPz8M04UAAYfxgTeg==
X-Received: by 2002:a05:6a21:4a4b:b0:1e0:cbd1:8046 with SMTP id adf61e73a8af0-1e88cd28733mr22686981637.0.1736610755348;
        Sat, 11 Jan 2025 07:52:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a3c259314b1sm3912790a12.9.2025.01.11.07.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 07:52:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 11 Jan 2025 07:52:33 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Joel Stanley <joel@jms.id.au>
Cc: Jean Delvare <jdelvare@suse.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH] hwmon: Fix help text for aspeed-g6-pwm-tach
Message-ID: <7642492f-85d2-48d4-b988-d1ce9010c1d1@roeck-us.net>
References: <20250110114737.64035-1-joel@jms.id.au>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110114737.64035-1-joel@jms.id.au>

On Fri, Jan 10, 2025 at 10:17:36PM +1030, Joel Stanley wrote:
> The help text has the wrong module name mentioned, and the capitalisation
> of the title is inconsistent.
> 
> Fixes: 7e1449cd15d1 ("hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach")
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Applied.

Guenter

> ---
> The naming for this driver unusual; other aspeed devices are named for
> the soc name (ast2400, ast2500, etc) that introduced them, not the
> generation.
> 
> Additionally this driver uses the abbreviation "tach", while the other
> uses "tacho".
> 
>  drivers/hwmon/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index dd376602f3f1..9afa70f877cc 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -413,7 +413,7 @@ config SENSORS_ASPEED
>  	  will be called aspeed_pwm_tacho.
>  
>  config SENSORS_ASPEED_G6
> -	tristate "ASPEED g6 PWM and Fan tach driver"
> +	tristate "ASPEED G6 PWM and Fan tach driver"
>  	depends on ARCH_ASPEED || COMPILE_TEST
>  	depends on PWM
>  	help
> @@ -421,7 +421,7 @@ config SENSORS_ASPEED_G6
>  	  controllers.
>  
>  	  This driver can also be built as a module. If so, the module
> -	  will be called aspeed_pwm_tacho.
> +	  will be called aspeed_g6_pwm_tach.
>  
>  config SENSORS_ATXP1
>  	tristate "Attansic ATXP1 VID controller"

