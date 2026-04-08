Return-Path: <linux-aspeed+bounces-3870-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC5E1073CB6
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Apr 2026 13:31:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frP925jntz2yVP;
	Wed, 08 Apr 2026 23:31:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775655078;
	cv=none; b=JkK0w20IQqsKU0czDBWTJEwzWsG6Tcww8UA2iUNp2DmAouIYel4VU0O3Yvx6t3PtKpV818M9wBoaoLlwDHRnjpQY1SvXjx6YRQkFAT1xHnxSL0CW/7VRkkItKNnb7vTuHgyTheRtiJia7x2Md3Tlgf70hxJj4vfzTT7rIkY/mTaN3ZUjmtlKJuBMNJRbDynEGDEbR7mr4i4teBuA/FSTTuh8WcaYV1w7PbGQRnaUc6P5i90m5JwAlzRPSO/U+IhP5EsOU7ZiYy2+6iQQs3e3pBMsSDtsThIpVLbekL+22Sh+pP/Ph0qfsLUo8FGeoWAflw1CRj4JStfNoN1TANoRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775655078; c=relaxed/relaxed;
	bh=H6LbHcTTP9FZbItc1diImmtUZwjMhLQ4smYNl2k6uQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSvnEkXzMWOkLzzLDs4QoCr2sPS2aXmGkOfju8uXgiI06ILPbXDGEaurjCuw0+l9Raa2rfpoN5hOr9H5dD8omgAMOwgFlyZH2bRMhJd1+7UzyZxuT9SrMnqckhV/4BBWKu6zXBn7XoCsXtVv9m2BmaGaMKr1dhDPP+Rj+o/4fUBDC6c3JMBNTu3oqfKyhgmseNmohTv7UWevEcHWhEMJgDFeUpDe/ugQmYOkyByUMuTX5AGYno2VUw4BdEpL1PlGIlzP6WuP7KtyHEEtgXo7xCP6UzqfBIRK3k3bsfTVrg/4pQGtT823RLDtuR7rD06x49il3QmSoYyP2OoWofaBIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rtN7MGYB; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rtN7MGYB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frP920GDYz2xc8;
	Wed, 08 Apr 2026 23:31:18 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7E3194452C;
	Wed,  8 Apr 2026 13:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7A3C2BC9E;
	Wed,  8 Apr 2026 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775655076;
	bh=sqUO8WthhJzcAvxM38OAUGehd9oMK+15WBmzaWNn1p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtN7MGYBrPtoBdayEGA8Bnd5JDJvLqhc+pJsd5pw0aUN5CcVQ2NLuFngCfmnH5qv0
	 iefrYkl1O+7pu18psbX3QN8D4M0iDwlJ3909aUSS3aPVNKUtF8YAB06ZiNj+G57h7X
	 EUDkawGKS+itWyQRGJCn2GDmU1bBZhnRusnH+GDjHj0JvVBlCS7LJMSfU+zpH2Vsc+
	 nZlsRiPeyTA9ygmbXB5NjRNzIRCxFmhRDmrZd6yAzzu87c5hIJ5tF2SooEn+uLHLD3
	 tfvz6+2KrpaupePD8ZBHGDPh7tHbtppsgqO6U7k05O8cKHBGKlZdzds0DfddJ35sX0
	 1M1uXixj4VREA==
Date: Wed, 8 Apr 2026 08:31:14 -0500
From: Rob Herring <robh@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Andrew Jeffery <andrew@aj.id.au>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] dt-bindings: mfd: aspeed,ast2x00-scu: Describe
 AST2700 SCU0
Message-ID: <20260408133114.GA1938858-robh@kernel.org>
References: <20260331-upstream_pinctrl-v5-0-8994f59ff367@aspeedtech.com>
 <20260331-upstream_pinctrl-v5-2-8994f59ff367@aspeedtech.com>
 <20260401-adept-zebra-of-bloom-5bb68b@quoll>
 <OSQPR06MB725204B2FAE543A71AEA52C38B51A@OSQPR06MB7252.apcprd06.prod.outlook.com>
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
In-Reply-To: <OSQPR06MB725204B2FAE543A71AEA52C38B51A@OSQPR06MB7252.apcprd06.prod.outlook.com>

On Thu, Apr 02, 2026 at 06:14:06AM +0000, Billy Tsai wrote:
> > > AST2700 consists of two interconnected SoC instances, each with its own
> > > System Control Unit (SCU). The SCU0 provides pin control, interrupt
> > > controllers, clocks, resets, and address-space mappings for the
> > > Secondary and Tertiary Service Processors (SSP and TSP).
> > >
> > > Describe the SSP/TSP address mappings using the standard
> > > memory-region and memory-region-names properties.
> > >
> > > Disallow legacy child nodes that are not present on AST2700, including
> > > p2a-control and smp-memram. The latter is unnecessary as software can
> > > access the scratch registers via the SCU syscon.
> > >
> > > Also allow the AST2700 SoC0 pin controller to be described as a child
> > > node of the SCU0, and add an example illustrating the SCU0 layout,
> > > including reserved-memory, interrupt controllers, and pinctrl.
> > >
> > > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > > ---
> > >  .../bindings/mfd/aspeed,ast2x00-scu.yaml           | 117 +++++++++++++++++++++
> > >  1 file changed, 117 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> > > index a87f31fce019..86d51389689c 100644
> > > --- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> > > +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> > > @@ -46,6 +46,9 @@ properties:
> > >    '#reset-cells':
> > >      const: 1
> > >
> > > +  memory-region: true
> > > +  memory-region-names: true
> 
> > Missing constraints. From where did you take such syntax (so I can fix
> > it)?
> 
> The intention was to constrain these properties conditionally for
> AST2700 SCU0 as done further down in the patch.
> 
> I can update the binding so that memory-region and memory-region-names
> have baseline constraints (e.g. minItems and maxItems), and then refine them in the
> conditional branches for AST2700SCU0, AST2700SCU1 and others
> 
>   memory-region:
>     minItems: 2
>     maxItems: 3
>   memory-region-names:
>     minItems: 2
>     maxItems: 3

As of this patch, you don't need that. You can just define the regions 
and names at the top-level. And the conditional schema only needs to 
disallow them for the appropriate case.

Rob

