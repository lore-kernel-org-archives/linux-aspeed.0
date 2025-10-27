Return-Path: <linux-aspeed+bounces-2633-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CDDCCF9EA
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Oct 2025 12:35:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwCdK72Csz3btf;
	Mon, 27 Oct 2025 23:35:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761568501;
	cv=none; b=U/dQ/mLZTyE42It1pFrsC10FdEp5JpwdROCIsZaErH0uKZv5zpZKFuG7PqisCJt2M8Y7O2eW6j+GKRMlwIPLE82blMwk3FV2lZnRNTQbU+ZNpL1n/0HFEmlMOyA5XjrfwnUTs8MIYP7rrEyDWUzwUnfRCGDZRF/B1ObnXbODnmxmcJZuT/xCTV2iZEcKsezHkSw74M6Kksmc4ub8osvXRaaGTHEKtTqLLB3zJDiYfkduTwy4f6bD6cHyxmOwpjxYGnNkgGA/bxSVTt9bKud/XIshKjWLQMwTT6hQ8Xks1d8IrApHkI+Ju0mKi0GdZnLAzrA92psN2QX1ehMS0TEOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761568501; c=relaxed/relaxed;
	bh=iA7t2Iu5WmijCKzI4GOFbP1+sQVyXkrlu3SiinRY5fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEQ0nlBbDDEnAIy0tFFG9Aq60w9MZUaBBRVsLoysn7pKwCkE8wCghZ+eaB/nmwrMhrPeYLCI9wofpB58G3fZsmUi2j9ouBld3/Djog3bHaBmcVBQfyfYEzmjzL7NnuYLTKYR+6AgALWIUCH42VMv/YrNPDo9eCL/i8YA+rsOvr1m1vJKOjHmvE0cn7E+XHFslGiUEr0C8zQT4D/PIh6nJ8oVOCw06xRlUdUYkrXMR2irffLJewFjPYE848vq43EGxULfzRdBZr3aV5qI+lInfpiQXQu4HB54gADU1ij1LTKs49mkn1uJSrcJ8f6RSIMunMeAwPZHj4U2EuG+EK7BiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=xOHj51J/; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=xOHj51J/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwCdK1LLDz2yrq
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Oct 2025 23:35:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iA7t2Iu5WmijCKzI4GOFbP1+sQVyXkrlu3SiinRY5fE=; b=xOHj51J/BGH7TW8B1tue9x+1cZ
	ciRjmO0LOkcfCgqKGjCBlhej8qpS2adZBtz83L4kTWr2SWApaY5YfMZ2y2Ezd/LwY8+ytZgOHpVEC
	5g2JJQlARRG/mEHbQFcddVjttfvRkuIDkru5t5BQhF1yh4cYwCY8enA2+QPSZI+5AZyY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDMQs-00CBov-Nc; Mon, 27 Oct 2025 13:34:42 +0100
Date: Mon, 27 Oct 2025 13:34:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: BMC-SW <BMC-SW@aspeedtech.com>, Arnd Bergmann <arnd@arndb.de>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [net-next 0/3] Add Aspeed
 G7 MDIO support
Message-ID: <ad12992b-2ddf-406f-a024-dd402f8a3f0c@lunn.ch>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
 <7368c77e-08fe-4130-9b62-f1008cb5a0dc@lunn.ch>
 <SEYPR06MB513478C462915513DE7BE1AE9DFCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB513478C462915513DE7BE1AE9DFCA@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Mon, Oct 27, 2025 at 02:44:23AM +0000, Jacky Chou wrote:
> Hi Andrew,
> 
> This is Jacky from ASPEED.
> Last year, I submitted a series of patches to add a new compatible string
> "aspeed,ast2700-mdio". At that time, the feedback I received was that if there
> were no functional changes, a new compatible string would not be necessary.
> Recently, we are submitting the AST2700 platform support to the Linux kernel.
> In the following discussion thread, it appears that the MDIO driver might need
> a new compatible string for the AST2700 platform:
> https://lore.kernel.org/all/b048afc1-a143-4fd0-94c9-3677339d7f56@lunn.ch/
> I would like to confirm whether this case should be submitted separately to
> net-next, and in general, if there are no hardware or design changes, is it
> still required to introduce a new compatible string?

Are you sure it is identical? And are you sure there are no bugs in
the driver which would require breaking backwards compatibility, like
you are going to be doing for the MAC driver?

Take the reset handling for example. It looks like it was added after
basic support for the 2600 has added, so it had to be optional, to not
break backwards compatibility with older DT blobs. But since there is
no support for the 2700 yet, you could make the reset mandatory,
without breaking anything.

How is the clock handled on this hardware? The MDC is currently
ticking at 2.5MHz. However many PHYs and MDIO based Ethernet switches
will happy run at a faster speed. So you could implemented
'clock-frequency'. But for that, do you need a clock listed? Should
that clock be listed now, as a mandatory property for the 2700?

Having a specific compatible and a fallback costs nothing, so i would
do it. 

	Andrew

