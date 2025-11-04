Return-Path: <linux-aspeed+bounces-2743-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324ACCCF9E3
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Nov 2025 13:41:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d18jv32Dhz3bf3;
	Wed,  5 Nov 2025 00:41:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762263667;
	cv=none; b=oWOjvzss4t0v3fVKhN6xJx0XMqS+Ihhzi3OapBLM/IpJPfoIbhLBWQvUoOZXs21tLl5QT/1dyajC5WufNfQ3trgNbIOvqL/+oxlY+0dt26wEanxZtBIdbRxIpo/PZep20cPFcvghXQqwXzzGvat2N3Wa7afFrnueHPjd7EEOSTPHJT8RI4Pma8Hkzj28pemEUa5AgzZTm5q4qSDze0B3eAc9o4JA7w1cN4+rw/V5875Ype0PKyPep2ltk5mn8Wm+H6AxwFzunL7c38s9sXF7/cIQmjn7lgGwyH1m+M1fkGrfGp0KniutF66YW65iIHI7ROyXavJqSMIZrDa7odugUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762263667; c=relaxed/relaxed;
	bh=ITCLqcPKdtMfzHDn3f1hMx+q58ZaP4E+ZYDldEc3toE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YecRpEzRGTOXdnol5y+Xk0J/lOYDbplsRkhQ1Kzax3+fhpSKoK4rhVRWEwmbPrTZesjMQtRiOJm7TB6GQgqdkWM0NGdh85p6KuCtDPI3h94Vn5vGJaDbS90eNMyCtWwUD2f2r/1fAoYINovIr6Xid8N6e3RGj+MNSPV7fcCfPR1NCbQ4AeDa9zA6cltcxNCOoz7u8vQQEId2+3P2Zk/Mu9eyikEVrYN51/Aqa24m9icD/KYyqREHwUS4x1TC1aDAJcdSiqIXS/Z6WH5lWuoqs1xCqp6h35Ifske+/dsAZmmpbvmMyRCbvBIyiW1RhqEdwKXLCwfUIxMRAUJRy9PSxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=y6KWc+d1; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=y6KWc+d1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d18jq0MCKz304H
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Nov 2025 00:41:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ITCLqcPKdtMfzHDn3f1hMx+q58ZaP4E+ZYDldEc3toE=; b=y6KWc+d1T0EMoGe0Uz8xFsN4wG
	Hlk1wADkucu+s+tHZWPnOVCGTF2eItOAjrhVLD3QdPb5iAThErckAfFf4rZJdIe3i26+IzHZy7IiV
	wGBMJUlRL0FiD9UZoZfhBArAmMCJDIV71TCE6UEZVmbXZMAVSw2X6IEm0YKhLRidusVc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vGHGu-00CtIS-V1; Tue, 04 Nov 2025 14:40:28 +0100
Date: Tue, 4 Nov 2025 14:40:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
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
Message-ID: <d7b08607-73a3-4f6b-ab8b-3eb4ff8b8647@lunn.ch>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
 <2424e7e9-8eef-43f4-88aa-054413ca63fe@lunn.ch>
 <SEYPR06MB5134AB242733717317AAEDEA9DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB5134AB242733717317AAEDEA9DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Tue, Nov 04, 2025 at 05:14:41AM +0000, Jacky Chou wrote:
> Hi Andrew,
> 
> Thank you for your reply.
> 
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: aspeed,ast2600-mac01
> > > +    then:
> > > +      properties:
> > > +        rx-internal-delay-ps:
> > > +          minimum: 0
> > > +          maximum: 1395
> > > +          multipleOf: 45
> > 
> > I would add a default: 0
> > 
> 
> Agreed.
> I will add it in next version.
> 
> > > +        tx-internal-delay-ps:
> > > +          minimum: 0
> > > +          maximum: 1395
> > > +          multipleOf: 45
> > 
> > and also here.
> > 
> 
> Agreed.
> 
> > > +      required:
> > > +        - scu
> > > +        - rx-internal-delay-ps
> > > +        - tx-internal-delay-ps
> > 
> > and then these are not required, but optional.
> > 
> 
> Configure the tx/rx delay in the scu register.
> At least, the scu handle must be required.

Sorry, i was unclear. By says 'and then', i was trying to chain it to
the previous comment, that the delays should default to 0. With
defaults set, rx-internal-delay-ps and tx-internal-delay-ps become
optional. I agree scu is required.

> Here I have one question.
> In v3 patches series, if the ftgmac driver cannot find one of 
> tx-internal-delay-ps and rx-internal-delay-ps, it will return error in probe 
> stage.
> If here is optional, does it means that just add warning and not return error when
> lack one of them and use the default to configure? Or not configure tx/rx delay just
> return success in probe stage?

Once you add the default statement, it is clear what delay should be
added if they property is not listed, 0. No warning is needed.

What you should find in the end is that most boards just set the new
compatible and 'rgmii-id', and need nothing else. Only badly designed
boards tend to need tx-internal-delay-ps and rx-internal-delay-ps.

	Andrew

