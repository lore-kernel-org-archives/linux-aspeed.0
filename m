Return-Path: <linux-aspeed+bounces-4520-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90BDC4451C
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 07:00:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4lX13Vzfz2yVd;
	Wed, 22 Jul 2026 17:00:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784703649;
	cv=none; b=aJs+yBeQxZ7V9jsMcP/TUGU3NNbDVHckfDcXx/euNZhps7ujErr3B0vJsanWiNGPjVxVScWE2uZQ1Q/kQQOM72H4x0Oo2+31WpIxd1eJdVAo5KsUxAxUsNgXE14oMCvzBNtxIaS38e/lshnodoVolBk50AF+KbQPTgP3DCAjzVaG6PidyEV7Bjw18q8Jbw6tm5+YGlycVzuth3wNXTXEPYgnH8Ipehqp8WUSe31SyUhtyitH0AeAsjS7i5Ogackj+p3QOBys251JPX9lH8sQo0LDWYsU7NUGiO8ETItcNrmJ8d363ZDOXpbMYi5SqUr2Zrq/Yu/ucPth6YXsaFZPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784703649; c=relaxed/relaxed;
	bh=C55jJmDfmGi6xpILXoNlr/fLTzAI61lVTFq8ZnYY1Ss=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Btc8YLqRLouc9LqpgFZxgAGU79uLhodnxs8jfvoJR7YhPbjAAKDjTJSBm0WtE1BAKmUgUczbipvlFSKySlhzLmJd/9swboNfy0L5v1JL0oxjJ8s2xgWCW44gbt2Ugwef/6IV1lx4f1R+Lj6aqMybh5RLvBV26bDRFkqedvH2kWt1wm+khIqvc1zoORENXCLKM+mTTNk5ogqyhxcHrzpK09y09hbw2y0SS3igeTy9OYnttR4PGVphltOYPhD8CEVHTvkrCCG4Bv/yMpjayLVQqDLJahw2C71ORXx6xd/djuRdzN9DX/T2ahEZY1H11L1LdWw05a1bFk4AcXNH8LiruA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=L4ROw7Wm; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=L4ROw7Wm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4lX06Mykz2xJT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 17:00:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784703648;
	bh=C55jJmDfmGi6xpILXoNlr/fLTzAI61lVTFq8ZnYY1Ss=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L4ROw7WmxD0DtmLKlIjP2iYeD33ovUCxgEUFLf71Ovsb1jkdAagvaoppTpL0ATlN/
	 NQXSxgO8Nx0vj91tGSZACMYqo0NGJ+fjv53HUK4niolcSHps04ETXjiB3gAVNRsF96
	 qOPyznz4DllyhGchKA14oBLQWTmX4FGnhNWfq0jhv8Xwa2AWGmNxRC4bjV/cb33QT+
	 HY+1jeTBEB1Sr4YCBUbGGsTcUVhcHpP42qJ49UeT5ZZ73Fz3bA7Ol7p2wA2SQ7UVr7
	 z/AExnCM14rq2P04jrvVGWPQ8lk/f7vTzM5DCJQYAyOMi6iRR7j0wp/wy4H90Du5iV
	 S1bCyb8/Aycmw==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 23BB465B37;
	Wed, 22 Jul 2026 15:00:47 +0800 (AWST)
Message-ID: <ca289e45bbde8e8a2f823a1660aa0a8f88e94bc4.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 2/3] phy: add AST2700 usb3.2 phy driver
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>, Philipp Zabel
 <p.zabel@pengutronix.de>
Cc: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
 "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Wed, 22 Jul 2026 16:30:46 +0930
In-Reply-To: <TY2PPF5CB9A1BE6AE5B658D558EBDF24450F2F82@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260116-upstream_usb3phy-v2-0-0b0c9f3eb6f4@aspeedtech.com>
		 <20260116-upstream_usb3phy-v2-2-0b0c9f3eb6f4@aspeedtech.com>
	 <ddb133ca1a3be605ee776b2276c1907c9ad32491.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE6AE5B658D558EBDF24450F2F82@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

On Wed, 2026-07-15 at 05:55 +0000, Ryan Chen wrote:
>=20
> >=20
> > > +	}
> > > +
> > > +	/* Wait for USB3 PHY internal SRAM initialization done */
> > > +	ret =3D readl_poll_timeout(aspeed_phy->regs + PHY3S00, val,
> > > +				 val & PHY3S00_INIT_DONE,
> > > +				 USEC_PER_MSEC, 10 * USEC_PER_MSEC);
> > > +	if (ret) {
> > > +		dev_err(aspeed_phy->dev, "SRAM init timeout\n");
> > > +		goto err_assert_reset;
> > > +	}
> > > +
> > > +	val =3D readl(aspeed_phy->regs + PHY3S00);
> > > +	val |=3D PHY3S00_SRAM_BYPASS;
> > > +	writel(val, aspeed_phy->regs + PHY3S00);
> >=20
> > According to the datasheet PHY3S00[15] (PHY3S00_INIT_DONE above)
> > indicates that the PHY internal SRAM initialisation is complete. The da=
tasheet
> > reports the SRAM is used for configuration of calibration among other t=
hings.
> > PHY3S00[6] instructs the PHY that software has completed loading the
> > configuration data into SRAM, however PHY3S00_SRAM_BYPASS (PHY3S00[7])
> > tells the PHY to load configuration from "hard wired" values.
> >=20
> > Is it necessary to wait for SRAM initialisation to complete if we're by=
passing it?
> > Or are there other side-effects involved in the setting of PHY3S00[15]?
>=20
> Yes, it is necessary to wait SRAM initial, the driver polls PHY3S00[15].
> It reports that the boot loader in the PCS has finished initialising the=
=20
> SRAM (loading the contents into the PCS), and that initialisation has
> to complete before sram_bypass (PHY3S00[7]) may be asserted.=20
>=20

Can you improve the comment then to make it clear that the wait is
necessary despite the bypass?

Andrew

