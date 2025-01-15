Return-Path: <linux-aspeed+bounces-489-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E9AC02185
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Jan 2025 13:30:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY6Ls21JZz30CL;
	Thu, 16 Jan 2025 00:30:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736947829;
	cv=none; b=FIpHaNtBO8c3gYXsrCMXskJhLP2fH9UJcC5z4VBglFGsJ44czw5ovSSiu7DiLJqnJEaSHPV5OamTCCHuIxb2MQZSaBPjMQ+vJerbyr0GzO43zVHsmhm0KhwZmuuZIK/fcsISn2bY2nQ165aJH0J3LqJ/PADRqWtZyokh5/XpNw8m+FFOohS9nQ8xa1MFMUnu6Eml3xWr6VCJcppSzTmoViXPl6189FmilplzbJ5QKC+hGTEaKJSd/ytznPaGZvn3TnuzYwUhKP2Hm6r9gz1uDf9xQAJfuwNOiXZ4awV7W/yTGi/JZ7Jo7f2Rluy8eMKXY5dSciFfHT5hasgP8vOf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736947829; c=relaxed/relaxed;
	bh=7Jxfu41iCy3/Xl/2SlMHlq/E6+bEJVMK0dEbie6RGZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUFIcgDju4C8q+DzzhpcjWK/kVA50RIh0eTUxrq6l1cXMfeWIAhNZGeKGpNYmDTFjP8XV+ettQTpz0Y714uBFnoMs4ElocXkP0/aO+kX2fRvxM6TmGikbtsWQwBodd2JUlJtrKGqtFZhT9/hY2XW0w8SxVBxPHfUr0GQDHJi7tqBI18NPjdZ0mpF6O3s6YaFC3pXNf57zpMIaqYGCy4aYXRj+Kvg0xGAA//9izVRVJPhCGvTkDminzzcHdr57u10wo/H5UPgBT99bPJRZyrelNu/Qtxm3kIbbzcFLipQwF6lesj0B06ShU9AgqVy6T4hNsjDz21zMNh4WLIn7Zfn2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Ij3Sj/Tx; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Ij3Sj/Tx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY6Lr3rq2z305Y
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jan 2025 00:30:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7Jxfu41iCy3/Xl/2SlMHlq/E6+bEJVMK0dEbie6RGZA=; b=Ij3Sj/Txb2dxOJgo3P6GgArB+/
	dEwiCa+37ZNiUwU0vMWkSRkhXvTogV3InoFtWWh2wqagd9Zjs5v4p5SaaJBMjx4HbDjyeWCYxm17j
	gkhD2tSn1E2sWqOKsblQoPD7u3iP/onq5igWETBEd8eJ9Cp0Wr9GQFrhWHjEi4xkdokI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tY3TA-004nPe-5A; Wed, 15 Jan 2025 14:30:04 +0100
Date: Wed, 15 Jan 2025 14:30:04 +0100
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
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY6IOWbng==?=
 =?utf-8?B?6KaGOiDlm57opoY6IOWbnuimhjogW1BBVEM=?= =?utf-8?Q?H?= v2 05/10]
 ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <f28736b5-f4e4-488e-8c9b-55afc7316c5e@lunn.ch>
References: <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
 <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
 <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <d80f5916-4918-4849-bf4e-2ef608ece09d@linux.ibm.com>
 <SEYPR06MB51340579A53502150F67ADEC9D1F2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <bcebe5ed-6080-4642-b6a5-5007d97fac71@linux.ibm.com>
 <26dec4b7-0c6d-4e8e-9df6-d644191e767f@lunn.ch>
 <SEYPR06MB5134DD6F514225EA8607DC979D192@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <e5178acd-0b6f-4580-9892-0cca48b6898a@lunn.ch>
 <SEYPR06MB513402FD4735C602C5531F499D192@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB513402FD4735C602C5531F499D192@SEYPR06MB5134.apcprd06.prod.outlook.com>

> > I already explain how this works once. Please read this thread again.... The
> > MAC can apply the delays, but it must mask the phy-mode it passes to the PHY.
> 
> Yes. I have read these mails.
> 
> I understand what you mean.
> "rgmii": delay on PCB, not MAC or PHY.
> "rgmii-id": delay on MAC or PHY, not PCB.
> 
> ftgmac100 driver gets phy driver handle from of_phy_get_and_connect(), it will pass the phy-mode to
> phy driver from the node of mac dts.
> Therefore, I use "rgmii-id" and the phy will enable tx/rx internal delay.
> If I use "rgmii-id" and configure the RGMII delay in ftgmac100 driver, I cannot pass the phy-mode to 
> phy driver.

Quoting myself, yet again:

> > MAC can apply the delays, but it must mask the phy-mode it passes to the PHY.

If you decide the MAC does the RX clock delay, it needs to mask that
from the phy-mode, otherwise the PHY will also do it. If you decide
the MAC does the TX clock delay, its needs to mask that from the
phy-mode.

	Andrew

