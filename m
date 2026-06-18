Return-Path: <linux-aspeed+bounces-4271-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AB4CD98ED
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Jun 2026 00:58:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggj626sxVz2xd2;
	Thu, 18 Jun 2026 10:58:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781744330;
	cv=none; b=AT7NSMix9S27F4mi6ameDxmlRVfeZ5+O/orCXrh9xY8wA53VVeeEXqY50O+CHp72Xgz+IHkj3FJw+ILDAqoOiNc3RhwktNi2rJ8bui7AT1DssnSQ31+pH/9lPLQQK2qjRLSfzxtvle920aoHpBrUBs+OV72/s5hjQdxGdecrU286XcyFqGG67Ypmvh5HmMc9tEGGrCpj53xTnufafGpBHxnSuR9r5O5khgFuwwybECaqrAj9awwYDWdObVr36jwKSkjIPw2Hij0B5h+OOnxkdBV6/KnbfA6cpIVm6NxHqtoI08IZsKTCCGakPZOP1W+a6oarkQtf7JCBRyLPVhAX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781744330; c=relaxed/relaxed;
	bh=1z0mzRaUwg28hI/tJz6GdvQqkq6YjyxhLSV6ywwj7Sw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XsvgNlQXh6EDeFc8UGAhVmuF4fvSOeVngoaWttvsjXP15IIF6HFSrWi/LPs+sZh1ZfwqLv0T5kmVSHSvPb4yJXovtE6AdOoAa/tNfFX1uf+hf1H/n1ZKPD8XwvlyX/TyiKJae5XBucp0AGIHLS9mdfBMS7ik3BI062YvbCXrh6QgJEAcmtJRgZaHr+palM+yHsl3ARaCn6NQOJ9oQPz6CGLQBPqW3T0g/GSlrTY4UaPrbhNALDT9uAkodpjGJ125qK3gWHamzI58YhsBoIF0rjMLNzRiR7QPuKeZ6YJFamp20iVRVdjjA0SFT9DnwU2Nq98lyY5SGhKY2i3trTKfpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=D9aMXaS2; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=D9aMXaS2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggj621SWsz2xLm
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Jun 2026 10:58:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781744329;
	bh=1z0mzRaUwg28hI/tJz6GdvQqkq6YjyxhLSV6ywwj7Sw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D9aMXaS2Asgq1ESDl+vx0toQM1hhkc/hl8b0S37TNz/ZYTDXKsL/mFzZEwIZiTKwK
	 OSn2jCqTsmAKKwXcB+pyac+xBbjdZT9a17AIwwEzJbCIZgLewQ0/f+sdMZ7QLsu/nF
	 lEqpnlN78WMyKbpL5kl0DITIA2PIdXLtxujTBrR9KbSnU4eQ/J/s8M2eVEdz/2+TUr
	 hjHTvRO8XzEEcO2EXOvjPvUyAJOVe2TH0FhULoCBK5ALWbPhOK9MjoLVGINK58kkom
	 P+FZ9zggLJWLrLH1P4RZJafkfnvhE/Gp2qyVUbQOAOMlcTDEpbtEVPOdcTdox+mVa5
	 yyAf/Oj87fOTw==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8C404605A0;
	Thu, 18 Jun 2026 08:58:48 +0800 (AWST)
Message-ID: <492d66285039a789cbede66133a053fd75492e8b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 1/2] soc: aspeed: add BMC-side PCIe BMC device driver
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?Gr=E9goire?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
	yh_chung@aspeedtech.com, ninad@linux.ibm.com,
 linux-aspeed@lists.ozlabs.org, 	linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, 	anirudhsriniv@gmail.com
Date: Thu, 18 Jun 2026 10:28:48 +0930
In-Reply-To: <CAFi2wKYgxKpp0ezzryYhFPDeqAeHhUq9Lhm67pVpnXRg+c2Vhw@mail.gmail.com>
References: <cover.1780929570.git.gregoire.layet@9elements.com>
	 <af322e76d34ad504e0bdec470293a017b489cfd7.1780929570.git.gregoire.layet@9elements.com>
	 <4839c31f666b612799a795bb47c884901fd2a903.camel@codeconstruct.com.au>
	 <CAFi2wKYzUDY5Gis9GaHdqeYdv-orHB+gWfLXkJBgbxfbnRgorA@mail.gmail.com>
	 <CAFi2wKanAH+ekKz3eVtdiz=pjEvmKwSh1XhE-Xo7p=CCiSWpEw@mail.gmail.com>
	 <e5822b82e99f8c2f81deecfeaea2192b223dfbec.camel@codeconstruct.com.au>
	 <CAFi2wKYgxKpp0ezzryYhFPDeqAeHhUq9Lhm67pVpnXRg+c2Vhw@mail.gmail.com>
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

Hi Gr=C3=A9goire,

On Wed, 2026-06-17 at 08:40 +0200, Gr=C3=A9goire Layet wrote:
> Hello Andrew,
>=20
> > The concept sounds reasonable to me. There's probably some bikeshedding
> > to do on the devicetree property though.
>=20
> Yes, having looked at how it's done, I would say :
> 'aspeed,vuart-over-pci' and 'aspeed,kcs-over-pci' flags would be
> better.
>=20
> > Can you outline the duplication you're concerned about? I think it's a
> > matter of resolving the SCU syscon to its regmap, then performing the
> > necessary accesses?
>=20
> Both drivers will need to set :
> - Enable PCI BMC Device MMIO
> - Enable PCI BMC Device IRQ
> - Enable PCI BMC Device MSI rooting over PCI Device 1 (BAR1)
> - Enable Host 2 BMC MSI interrupts
> - PCI device class to 0xff000000 to be identified as a MFD device. The
> reset default is 0x0C070100 which is an IPMI KCS device, but that
> causes issues as it is detected by ipmi_si but can't be loaded because
> of non default KCS address.
>=20
> Sorry for my errors, there is not that much. But both drivers will do
> almost the same initialisation. That was my code duplication concern.

I think it's valid to be concerned, but perhaps not for the reason of
code duplication. If there are multiple consumers then we need to
ensure consistency of configuration and correctness wrt to enabling /
disabling the capability based on the number of consumers.

>=20
> > I think it's not as bad as you make it out to be. The SCU's regmap
> > protects updates to individual registers under a lock, so concurrent
> > modification isn't a concern. The hardware design choices make all of
> > this slightly awkward for any related software design. As an
> > alternative you could implement a mini subsystem that relevant drivers
> > could call through to set the bits, but I currently think that's
> > unnecessary work.
>=20
> You are right it's not as bad as I thought.
> For now, I will focus on the VUART until the solution has been
> validated. Then I will easily do the same for the KCS over PCI.

I think it's a good step to at least solve one thing at a time, so long
as we're not precluding making those future steps.

>=20
> So I'll do for the V3 of the BMC side driver:
> - modify the device tree binding to have 'aspeed,ast2600-vuart' and
> add the 'aspeed,vuart-over-pci' boolean flag, only for the ast2600.

Just to confirm, you're proposing modifying the 8250 binding?

> - modify the '8250_aspeed_vuart' driver to add 'aspeed,ast2600-vuart' sup=
port.
> - add vuart over pci enable and disable code to the '8250_aspeed_vuart' d=
river.
>=20

Sounds like a reasonable start to me.

Andrew

