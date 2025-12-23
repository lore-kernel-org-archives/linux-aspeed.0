Return-Path: <linux-aspeed+bounces-3196-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A661E6F078
	for <linux-aspeed@archiver.kernel.org>; Tue, 23 Dec 2025 09:14:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4db8T76nyWz2xlP;
	Tue, 23 Dec 2025 20:14:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766481243;
	cv=none; b=US6gOsEEV3pobEuHDX4OZ+BlsV6RrlcU46DgARuEWwtMcEwwD9uwm8Sx6VY6krrCvqy9GlwOI9y1B9s31Yq2F6h/u3IYdECG02Fnj038p0p9NC+AQ6RZBtMTJrhc49tngxRTgkeEEm+iGP0+qD8wTn9eo+5i9eizLnzsKMGGHGSxWsfjEpnupS2HkGYQDhFK7B8260zvYOJM3NOfK7fljMXBGFnYKY5hHYWb4TnflOS9C/86Rr6iDrTQtrSrfYC9pJzB0hZ/7cxJwI6GT8NGBOgfY8zICmgIU5+LYi900FrfZXeAReB0Sr5DAfUM2bsZ7BEp+fiaUglOkqhJLUFBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766481243; c=relaxed/relaxed;
	bh=HEk39s4EUEiPzn8QUrMy0dlOdorZCmMf4fjGiDLyucY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou0RketQ0HCR+FDSaLI3V+mcGmfU099YeikhClB/RgoVXa1ajY2TA7+ufXNjaY4Hk+MW1CeNDz6/Uj69STAox066XuUPkU0CcdzAqkvwgf96hwkM2aKdHJk+b7ONLUwPNoQYOs2/8rqDxuOF8YIFKv12y20tybSIFollvRhXJ/UFXKSbIt9LwvHYE7wMmVKnGCqO6/R8kVSI3o/IbBASAuV/MeZh/fDm1agUW7oAn9EnPk1E3272yinOjwOrQIgSKQx/6TB9ZsMRb8mlKK7qGhKedCPA2kb3hQikJCBhvQ+fXzXgd7g9OHzK9SydDTmktt4Y30OPOfwf2cPMe5KHbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=pMFy6O32; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=pMFy6O32;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4db8T6544Dz2x99
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Dec 2025 20:14:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=HEk39s4EUEiPzn8QUrMy0dlOdorZCmMf4fjGiDLyucY=; b=pM
	Fy6O32zXiYSnuByU6S4Pnh4CTm2w1pkPqd/2RU0oPjhbC0146rEV6+5nHEmctSJJD3ysmjpFcr+nu
	bwyGbv8CIM+GI9DWjEl6tL6olkcK0AB7+kWr1JxniPo/ZRmB53AMXxXG7zWWaLUsxaQmWR/+lTVm/
	gutJkDs26RLuB48=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vXySY-000HP0-F1; Tue, 23 Dec 2025 10:13:38 +0100
Date: Tue, 23 Dec 2025 10:13:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?6Kyd5pS/5ZCJ?= <kylehsieh1995@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
Message-ID: <35f3eba9-5ec4-4cba-8a64-fb521dc65b79@lunn.ch>
References: <20251222-ventura2_initial_dts-v1-0-1f06166c78a3@gmail.com>
 <20251222-ventura2_initial_dts-v1-2-1f06166c78a3@gmail.com>
 <c069b452-df22-4afa-bf6a-c48949f40ebc@lunn.ch>
 <CAF7HswN_jEXOU_9K4LpLnbhvd+RD0qqELAHxMBbp=hGtMjS4kQ@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF7HswN_jEXOU_9K4LpLnbhvd+RD0qqELAHxMBbp=hGtMjS4kQ@mail.gmail.com>

On Tue, Dec 23, 2025 at 09:49:02AM +0800, 謝政吉 wrote:
> On Mon, Dec 22, 2025 at 5:30 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +&mdio0 {
> > > +     status = "okay";
> > > +};
> > > +
> > > +&mac2 {
> > > +     status = "okay";
> > > +     phy-mode = "rmii";
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_rmii3_default>;
> > > +     fixed-link {
> > > +             speed = <100>;
> > > +             full-duplex;
> > > +     };
> > > +};
> >
> > That is an odd combination. You enable the MDIO bus, but don't have
> > any PHYs on it, no phandles pointing to it. And you have this
> > fixed-link. It makes me think you have an Ethernet switch on the bus,
> > and this connects to it?
> Thanks for the clarification.
> Yes, there is an Ethernet switch in the design.
> The MAC is connected to the switch via RMII using a fixed-link
> configuration.

What make/model of switch is it? Is it unmanaged, or does it use SPI
or I2C for management?

	Andrew

