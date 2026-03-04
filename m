Return-Path: <linux-aspeed+bounces-3591-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3CBEFCE37
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Mar 2026 20:16:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR3pY10K3z3bp0;
	Thu, 05 Mar 2026 07:16:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772655381;
	cv=none; b=iJGFyF+wZo2Jx+TflKrL+jD5q/JG9xnM7Y+i3NrUrqD0jPKwyzhEZU60bEeCqqzFWG/6eoAFhUGZh9rvBGOJh8YRzKwQHPC0ZKiZrjuaJYeA2Y/ffKN1oHHUH4BOGY/zc8JdnICorejk/rCRpfLVWR92agmCUW6lgt7bi8+PyTvBhNJlkDOzP7CKI7kKsEbSThXiNgEZoPoBALP3wcmw6YfX0VZdSAvrVEWqvMGXc4L6L1/SiPfFEvYaCxdY1wWgOiGlpZmFJjdnmUNDw9g41KliOYlVESnA9aPIMp6oezystltcwvakKB078q0t+6tNT2wa6ubb8aSE4X/ra7+crA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772655381; c=relaxed/relaxed;
	bh=O5W0rWNkyqIYuvm8hc/o0jT6NtzcpJClwcC+P3CAwxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EupyccQKfbFm/mrlbXiW1+NlzzOOFEsVlnxcMXLYvYV2bKUoetRolYrLBiV5CCGhBjUuk3xhfcm6M5YT9l/uy5uhbgnf8yWDVVA8/F/6Ej0hJq8H93hMoVBuSIBUxN+Oj+EYub2GTUlTj6ryTx9pVvBMAOXPuZALeh52XJ3UxaDNq3aFVe/X8VL0CMJ46hhdxlfnSDVcEL2IoEG364NJKcMmSzq/Wa7G8eqk0IqtD7eW2LRam6HbKjkJqFEOLL5q1XiJ1rDANFA417vbg3M/MiGUIUxUxsqwm9omvfT3c9/S1VzvgH50VhPOuxJ5NCI8qAutAvMKvorO1bPuOVrIwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=xYIGO1mN; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=xYIGO1mN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fR3pW0Dmdz30hq
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Mar 2026 07:16:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O5W0rWNkyqIYuvm8hc/o0jT6NtzcpJClwcC+P3CAwxA=; b=xYIGO1mN6A+vyyrQebHB5RDrjO
	Cax+vH7HBHBnKH3pJLlMqu2z+9wJ1DXp15d3kAdIEQcs/+91UX7VV7fEWMrG7q/rQzEnJ1gwRC+1t
	N7HNovYnSV6GPazhPDL+FQybwqYiogrhd9dVD54AIhVamfKzXl91omeJ5LmRa1Sv4CD0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxsdF-00AAfh-DA; Wed, 04 Mar 2026 21:15:45 +0100
Date: Wed, 4 Mar 2026 21:15:45 +0100
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
Subject: Re: =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5l?= =?utf-8?Q?xt?= v6 3/5]
 net: ftgmac100: Add RGMII delay support for AST2600
Message-ID: <8b1e64cd-b48c-43c4-a184-82a6297f273b@lunn.ch>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <20260302-rgmii_delay_2600-v6-3-68319a4c4110@aspeedtech.com>
 <ae88d56a-04c9-4a50-af22-5e439acd59c7@lunn.ch>
 <SEYPR06MB5134E02B840BA59CA81C21389D7CA@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB5134E02B840BA59CA81C21389D7CA@SEYPR06MB5134.apcprd06.prod.outlook.com>

> > > Therefore, we calculate the delay stage from the rx-internal-delay-ps
> > > of MAC2/3 to add 26. If the stage is equel to or bigger than 32, the
> > > delay stage will be mask 0x1f to get the correct setting.
> > 
> > Please return -EINVAL. Asking for more than 7.75ns is clearly broken.
> 
> ...
> 	tx_delay_index = DIV_ROUND_CLOSEST(rgmii_tx_delay, rgmii_delay_unit);
> 	if (tx_delay_index >= 32) {
> 		dev_err(dev, "The %u ps of TX delay is out of range\n",
> 			rgmii_tx_delay);
> 		return -EINVAL;
> 	}
> 
> 	rx_delay_index = DIV_ROUND_CLOSEST(rgmii_rx_delay, rgmii_delay_unit);
> 	if (rx_delay_index >= 32) {
> 		dev_err(dev, "The %u ps of RX delay is out of range\n",
> 			rgmii_rx_delay);
> 		return -EINVAL;
> 	}
> ...
> 
> These codes will calculate the ns delay to MAC delay index.
> (rgmii_delay_unit is 250 ps on MAC2/3)
> If set tx delay to 8 ns on MAC2 or MAC3, it will get index is 32.
> It is over the delay configuration range, here will return -EINVAL.

So is the comment wrong? No masking is actually done?

   Andrew

