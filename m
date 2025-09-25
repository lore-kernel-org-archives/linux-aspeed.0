Return-Path: <linux-aspeed+bounces-2341-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8979CAC5A5
	for <linux-aspeed@archiver.kernel.org>; Thu, 25 Sep 2025 00:16:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXDmT609cz30Pg;
	Thu, 25 Sep 2025 10:16:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758759417;
	cv=none; b=m9wUXqoXkN/MzzXX9Nk/z+sk9ksA72uy2HFoY6Yvtf7qoSOpD5JVq/lPuCqIjDuqZzOvx3tbMP6JW9jeqoxa28rjOAlUeAtl0mDzXwzpRrRCLbFZk/c0+CAzCLafvi2/RjWkZ39+CCe/VDvMUEdTmhR5mST4NviiPXdNm6tnZiP9LNwlfny8n5+mFv44nd/ea/RdioCfmIXSO6q98/0CWPPJMfuEyb/6xKSFgFXaKIrREp/fHvyEPMPWrXHV6mCaY4QFc74hhefBPUKBK72tzxlmXRb+oQeyzWReO69DRv3xbVNQ210QZkCjsDnnW3qFiSj3mUt+62Xz1yfzkagGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758759417; c=relaxed/relaxed;
	bh=trv/5zES0J71ogwwSlHNmpRE442auLyV/o1fTLjOtsY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DR8Uil3BbB0wpKCuv1sVsepQJfNERwyP/bOxOqQUqfxmQyim8vPyTcnk130q0SL+G1OOb5FNnhWC18+XqUE+27OCmoubB0U3f6pEGqdUZQ8I1uTN12EAVZUm/pFpyRC2gqcOy2Hey6Wlc8l5YSuVwJ7TduFytHHPuSlbeI7hSRaUweQPLmJPGW8ao00VD7gmM12b3zWYAkb4jY8Arm7uFXTfwG/KDz1mOUWp4wFzZzrcZsgkS4/fkJDT/qR/LGi1mgFKcPKMDKOY1U+xYp0aXmwLyPcj6DDOvVMdIOpVPT/zEkWjshXVC6fBJh/X3R8SQLIVsC0PNBvYSoboqeoW5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=OJ2QRaPE; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=OJ2QRaPE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXDmS4H8tz2yrm
	for <linux-aspeed@lists.ozlabs.org>; Thu, 25 Sep 2025 10:16:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758759414;
	bh=trv/5zES0J71ogwwSlHNmpRE442auLyV/o1fTLjOtsY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OJ2QRaPE5M6I7OP/H1j/PrTVgCrSMP8UrZbzVbJyJ9se212oYGTasKT/W0nJ7I+XH
	 ufKTD795DRI0fcQbAbG4Akd1jFQhFgIBgbF9Hsd9dw62X2HbwkoHeOTNow7OPwDWHO
	 01TvqkRQaD37ozssgLvRxP2BAueimrUnliWp0A5eAXcAgpoXodP0Uz993+ElhG/G5j
	 hZb7lX1kvo7ItL6eQKyReGgHb3fIB4nnpYY5Psj6Olq3TMKiyomvU1KqwmUNxQA2bK
	 N6lSo2VEHUf2xwIN6720wRPNbNRpW4oVU/TXB1hs2vZgfs+iZTeHf20qDw0vajdGqj
	 k3l0y0U2BxUNg==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 55C40738DF;
	Thu, 25 Sep 2025 08:16:52 +0800 (AWST)
Message-ID: <090d0e196fd0f814b5385f2c6e47e5196f0be649.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 0/2] Add Meta (Facebook) Yosemite5 BMC (AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>,  Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Date: Thu, 25 Sep 2025 09:46:51 +0930
In-Reply-To: <CAL_Jsq+zBK1CBJX0XcaqaYeOPUhoRE-nMeYvkTNwQovJ+dakGg@mail.gmail.com>
References: <20250917074812.4042797-1-kevin.tung.openbmc@gmail.com>
	 <9bb9929a-8130-48da-983e-2901a7c3da36@lunn.ch>
	 <CABh9gBew1=hbJvg1Mhg5dE7Lr_Z442_kbBX6zTs_6_C2NRyLbw@mail.gmail.com>
	 <7e6f568da28d7a63738b6ed22b33db3df4c478c9.camel@codeconstruct.com.au>
	 <CABh9gBcoWbXurPo0f9U9+gz8k6gttUvj=NMMDVfgjo5dgaTLSA@mail.gmail.com>
	 <CAL_Jsq+zBK1CBJX0XcaqaYeOPUhoRE-nMeYvkTNwQovJ+dakGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

Hi Kevin,

On Wed, 2025-09-24 at 08:34 -0500, Rob Herring wrote:
> On Wed, Sep 24, 2025 at 8:05=E2=80=AFAM Kevin Tung <kevin.tung.openbmc@gm=
ail.com> wrote:
> > I also checked the work with `make CHECK_DTBS=3Dy
> > aspeed/aspeed-bmc-facebook- yosemite5.dtb`,
> > and the warnings that appear are not related to these patches.
>=20
> Um, they are related because they are warnings for *your* platform.
> You don't care that there are warnings for your platform?

Which is to say, by contributing a DTS that relies on the ASPEED DTSIs
you're now part of the community of people interested in maintaining
support for ASPEED SoCs in the kernel, and it will be appreciated if
you could help improve what we have.

If you could pick a warning or two from the DTSIs and contribute
changes to address them that'd be great, as this improves the situation
for everyone.

Andrew

