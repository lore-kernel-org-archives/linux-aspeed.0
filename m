Return-Path: <linux-aspeed+bounces-1909-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C90C87FCB
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Aug 2025 03:03:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxZr54N9rz30W5;
	Wed,  6 Aug 2025 13:03:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754449429;
	cv=none; b=N27nk4u1RdHDGuTq/9ElGO0tPGPjHDbSoEM+M9EFEQUj8nAr884Vuj+lP4fB/RhTP5ozWEgYU9jpQJvuF/q4TT71SL0+tHsKa9aB4NxPL4U8GPEJvV4S2lGBHJRYbA21ib5jvF2wTchPjsCTfIxKDoY9OYFMKZSJqotlsgVuEl9xfAbOYD7acBGRIpDHwRcc3yTKelyEeKbqKRxGX+LsG3IWuh4sr5Qc/UlCJ1FD5FKVs9SDvLp+TafWDV/xWEcU/mLpg5dXXNJFIj5Hs9iPakWPgy9QWQy9SDGUKtuLmYge3mTsZ/OzXE2v5Frm6Hc8QyQ0rbXAVGL71vni4tXs4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754449429; c=relaxed/relaxed;
	bh=Tr7NN2jphfR6xHA/UzGXZWi6sl0YOUmnWotym5mZwz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7pbsH+rfLrGLnHE7FPdEkjvddCrRJf6I7fiwAh+0GFNdwuDsXSm4VCseVjZkzrUn4hCPClIe6omhahAoLYAf4jlpr5pXDOoq1rLYUQMAe9tiYNFoADERNU8EWITK+IPexQ5nRZQwvWbeqJuUcsnHWvY4JNdFj9hUXQPrZdGkxbvkwYYi+MdRTdxkONUZlcFcJFi6YgdWvvId2Pgh9dDNsA9ZUq2HoZQmp/99DPaQHWlfQUofrJ6Cqf1XkmmXR6f1O7KlVH+sgrYgd/mat0GdavnnkiCWrRYguH/DFzeHwlIK11SnMdy8mOG55hoXzgrdOOmw0wFJji9rTJq7AewAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=w+3l+Dsi; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=w+3l+Dsi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxZr26G2bz2xQ4
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Aug 2025 13:03:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Tr7NN2jphfR6xHA/UzGXZWi6sl0YOUmnWotym5mZwz4=; b=w+3l+DsiNEdtl4SdPo25MfoSwx
	6zeqoaeDGmSxgzZ9JnskLH7Dz9SULlis8/dRT0QOqH/Y1EtVKBrEC3uQEsYfEYxYKm1c3ZEDnWwk5
	DHX5iBtN23GQB1oNZdi/GBgRSA0gned3RSnZrlzpkmj1vuZxQlxck5hyU2fafIu61at4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ujUR3-003qp3-Fc; Wed, 06 Aug 2025 05:03:25 +0200
Date: Wed, 6 Aug 2025 05:03:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mo Elbadry <elbadrym@google.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rom Lemarchand <romlem@google.com>,
	William Kennington <wak@google.com>,
	Yuxiao Zhang <yuxiaozhang@google.com>,
	"wthai@nvidia.com" <wthai@nvidia.com>,
	"leohu@nvidia.com" <leohu@nvidia.com>,
	"dkodihalli@nvidia.com" <dkodihalli@nvidia.com>,
	"spuranik@nvidia.com" <spuranik@nvidia.com>
Subject: Re: [PATCH v12 3/3] clk: aspeed: add AST2700 clock driver
Message-ID: <e53edafb-bfb0-45ab-8224-7b393af4e0ad@lunn.ch>
References: <20250708052909.4145983-1-ryan_chen@aspeedtech.com>
 <20250708052909.4145983-4-ryan_chen@aspeedtech.com>
 <OS8PR06MB7541E7FCB367AE610EBBE121F249A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <CAOO6b=tEigCRXZ47BMgsTvxiZdO0P32+jFhQ313O044VALgaWA@mail.gmail.com>
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
In-Reply-To: <CAOO6b=tEigCRXZ47BMgsTvxiZdO0P32+jFhQ313O044VALgaWA@mail.gmail.com>

> > > +static const struct clk_div_table ast2700_rgmii_div_table[] = {
> > > +     { 0x0, 4 },
> > > +     { 0x1, 4 },
> > > +     { 0x2, 6 },
> > > +     { 0x3, 8 },
> > > +     { 0x4, 10 },
> > > +     { 0x5, 12 },
> > > +     { 0x6, 14 },
> > > +     { 0x7, 16 },
> > > +     { 0 }
> > > +};

> > > +     DIVIDER_CLK(SCU1_CLK_RGMII, "rgmii", soc1_hpll,
> > > +                 SCU1_CLK_SEL1, 25, 3, ast2700_rgmii_div_table),


Historically, aspeed has got RGMII delays wrong. Could you confirm
this has nothing to do with the 2ns delay needed by RGMII.

What exactly is this clock used for? RGMII needs 2.5MHz, 25MHz and
125MHz, which none of these dividers seems to provide.

	Andrew

