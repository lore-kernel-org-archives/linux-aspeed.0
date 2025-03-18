Return-Path: <linux-aspeed+bounces-1037-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC340C282EC
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Mar 2025 14:03:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHD8B4LDgz2yMF;
	Wed, 19 Mar 2025 01:03:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742306602;
	cv=none; b=dte4cOK7QeoOZ4KKe7ORFmtlaDB7WO7IflXEYSrmXPGy1Xtp6Qi5DVSPAybu377e09d3ARzfUosgXWsGtybxnWMBiGK0xm+5WHsFuAMwSH4T5x9I72OPW9jl3NM1VjtLo4/lkNzhAlYb4PavHT76lruTn0gsE9SDLZvtY+7cZIcXAo7KSFIh6xBe0ybCGKJH4Yz3teBApBnVtJcvgjiDE24nQ8BWW/t1ZxUiUh3U0osrfAfjthGUlV/ey/b3MiY/0HGQlvk4DwysDGlXi/zwNRdoQI0o9efu7EqIovXFTkaORkF8x+qy9TgG0dA3trHeEn3GbBFXg3NLTe5eMKBJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742306602; c=relaxed/relaxed;
	bh=0yf+Edtj7qyHSUTzNfZ+JKXVNOrD8jm+TXRXVg69QbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVRTkFd/GTWs8NOwYDezXHHQQDo8XdtUI0VIMwk7NeRIfs01FqTAzzig7OPWk5/Kt1dGeQTXgEzrLHmXj95zAg/2iqxoJqCUDsASdeVKgm08mH2tl/wvY+c/WO4iESt18RUDrOKxjx7KoaW20jpHBT2/Bhyxau1WXiE8NnjR9LJ7Hrr4TdChaeIhlNRpZCQytnWmfXfkwOEYR79p9SIoj2HrSMgzwpUjRNRH/TaV3DttYXRt9rGr4kO28qhmEWJ2QN/asv9i+wITiQy4ryxN9ie66PnUUTCp/35b3+H3aY5DauaNR6zl4P4Fz1WNQMOVgMPssPTyOvnYBTNXOKmm3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=357SSSF2; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=357SSSF2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHD895wyHz2yDk
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Mar 2025 01:03:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0yf+Edtj7qyHSUTzNfZ+JKXVNOrD8jm+TXRXVg69QbA=; b=357SSSF22yh5nMcYWPclY7KXns
	bBTRpnsCM0yabQo6ggsqvDtS521lMh5u73mchyQSJ01CwKeyG0v+3YePiHNisxh+qWVKy4GBaVYcn
	r0Q3lIM+FIwRUz5pkuG+bJ7OENHhjUHK7BtAmWbnOGI3HE7L6QrQAaz1gFMU1LblELAo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuXX5-006Gct-Rs; Tue, 18 Mar 2025 15:03:03 +0100
Date: Tue, 18 Mar 2025 15:03:03 +0100
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
Subject: Re: =?utf-8?B?5Zue6KaGOiBbbmV0LW5leA==?= =?utf-8?Q?t?= 2/4] ARM:
 dts: ast2600-evb: add default RGMII delay
Message-ID: <8c0195dd-50b3-4f30-a021-c5b77d39d895@lunn.ch>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-3-jacky_chou@aspeedtech.com>
 <5db47dea-7d90-45a1-85a1-1f4f5edd3567@lunn.ch>
 <SEYPR06MB5134A69692C6C474BDE9A6A99DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB5134A69692C6C474BDE9A6A99DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Tue, Mar 18, 2025 at 11:00:27AM +0000, Jacky Chou wrote:
> Hi Andrew,
> 
> Thank you for your reply.
> 
> > >  	phy-mode = "rgmii";
> > >  	phy-handle = <&ethphy2>;
> > >
> > > +	tx-internal-delay-ps = <8>;
> > > +	rx-internal-delay-ps = <4>;
> > > +
> > 
> > Ideally you want:
> > 
> > 	phy-mode = "rgmii-id";
> > 	tx-internal-delay-ps = <0>;
> > 	rx-internal-delay-ps = <0>;
> > 
> > Since 'rgmii-id' correctly describes the hardware.
> 
> I still confuse about ethernet-controller.yaml.
> It lists 'rgmi', 'rgmii-rxid', 'rgmii-txid' and 'rgmii-id'.

DT describes the board. Does the board add the 2ns delay via extra
long clock lines? If yes, use rgmii. If the MAC/PHY pair need to add
the 2ns delay, use rgmii-id.

If the MAC/PHY pair is adding the delay, the DT says nothing about how
they add the delay.

The general rule is the PHY adds the delay. If you look at
drivers/net/phy/*.c, every PHY that implements RGMII support both
PHY_INTERFACE_MODE_RGMII_ID and PHY_INTERFACE_MODE_RGMII. There is no
reason not to follow ever other MAC/PHY pair and have the PHY add the
delay. The MAC can then do fine tuning if needed, adding small delays.

	Andrew

