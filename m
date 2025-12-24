Return-Path: <linux-aspeed+bounces-3207-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9129EE75442
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Dec 2025 09:20:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbmZQ0c8Xz2yFY;
	Wed, 24 Dec 2025 20:20:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766568046;
	cv=none; b=cO4IPVuso9OOQpS/zZyJXoygPKj5Mq0W2XR1D1hsoY05k4uGc8xpqEKgILRdPRJupzLS/xewSJ5anInn/eTbn6xcIvHqKySYtXRjJyBXJiIp33XNbyqGVs5hsZf+WKHdVt+8kzp9XXaGz1sSPPQc2wPg/vKSiU4gu7SaVdVjsqtjYessjaqb8wxQSnME//ZN9w0aitFW4jLIWlPTOrNQiPTkvgywYvS1Dx7GthbQnR1gLwij15b3by3mLgWIaCaQlKNo7ONGTfvCRpybIfxAoOT6nqC/z+MV7XnRysmlWAF8GM5s+b9HO3MQap3Aee/8sOFJPjoY4OeIsD2TvIhjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766568046; c=relaxed/relaxed;
	bh=og+Ux3x/arfwiOpRBPCbvWYwNi8map9YcJ7XOxJZxGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8whwz6zugYxshlpgDLH9KHnuq4eL6/3qFAy18/js+haNRcOm9z3HuY/rsv+81FxPS0fST1DhxngO0whK9igGzeSy/ZdtdJHOyncT0M529PpDq40rguBaL/N2jvTQl5E4aeZrmCQ3q1Ejr/+kpli72sV+sM5bQZTdnqFxFUM1XDoBvNnWiFroBrquHjvuSf32EyNNxTtxQuQORTSqGQpFW+vHiu+M15MC4xfBZdjK71BW5U3+UuduvLMRWEpObMqGUeZTL/Qhbv/8maqZmfxqbADlxWSzWTHJYynop9uIfuY+SdFDshfjPjQO3yOleD4hRTPfM5VR4PySfqhlhTOnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=hEGjb/QW; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=hEGjb/QW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbmZP1fmFz2xqf
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 20:20:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=og+Ux3x/arfwiOpRBPCbvWYwNi8map9YcJ7XOxJZxGA=; b=hE
	Gjb/QWuTRrKy/elfnoXQGAxsz3lHe01RhnyEGCL+KU1uLVKaRaFFag3yNR9W0sVVyou0xDbsriE2v
	7mhfgvWZ38SIcDoM7OplqSjOx966l9U3iN1u4D6jAAWOrpmKQsjQlmD1vIpeziRbQIJmIf5+bhuhv
	Kn39wZdha559GFM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vYL2a-000OlF-00; Wed, 24 Dec 2025 10:20:20 +0100
Date: Wed, 24 Dec 2025 10:20:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
Message-ID: <32ff7ca8-9cb0-4889-adb0-a6dae735630b@lunn.ch>
References: <20251222-ventura2_initial_dts-v1-0-1f06166c78a3@gmail.com>
 <20251222-ventura2_initial_dts-v1-2-1f06166c78a3@gmail.com>
 <c069b452-df22-4afa-bf6a-c48949f40ebc@lunn.ch>
 <CAF7HswN_jEXOU_9K4LpLnbhvd+RD0qqELAHxMBbp=hGtMjS4kQ@mail.gmail.com>
 <35f3eba9-5ec4-4cba-8a64-fb521dc65b79@lunn.ch>
 <CAF7HswN0hhJQ-gmE59cKTuPyzrs1A3rM8Xw+Z8i3_AsHRiNcug@mail.gmail.com>
 <1e21f828-1b06-492d-bfcd-ab5721621e8a@lunn.ch>
 <CAF7HswP7Oejs42K=jG8bkNiBoDhXR2LbeHoppk0nnNon6_afwA@mail.gmail.com>
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
In-Reply-To: <CAF7HswP7Oejs42K=jG8bkNiBoDhXR2LbeHoppk0nnNon6_afwA@mail.gmail.com>

On Wed, Dec 24, 2025 at 02:40:39PM +0800, Kyle Hsieh wrote:
> On Tue, Dec 23, 2025 at 6:35 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > What make/model of switch is it? Is it unmanaged, or does it use SPI
> > > > or I2C for management?
> >
> > > The switch is connected via RMII to the MAC and is managed over MDIO.
> >
> > O.K. What make/model?
> >
> The device is a Marvell 88E6393X switch. In our design, the BMC connects

Which Linux does have a driver for.

> to the device via RMII with fixed link parameters to retrieve ethernet.
> > > On our board, MDIO is not wired directly to the processor; instead, we
> > > use a USB-to-MPSSE bridge (FT2232) to toggle the MDIO signals for
> > > switch management.
> >
> > I have to push back on you using a closed source user space driver,
> > given that i help maintain the Ethernet switch drivers...
> >
> > I know there have been attempts to get GPIO support added for FT2232,
> > but i don't think any got as far as mainline. That is probably the
> > only part you are missing. You can describe USB devices in DT. So you
> > should be able to describe such a GPIO controller. You can then
> > instantiate an virtual,mdio-gpio driver to give you an MDIO bus. And
> > then add nodes for the switch using DSA.

> Apologies for the confusion in my previous reply.
> The BMC connects to the peer via an RMII fixed-link.
> The link parameters are fixed at design time and there is no runtime
> MDIO-managed PHY or switch control from the BMC.

So you use the USB-MDIO to program the EEPROM? The switch boots using
the settings in the EEPROM? It is then an unmanaged hub? You are not
using UMSD in userspace? That code looks terrible.

So if you connect multiple of these unmanaged hubs together in a loop,
your network disappears in a broadcast storm? Yes, you can use these
switches in a dumb mode, but it has consequences. If you let Linux
manage it, you gain a lot of functionality, such as STP, to break
loops.

But you seem to be opposed to this. At least add in a comment
explaining the purpose of the fixed link. DT describes hardware, so
there is no harm in describing the hardware, even if it is a comment
and not real properties.

	Andrew

