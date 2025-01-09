Return-Path: <linux-aspeed+bounces-384-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1094E77197
	for <linux-aspeed@archiver.kernel.org>; Thu,  9 Jan 2025 14:54:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YTSVN2VtGz3bVl;
	Fri, 10 Jan 2025 01:54:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736434460;
	cv=none; b=Qr4LNU/3HUowBdtmrT5jscPlSIWx36JDU+lVG96elG99LHVrEBXZdSOlyrI0llFQ81QKtCJWLtMj9e2Y/I82HO3lgZuo2SoNeMlZLvn3fiWTf9NFCAcq7KSEthzMCdF/xeqYaAoJKZbD5OdkPT+5h5/oOPivm7DPsLIACdNn9F72y9hu126Tb4Th4XIQpZGXfew7FV+PUSN+9jk/2VtS+S/EXBMNRZB+9huFFGJTVonfqpVX3LjsV5/YEX+Q/n+IYFZAsRSOQGiSOD6wlufwutbNvbSWZkmeB3fU7NrtH0N2Ho4a2t5gxftlTfjinpdvZqiuoK09OnryAtI72/Uv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736434460; c=relaxed/relaxed;
	bh=XS2zHmL8eJvwlmo1sEnhOq6r1rAGjvGYbp8ZEUGFl1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAmIVrsMvbEZWbcDCcEphenNyFC6BePP4YN/EweF3mDOrvR4ninjHt5q2iNjYl4H3ASqEUkd+LuN/aFOw8r2B7eV1mx8dBBT2NqdSl3vidmWTGhTxsZr1EJwxqBdL8oxwCk4smGEQa3LKyZAsZpEZ2IO0bHzzZ9XJe/9GqfEHcIBpesb646ZUt5Tn4YF4rceBxX0iw+bQuys/u/TyYY3cvFuCIrBCCgzDKLBNck9t6EryEzQs/h0PN00Uil7iau85F9fAbHX3JQH17j/ET/N8InGt9axuMYUJlmWErJTOJNzz3ZAU72L/ckDuGJtI4G8On+BdLZfuaer9UakVaFJbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=e5HM2Lc7; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=e5HM2Lc7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YTSVM1tMyz2yRP
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Jan 2025 01:54:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XS2zHmL8eJvwlmo1sEnhOq6r1rAGjvGYbp8ZEUGFl1Q=; b=e5HM2Lc7Oc/aGxpK7LuQgCbm00
	xw1HYHPDQtPmf7zSBPtz8vsJNAAMNfQQ2FuneHutnkBVy2KVQ1n5a4kMYJuQUBEgP+7S2ZbiK6OMw
	aaSH+H26CrsWNk4ic2+hnuMT9zDDAai41SWYjVi8Ia+UDfujLoXB0n/Kfdvx9zRwKk4g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVtvB-002vFx-GY; Thu, 09 Jan 2025 15:54:05 +0100
Date: Thu, 9 Jan 2025 15:54:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
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
Message-ID: <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
References: <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
 <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
 <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
 <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
 <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
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
In-Reply-To: <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>

On Thu, Jan 09, 2025 at 08:25:28AM -0600, Ninad Palsule wrote:
> Hello Andrew,
> 
> On 1/9/25 07:21, Andrew Lunn wrote:
> > On Thu, Jan 09, 2025 at 10:33:20AM +0000, Jacky Chou wrote:
> > > Hi Andrew,
> > > 
> > > > > There are around 11 boards in Aspeed SOC with phy-mode set to "rgmii"
> > > > > (some of them are mac0&1 and others are mac2&3). "rgmii-rxid" is only
> > > > mine.
> > > > > No one in aspeed SOC using "rgmii-id".
> > > > O.K, so we have to be careful how we fix this. But the fact they are all equally
> > > > broken might help here.
> > > > 
> > > > > > Humm, interesting. Looking at ftgmac100.c, i don't see where you
> > > > > > configure the RGMII delays in the MAC?
> > > > This is going to be important. How are delays configured if they are not in the
> > > > MAC driver?
> > > The RGMII delay is adjusted on clk-ast2600 driver. Please refer to the following link.
> > > https://github.com/AspeedTech-BMC/linux/blob/f52a0cf7c475dc576482db46759e2d854c1f36e4/drivers/clk/clk-ast2600.c#L1008
> > O.K. So in your vendor tree, you have additional DT properties
> > mac1-clk-delay, mac2-clk-delay, mac3-clk-delay. Which is fine, you can
> > do whatever you want in your vendor tree, it is all open source.
> > 
> > But for mainline, this will not be accepted. We have standard
> > properties defined for configuring MAC delays in picoseconds:
> > 
> >          rx-internal-delay-ps:
> >            description:
> >              RGMII Receive Clock Delay defined in pico seconds. This is used for
> >              controllers that have configurable RX internal delays. If this
> >              property is present then the MAC applies the RX delay.
> >          tx-internal-delay-ps:
> >            description:
> >              RGMII Transmit Clock Delay defined in pico seconds. This is used for
> >              controllers that have configurable TX internal delays. If this
> >              property is present then the MAC applies the TX delay.
> > 
> > 
> > You need to use these, and in the MAC driver, not a clock driver. That
> > is also part of the issue. Your MAC driver looks correct, it just
> > silently passes phy-mode to the PHY just like every other MAC
> > driver. But you have some code hidden away in the clock controller
> > which adds the delays. If this was in the MAC driver, where it should
> > be, this broken behaviour would of been found earlier.
> > 
> > So, looking at mainline, i see where you create a gated clock. But
> > what i do not see is where you set the delays.
> > 
> > How does this work in mainline? Is there more hidden code somewhere
> > setting the ASPEED_MAC12_CLK_DLY register?
> 
> I think the code already exist in the mainline:
> https://github.com/torvalds/linux/blob/master/drivers/clk/clk-ast2600.c#L595
> 
> It is configuring SCU register in the ast2600 SOC to introduce delays. The
> mac is part of the SOC.

I could be reading this wrong, but that appears to create a gated
clock.

hw = clk_hw_register_gate(dev, "mac1rclk", "mac12rclk", 0,
	       		scu_g6_base + ASPEED_MAC12_CLK_DLY, 29, 0,
			&aspeed_g6_clk_lock);

/**
 * clk_hw_register_gate - register a gate clock with the clock framework
 * @dev: device that is registering this clock
 * @name: name of this clock
 * @parent_name: name of this clock's parent
 * @flags: framework-specific flags for this clock
 * @reg: register address to control gating of this clock
 * @bit_idx: which bit in the register controls gating of this clock
 * @clk_gate_flags: gate-specific flags for this clock
 * @lock: shared register lock for this clock
 */

There is nothing here about writing a value into @reg at creation time
to give it a default value. If you look at the vendor code, it has
extra writes, but i don't see anything like that in mainline.

	Andrew

