Return-Path: <linux-aspeed+bounces-3676-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D329CF30296
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Mar 2026 01:55:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYypW3Wprz2xpn;
	Mon, 16 Mar 2026 12:55:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773626115;
	cv=none; b=ek0a6UoLJvGSNulO+ut3k2XsxKoyTlcwiO08xGCqVqyo9gFygYI92u68m6ZN4SW1yYOlE7p5Ax4Fvp7d3rtv5KwGjdFIQCceTMG/BS6jM01AvzWV+gSq/MvF85jFGacMC4HvlvLiBSmDRMPKF092HCAq32m/uXkHIARSBLElPeW37CX/bFXCL0tTQvoHYoPgh+6I736kO0j1jM1SbdYtnY3Txtuxfz//vBuZGhDaHyCxNHXJeBJjLRX4bfBEXrqNIMWHmj3CcMiWm2okPWly/ulvrLPCmJnl0W0as346X6KB62vRtpUnhJ4zDcLlUHsaasbNhR8fYF8yTqHU5EQY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773626115; c=relaxed/relaxed;
	bh=nkGznBF1XyO8DVSgDpTBwSZfSOT93qCEm7hJnIBqTf8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zh4Tm+PPFHNhHhVX5tHRHuHUsso95XQlsrw87CG8SM7dvzUJ6UPYidTmON0PPVvJ4BVO2eWKWWFX5rIFv0wzf6ldbY9ff4q4v9rHN5ZXhiw0F8GHtmC17KrxVyBSNyomkSgbLFG4D4peXAfSQMzXwn51sB6gxrZ8ouXsUrAmvpFRz7vp8KLfUyPg9W08jrb0gJTM6c9iJqVSMSdak8ovT24zhGXeEGKCB5/T3W8G6U9pRvViPdfz0V00aFIOqLjgwaubCyZssw3jldVCEBILAIAEBOiw+Gx+aqMDTwx3vYHIvJeLW0GYjPW00zG4KVd43qKv0BLXFHKNGlL4HbRFWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=c4ExRsyn; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=c4ExRsyn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org)
X-Greylist: delayed 322 seconds by postgrey-1.37 at boromir; Mon, 16 Mar 2026 12:55:13 AEDT
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYypT4ZzMz2xlP;
	Mon, 16 Mar 2026 12:55:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1773625789;
	bh=nkGznBF1XyO8DVSgDpTBwSZfSOT93qCEm7hJnIBqTf8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c4ExRsynMm40V9We4mPTyAQ1gMSRmWj67Whu9oyw2qfM5dhrnt1Za/xhR24MZzEjE
	 wE6BS33UEf+oWRBXfIrfXIgaLjxZCscKQEyaW2ILSaH7sVj/3S5aKwXOZOX/JdAGtK
	 oL1ErnHTMy6VKZbjzRCFZ4/PEBSFNTHSJ5/U87wbIKJ43/0QVIQhMCotzD0Pnj1rh5
	 OFkJHP1MuIe3Mn6su+WhadLr+OpA0579MY9xO+u9yHWRsEqrsQpNOI9twi3DvWA4mH
	 uCLYz46YLZXeYU6Y/sVdaFd9g9ec13XAyajn+VC3M3M70j03sOHZQlydpTRGRW/KT3
	 ot8IedAXEoYaQ==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 74B1960929;
	Mon, 16 Mar 2026 09:49:46 +0800 (AWST)
Message-ID: <7ae8222bf6abd83a3c2ac976f54a2edbe4e9727a.camel@codeconstruct.com.au>
Subject: Re: [PATCH v26 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
  Andi Shyti <andi.shyti@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>,  Philipp Zabel
 <p.zabel@pengutronix.de>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>,  "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
 <openbmc@lists.ozlabs.org>
Date: Mon, 16 Mar 2026 09:49:45 +0800
In-Reply-To: <TY2PPF5CB9A1BE6A19D439C675AF5028C13F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com>
	 <20260309-upstream_i2c-v26-2-5fedcff8ffe8@aspeedtech.com>
	 <20260313232125.GA3618633-robh@kernel.org>
	 <TY2PPF5CB9A1BE6A19D439C675AF5028C13F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
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

Hi Ryan & Rob,

> > > +=C2=A0 aspeed,transfer-mode:
> > > +=C2=A0=C2=A0=C2=A0 description: |
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASPEED ast2600 platform equipped with=
 16 I2C controllers each i2c controller
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 have 1 byte transfer buffer(byte mode=
), 32 bytes buffer(buffer mode), and
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 share a DMA engine.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select I2C transfer mode for this con=
troller. Supported values are:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "byte": Use 1 byte for =
i2c transmit (1-byte buffer).
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "buffer": Use buffer (3=
2-byte buffer) for i2c transmit. (default)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Better performance then by=
te mode.
> >=20
> > Good, I like worse performance so I can use byte mode.
> Thanks your review.
> Will remove performance statement.

I don't think that really addresses Rob's point there.

The selection of mode is somewhat a driver implementation decision (and
so would not belong in a DT binding) - *except* that there are
considerations around the use of hardware DMA channels, as covered in
earlier review.

[My understanding is that the mode needs to be defined here to select
which i2c devices have a DMA channel allocated to them. I also
think that byte mode may be useful in some scenarios, but that
consideration certainly does not belong in the DT binding spec]

So, how about we refine this to *just* the hardware-specific component:
whether a DMA channel is allocated. A driver implementation can then
select the appropriate mode (dma, byte or buffer), depending on
implementation-specific details.

In that case, we would just have a boolean property, like:

    aspeed,i2c-dma-enabled;

- to signify that this controller may use a DMA channel. The choice of
actual mode is left up to the driver implementation.

Rob, would that suit better?

This way, we don't have ambiguity on "buffer" default vs. absent
property, and we're no longer specifying actual driver behaviour in the
DT.

Cheers,


Jeremy

