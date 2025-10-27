Return-Path: <linux-aspeed+bounces-2632-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFEDCCF9E5
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Oct 2025 12:02:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwBvJ43ZCz2yrq;
	Mon, 27 Oct 2025 23:02:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761566524;
	cv=none; b=drv7zmoL0TcvoNOpF41H+LBGere198pVeWNRR1IXxTnBAelhLibnGAiiR5j1+xt5mheJkwWMsxmh69HqKs4MI9McMqLlzrOBDRBj5Z782hx7534y4z3nh6q1WR0NWIqAK/cbwZALzH/6gA340cD4BtypwYSFe06xosxsPKm915UYjUVMxfimLw7ybIk3ndVee7Kr41xDfyADV69crQtRxjHn4p3+rfFcMMVbUm/ptTyIL1MkvFkHBDS+rptmgPyToVbXz8TkcnTteSB6MwS6st6nBzRiCNhD8g+rPMx1cAyG8UCqhzbKUgr3+ltCgikfsBmfPLntEnCcGtwW4TZ0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761566524; c=relaxed/relaxed;
	bh=FdoLUkFsTrx3NpFcZ9/EDnFFAX0bYLccLygNQPaZVns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4k+/pGqwadAaI+kfnWGkQ5TFOQwCmxOQrfSYqzWocc9geroQaahdrg3sy72tXfX4x/4dKdrYRXJl3lU7bT1rxMc95lYnD+rjv7XgyZVXDfNyQKCmE4Yj/Vem8S8ppFTzzSHmakVkrJWfCnn/IiPd2MwKAXcBDiYZrZCyT19ocnfSx5CwBAOcj1KpxJn0ubgk9bHU4auTM/iQXWF2ygqP1Sy5mFYyeeEFXWOY0vpNjLOO+KYJnvApMX3K8+r5P7Rs4KuZ07V07I7UvzE4LK3Mx+RTv69S4LkwCaQ0p3c2LQFmOv/s5nKhw0WTP+GNZ3SYcXffNFvDQiuEraurmQilg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=GrMibrmT; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=GrMibrmT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwBvG6Fn3z2yrl
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Oct 2025 23:02:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FdoLUkFsTrx3NpFcZ9/EDnFFAX0bYLccLygNQPaZVns=; b=GrMibrmTQ7wGPam738kHj/tSaX
	IsT0YMk50MEpusuZFh1pLbq15Efa1km3bGjICrTTGK0kTSVVdkoM7eSer0kQ5PQJeaLJa6S22x4f9
	PtWcj2AyljqPqv/UB3DBWGBVWTRwddCfAUEcO6S5tVF7QvS5v53mIGKCQ7AMrD2hTEDI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDLui-00CBcN-Nb; Mon, 27 Oct 2025 13:01:28 +0100
Date: Mon, 27 Oct 2025 13:01:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Arnd Bergmann <arnd@arndb.de>, BMC-SW <BMC-SW@aspeedtech.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Jeremy Kerr <jk@codeconstruct.com.au>, Lee Jones <lee@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Nishanth Menon <nm@ti.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Taniya Das <quic_tdas@quicinc.com>,
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC
 device tree
Message-ID: <01573262-69a8-44cf-ae02-2e9842c59dde@lunn.ch>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
 <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <71df9bdf-53b2-45e2-a9e3-5b00a556f957@lunn.ch>
 <TY2PPF5CB9A1BE6F3E95C7FD61CF4F90ECAF2FEA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <fdbc471f-514e-4521-b7a1-dcf6127d64ff@lunn.ch>
 <TY2PPF5CB9A1BE6DD93D0F397C961D5CB5AF2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
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
In-Reply-To: <TY2PPF5CB9A1BE6DD93D0F397C961D5CB5AF2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>

On Mon, Oct 27, 2025 at 02:42:01AM +0000, Ryan Chen wrote:
> > Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device
> > tree
> > 
> > > SoC0, referred to as the CPU die, contains a dual-core Cortex-A35
> > > cluster and two Cortex-M4 cores, along with its own clock/reset
> > > domains and high-speed peripheral set.
> > 
> > > SoC1, referred to as the I/O die, contains the Boot MCU and its own
> > > clock/reset domains and low-speed peripheral set, and is responsible
> > > for system boot and control functions.
> > 
> > So is the same .dtsi file shared by both systems? 
> 
> This .dtsi represents the Cortex-A35 view only and is not shared
> with the Cortex-M4 or the Boot MCU side, since they are separate
> 32-bit and 64-bit systems running independent firmware.

DT describes the hardware. The .dtsi file could be shared, you just
need different status = <>; lines in the dtb blob.

> > How do you partition devices
> > so each CPU cluster knows it has exclusive access to which peripherals?
> 
> Before the system is fully brought up, Boot MCU configure hardware 
> controllers handle the resource partitioning to ensure exclusive access.

Are you saying it modifies the .dtb blob and changes some status =
"okay"; to "disabled";?

	Andrew

