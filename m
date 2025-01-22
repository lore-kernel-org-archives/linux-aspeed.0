Return-Path: <linux-aspeed+bounces-544-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683BCC0218C
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jan 2025 23:31:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YdgLv5bqgz2yjR;
	Thu, 23 Jan 2025 10:31:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4b98:dc4:8::228"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737554755;
	cv=none; b=QA2Vv8FxnnP7sXxYbioTilzfTCyeMRvHCu/vYhH15YuiMc+scHniJrM/VjfHT8g3eZ9kjdjo5wukSWZGts91NIp4HN0/qHmOD58e1M3GoOKKXcGEP0/l1yaxXa2W1soyDz1P/PAWwSlKBUU1aM2BdjvbHMpHbrOMjtZNggsKvyWKcMOT88v6+NzWTlH0+kqLPTWAvY8EGnxN7p9vcg1oDQ+E8QnNVbEv63HBETHAceGDj6DQGQSmUGa2cOgxqIcrGVl+w1GJGfdWUyKjHHUgfFMExq+g2Hgow3lY4Y+UQy98VcTjZYppd5ubFdPvTsVvypDu+vPKMxeuRBOuGqRg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737554755; c=relaxed/relaxed;
	bh=u6A2D9Gp6FOhIbSWgb9j5UrKEP+ZhUZ+HlhkvNqPm+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pvk5HRayLYDWj18R5zxi+Ih5c/L9SADJ6tZhNa7pw8g/NeLORCff5CQIxCxH3uBwA7u6QDqx/XrTRl9OwBQlgu/WfFfs0wlPxrR3QtG88D1rChyoYrwQ2BbAmWlB9xFyGP1hqaZLyB7mUWHIpzBLF/dOsAXQuydi295IvlPIHuv3H77Su5M4ns1J+jb7JanRYs09y903of1JaqLIFiWa+ddNWOq5UA7M0ga5T9WuHSXzBgPQUcV6tqjVdw3nTJle18+h4gRarv8XbnN8hf3Ai0X+ZXsaZ+czkjxdAsIooN/8ElZeIUbP/Wx2A2kovt0jdvcIm3aKRcBIEeRaB8FOcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=j45+Wj0b; dkim-atps=neutral; spf=pass (client-ip=2001:4b98:dc4:8::228; helo=relay8-d.mail.gandi.net; envelope-from=maxime.chevallier@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=j45+Wj0b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=2001:4b98:dc4:8::228; helo=relay8-d.mail.gandi.net; envelope-from=maxime.chevallier@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YdQpT4Xk3z2yDr
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jan 2025 01:05:51 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D40F1BF208;
	Wed, 22 Jan 2025 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737554747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6A2D9Gp6FOhIbSWgb9j5UrKEP+ZhUZ+HlhkvNqPm+8=;
	b=j45+Wj0bkZUjkfE2K7uxrujT3U0CBiljadFY9MriVnVTIHNFfsdFA5xnU5ptdu/wlydT4b
	n2vJbfLP+TmM0g0MR4H0vd5fJviqvSdbh8lgC+59TU/F7Kg9mInq2xT1/fXyc8Tympc6pG
	SC1r2wzqeAOGO3MYoRZWhHoz94AxeCf6w7Sg90jqLyrtUdnL1bBgjkNRgxmFFzVSP+iS14
	gMCgNt+ynhl7pYBKfOnoTLNBgl1YBVjuodqnbWHX3XtTAebrVCkdoAeIJFUCtV2Rus55TL
	9HF2d9LlA3ulb67ms7LaA+aWcA3fGjTx4RxCyixqFvkjd/WiVeMYS9QNDhjXUQ==
Date: Wed, 22 Jan 2025 15:05:42 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ninad Palsule <ninad@linux.ibm.com>, Jacky Chou
 <jacky_chou@aspeedtech.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "eajames@linux.ibm.com"
 <eajames@linux.ibm.com>, "edumazet@google.com" <edumazet@google.com>,
 "joel@jms.id.au" <joel@jms.id.au>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "openipmi-developer@lists.sourceforge.net"
 <openipmi-developer@lists.sourceforge.net>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
 "robh@kernel.org" <robh@kernel.org>
Subject: Re: =?UTF-8?B?5Zue6KaGOiDlm57opoY6?= [PATCH v2 05/10] ARM: dts:
 aspeed: system1: Add RGMII support
Message-ID: <20250122150542.55d483e6@fedora.home>
In-Reply-To: <c83f0193-ce24-4a3e-87d1-f52587e13ca4@lunn.ch>
References: <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
	<SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
	<8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
	<c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
	<c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
	<SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
	<9fbc6f4c-7263-4783-8d41-ac2abe27ba95@lunn.ch>
	<81567190-a683-4542-a530-0fb419f5f9be@linux.ibm.com>
	<0ee94fd3-d099-4d82-9ba8-eb1939450cc3@lunn.ch>
	<20250122140719.5629ae57@fedora.home>
	<c83f0193-ce24-4a3e-87d1-f52587e13ca4@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

> > Can we consider an update in the kernel doc along these lines :
> > 
> > ---
> >  Documentation/networking/phy.rst | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/networking/phy.rst b/Documentation/networking/phy.rst
> > index f64641417c54..7ab77f9867a0 100644
> > --- a/Documentation/networking/phy.rst
> > +++ b/Documentation/networking/phy.rst
> > @@ -106,14 +106,17 @@ Whenever possible, use the PHY side RGMII delay for these reasons:
> >    configure correctly a specified delay enables more designs with similar delay
> >    requirements to be operated correctly
> >  
> > -For cases where the PHY is not capable of providing this delay, but the
> > -Ethernet MAC driver is capable of doing so, the correct phy_interface_t value
> > -should be PHY_INTERFACE_MODE_RGMII, and the Ethernet MAC driver should be
> > -configured correctly in order to provide the required transmit and/or receive
> > -side delay from the perspective of the PHY device. Conversely, if the Ethernet
> > -MAC driver looks at the phy_interface_t value, for any other mode but
> > -PHY_INTERFACE_MODE_RGMII, it should make sure that the MAC-level delays are
> > -disabled.
> > +The MAC driver may add delays if the PCB doesn't include any. This can be
> > +detected based on firmware "rx-internal-delay-ps" and "tx-internal-delay-ps"
> > +properties.
> > +
> > +When the MAC driver can insert the delays, it should always do so when these
> > +properties are present and non-zero, regardless of the RGMII mode specified.
> > +
> > +However, the MAC driver must adjust the PHY_INTERFACE_MODE_RGMII_* mode it passes
> > +to the connected PHY device (through phy_attach or phylink_create() for example)
> > +to account for MAC-side delay insertion, so that the the PHY device knows
> > +if any delays still needs insertion on either TX or RX paths.  
> 
> You dropped:
> 
>    For cases where the PHY is not capable of providing this delay...
> 
> This is something i would like to keep, to strengthen that we really
> do want the PHY to add the delays. Many MACs are capable of adding
> delays, but we don't want them to, the PHY should do it, so we have
> consistency.
> 
> The language i've tried to use is that "rx-internal-delay-ps" and
> "tx-internal-delay-ps" can be used to fine tune the delays, so i'm
> expecting their values to be small, because the PHY is adding the 2ns,
> and the MAC is just adding/removing 0-200ps etc. I've also used the
> same terminology for PHY drivers, the PHY DT properties for delays are
> used for fine tuning, but the basic 2ns on/off comes from the phy-mode
> passed to phylib.
> 
> If it is just fine tuning, and not adding the full 2ns, it should just
> pass phy-mode straight through.
> 
> So your text becomes something like:
> 
>   The MAC driver may fine tune the delays. This can be configured
>   based on firmware "rx-internal-delay-ps" and "tx-internal-delay-ps"
>   properties. These values are expected to be small, not the full 2ns
>   delay.
> 
>   A MAC driver inserting these fine tuning delays should always do so
>   when these properties are present and non-zero, regardless of the
>   RGMII mode specified.
> 
> Then we can address when the MAC adds the full 2ns.
> 
>   For cases where the PHY is not capable of providing the 2ns delay,
>   the MAC must provide it, if the phy-mode indicates the PCB is not
>   providing the delays. The MAC driver must adjust the
>   PHY_INTERFACE_MODE_RGMII_* mode it passes to the connected PHY
>   device (through phy_attach or phylink_create() for example) to
>   account for MAC-side delay insertion, so that the the PHY device
>   does not add additional delays.
> 
> I also think we need something near the beginning like:
> 
>   The device tree property phy-mode describes the hardware. When used
>   with RGMII, its value indicates if the hardware, i.e. the PCB,
>   provides the 2ns delay required for RGMII. A phy-mode of 'rgmii'
>   indicates the PCB is adding the 2ns delay. For other values, the
>   MAC/PHY pair must insert the needed 2ns delay, with the strong
>   preference the PHY adds the delay.

Thanks Andrew for the suggestions, your wording is definitely better
than mine :) I'll queue that for when net-next re-opens.

Maxime

