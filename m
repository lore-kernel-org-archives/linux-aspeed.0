Return-Path: <linux-aspeed+bounces-3197-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8741E6F079
	for <linux-aspeed@archiver.kernel.org>; Tue, 23 Dec 2025 10:36:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbBHr1Vnhz2xlP;
	Tue, 23 Dec 2025 21:36:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766486168;
	cv=none; b=Q5wqyAFa+FHg/f34AVdKzoxXWJDRol0x6aUcSl4CNSFC1pdPxeZojVS7A0IlRUeWgrkWZX0SruhecJ7i+LcCL88AIpjVjEoRsECAiF5IbWmQHh7IB0jXeAh0sUn9BQjSUYU1ixNNa1ToBSPTMCZYeeV/ox07L+n0l8PSwzLYHOZmkzjkV13gGbxmsXRZuWKY85OLcdIpCL1NVDohN8QokCQB7jVhM1WPZyM5eOFTPOcwUL/pTYcRoH4ptCk9jFhYfO/jlL5P7pv/g69GcJskiZtlVSyZQMxIZX2K/3Pc4+zL19s+1NtHPf1qhR6r9Y1Xc+DCxR0hJoc1558kdTZthA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766486168; c=relaxed/relaxed;
	bh=havzK/SwF0OREzHRiv691TKr+k8MMceBKF0LuOOygAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvvoOVQEj1r5Yed2dgch1edO0AhwnGtmBOx49acBatSrwaBpj8B8Cbo2nW4Jn2k5gsfOwZgk8t+dWkf2bUvDcmSKkASIymwmFx3QW7tungX3+Nq+cs6Qj+sDCg0jPVX43DfOgoSfvpH0nyzqUXq4VChzFlfXQq3IOzud+k4k9iiGVQfwq8RWw3WFLFqrTXtOyhSTwi4EEw8LC4YN8wGRlhxISFrm2i9H0mHsEO6mrZXjS5JH/HP8waiJj3o77rxnlYELgYtT23N59tVLWZtfqqfzVSf21R0JMS9lVADC/iujfj67xN8dlOXeuk7sqkphJyVQuUxfGJphkk7qL6oHYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=aZLauevL; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=aZLauevL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbBHm5r87z2xQK
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Dec 2025 21:36:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=havzK/SwF0OREzHRiv691TKr+k8MMceBKF0LuOOygAE=; b=aZLauevLcwMG/dS6u3X7JjCQ3D
	HuNgnIbUxXzfYaLmd4Tpc/2qGNVx/XpFkh7MT/c0ALJF8vlsufhUVxT1LmponF6eHjliWP57PiuMY
	sFY4/9T97AFGLzfZJPzKGd6JuQJP2BRr6vY3MYRLl8DU9Biy2icAyl0WjOKZ1ORlgPcA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vXzjw-000HuJ-IF; Tue, 23 Dec 2025 11:35:40 +0100
Date: Tue, 23 Dec 2025 11:35:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
Message-ID: <1e21f828-1b06-492d-bfcd-ab5721621e8a@lunn.ch>
References: <20251222-ventura2_initial_dts-v1-0-1f06166c78a3@gmail.com>
 <20251222-ventura2_initial_dts-v1-2-1f06166c78a3@gmail.com>
 <c069b452-df22-4afa-bf6a-c48949f40ebc@lunn.ch>
 <CAF7HswN_jEXOU_9K4LpLnbhvd+RD0qqELAHxMBbp=hGtMjS4kQ@mail.gmail.com>
 <35f3eba9-5ec4-4cba-8a64-fb521dc65b79@lunn.ch>
 <CAF7HswN0hhJQ-gmE59cKTuPyzrs1A3rM8Xw+Z8i3_AsHRiNcug@mail.gmail.com>
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
In-Reply-To: <CAF7HswN0hhJQ-gmE59cKTuPyzrs1A3rM8Xw+Z8i3_AsHRiNcug@mail.gmail.com>

> > What make/model of switch is it? Is it unmanaged, or does it use SPI
> > or I2C for management?

> The switch is connected via RMII to the MAC and is managed over MDIO.

O.K. What make/model?

> On our board, MDIO is not wired directly to the processor; instead, we
> use a USB-to-MPSSE bridge (FT2232) to toggle the MDIO signals for
> switch management.

I have to push back on you using a closed source user space driver,
given that i help maintain the Ethernet switch drivers...

I know there have been attempts to get GPIO support added for FT2232,
but i don't think any got as far as mainline. That is probably the
only part you are missing. You can describe USB devices in DT. So you
should be able to describe such a GPIO controller. You can then
instantiate an virtual,mdio-gpio driver to give you an MDIO bus. And
then add nodes for the switch using DSA.

     Andrew

