Return-Path: <linux-aspeed+bounces-3869-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1BC1073CA8
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Apr 2026 12:34:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frMw16tzLz2yDk;
	Wed, 08 Apr 2026 22:34:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775651697;
	cv=none; b=lgiQ6O9stLClspovSajL5NPcKYCrehCzSyadvOFCyX52c6s7VoeB7YC2GgsTPEB5xeeQfEuOgfIM/nDGD4QZt344s3OuNbI9Uu9fEHyt6szzyKVG5yUESqzVyVeYxEiTJq/5zMD/g5rObwiPAXV1I6Lpy7y9OLy6gb3ecsN4lTsRre2QPpmwwxvfvFMQ9rVZO6yxN37qCyRNOphMsHcw8eRvhhy9Nbn2SMA/OdMPEM6ookvUP3m6n+uSV016udh4ljzTFu9fBamkzawbL6DeiI528YSz9VF1HN0H0nzVUS8MACNg84+teEw1I+GzGSXAFGw1ad7lpHc1V3gAqGgyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775651697; c=relaxed/relaxed;
	bh=UZm0OMiCYQ+7g0KMOOJaEeMtCB1NoXIae3H5HwDH82U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yz2Bq0XB37rIuRMz1kzoWD8RWWfx5ByNgRVxCLXeQGq5oaWFZe+UKEt9tiLcEaQ9KH6UnaIxLIBvgIbKOSu3Fjh3oKgHCkcITr5g5SqpSjZPF44EJC6VYnoEirC68rHpnkGAM0Xq8sppDb+x+XuCCAgsn/xsKeNjr0miJSqYXp4NCokzyG5v4AcnbDsHjHdunp5lSo07wyvMuRCOnXSMXBY8AKnKjhFZr/oTgqNFLn0YDCu7NlYMC8l9jI74ly41EsHco6nI5/xgNfJccMSDNYRuyZfusKaeUgPX148tpbM8y04L5FNDdGNf8khcJg5G4J5e/P0tSmHg+5yK8koEvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=lUcQs91s; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=lUcQs91s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frMvz5HkLz2yC9
	for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Apr 2026 22:34:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UZm0OMiCYQ+7g0KMOOJaEeMtCB1NoXIae3H5HwDH82U=; b=lUcQs91sIVusfR1u89Stz05ODI
	AMhxret+/edGus9rBRyTcLUGXHf1+j7vips6AbSB6HSPe9HBw1p0HiJ6vLRsEXaM20P3nzGqQFLn7
	Efio5MaldMKsoTnJqx0IzS6klKtDGHTB874frDoDMPk7FfEAj85BYwcWdzltEDxPDzEM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wAS7A-00FHkV-QP; Wed, 08 Apr 2026 14:34:36 +0200
Date: Wed, 8 Apr 2026 14:34:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "P.K. Lee" <pkleequanta@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Jason-Hsu@quantatw.com, p.k.lee@quantatw.com
Subject: Re: [PATCH v12 2/2] arm: dts: aspeed: ventura: add Meta Ventura BMC
Message-ID: <e7a1588d-b4d4-4aa7-ba94-da3e2591d49c@lunn.ch>
References: <20260226055521.1655243-1-pkleequanta@gmail.com>
 <20260226055521.1655243-3-pkleequanta@gmail.com>
 <258747f4-9da5-44da-8eb9-24f8a8cbff3a@lunn.ch>
 <CAK8yEODCyYxkggU+7=xzWFcXP6RMTpNbHyYRHZhahX7=b6reqA@mail.gmail.com>
 <435616b8-8d4c-4814-8f21-d667755473f1@lunn.ch>
 <CAK8yEOAYC0iApNHBApt+xu1Fz=+N1wX0XrLGOPzmeRq=OjWnhg@mail.gmail.com>
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
In-Reply-To: <CAK8yEOAYC0iApNHBApt+xu1Fz=+N1wX0XrLGOPzmeRq=OjWnhg@mail.gmail.com>

> > > > If there are no devices on the bus, why enable it?
> > >
> > > We intentionally enable it so user-space tools can access the switch
> > > registers. I have added a comment in v13 to clarify this.
> >
> > Why would user space want to access the switch registers for an
> > unmanaged switch? It sounds like you are using Marvells SDK in
> > userspace to manage the switch, rather than using DSA.
> >
> 
> We do have a custom user-space daemon that configures the switch
> registers for our specific use case. Should I remove the &mdio0 node
> if it is only enabled and has no other configuration in the upstream
> device tree?

Please just be truthful that you have a user space driver, so need the
bus enabled.

I also guess you have some other kernel code that allows you to
actually use the bus from user space? The typical ethernet IOCTL
handler does not work for you, since you don't have an ethernet device
using this bus. Such code is unlikely to be accepted into mainline. We
don't like user space drivers when there is a perfectly good kernel
driver for this switch.

	Andrew

