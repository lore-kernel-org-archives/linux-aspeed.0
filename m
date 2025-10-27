Return-Path: <linux-aspeed+bounces-2613-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F182CCF9E5
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Oct 2025 01:44:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cvxBL5X1Vz2yw7;
	Mon, 27 Oct 2025 12:44:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761529450;
	cv=none; b=i0JMADeaYCMTupffGXmaMzT0JpHeyrWeTo6XPOsO6fgADSXP1YQ960O8xHZPVPhmeQwnv/TsG02bKkF48kpnh0auVkPI9XdawOl2LXB89IWztYZl6PmlJM4oqbzQ3gTmd3oZwuwNmdWi0guWozfXN1Z2H3A9gby1liDahDw57SFRWUHd5pS96L/sv/lZAA30Ufj89DewbZqPuYSHzfICOi0OHuN9oRw6dilPKqlaB9xeTPB4U/KrWyqnAZDOaeE4o/hhsvuCEGXszjitfK2/TWLupl4fA+0+N2EU5K6i5M+EaA88wu7u6n2l/gnMT/kl0dA8bx717zsC2x6fiwCwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761529450; c=relaxed/relaxed;
	bh=7a/EwuumQpo2swNq1SpUCucENGWBvUDAitJ2riFGT+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKtZk1XX1UdkMqw9qti1dyQBnCA8FrKutcM0NVsexga8fsZWexf8O6LETd6yLN3ilu0esu2764DduQXCULeUAEiVs8NCtT7Dcpwi7EGzkaYWbW01y0Z5uR3JY8iiQPYODcgeBScwlVIiLsprplHH2310AFKlkErNGdGiaKzuAZo8PZwGulmySYmmSc+HnZeu59T/SUmW7OnzCsVg44nIqp2Ar/7FciFybvMXRKpdyQtgcKls+VnFnAfhpn/or+s1LfrJtNE0gxqSiSkp+rf1n0U1BM5ocuHmEeRv+m3U7mVcoWDy7kLcRUPnZJaFHqoDdgHG80RSdDFYgcAW9s/L1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=vqKT+cw7; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=vqKT+cw7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cvxBJ3c9Rz2yvk
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Oct 2025 12:44:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7a/EwuumQpo2swNq1SpUCucENGWBvUDAitJ2riFGT+Q=; b=vqKT+cw7qfCksSfiPz3S4iHhrx
	VA30MsXAzH6jQu6JS9fR8f45Gp3ooOLXKwGx4yGeJiduyc1fWA+bZflGabd8ESumpM+8PMl/qaSGX
	uoGN3n/PJTTN/Ovs+5D16m3RoKgoPXO3stpKVCzTFxGasaOu5qvgLwseqVQbSNm4OKMI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDCGa-00C9BP-I8; Mon, 27 Oct 2025 02:43:24 +0100
Date: Mon, 27 Oct 2025 02:43:24 +0100
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
Message-ID: <fdbc471f-514e-4521-b7a1-dcf6127d64ff@lunn.ch>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
 <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <71df9bdf-53b2-45e2-a9e3-5b00a556f957@lunn.ch>
 <TY2PPF5CB9A1BE6F3E95C7FD61CF4F90ECAF2FEA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
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
In-Reply-To: <TY2PPF5CB9A1BE6F3E95C7FD61CF4F90ECAF2FEA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>

> SoC0, referred to as the CPU die, contains a dual-core Cortex-A35
> cluster and two Cortex-M4 cores, along with its own clock/reset
> domains and high-speed peripheral set.

> SoC1, referred to as the I/O die, contains the Boot MCU and its own
> clock/reset domains and low-speed peripheral set, and is responsible
> for system boot and control functions.

So is the same .dtsi file shared by both systems? How do you partition
devices so each CPU cluster knows it has exclusive access to which
peripherals?

Seems like a fun system to play core wars on.

	Andrew

