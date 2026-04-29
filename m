Return-Path: <linux-aspeed+bounces-3976-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5488CFF8867
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Apr 2026 12:58:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5HR10C69z2yVL;
	Wed, 29 Apr 2026 22:58:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777467484;
	cv=none; b=O9xNwmu6iX9SEtxvfudtYmaTaGvRzGaF6ku/uKEfaM2I6AJFSAUZLb0v1ThE2uWOEWE+foD/3pkuPibiyOXT5rplz/N06cWZnv2t8Ccf0DZknUfvg6TwMxv1420W3fnDAkzvSjJD7x8NqnJEEnB8hXYVxW12KWGyEJqHQ8MHArrw8+RAtCjG7xn/D7KWVOMpoOtWXgmYMs18bWgyqbHmtCoYEjw2f3wx55iWU9cZX78rVcWL81n3YbW8J3zBOg413G7Bb58u3VsV11c/JSJWOaja+cDGHzGYX7uRcUXxJ2517oZ9Y3m07Mb7EHt+p8tqLikFbO7s6Kmqtq+bKDDcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777467484; c=relaxed/relaxed;
	bh=Ct2pD6eOtO9PvBCttFPIKGh9xJAlja9V7gGV1f2aOrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1oEXpoSRdbRpIxwuBxgklYP5xvyaDEgyBdeURbSftGKj9A5bkVawaNR1l1KjZRUpFN9oqLzlDUDH2LfSuwOUQwHDcbTgZaTtjYaRdeh/J4hYXlwXVK+dnV9/7M1uCzDdhWGgDD/qi0CSpEUDSHvdp1PijOCDP84qZrLtV5+8cATW2/xKHAZXteCbyJI38QwSyZJjkUKmPze6oY8oopJ8H8QG3NFLqoOLY8KoS7KJ5O12uHnU8nHW35x6g/9dOhsCq/+XTzKQWKtPhL9Ot0DNoBFyosvRPYwodGbZD5npUZmJSrpkpsSQb0yAjY8DyCB3uCXTnEJR44XJrtNzEM55w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Eh15RP9p; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Eh15RP9p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5HQy5ztgz2y7M
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Apr 2026 22:58:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Ct2pD6eOtO9PvBCttFPIKGh9xJAlja9V7gGV1f2aOrs=; b=Eh
	15RP9pympRHZWMV4ZiZ+hYbVC+2zSKdb2Fo+blTeh3gBRi02zqnB5/XAN2JY4+IXjsMGqgsz6wG+m
	AkTo/K3gDwGhBezNzd7Lv9b127mY62fXIfxrWus2CE0zY/M72XfUMFL9/uf/TQmKMGM2yvzhXtHEv
	KfxUTbe69yOWqxQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wI4UI-000X6s-3c; Wed, 29 Apr 2026 14:57:58 +0200
Date: Wed, 29 Apr 2026 14:57:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Ender Hsieh <andhsieh@nvidia.com>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	Marc Olberding <molberding@nvidia.com>
Subject: Re: =?utf-8?B?5Zue6KaGOiBOVkwzMiBCTUMgZW5h?=
 =?utf-8?B?YmxlbWVudCDigJQ=?= offering help on ftgmac100 work
Message-ID: <eac09481-0ba1-4ac2-ad8c-d859822ff0d5@lunn.ch>
References: <SEYPR06MB513489D0B8F5BC77258EA1FF9D372@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <20260428151416.1700609-1-andhsieh@nvidia.com>
 <SEYPR06MB5134EAEAB53E80B69F73131B9D342@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB5134EAEAB53E80B69F73131B9D342@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Wed, Apr 29, 2026 at 02:08:51AM +0000, Jacky Chou wrote:
> Hi Ender,
> 
> We stopped to submit the RGMII delay configuration in ftgmac100 driver, please
> adjust the correct RGMII delay and configure in bootloader.
> 
> Currently, we suggest the PHY side to enable TX and RX internal delay, which
> means the phy-mode is set to 'rgmii-id' to tell the PHY driver to enable both
> delay to its PHY device.

Please don't top post. It makes it harder to make the emails
understandable.

> Thanks for the update on the AST2700 ftgmac100 plans.
> 
> A bit of context from our side: we're working on the OpenBMC upstream
> effort for nvl32 (the AST2600-based msx4 platform Marc Olberding
> upstreamed in commit f28674fab34f). To get host networking working on
> our test platform we currently carry a local kernel patch in the
> OpenBMC layer that re-adds the mac0/mdio3/ethphy3 nodes, but holding
> it there long-term goes against upstream-first principles and the
> Gerrit reviewer has flagged it.
> 
> Given AST2600 ftgmac100 work is sequenced after the AST2700 series,
> do you have any suggestions on how we could resolve this using
> upstream resources — e.g. an interim path that's acceptable to the
> community while we wait for the proper driver fix? Any pointer on
> the right shape (RFC PATCH, openbmc/linux backport, something else)
> would help us a lot.

Hi Ender

The problem about getting stuff upstream is phy-mode. If you don't
have the PCB adding the delays, you need to use phy-mode='rmgii-id'.
Which is the typical design.

The root cause of the problem is actually the bootloader. It enables
the delays in the MAC. The Linux MAC driver leaves them untouched, but
it also passed the phy-mode direct to the PHY, not taking into account
that the MAC has added delays.

The quick and easy fix for getting patches merged into Mainline Linux
is to patch the bootloader. Stop it enabling delays in the MAC. You
can then use the correct phy-mode. If you go this way, place make it
clear in the commit message you have modified the bootloader.

The more complex way to solve this is to make the Linux MAC driver
look at how the bootloader has configured the delays, compare it
against phy-mode, and decide what to do. I've not thought through all
the combinations but something like:

* If the bootloader MAC configuration is not adding delays, do
  nothing. (This covers what i just suggested)

* If the bootloader MAC configuration is adding delays, and phy-mode
  == 'rmgii', turn off the delays and pass phy-mode=rgmii-id to the PHY
  (This covers any DT blobs which got passed me and merged)
  
* If the bootloader MAC configuration is adding delays, and phy-mode
  == 'rmgii-id', turn off the delays and pass phy-mode=rgmii-id to the
  PHY (This covers how it should be)

What makes it more complex is that delays are not simple on/off, but a
range of values. If the PCB is badly designed you sometimes need small
delays to compensate. So rather than having a delay of 2ns, it might
be 2.1ns. Or it might be 0.1ns. If it is 2.1ns, when you turn it off,
you need to set the MAC to actually add 0.1ns delay. And you need to
consider 0.1ns as not adding delays, and keep the 0.1ns. And if the
delay is actually 1.8ns, it gets even more interesting, because i
doubt the hardware can add a delay of -0.2ns, so you should actually
leave the MAC delay alone, and pass phy-mode = rgmii to the PHY so it
does not add delays as well.

If you decide you want to make changes to the MAC driver, do it, post
patches, and they will get reviewed. And given the number of dts files
i've stopped getting merged, it should not be hard to find others to
do testing for you, and you might end up with a crate of beer/box of
wine from other openBMC users.

     Andrew



