Return-Path: <linux-aspeed+bounces-2001-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970D0CA0EE6
	for <linux-aspeed@archiver.kernel.org>; Wed, 20 Aug 2025 02:44:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c69kw6gH1z2xcC;
	Wed, 20 Aug 2025 12:44:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755657848;
	cv=none; b=ZW2m0kmmufu6ZJdpElHOReK9yaKw1X32fKZx/pCA0F1A5BROXsuCsop6RULCVmmuez0aa1gmFOOLL94L7L5tZuDK2fnnTqMfpeWutFYtvJy3DwY2ucJiqXfBgZqA2lQ4wdE3RsKNQqzYIbHnnM056EHumO9g4lql9QQegJpQoh91Wh2m3UNFnJ6LWKHmbCbYU6ojDEpfDkIKzz2ORyqif30NUmJZOv1WU1ABu0k8F+ShOvpgal07AowwqIswKmHRkFVey9eUW45iGzImsjwqIGcq5fd0xO1qNOT2WMWRsxfFlE9C1rapJolX+icol2bjPB1JrjhqJq06XOv2zZuM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755657848; c=relaxed/relaxed;
	bh=N+xJmULXxpHn+xezKethz/N2R54pHjMy75yfVcSZbZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2+X5kPnB0P6eDIAe4QGlSzpHyuqI50u5GcBC3CR6zSXlX/+BNLhiFSVaILp6+Bnaif6Lcsj3oyVH1l2DaFlsDPj7SI4J98j+GOEcTfqRAuyEAnPERApXr7wY9Lzv4XvRbJ6WP8Is5Kko9cTa6gZPatf39MvhGT5x5nkQfxgP3hNGrSkVnmoFFiXNOXQUS+YBt/k5GU9ZyfkAmrYhLvkC8hm7d0EFG+Ylr2nqZT6OwAzifAPLb462rWb8nnQ1/pSfoH4FuUDbklbWs2+mbSiDFI4RZ50LekJNPHrw+B1vSZs/b+mR5M6Tzvh6m4OiCK3n+4ncKjcjOlRLVhG28ffpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=aFfxz7Lu; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=aFfxz7Lu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c69kv0SFDz2xQt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Aug 2025 12:44:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N+xJmULXxpHn+xezKethz/N2R54pHjMy75yfVcSZbZ8=; b=aFfxz7Lu4MS5kpv0tqnOjSO/Dk
	ftywl6LjfJ0a6NPa1n8NITAaay22TzriZiEV1deD1WFg1dO8r+tsKtGpktxxfAPp2Xb1nYTYbvbxn
	Ky/EkLFTVc5T+v66fENPlvrezjt982uOKTkQdC2O6zM2MLVK7SV0mBlHGJ4Z9x6rqXQk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uoYnW-005GZ7-5N; Wed, 20 Aug 2025 04:43:34 +0200
Date: Wed, 20 Aug 2025 04:43:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [net-next v2 0/4] Add
 AST2600 RGMII delay into ftgmac100
Message-ID: <3966765c-876e-4433-9c82-8d89c6910490@lunn.ch>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
 <a9ef3c51-fe35-4949-a041-81af59314522@lunn.ch>
 <SEYPR06MB513431EE31303E834E05704B9D33A@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB513431EE31303E834E05704B9D33A@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Wed, Aug 20, 2025 at 12:40:02AM +0000, Jacky Chou wrote:
> Hi Andrew,
> 
> Thank you for your reply.
> 
> > > This patch series adds support for configuring RGMII internal delays
> > > for the Aspeed AST2600 FTGMAC100 Ethernet MACs.
> > 
> > So i think you are doing things in the wrong order. You first need to sort out the
> > mess of most, if not all, AST2600 have the wrong phy-mode, because the
> > RGMII delay configuration is hidden, and set wrongly.
> > 
> > Please fix that first.
> > 
> 
> The RGMII delay is configured in U-boot stage, and it is not changed when booting to
> Linux. I want to know whether the first thing to correct here is whether the phy-mode
> in aspeed-ast2600-evb.dts is rgmii-id. Our AST2600 EVB, there is no delay on board,
> so, I need to change the phy-mode to "rgmii-id" to meet the RGMII usage first?

If there is no delay on the PCB, then phy-mode is "rgmii-id".

	Andrew

