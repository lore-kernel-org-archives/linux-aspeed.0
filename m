Return-Path: <linux-aspeed+bounces-446-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4766C02180
	for <linux-aspeed@archiver.kernel.org>; Mon, 13 Jan 2025 14:39:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YWvz40BXtz30TY;
	Tue, 14 Jan 2025 01:39:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736779151;
	cv=none; b=f3U47SQ8qzIvAEm64nyc7UlMG6yrrZf4y+AGXP8PIPYPktHr6aWBUjpGLxY17cQEFvqjjvw7kX92il/ah5weAm7yMff2oh2zoXoRJ091jAxSRa0n0BuqrRlPB3ECyOtpqTHRFyTSE25Ipy5Jv+JWWEXHP16tPwBtZeZ34LkwYG4Ze1XVxbMWH95P62ht3rT7KQQN2enw/yHuFnK3mqhU0Dj9nQDyGLfIUaMqeBWtCTuqYKmVldMYgOeuBWAxLymRTJjlEUtJaoecEI8JWbLDitLWGai+xQWLZKgionlvQLIzk6iswxTVUAELE0KQhXAPYiUBPTSh4uZGbmsUH8dBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736779151; c=relaxed/relaxed;
	bh=nl3Mw4Ndpe7aZrKhI8t+n+/czM8OaalquBI/xX0tQ8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN2VkJ1YO54/9S5EZVLPfikWJ7yiHwFHhA/k6y6/Uuck06/K1REhXnJQTY/lOI8lB1CuzFVclSseAK6ew5VlyGzdpepv1exymxy1zNt2QXwzhjL62ZQMgKdXvuEQxu/kJv+HVRjvWNoC5H2Vdg6Np0db1bGZ+tQHiYMCGMbkOO4pSrma7YyDR86bIeFH4SPI96HOLT11Xd9FyTvXfncd34kGi41ohdphOfL1aOhJ6/keuIdROuGqWDTAvHSR06y1h5kz+X5l1z06UZ5JJcvqjpd6KD1Ek9QRR0sgXarQ5lrkk5iygNuii4vjjTlD/SN9UKr2m2qxDGKSk5Guihs6Bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WIdE1Sba; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WIdE1Sba;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YWvz14L6yz30Ss
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jan 2025 01:39:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nl3Mw4Ndpe7aZrKhI8t+n+/czM8OaalquBI/xX0tQ8A=; b=WIdE1Sba7ulUJLWZr8AlOw/rac
	EHP1Csl7Y7MCeFWZf2F2bLnlUf58zNncweVjALqPxuZdMOE9F9nJOEhwl8XZ1m/hmIAUGrkMibmBS
	ipxofbBoyf3Wr/Af3EFLDh+lR6mS8W4IJJZ+AF4BP2oQylV4ESKodQD12FO/K1fpDO5A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXLaV-0047S8-N4; Mon, 13 Jan 2025 15:38:43 +0100
Date: Mon, 13 Jan 2025 15:38:43 +0100
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
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY6IOWbng==?=
 =?utf-8?B?6KaGOiBbUEFUQw==?= =?utf-8?Q?H?= v2 05/10] ARM: dts: aspeed:
 system1: Add RGMII support
Message-ID: <26dec4b7-0c6d-4e8e-9df6-d644191e767f@lunn.ch>
References: <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
 <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
 <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
 <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
 <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
 <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <d80f5916-4918-4849-bf4e-2ef608ece09d@linux.ibm.com>
 <SEYPR06MB51340579A53502150F67ADEC9D1F2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <bcebe5ed-6080-4642-b6a5-5007d97fac71@linux.ibm.com>
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
In-Reply-To: <bcebe5ed-6080-4642-b6a5-5007d97fac71@linux.ibm.com>

On Mon, Jan 13, 2025 at 08:26:08AM -0600, Ninad Palsule wrote:
> Hi Jacky,
> 
> On 1/13/25 00:22, Jacky Chou wrote:
> > Hi Ninad,
> > 
> > > Thanks. When are you planning to push this change? I might need to hold on to
> > > mac changes until then.
> > Yes. We have a plan to push the patch about RGMII delay configuration.
> > Currently, I try to align our SDK to kernel.
> 
> Thanks. What will be the "phy-mode" value after you make these changes?
> 
> Will it be "rgmii-id" for MAC1..4?

It should be.

> If that is the case then I can test it with current configuration which may
> add extra delays in the RX from PHY side.

I would then expect traffic will not flow correctly, and your see CRC
errors, because of double delays. It is however a useful test, because
if it does somehow work, it probably means the PHY driver is also
broken with its handling of delays. I don't know what PHY driver you
are using, but those in mainline should be correct, it is something i
try to review carefully.

	Andrew

