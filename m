Return-Path: <linux-aspeed+bounces-2744-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA4BCCFA06
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Nov 2025 13:51:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d18xh5kpSz3bf3;
	Wed,  5 Nov 2025 00:51:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762264280;
	cv=none; b=Vqse8xrmlCDPBjcFTA0fbMwO8T5ESvGHKE0xLTnBv5Kn6ZviaQNLlu98ohDCPLf2bL1/mRAJZM0bFvmcwU6850i7p972HqPvu76a659SnHs/fJ6A5lrzsvBQpa89c3AwsgVPAPLyAALPSZ6IdFM3v5qqAbVGT54l2sEf3q841kdtTvnBiY7ypS4sel94GgcClbgy4ojsMbGN8MELkMBjlMY1hhwrcFINRbrRipZJTcblbDVewyA8klX/zX9YaGtgdfKOVn64n/T3wuCSsRK1sqvdSLoKTycCy5wd+PbUQHJIFqUIff4dRo78hbw6FV711cdWt3o1MwQYX1UFVXQWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762264280; c=relaxed/relaxed;
	bh=1RoProTG9PzhyYdQtnEke6X8DcnYXk+jaxvxgzqlOOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAIdI8/XeEMqrpEqKwDzTq9IKFEUDGgZRZEVtcewEvNqQ2LLuGJWXR6ZHiTW4jfqWcOTsJvzeq2i8qoKBlYNRDsdp4+jAhhGqRufkcWtz5v4OKGTTVO7hNs/oSTlSw+VuydrKqnUea6C5Ul8eos1vaW0Onq7dCleaTZ2p69TdrZtu3k3ohJi1pXh4AJt9rTZq16jSopuapZghVCiDp2/qj3duCZgnou2b3C4K0QeoO9fUHA02rT5o1MMLdBTDJ6K8TmtS8ISKrX+C3rkth3bSdHrycRYd6KOvQ+NaWSmOX2wFrPW/htZsoviaZHEghJ4/rzaNjclvqYftXFkBYlhOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=0fVMoEM2; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=0fVMoEM2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d18xc5GHVz304H
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Nov 2025 00:51:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1RoProTG9PzhyYdQtnEke6X8DcnYXk+jaxvxgzqlOOM=; b=0fVMoEM2YIUsV39yO4/4GFCh1C
	W4SVgioyHTwO+McaUh/604S2HDExj5aRUIq2NI6OU8B1J79LrMxGrh49mMr5DR6Nb+qT7RaGc6gLl
	iuzuYrhb0OSwO6VXHp76u6bRwdoKoiAnDZe9JjVQ/aok5ME/MUIPVXT/AZvq/+R8su7I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vGHQy-00CtNF-Ri; Tue, 04 Nov 2025 14:50:52 +0100
Date: Tue, 4 Nov 2025 14:50:52 +0100
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
Subject: Re: =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5l?=
 =?utf-8?Q?xt_v3_1=2F4=5D_dt-bindings?= =?utf-8?Q?=3A?= net: ftgmac100: Add
 delay properties for AST2600
Message-ID: <eaff1dbb-b836-42b1-a9f0-715698bd0a6f@lunn.ch>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
 <cf5a3144-7b5e-479b-bfd8-3447f5f567ab@lunn.ch>
 <SEYPR06MB5134396D2CD9BD7EE47137F09DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB5134396D2CD9BD7EE47137F09DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Tue, Nov 04, 2025 at 05:22:59AM +0000, Jacky Chou wrote:
> > > diff --git
> > > a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > > b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > > index d14410018bcf..de646e7e3bca 100644
> > > --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > > +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > > @@ -19,6 +19,12 @@ properties:
> > >                - aspeed,ast2500-mac
> > >                - aspeed,ast2600-mac
> > 
> > I don't know if it is possible, but it would be good to mark aspeed,ast2600-mac
> > as deprecated.
> > 
> > I also think some comments would be good, explaining how
> > aspeed,ast2600-mac01 and aspeed,ast2600-mac23 differ from
> > aspeed,ast2600-mac, and why you should use them.
> > 
> 
> Thanks for the suggestion.
> We keep "aspeed,ast2600-mac" in the compatible list mainly for backward compatibility.
> There are already many existing device trees and systems using this string.
> Removing or deprecating it right now might break those setups.

I'm not saying remove it. I'm just saying mark it as deprecated. For
properties you add an extra attribute, e.g.

https://elixir.bootlin.com/linux/v6.17.7/source/Documentation/devicetree/bindings/net/snps,dwmac.yaml#L433

but for a compatible, i've no idea if YAML supports it. However,
snps,dwmac.yam actually places st,spear600-gmac at the end of the list
after a comment. Maybe that is the best way to do this, and in the
comment you can explain what it gets wrong and why you should not use
it.

> In the future, if someone submits a new DTS for an AST2600-based platform,
> I think they should add the new compatible string and properly describe the TX/RX delay and 
> phy-mode properties in their DTS.

Yes, i agree. It would be good if you can keep on out of for such
patches, and make review comments. I assume you will also update the
vendor documentation with this recommendation.

	Andrew

