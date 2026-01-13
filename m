Return-Path: <linux-aspeed+bounces-3307-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C202D2F35C
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 Jan 2026 19:33:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drKDk2Yjdz2xWJ;
	Wed, 14 Jan 2026 06:33:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768332838;
	cv=none; b=dMbGDMt4RzPYnYBDqFIk7pJjMm79e9BKmKODfE0a/OyQ6gpfjVwHDfbqTy2UmNni5qVCEbDYYpCi0L08ciTl4CWyelMJhVs1ta/yewutHUuq53X5Ngffz2qCHbdN8oz4iXTYsgxIEkTbgzE/aj5gJNTHxqgD188qfx3d0/Sc3hr4uCCEgfIaTsyww7lTmzQtlb0z9Yv+2zFYZSrxDMYkiKAmuwNBt/Li6qECPZ43oqZCT8Yj0r0Eca9sphcuFEl3ulUhmXoKGLz4Ki05J6WlRppGSL6w24lN+nhi0p0YrQZFzxCC7y8hnztaeqxd2Cl6NnQK5gi8RtoNJ1eNtDniOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768332838; c=relaxed/relaxed;
	bh=QUe3p68Mm3OsOBcMm6RQixsXLcR6aOMZwt8Wi464jhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5izVp8ROy24D/3o/8+APsjzR6GAb+zNBLHqgWrD8lYO9k1rr05JFzHFHWXvbtI91S8ZB1UIHaWODKhzlW50ut6+2TtaPA/b5XqkoTPj2fM2cdF0J+aH7tLe4kI1zTXCzqWVd+1QVUje70cKNOCEB6457DO03H0rEcJkZEdenP7xJO1VJag9a3arYRUtsZB9OVvuU3KAp0BzJfH9CEKmuv6K4+9b8qyFG6ic/bkk+AaN4VuXYapM3qDMl+3AnPgb4PdIBAFWvcpaDUAhnrcSLT67TEbwHUI7J4NdqdFgJNtDzkgEbqUQlSoUu9dX5IL5g8Gi+Ad24yrMWMwo3V6tow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=GF0+M2AY; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=GF0+M2AY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drKDh3tVfz2xQs
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 06:33:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QUe3p68Mm3OsOBcMm6RQixsXLcR6aOMZwt8Wi464jhM=; b=GF0+M2AYoE8pxPe1eEUG/Kxo0j
	4fQhaFccuxjV/Xu4bg2335tzPKnalaLTaM0wA7dYLuywGYAEC/q0+9yOEAlGGp9INbHj+sHopEjiF
	/x1GLMTM/1tO+/lsdRWAjkkN86ATvSkEzIzRgZ93MoJSRc8VKciAj1FaNqI4Fv8jA7+M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vfk8z-002gHg-Gg; Tue, 13 Jan 2026 20:33:33 +0100
Date: Tue, 13 Jan 2026 20:33:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
Message-ID: <d9926d5e-7cdd-4c3c-9d9c-86418ceb4933@lunn.ch>
References: <20260113-ventura2_initial_dts-v3-0-2dbfda6a5b47@gmail.com>
 <20260113-ventura2_initial_dts-v3-2-2dbfda6a5b47@gmail.com>
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
In-Reply-To: <20260113-ventura2_initial_dts-v3-2-2dbfda6a5b47@gmail.com>

> +&i2c6 {
> +	status = "okay";
> +
> +	// Marvell 88E6393X EEPROM
> +	eeprom@50 {
> +		compatible = "atmel,24c64";
> +		reg = <0x50>;
> +	};

Are you don't multi-master with this EEPROM?

> +	io_expander0: gpio@20 {
> +		compatible = "nxp,pca9555";
> +		reg = <0x20>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		gpio-line-names =
> +		"RST_POE_BMC_N", "POE_DISABLE_BMC_N_R",
> +		"RST_FT4232_1_BMC_N_R", "RST_FT4232_2_BMC_N_R",
> +		"RST_FT4232_3_BMC_N_R", "PRSNT_FANBP_0_PWR_N",
> +		"PRSNT_FANBP_0_SIG_N", "PRSNT_POE_PWR_N",
> +		"PRSNT_POE_SIG_N", "IRQ_POE_BMC_N_R",
> +		"PWRGD_P3V3_ISO_POE_BMC_R", "88E6393X_INT_N_R",

You have the switches interrupt connected to a GPIO expander?  That
seems a bit odd when you say it is running as a dumb, unmanaged
switch.

	Andrew

