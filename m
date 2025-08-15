Return-Path: <linux-aspeed+bounces-1971-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD25CA0ED1
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Aug 2025 18:18:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3Vhq5GLxz3cjL;
	Sat, 16 Aug 2025 04:18:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755281883;
	cv=none; b=R7aFYY5AJ0lOYFFvC+A6ElRCD4ctto4rA+9/K2Rrz3GJKJ4aDC0+jAiz6c3fsjNl+lAh7zvJp6zhLEbAtAGcxKz3gyRiQqXOw5mMV0S9jTHoB3A9mxlMY/lA14kEMcIXhnF6elomFOl7fVjCimlizJxrPiSvU2pggaD9lXvPUbQ9A5uFGWPYzJAme3KnRMnPNmUrIftr6OeTnnQh8pkFZOqHmk2YDgq4dhV+gTpGis5zK3Kq92qFR2rqlwgIPzu99LE00rqnjSNyvodJo2MVhzr8oWonvG0OeKaNNRcQhNQ/2B7yWwmbpD/aeAm5EVyRrffUyzIdLgOKrcUF0anCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755281883; c=relaxed/relaxed;
	bh=x991MXHST0EKiSJEKhetd564OkHnAL8jVf76/MDrS0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mboyKxh/zvry7CqATOc8fYnl6LVrxRiGlvx6ZIvdUkh1Zd40ZB464NKc/oRc4hHbd4aG532MBc3bmoVO+XWxOtz1D5jQJzpixMDmeQEtZ5jk4ykXO+x/1dc+YbCuwnUwVyj6Doj2V4ryqFICbSWQf39fH+bofn+9UGkA4rkGtP6kzJfz6tR2yvNMUK96lZkkSJk70E+66TXahLyLXMoX8mm5AgDjNMYHK4yJmmJ11UJE72LMz4zo+Ifa1T8CrYqM8z30YzRpAwCkX1aCs/jRZtc7KhzONCga4Roo4KJlZFpn8rjG4v7j3r+DjgmlJd3FULvaAeaNhwF7fKTvtAAMUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=XeDhmJ4y; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=XeDhmJ4y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3Vhq10mVz3cj9
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 04:18:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=x991MXHST0EKiSJEKhetd564OkHnAL8jVf76/MDrS0c=; b=XeDhmJ4y9KKDkVdDuflrq5rn09
	L5mL6HhGn0XktAYU7n3gE40QDLQ2HzzS51Uyk61sD2QFliAjVGRBjC2aHH5+x+mbqWGvu9fWqUilP
	PFN6P/BWLU60i0PyUv3v+2ex0B4ftLx92Ab83vIpqI3OPteQ4f3sG9XgovWaSO/8S3G4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umyzl-004qln-V5; Fri, 15 Aug 2025 20:17:41 +0200
Date: Fri, 15 Aug 2025 20:17:41 +0200
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
	Po-Yu Chuang <ratbert@faraday-tech.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	taoren@meta.com, bmc-sw2@aspeedtech.com
Subject: Re: [net-next v2 3/4] ARM: dts: aspeed: ast2600evb: Add delay
 setting for MAC
Message-ID: <0f0383dd-a55b-48e6-824c-798c2a9e173e@lunn.ch>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
 <20250813063301.338851-4-jacky_chou@aspeedtech.com>
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
In-Reply-To: <20250813063301.338851-4-jacky_chou@aspeedtech.com>

> @@ -149,6 +155,9 @@ &mac2 {
>  
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_rgmii3_default>;
> +
> +	rx-internal-delay-ps = <2000>;
> +	tx-internal-delay-ps = <2000>;
>  };
>  
>  &mac3 {
> @@ -159,6 +168,9 @@ &mac3 {
>  
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_rgmii4_default>;
> +
> +	rx-internal-delay-ps = <2000>;
> +	tx-internal-delay-ps = <2000>;
>  };

Documentation/devicetree/bindings/net/ethernet-controller.yaml

# Sometimes there is a need to fine tune the delays. Often the MAC or
# PHY can perform this fine tuning. In the MAC node, the Device Tree
# properties 'rx-internal-delay-ps' and 'tx-internal-delay-ps' should
# be used to indicate fine tuning performed by the MAC. The values
# expected here are small. A value of 2000ps, i.e 2ns, and a phy-mode
# of 'rgmii' will not be accepted by Reviewers.

    Andrew

---
pw-bot: cr

