Return-Path: <linux-aspeed+bounces-141-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB22D44157
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 Nov 2024 13:26:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xt4yW3KgFz2y72;
	Wed, 20 Nov 2024 00:26:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732022787;
	cv=none; b=NoPg3S4GUdkN5UbLl/MO2r3pR0mo3xQECm4oLcX773gqLlvbN37E2ltEgOz7arAr21Fl2SyF2kAG4dP5QMRQ48Vi6MIrn/QbVZwJbTyuISpbsI20uUFNbz5oj6VXt/O7v5MeCRblgGF2OozSwqZmyZmyihm0YNM4rpU2NFsGhfPrz+0f3laOkm0LdgN6+rY5tUlnxIJEUbSuwDqy69EXjUeECQfLUbBmLK96/wI7mlMCyFbNrmbOdUrtTzskGd1k7Ty/Xl9hJxEUvFa3DR4U60p+hjJGmin3Ugwm9vQCFwjbO4aoq6ixPi6DPb+JOE09wBVedTvTl0BCxkRnKNN7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732022787; c=relaxed/relaxed;
	bh=10XFHA4WlKYuCUuXVeCcAEgWg2V+Sh14geel43tsfcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBBAWfLdGNNx3Dj4BOmfw7YzkHjgMWnrW2Yei9KwSpaLlzHnYnr37PaHiK1kgakEXa2+hYlWeDBMecrHlRKfgQknfpcg8iarAZ/FkQ7sYtoWbDjl0lRacXS+PinVJ+rLt3gN6k8wv2EkOs84GK8yDFYuOrr01YcMFzF+z1ZazMVUN7rCDq6BF0NCLbgp190WrkXRxUvqr6px5m3DZv8qfmXICqWtKDyOjqkBVhvXdeef2gk7SMqLPHcUkHPEojaVXxaH+KPvNVKWD1FTrVTMbhPf3ClPpPP3BGVG1o8hOVbnfmHpYcXZnCyDJ4B4hIiEEaUJlx6sgqpS+cILJpGVJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=v9EloRtN; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=v9EloRtN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xt4yT4kkBz2xxt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 00:26:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=10XFHA4WlKYuCUuXVeCcAEgWg2V+Sh14geel43tsfcc=; b=v9EloRtNMXlEcEg5euoahINDxU
	BsgU65QlQD3uKoH2Qfbws9YV99RKTqGhbNFfLlHJdXiMqeRGVZPP9EN3NhIszhvO2b7U1cHNOl8TB
	Uf2vRBK/g7+XhmdmS+DtqxOBlvzGNzx5wQ9oYLv7nfbV0tIxHs9aYDTptdocqbXumWkc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDOEv-00DnnA-DP; Tue, 19 Nov 2024 14:25:57 +0100
Date: Tue, 19 Nov 2024 14:25:57 +0100
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
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [net-next 0/3] Add Aspeed
 G7 MDIO support
Message-ID: <6ae91aae-5939-4ffd-a430-181fb88d259b@lunn.ch>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
 <7368c77e-08fe-4130-9b62-f1008cb5a0dc@lunn.ch>
 <SEYPR06MB513475D2B233EA9BDF52AD259D202@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB513475D2B233EA9BDF52AD259D202@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Tue, Nov 19, 2024 at 05:35:40AM +0000, Jacky Chou wrote:
> Hi Andrew Lunn
> 
> Thank you for your reply.
> 
> > > The Aspeed 7th generation SoC features three MDIO controllers.
> > > The design of AST2700 MDIO controller is the same as AST2600.
> > 
> > If they are identical, why do you need a new compatible?
> 
> We want consistent naming in the DTS of the new SoC, even if Its 
> design is the same as the older SoC.

You might find the DT Maintainers push back against this. What you
want is effectively a Marketing game, it has little to do with
technology, describing the hardware.

	Andrew

