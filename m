Return-Path: <linux-aspeed+bounces-1035-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3720FC28B28
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Mar 2025 13:45:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHClL5zmvz2yfS;
	Wed, 19 Mar 2025 00:45:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742305518;
	cv=none; b=UFFa6jZkn7XZbC+g0tgd1U1ZbXdJnQbbD3D8bH+xj+Ig3tbb+e85UsIcakwHYopIfuFfOgPx981vg2ZP8c1dwhfQSp826yOMNZ32TmthFTOo9bhiXD1DUu5d5MGDvUyb1U+HGhGvTgtlqjJjbg4syOCG6QgWlkDQzIkXw0f5DfXaxX+n79Hb/ztzV7mke8xcpclT28+sbRR2CpoZhKwBEHZ5Qz9KfC/k0QQFKQWltixuwqFTB93IuYlrzTNWXkKPiSFEU1A5gox2F4ORbEZirBh3rf4pIDzQnh+p+kwrsKqHwJCJdnRw04C3J3bOdlRlkfElYlwWx0HuqkoCAgLTTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742305518; c=relaxed/relaxed;
	bh=8/RzstvQ9BWwLvvMkrQEWveUn5iG+OyCk6DBs4Rad9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuYjAC3XrmyhusdUNXq7kw3U5gVg1p5z5WzkunHMlxSE6o5VHryJBmtp5ZFpuuaJ/11lZaU1d15gJrGzRWNZE4z5wfyMj/OF0S2rBuOzCK388pRpUdBxvugTo2h7Mk80BpO9EcCNlozIXr6mGdKp87xaIJAFp55omNzTXLD+VY4I/5XE/uC2UtUg+Isd5FfD1OllYmTxO5ZxrxHE/sEPJvZGY1tc59LUx/TO+fOUgEGUII+lYyY+mVHGTLu/s5vASdg8vQv40hyENZnua5wt5XsQQGGvrFKhdAfnO2v1ZC2MiiJmHaohEOY7M+r70Q1ctruJ5QL6vagBJtjiTJRurg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=TIykPaMS; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=TIykPaMS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHClK04FVz2yMh
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Mar 2025 00:45:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8/RzstvQ9BWwLvvMkrQEWveUn5iG+OyCk6DBs4Rad9Y=; b=TIykPaMSpNNvt2P5/a+iJhCdkH
	ZDU27yEMxC6rC9OBHfa9CLX+uTPrfzKx89lqkaTMu80DUdw+cgNe/cB87UYF5GoGvpaKYXa51093A
	Pv6f1eCCR9DEwQr3pZC1oPxCHdW0uc5m3ke99tB6mi7Q9b2N0Zt2MkC/rl1UySGgT60Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuXFE-006GSZ-5r; Tue, 18 Mar 2025 14:44:36 +0100
Date: Tue, 18 Mar 2025 14:44:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [net-next 4/4] net:
 ftgmac100: add RGMII delay for AST2600
Message-ID: <1a2dab82-ddb1-4c38-a576-abd1edd8d5e1@lunn.ch>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
 <dc7296b2-e7aa-4cc3-9aa7-44e97ec50fc3@lunn.ch>
 <SEYPR06MB513471FBFDEAFAA3308000699DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB513471FBFDEAFAA3308000699DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Tue, Mar 18, 2025 at 10:46:58AM +0000, Jacky Chou wrote:
> Hi Andrew,
> 
> Thank you for your reply.
> 
> > > +	u32 rgmii_tx_delay, rgmii_rx_delay;
> > > +	u32 dly_reg, tx_dly_mask, rx_dly_mask;
> > > +	int tx, rx;
> > > +
> > > +	netdev = platform_get_drvdata(pdev);
> > > +	priv = netdev_priv(netdev);
> > > +
> > > +	tx = of_property_read_u32(np, "tx-internal-delay-ps", &rgmii_tx_delay);
> > > +	rx = of_property_read_u32(np, "rx-internal-delay-ps",
> > > +&rgmii_rx_delay);
> > 
> > > +	if (!tx) {
> > 
> > The documentation for of_property_read_u32() says:
> > 
> >  * Return: 0 on success, -EINVAL if the property does not exist,
> >  * -ENODATA if property does not have a value, and -EOVERFLOW if the
> >  * property data isn't large enough.
> > 
> > You need to handle EINVAL different to the other errors, which are real errors
> > and should fail the probe.
> > 
> > The commit message, and probably the binding needs to document what
> > happens when the properties are not in the DT blob. This needs to be part of
> > the bigger picture of how you are going to sort out the mess with existing .dts
> > files listing 'rgmii' when in fact they should be 'rgmii-id'.
> 
> Why can't the MAC add internal delay to RGMII? Is it necessary to add on PHY side?

The MAC could, but that is not the point. You need to explain how you
are going to solve the mess you have in DT, why all aspeed boards have
the wrong phy-mode. You need to fix that, and i will continue to NACK
new boards until the correct rgmii-id value can be used to indicate
there do not have extra long clock lines on the PCB.

> > > +		/* Use tx-internal-delay-ps as index to configure tx delay
> > > +		 * into scu register.
> > > +		 */
> > > +		if (rgmii_tx_delay > 64)
> > > +			dev_warn(&pdev->dev, "Get invalid tx delay value");
> > 
> > Return EINVAL and fail the probe.
> 
> Agreed.
> I just show warning here, because sometimes the RGMII delay value will configure at bootloader.

That is a different issue. If there is a value in DT, it must be
valid, fail the probe otherwise.

	Andrew

