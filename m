Return-Path: <linux-aspeed+bounces-5128-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3291CA5FEC
	for <linux-aspeed@archiver.kernel.org>; Sun,  4 Oct 2026 21:20:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyb5p5w6rz2y2B;
	Mon, 05 Oct 2026 08:20:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791148830;
	cv=none; b=WqBmj/LZwES0Ky4vWK2FkhZp7gkaGiutAO6pwxHwxTXUkSLH1YZ7LxUHE7xLdiYJ26Qi1KAP4mckTxTU851XVSBjdVI/90T0M4KZJx6Cnp8/lptb5p2fohAnIjnDMk7eXHPYf6haVCsRjanNzv/jD4yzOsQn9RQgQZ6o/HqlqNaqnU+eJiilrJlU3hi+LKI3u3AK9jQ5BEbW39lQqajgr0hzCjk+jj91NR5mqqJzrE7k+OdVQsksTiWIJY/9QlETQMBVtHvfmLMrpu4BCj3hUxcO6F+/pWucjAQrSFtFKIYca5Zg93j/jP9xOVJGC1oehrP0f2BGbzuV/V/rLflV7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791148830; c=relaxed/relaxed;
	bh=fj17ivJKl9pVttgkUPXykC072wjB1hkYn8FIT+/LeyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9lmG67l9VjcUAKEiRLFYsP4BoC+QX+RpzAuSdYPj7Q7r3HicvF6ZafUOZ2H7eh16cs7aOWIuHzGormkL9MwCUx/YddpAabpwA4OlRHdLHfVbHl5r+5SCyPytwcC1eQRjGvEnoAxLct85g61Nc44YLCpsj1NF5b0IRi/RyL2SjS+D7Z3UxU7LyI89w+Dj0LawMYVTFk0jOWOeO0eIUN8JFQEyMLPDWw6LZBPmYE6WuGASz6tft5EwjxuIkIXjwI90XJRWwUfAnKwRtPoWINMYpDZc4FvUCIhBKiIWBLNiv93TMrpGdvKUzk2ovh9ga55ijHKvn2g57NnlxbousdtuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=4wLuTMe1; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=4wLuTMe1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyb5m1dBhz2xwd
	for <linux-aspeed@lists.ozlabs.org>; Mon, 05 Oct 2026 08:20:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fj17ivJKl9pVttgkUPXykC072wjB1hkYn8FIT+/LeyI=; b=4wLuTMe1d8yvLRI010S0CAOWDM
	VA6PoB7vGuqU8PUyQoPhHLiggoc2cNtRZFZBcJIMAIoYNB7ki2wkTWXVoW0/K3nTrIFH3HOrfHOWK
	ETWMpyp9PvaI1x5F90Yftk4Z+IKvZWzEIGRpOVHIs8IFVkZJJDwXGbZF8VS7cL/KSsoc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDTcn-008wXc-HL; Sun, 04 Oct 2026 23:20:01 +0200
Date: Sun, 4 Oct 2026 23:20:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dawid Glazik <dawid.glazik@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	maciej.lawniczak@intel.com
Subject: Re: [PATCH 3/4] ARM: dts: aspeed: add Intel AVCRP BMC
Message-ID: <04355d4a-e1db-4681-bca2-43806216a7fd@lunn.ch>
References: <cover.1790344811.git.dawid.glazik@linux.intel.com>
 <9dadaaf04cae28e13057fa5d65023789f74483fb.1790344811.git.dawid.glazik@linux.intel.com>
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
In-Reply-To: <9dadaaf04cae28e13057fa5d65023789f74483fb.1790344811.git.dawid.glazik@linux.intel.com>

> +&mdio1 {
> +	status = "okay";
> +
> +	ethphy1: ethernet-phy@0 {
> +		compatible = "ethernet-phy-id001c.c916";
> +		reg = <0>;
> +		reset-gpios = <&gpio0 ASPEED_GPIO(C, 1) GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <10000>;
> +		reset-deassert-us = <50000>;
> +	};
> +};
> +
> +&mac1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii2_default>;
> +	clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>,
> +		 <&syscon ASPEED_CLK_MAC2RCLK>;
> +	clock-names = "MACCLK", "RCLK";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy1>;
> +};

Oh, wow. Somebody actually got RGMII delays correct on the first try
for an aspeed board.

For these two nodes only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

