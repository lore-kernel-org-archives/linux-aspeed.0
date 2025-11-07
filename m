Return-Path: <linux-aspeed+bounces-2814-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA31CCFA13
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Nov 2025 02:01:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2j3l3xYnz3bmk;
	Fri,  7 Nov 2025 13:01:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762480915;
	cv=none; b=c/9J7qJMDD6aOpR78sflMC+iff+l4dBg+1SLPDgKH9XNwX8/zjL6DIqYjcWMXfCqLbl8rq8Tk+c44xR+mvM41UvlKEMaYq50I1nSaAxZe78hAN+7ex1vkdqlyc5oqkTSeRerpyDzpjqiDqVlCh9/oZsOmoI78S3LTkP3m0qwt+AMvboIlNZhwE9bcwlvSPgrObzMfPYkPgJc/majC55SKRbMB7HoTZt3sg38aH3+OZYlRxiR+C0ewHgrEkY/Z1qL/cAIcpL+25FM0F4np0vQGTw3JpnErf03iFFgxeAkEn++4GcVz0jSoK9HVfg4IlMvJqme5jRqG7W4K12bUgjGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762480915; c=relaxed/relaxed;
	bh=8N27r7Oyc3ywyYoactwLwAQqQuBjFkaj2XYsC9wqqK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYYh6I0QHfz1B3d9EY7Nx/ByhiRliIGgT1/iXZ82QNgjFstUemV7Mcnx85hJsVqn3QsEVaBy3BpyE/Crtldb4QipC7QkjayNUDkWPoWG4cUYubrVQzipXpiVEVHKk0f8QYGOcfb9HuHsfJ6Q98Lbw7OolwnFZcgnS2aub7D3sgqo9uaqoarMoL3LERmw721Y67479V9KP8kgaAJwm8xAZjtQgFHiIzOCTBgYk2AWnnbq7qt0X6aNDfcj5dEB8T8CDkbJzft+wvyTLht/sA52GZHLUazMYBjvDS96WYJ4vCEnYOkyNWVR5WLXbBpnfGWSuIih96kQjx4JhcAurR4hcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=a8anxoyB; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=a8anxoyB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2j3k5Dclz2ywv
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 13:01:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8N27r7Oyc3ywyYoactwLwAQqQuBjFkaj2XYsC9wqqK8=; b=a8anxoyBx7wvtgUTEJpLKERgMl
	V+UTcgG4iGjmD2EgxRzkEjCoc7DoHYXIuQHqcF0m9ASAg/1S5j9bxDOoEd4U72iMpsPLAN93IpNUE
	CR3416YcFDWFVvbfyoiq3ftgKJA+x2HK0P9NJwc4bEsCP7cu9fEDb/it4hufMRwquxBo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vHBn3-00DAwe-UJ; Fri, 07 Nov 2025 03:01:25 +0100
Date: Fri, 7 Nov 2025 03:01:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: [PATCH net-next v3 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Message-ID: <8b2f985f-d24e-427e-88cc-94d9bc5815b2@lunn.ch>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
 <20251104-victorious-crab-of-recreation-d10bf4@kuoka>
 <SEYPR06MB5134B91F5796311498D87BE29DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <9ae116a5-ede1-427f-bdff-70f1a204a7d6@kernel.org>
 <SEYPR06MB5134004879B45343D135FC4B9DC2A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <1f3106e6-c49f-4fb3-9d5a-890229636bcd@kernel.org>
 <SEYPR06MB51346AEB8BF7C7FA057180CE9DC3A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <44776060-6e76-4112-8026-1fcd73be19b8@lunn.ch>
 <SEYPR06MB5134F0CF51189317B94377C09DC3A@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB5134F0CF51189317B94377C09DC3A@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Fri, Nov 07, 2025 at 01:12:08AM +0000, Jacky Chou wrote:
> Hi Andrew
> 
> > > There are four MACs in the AST2600. In the DT bindings and DTS files,
> > > what would be the recommended way to identify which MAC is which?
> > > In version 3 of my patches, I used the aliases in the DTSI file to
> > > allow the driver to get the MAC index.
> > 
> > It is a bit ugly, but you are working around broken behaviour, so sometimes you
> > need to accept ugly. The addresses are fixed. You know
> > 1e660000 is mac0, 1e680000 is mac1, etc. Put the addresses into the driver,
> > for compatible aspeed,ast2600-mac.
> > 
> 
> I used this fixed address as MAC index in the first version of this series.
> But the other reviewer mentioned maybe there has the other better way to 
> identify index.
> https://lore.kernel.org/all/20250317095229.6f8754dd@fedora.home/
> I find the "aliase", on preparing the v2 and v3, I think it may be a way to
> do that. But I am not sure.
> So, I would like to confirm the other good way before submitting the next
> version.

The problem with alias is that it normally a board property, in the
.dts file. A board might want a different mapping, which could then
break delays.

	Andrew

