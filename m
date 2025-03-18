Return-Path: <linux-aspeed+bounces-1036-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D630DC28B28
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Mar 2025 13:52:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHCvK3nfcz2yrR;
	Wed, 19 Mar 2025 00:52:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742305933;
	cv=none; b=QFGTUprKNuIUWIx2RlRpnfnaQaN8v48lDKG7Qdy3tjn9iAChv5eMi7ZF4EmXrmBus1VWyuCnpb25CTZLhGtIz4UIJj2QkR30tryIa3qUefiUrRI8kRkrP+Z6HFwZtWN7wrenuxGV3eVrxVMwYKP+cHbiKZ4/3/uA7F5gakYqYQt/wTaJpKBwY2/U3djqk0VjALX9Y2zgCf9UrCMFi5Xf71tPnYPs4FsT7f8RuOro+AD0gr94cqouePNn81+6UAE+0SRIojBcigILacRydiFwt+VcYWPLyroZs45cjqUUyJABUQ+qsidLvmMrPnRMvsFlbec9QQzuvYwopmI1mN/bqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742305933; c=relaxed/relaxed;
	bh=n26jTGw7a6IhILTyNcvgMrK+JzqQ4j06C8HKLqJCV74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFmgyKXEQffaJinxW2Y4X4T33lGMvX6Fzoe2XS8Orb0nRX9BZw5VXIMF316vYgLBAw7ZVYSKXKJgLMKZTrbCpf2UyIBcNQP6xzdhw0oY6KgD6kgFjZo9rhLauBTsbGIymgNZ6uwy119r99wQ853BbZf5yvVecSrjmYW5SLXjpB2jCj6naO+ilfQQV/GsjYumgaJdo7I2TLSsqJ3anqjoeIP1IriyoUHpdfg9zxTfasuuP6TP9c4y77Ti+L0YIoGrwcCnUMBZhKcG+UxB373pDLUPJ/qsV66P5XTcN/ivzAVCHr2AehvFUEnap1qnjqEnsr6RuQCJok6vTakmqbq1Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=fQLghR0h; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=fQLghR0h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHCvJ5g0gz2yfS
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Mar 2025 00:52:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n26jTGw7a6IhILTyNcvgMrK+JzqQ4j06C8HKLqJCV74=; b=fQLghR0hnNj09MYO1OaK/dfY6v
	ylVyfUE/zF0CnFLmbUo9xYGBNcXicjT40z9zwR4JF9C4nynTcfi8NPoCw57QcHCRhbV2S4grPzd01
	FVZmMGl3btj03Ymp0Wrg1ggotEGAwBnCJDHro067VRhx9kd2Mgx2Cmg4NDzXbi9/QDr8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuXMG-006GWG-39; Tue, 18 Mar 2025 14:51:52 +0100
Date: Tue, 18 Mar 2025 14:51:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
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
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY=?= =?utf-8?Q?=3A?= [net-next 4/4]
 net: ftgmac100: add RGMII delay for AST2600
Message-ID: <5b448c6b-a37d-4028-a56d-2953fc0e743a@lunn.ch>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
 <20250317095229.6f8754dd@fedora.home>
 <Z9gC2vz2w5dfZsum@shell.armlinux.org.uk>
 <SEYPR06MB51347CD1AB5940641A77427D9DDF2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <c3c02498-24a3-4ced-8ba3-5ca62b243047@lunn.ch>
 <SEYPR06MB5134C8128FCF57D37F38CEFF9DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB5134C8128FCF57D37F38CEFF9DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Tue, Mar 18, 2025 at 05:34:08AM +0000, Jacky Chou wrote:
> Hi Andrew,
> 
> Thank you for your reply.
> 
> > > The RGMII delay of AST2600 has a lot of steps can be configured.
> > 
> > Are they uniformly space? Then it should be a simple formula to calculate? Or
> > a lookup table?
> 
> There are fixed delay values by step. I list below.
> AST2600 MAC0/1 one step delay = 45 ps
> AST2600 MAC2/3 one step delay = 250 ps

That is messy.

> I calculate all step and emulate them.
> The dt-binding will be like below.
> rx-internal-delay-ps:
>     description:
>       Setting this property to a non-zero number sets the RX internal delay
>       for the MAC. ... skip ...
>     enum:
>       [45, 90, 135, 180, 225, 250, 270, 315, 360, 405, 450, 495, 500, 540, 585, 630, 675, 
>        720, 750, 765, 810, 855, 900, 945, 990, 1000, 1035, 1080, 1125, 1170, 1215, 1250, 
>        1260, 1305, 1350, 1395, 1440, 1500, 1750, 2000, 2250, 2500, 2750, 3000, 3250, 3500, 
>        3750, 4000, 4250, 4500, 4750, 5000, 5250, 5500, 5750, 6000, 6250, 6500, 6750, 7000, 
>        7250, 7500, 7750, 8000]

Can the hardware do 0 ps?

So this list is a superset of both 45ps and 250ps steps?

Lets see what the DT Maintainers say, but it could be you need two
different compatibles for mac0/1 to mac2/3 because they are not
actually compatible! You can then have a list per compatible.

	Andrew

