Return-Path: <linux-aspeed+bounces-1619-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D632C8303C
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Jul 2025 23:09:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bXbFp2MgDz2yPd;
	Thu,  3 Jul 2025 09:09:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751497790;
	cv=none; b=aKATAGoHi9GomUn3wadpx3+L2TKEQnqSX8UoGsc9M/vTqpe/HpwxjziFVPcA/LErtURoXZP+0YmRD7aM9FppG5J+8MEIRPRtmxbRjds3XY9qSgXY+Thn7sabBiVOmht4xW77kXo+kPlAuow6mtrkN7ifR55bIGnKmmWmu+357qR3r2UzczdGr0Ks8BXFlep7MoW9VBWCm8ST4JrdHa433ZKaF1c8swetxPve4N6ed8822wADvu2m0zgsoxfrBcHVbtkCsqtrXdvwL2OWhClCWkHtRxwClCg/glJ99ACgzQdCqAfJbZrFO/SKfY5Pdcu6fHC4+B67IzBYXaEpVLDrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751497790; c=relaxed/relaxed;
	bh=XeivJRV1NlwEM68DYnpxYNj/SFkkK7NrLDkX6W6GBRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hy48pV598yYFajH1zqI65ccimX/NVcRuuzpKT2bL5wK000Ir6SGA7V8kpmUTg4nSkBg/gSItwSXIjbPorzuwgPh4PWsnfMK39qElz1vNP5x328b0jxENDPiz0/7jgi4qWkJU7bdMw63mbqg/cnWCCXZn4HRQeDE557drZBh+9sUQ8AvmF6AWTj2C8UZQ5T6y5dH8WHIVt4pjfMw5aMScEM4YND+C4HHFqePSTBIImSc3pKMxUZ4JwXlY6PRw7bkb0injYpEgnECfdA1RHW/OAp/teaTJvP0TLRto9YwuqinOiMKK2/ANhPr+siy3toZl96EAZWrjWifcBYPVSEJChg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZsjlOL9+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZsjlOL9+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bXbFm6lxnz2xBb
	for <linux-aspeed@lists.ozlabs.org>; Thu,  3 Jul 2025 09:09:47 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-235e1d710d8so88424595ad.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Jul 2025 16:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497785; x=1752102585; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XeivJRV1NlwEM68DYnpxYNj/SFkkK7NrLDkX6W6GBRM=;
        b=ZsjlOL9+qByoqTAVceG/Uw41OR4ydxqEoQQ53/6b/araw6RskbHUPYiSwULdfKca4V
         MbM7g0B5w9eofBwN6onF0heXOBptW1eMS/oBxZ9KjmKupP6jHgWDKsk1vfk4NAKdO/o2
         +ldJ++0PtBk4TpXN1QUmOrD8SFu7rTbb1wvAoeDvZP0H+dgFHXCT1dHli8rnWJiO7IJE
         bC4KviiYhX18VQgJjOvMcK+bpgpOeNvAZGKgRM8KWPqsvbYaFk29qacalMhf1kpWMYno
         bT6Xg9y25f/79/dNvycHOyfmfwuscnz31bMobTYdR88DvmNGYaJol/fWv69UpC/Ffy62
         JUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497785; x=1752102585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeivJRV1NlwEM68DYnpxYNj/SFkkK7NrLDkX6W6GBRM=;
        b=iTrV4nQhY6SRbWy/On3PuCnlc0eu3WHKUwiw8L5/RQPkv16+8mwaR3yLxLb/OY4l7t
         zFup1+7nOi2IN+XL58UNSWYZ7u310NtnIP9dSrPA8jri9MLEuNZ7FAW7382vPz1OMFiL
         o17jriAJbl/4kA3rKWq9BkFdsdpAWjIzuVfq0CSbIZHxUHOZpjNgrxabHhiSrbcV1l1/
         LoNgB8Q5PvUWbc8rBbMuk1zmisae230jHibR8syBfZSdz/Ko4tYlIh34k8v7aOVdpX86
         B7WpRMRZDjVkiJxYnrFXW1t1z4U3Hwmmc7hB1TcuwewS+pGKFlKgcLFE0KERUDm74TyE
         C3Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUWRvqWgKJVMdXd2JiObhFr89KujtqLluT3Yi9LogG0O/eWA15KUuFVAIQ9gqfup1LpqDHELUaDK45Kfrk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YydTLF6QTX3XzrOFoNsKmI4ee7H/gUD+JWT8cGsahOe0sahgI7m
	F0K+scaQVCzoU55VYaT/roy0aBG2iEEkhGPYRrMcmG9KKSHScirTL6qsh7tuFBDu
