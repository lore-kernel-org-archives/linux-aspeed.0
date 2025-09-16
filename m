Return-Path: <linux-aspeed+bounces-2236-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EE1CAC592
	for <linux-aspeed@archiver.kernel.org>; Tue, 16 Sep 2025 22:05:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRGDP2fmlz2ySP;
	Wed, 17 Sep 2025 08:05:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758060325;
	cv=none; b=Pj6OpcamPIWx1ZnF0c/qTDtAd1twgDIdw1nkgDj6xoUw+9W20Wxw1XsLvqXeWcOZ/rNK1CLl6IrbXK1DeKH6SdTBPsyHlvb/cK2QxwhMNPv1tPNtmxhA6LoTFIhxF7aI+wZzeB6ahSHCntk8Ac8DKPrTyB+lLmXcrvVNeL0+Hem3pdP/QQasqC7Nkj0x2Lkz0uFtKhtMMWFHlgr/oUqU6/l3gUP2RzG1mufXaNNfxoJEQpglkdjAdTtjSQ12Pk5vD6RDhVXBZtI3cWfvgWfADVGEBNuWOnDWUVg6qFct+G5JiRQPr0ufsISLbjx0cVSgNpCHTQlaXKrIklTX2Hl8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758060325; c=relaxed/relaxed;
	bh=0NhlOmwwkbZxCW85MLAxOa0IFUPYAvjNPwpAMzd4f7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEzseTn4BRWcroGoD24u8LSGzXsPKxZW4VlK/W+L2wYM1IfpsEVnoiIj3CygS7t5Hg2USPKJnJNggg95iI8qnS5oPW/ka89M0WU6dUrihY/ieDBHw/t8cMvNEnwOq/USg/4alTdx9wIkeg2Pki9hgubfEROwbSprEpyJ1ePfQVgdL+hDh1Gd7I90PLefa5e8p5RGJU3YlaKP/vX5swcoXNrbcOBWlFrMQ6997eZh74yEdK6jPekz3Rmg2oBCDKKCl329o/5T0beD2tC1rKMcmtLIWnx+AM9cdjpoXGFATTBvMocJBZ6g/Z5pm0Y7t0gadFhbNApUvO5ATqJC7yJE6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=TmB0SquX; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=TmB0SquX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRGDN55r4z2yRZ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 08:05:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0NhlOmwwkbZxCW85MLAxOa0IFUPYAvjNPwpAMzd4f7U=; b=TmB0SquXq7T6jSiGvoN6t1GMKP
	WCDhj8wDFT/A5PtG/BREIkNIGFYYAxh0o98TF9TGgB45iejGzcgjHgrDRf8QbExubYbvnSsGTo7iM
	HkqW4BWHrciZDw7mdTmFDRUGMUNxD6s20rxchpp0SM9C518HluqC8mgPS09hTXWLXCuo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uydnP-008cU8-I7; Wed, 17 Sep 2025 00:05:07 +0200
Date: Wed, 17 Sep 2025 00:05:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rebecca Cran <rebecca@bsdio.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
Message-ID: <cc00cc74-778f-45ae-b48f-be26c91f78c7@lunn.ch>
References: <20250911051009.4044609-1-rebecca@bsdio.com>
 <20250911051009.4044609-3-rebecca@bsdio.com>
 <58a092c5-5dd0-4718-831a-e25ecb184087@lunn.ch>
 <5ccc4945-87f6-4325-b034-ca3f2f90257a@bsdio.com>
 <74e68c53-2696-4f86-97d3-c0b0a74d4669@lunn.ch>
 <92bcdac9-44b1-4fc8-892a-01ef0ed0b7e0@bsdio.com>
 <3f5e82ec-d96e-4258-b117-9876313f5402@lunn.ch>
 <e9b0d9c8-9117-4c75-93a7-1c334d823d99@bsdio.com>
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
In-Reply-To: <e9b0d9c8-9117-4c75-93a7-1c334d823d99@bsdio.com>

On Tue, Sep 16, 2025 at 03:22:04PM -0600, Rebecca Cran wrote:
> On 9/16/25 13:07, Andrew Lunn wrote:
> 
> > Now, it looks like all other aspeed-g5 boards also don't link to the
> > PHY. But the driver does seem to support adding an 'mdio' node within
> > the ethernet node, and listing the PHYs. Something like:
> > 
> >         mdio {
> >                  #address-cells = <1>;
> >                  #size-cells = <0>;
> > 
> >                  ethphy0: ethernet-phy@0 {
> >                          reg = <0>;
> >                  };
> >          };
> > 
> > And then you can add a phy-handle to point to it.
> > 
> > Then the question is, did Aspeed mess up the RGMII delays for g5? You
> > can try phy-mode = 'rgmii-id' and see if it works.
> 
> I can't get that to work, with either 'rgmii-id' or 'rgmii'.
> 
> It says "Failed to connect to phy".

That probably means i have the wrong reg value. Try 1, 2, ... 31.

Or put a printk() in phy_find_first() to print the value of addr.

	Andrew

