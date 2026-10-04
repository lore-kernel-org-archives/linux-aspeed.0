Return-Path: <linux-aspeed+bounces-5129-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EC1CA5FEC
	for <linux-aspeed@archiver.kernel.org>; Sun,  4 Oct 2026 21:21:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyb791gYkz2y2B;
	Mon, 05 Oct 2026 08:21:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791148901;
	cv=none; b=nFIrq5s6ZxpwHjpW30QJEbkN+spLTtF4o5RzvtNuTYtQyuz1TwTjCexUDqn2I+u0UKZfQlup9diaxmyOLZ+7UqLcbu8MWWeOsvToFadLlCosEb5ZEKF0C9heIpsgrpnmfWwlBYZg2ijTDkVgn0Ih1P8koi8nrhLfuVU/j5xrAeNuZeVr4I/tXMsE9xp0LGzrL19hWWIIBnShUbosjA/5g10akV23eBEOUrMKvliSJMsDbPikJNyKEyrw9dqttjEy+X+bjHtQviMefdX+vu7yrq573efTqAsN0uJAloOl0Wxv4flJq5SvLuBwIXhU814s4Jey2hVXdTk2N8waql64Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791148901; c=relaxed/relaxed;
	bh=iUejQ+v6arYz/jqDfYBOnzUc6H9Odh9nWzIu8FiM4MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKGK683pdRhHH4WKOJQsS+1Vvx3YnYiXJTZrq/iN/mWp1nGqmShKnCJTQcMMKqyR6h0riu8Wmoayoi65t/VIiFQUq2x/JdTiFZ0Hyd/5jBuk2rS7vjevFnIIKsKmsQl3nhzsCDMfkuilJO3qmxg1kzm9MZE7x13DAwzq3ExaXi0u+Nh5zBsFXb2wSaqk3BO8gGNB6HMdKrFtrC2rQVY0WNcEZ7T+h90jozzuazclr7esg6xu1OO9p7tMWzINiL3fJbnZmU9NVnKrfJrrPwvH9QW5W52iVIGPkIk3qu0K2dqZITZtPhDDxIhOw3Sw9481Gtr8az9Mw/6nYnhN6KmHzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=aKYofYFW; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=aKYofYFW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyb783WhBz2xwd
	for <linux-aspeed@lists.ozlabs.org>; Mon, 05 Oct 2026 08:21:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iUejQ+v6arYz/jqDfYBOnzUc6H9Odh9nWzIu8FiM4MM=; b=aKYofYFWg58gvgwIsDdSSAXOfc
	eywD5t2A0lofStpkskMl+2kuzBYUjz3jambXevnEMEOg08qy++uMVt9MZYTVmyT4bs7aCU3Fpc+YW
	ydx6kP7TeNNdmApt63uRzuYWL+FUhutho+GV7YBB0/RHes5u+MH090Tq/FC7NxwUu6dk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDTeB-008wYQ-QX; Sun, 04 Oct 2026 23:21:27 +0200
Date: Sun, 4 Oct 2026 23:21:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dawid Glazik <dawid.glazik@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	maciej.lawniczak@intel.com
Subject: Re: [PATCH 4/4] ARM: dts: aspeed: add Intel JNCRP BMC
Message-ID: <d303c2a1-f262-412f-84b5-71e27c76e7c1@lunn.ch>
References: <cover.1790344811.git.dawid.glazik@linux.intel.com>
 <bf582c24cc3222aca1b7d78a32439fd3505dfe20.1790344811.git.dawid.glazik@linux.intel.com>
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
In-Reply-To: <bf582c24cc3222aca1b7d78a32439fd3505dfe20.1790344811.git.dawid.glazik@linux.intel.com>

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

For these two nodes only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

