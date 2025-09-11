Return-Path: <linux-aspeed+bounces-2209-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3634CCAC58E
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Sep 2025 14:09:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cMzw44hKHz2xnh;
	Fri, 12 Sep 2025 00:09:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757599796;
	cv=none; b=mp+dSFO7N37qB/Xr0E+wXIzkaC7R3ex8assm/Y4i0MkPzdhw1jIq3HmcBPW5lg1VGZ8+LElu80kPn/PRPwwiwMTCChnawWrV1nFx94Z8SMTwrSw26/+r6J/qBy+Z1nqAHdZ8db32qH6q0rOFGpNrRTUPpuotQUIRD5eQoWEhgOXXIKtvqvskT0NSAXPOqIy/0ZwJ9g94xdIPV7Q1VmWx31Sr4MwV6X6NwJ+nDguKr2Zyy2KfNpcyTXmQWTBtQ/Ji0Pv9qfpybDboPdIJy+bdIeBqpQNON4OL4Mb9nyfJQT5QroetHksmNHp+XTnOnpay2piIRHv3XH3q1yeGwbZ5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757599796; c=relaxed/relaxed;
	bh=UTOFlXWDRobea92uCzaSAenu3tACfKoporlUKOZNwkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgAk4XCu/raH8VHSG3w7WMweYwE5N09bYcjU5JA6UkWaLEpb16o/NQ7qh9fPaJBbU2PtomglfWC5oeuy9hMa3w40losSUAwRQEtV8Xh+kbPTZ3Vx9oDnFjF7RaSCBJKJ0/3K7JE5F2PO+5+/5gnqT8NOsrl/hJj6glPcvZJKOkUKMKayxWWLyjKV6tWSW5Mj9W2UxZdRgAXIc+N4EJMA/tnbMVi1jonOCLh6+HSqf/IX6Lsvhwvi8KlG0ppQpY7BThdmolKNoOen6SyJdITZZflY7TnblKnnWjlL74KPRT9ffV08j6bQBCIW64EungKom8/qBMB0Bdalm9loV5BihQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=zAYMqDb3; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=zAYMqDb3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cMzw23WNtz2xlM
	for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Sep 2025 00:09:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UTOFlXWDRobea92uCzaSAenu3tACfKoporlUKOZNwkA=; b=zAYMqDb3NB78c7pxSOBOHgTqCO
	zH9pcex8Gn8Bl2yKiHF1FxhZm3/Sj1cNPlYKcA2EG0Y9eCbwBx+ALxGJt498GEKlMUupshhaQK1q7
	YoLAowsS0fLwn5NeD5tOEeDYjU9XScIYzBhn5J3o4oaBGYmo/CXkfeYFWN3E1cpUEVwQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwhzS-0085aR-Vh; Thu, 11 Sep 2025 16:09:34 +0200
Date: Thu, 11 Sep 2025 16:09:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rebecca Cran <rebecca@bsdio.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
Message-ID: <58a092c5-5dd0-4718-831a-e25ecb184087@lunn.ch>
References: <20250911051009.4044609-1-rebecca@bsdio.com>
 <20250911051009.4044609-3-rebecca@bsdio.com>
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
In-Reply-To: <20250911051009.4044609-3-rebecca@bsdio.com>

> +&mac0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii1_default>;
> +	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
> +		 <&syscon ASPEED_CLK_MAC1RCLK>;
> +	clock-names = "MACCLK", "RCLK";
> +	use-ncsi;
> +
> +	nvmem-cells = <&eth0_macaddress>;
> +	nvmem-cell-names = "mac-address";
> +};

There is no phy-handle here, and no mdio node in this file. What is
the MAC connected to? Does it connect to the hosts Ethernet interface?

> +
> +&mac1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
> +
> +	nvmem-cells = <&eth1_macaddress>;
> +	nvmem-cell-names = "mac-address";
> +};

RGMII pinctrl is referenced here. This opens up the question about
RGMII delays. What is this MAC connected to?

	Andrew