X-Gm-Gg: ASbGnctbrm+SQP4/EcZODypUUhlHtFxdCopLel6JGCzOYbzChO+pV+I9/ZxAVgQVgA6
	+uSmZUdZTw/jD8d9iEa8uYTHlcL6tm9j7C2HI+BYpXUQiu7l7mKfUht19CT52GmqwG4HwXH+jWh
	kuGPRCxQbpIY/Ef8dwdlhyWtLAgyPQPlittOYJ/Kyc5f0HkhTPq8nw3FRPx6EUoWILpoBhsIeNc
	NsgaWpycl7hUWnf4covnqd7ZnpcF5VTIA9k1rrzpUjqI6dUMPuWJdlf9MYPG3o9Qokq5JS5HWRI
	O7UVZ+ebJ+bkUgxSPnAge2Iyi6uG2Z+zSe+cXxYhH9J5QCuaE7GqbuY3wgmqZh8GBVK6duPgk2A
	QRvtT2Qdg2ACA0eWN5FEVxyvmkuGukCof6LDv7fA=
X-Google-Smtp-Source: AGHT+IEVdT1zTpOAW82Mu/cKqzXbhhazsjZMaKYPAm5vkqC5kKsvAAVyqV0n0+btI2SrjFS8l0lO5Q==
X-Received: by 2002:a17:903:1ac4:b0:234:cb4a:bc48 with SMTP id d9443c01a7336-23c6e593323mr74668905ad.31.1751497785135;
        Wed, 02 Jul 2025 16:09:45 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e244fsm142696605ad.12.2025.07.02.16.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:09:44 -0700 (PDT)
Date: Wed, 2 Jul 2025 16:09:42 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH 5/5] ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC
Message-ID: <aGW8Nm8ZWMwRYVOo@localhost.localdomain>
References: <20250702050421.13729-1-rentao.bupt@gmail.com>
 <20250702050421.13729-6-rentao.bupt@gmail.com>
 <a6f6966b-50ee-4b4f-9422-96c6ac9391a2@lunn.ch>
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
In-Reply-To: <a6f6966b-50ee-4b4f-9422-96c6ac9391a2@lunn.ch>

On Wed, Jul 02, 2025 at 09:40:40AM +0200, Andrew Lunn wrote:
> On Tue, Jul 01, 2025 at 10:04:16PM -0700, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Add initial device tree for the Meta (Facebook) Darwin AST2600 BMC.
> > 
> > Darwin is Meta's rack switch platform with an AST2600 BMC integrated for
> > health monitoring purpose.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed/Makefile             |  1 +
> >  .../dts/aspeed/aspeed-bmc-facebook-darwin.dts | 92 +++++++++++++++++++
> >  2 files changed, 93 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
> > 
> > diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> > index 2e5f4833a073..debbfc0151f8 100644
> > --- a/arch/arm/boot/dts/aspeed/Makefile
> > +++ b/arch/arm/boot/dts/aspeed/Makefile
> > @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
> >  	aspeed-bmc-facebook-bletchley.dtb \
> >  	aspeed-bmc-facebook-catalina.dtb \
> >  	aspeed-bmc-facebook-cmm.dtb \
> > +	aspeed-bmc-facebook-darwin.dtb \
> >  	aspeed-bmc-facebook-elbert.dtb \
> >  	aspeed-bmc-facebook-fuji.dtb \
> >  	aspeed-bmc-facebook-galaxy100.dtb \
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
> > new file mode 100644
> > index 000000000000..f902230dada3
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
> > @@ -0,0 +1,92 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +// Copyright (c) 2021 Facebook Inc.
> > +
> > +/dts-v1/;
> > +
> > +#include "ast2600-facebook-netbmc-common.dtsi"
> > +
> > +/ {
> > +	model = "Facebook Darwin BMC";
> > +	compatible = "facebook,darwin-bmc", "aspeed,ast2600";
> > +
> > +	aliases {
> > +		serial0 = &uart5;
> > +		serial1 = &uart1;
> > +		serial2 = &uart2;
> > +		serial3 = &uart3;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = &uart5;
> > +	};
> > +
> > +	iio-hwmon {
> > +		compatible = "iio-hwmon";
> > +		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> > +			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> > +			      <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
> > +			      <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
> > +	};
> > +
> > +	spi_gpio: spi {
> > +		num-chipselects = <1>;
> > +		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
> > +	};
> > +};
> > +
> > +/*
> > + * BMC's "mac3" controller is connected to BCM53134P's IMP_RGMII port
> > + * directly (fixed link, no PHY in between).
> > + * Note: BMC's "mdio0" controller is connected to BCM53134P's MDIO
> > + * interface, and the MDIO channel will be enabled in dts later (when
> > + * "bcm53xx" driver's probe failure is solved on the platform).
> > + */
> > +&mac3 {
> > +	status = "okay";
> > +	phy-mode = "rgmii";
> 
> How do RGMII delays work? Connections to switches have to be handled
> different to PHYs, to avoid double delays. But is there extra long
> clock lines? Or are you expecting the switch to add the delays?
> 
>       Andrew

Hi Andrew,

The delays are introduced in BMC MAC by setting SCU control registers in
u-boot. The delays on the switch side are disabled.

I will add some comments for the delays in v2 (after addressing the dts
schema warnings). Is that okay?


Thanks,

Tao

