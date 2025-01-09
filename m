Return-Path: <linux-aspeed+bounces-380-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49755E77197
	for <linux-aspeed@archiver.kernel.org>; Thu,  9 Jan 2025 13:21:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YTQRf26Flz3bW5;
	Fri, 10 Jan 2025 00:21:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736428910;
	cv=none; b=TAl+H3MloRNU75PAM6CCHojGDksablSPByJ0Qy/ddDmkezQ8mNO2Vk4F9OUorDtN9oL+3ZyGEHz/3vI5jgv0uMKTubtxKcwUhf/Msy2LRG/OIJ97C44GoY257K6UEQ1ADNLJ3ZPgzMqbNFm7w7MMqccEShXZtzrwKfP5ULXMLhZB1qW91IEdengLunTz51WxMdkVs+4/Qb002HVHZAtxXubwFCrWOE3scOUHMRw2gLXsd7s9DDqJsuW28U3jCGIgVwfvMCfr7QaJSJbayoD8D4YuqoA8LPbtSch7PcYyTcNZ/eBfdpCGcRXv6tTununNikmO5/zNRciHS2VCL6kJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736428910; c=relaxed/relaxed;
	bh=AbzsTNESBgo/hgO+hKhyZlCDUe5rI0jUjzYdhN5OFAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/ynpimf7UvzS5O27LBCws3lomwrUWXtUvopvmzVPYTmgCP/u+DLh8n3P4bvfUTbt/L49I4Sv/mSrLPwE3hYglG83QgP1VFcYGyNCPMOuSCdq5f8G14i8vFivC3PirNZnQpZXd105nnpaM3bvQNQ5FV7rmDQH54s0C1zJWUKzaHn8pxXmwLS2UVP2cMtgreJdbwrKB7k8YYTslXBqvQSWzZRSX3Onn3javAY9YbZpMfQbAaNclQjCxNIzWWy6G1CpQF7Bf0HRV2mElAkkMMG86cHlX8TGnuih2IBbCVoynHeb+n7x4hAsYFn41nc0izC4MSXsGJbgc37xCn/9B6GyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=u7GKAuu3; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=u7GKAuu3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YTQRd1mD0z2y8V
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Jan 2025 00:21:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AbzsTNESBgo/hgO+hKhyZlCDUe5rI0jUjzYdhN5OFAo=; b=u7GKAuu3isEhqufnQh+qheI5XK
	wl6jZD4/rFT59G3X8Lt96IZC8bssyWI7i79odb5w8ky0KYyYlCZG7gjjaKAhiSBlJ/rzH5WOXy5AK
	8ShrWiJBf3VI/zzF3ZkZRljn8NYayPMr97fibqcB7kqggZ+Dy7ezXrQQ6Tz5cqGpeTmA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVsTT-002tdk-RI; Thu, 09 Jan 2025 14:21:23 +0100
Date: Thu, 9 Jan 2025 14:21:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Ninad Palsule <ninad@linux.ibm.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"eajames@linux.ibm.com" <eajames@linux.ibm.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"minyard@acm.org" <minyard@acm.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaGOiBbUEFUQw==?= =?utf-8?Q?H?= v2 05/10] ARM:
 dts: aspeed: system1: Add RGMII support
Message-ID: <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
References: <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
 <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
 <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
 <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Thu, Jan 09, 2025 at 10:33:20AM +0000, Jacky Chou wrote:
> Hi Andrew,
> 
> > > There are around 11 boards in Aspeed SOC with phy-mode set to "rgmii"
> > > (some of them are mac0&1 and others are mac2&3). "rgmii-rxid" is only
> > mine.
> > >
> > > No one in aspeed SOC using "rgmii-id".
> > 
> > O.K, so we have to be careful how we fix this. But the fact they are all equally
> > broken might help here.
> > 
> > > > Humm, interesting. Looking at ftgmac100.c, i don't see where you
> > > > configure the RGMII delays in the MAC?
> > 
> > This is going to be important. How are delays configured if they are not in the
> > MAC driver?
> 
> The RGMII delay is adjusted on clk-ast2600 driver. Please refer to the following link.
> https://github.com/AspeedTech-BMC/linux/blob/f52a0cf7c475dc576482db46759e2d854c1f36e4/drivers/clk/clk-ast2600.c#L1008

O.K. So in your vendor tree, you have additional DT properties
mac1-clk-delay, mac2-clk-delay, mac3-clk-delay. Which is fine, you can
do whatever you want in your vendor tree, it is all open source.

But for mainline, this will not be accepted. We have standard
properties defined for configuring MAC delays in picoseconds:

        rx-internal-delay-ps:
          description:
            RGMII Receive Clock Delay defined in pico seconds. This is used for
            controllers that have configurable RX internal delays. If this
            property is present then the MAC applies the RX delay.
        tx-internal-delay-ps:
          description:
            RGMII Transmit Clock Delay defined in pico seconds. This is used for
            controllers that have configurable TX internal delays. If this
            property is present then the MAC applies the TX delay.


You need to use these, and in the MAC driver, not a clock driver. That
is also part of the issue. Your MAC driver looks correct, it just
silently passes phy-mode to the PHY just like every other MAC
driver. But you have some code hidden away in the clock controller
which adds the delays. If this was in the MAC driver, where it should
be, this broken behaviour would of been found earlier.

So, looking at mainline, i see where you create a gated clock. But
what i do not see is where you set the delays.

How does this work in mainline? Is there more hidden code somewhere
setting the ASPEED_MAC12_CLK_DLY register?

	Andrew

