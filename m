Return-Path: <linux-aspeed+bounces-2261-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E34FCAC59F
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Sep 2025 21:05:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRrrK2dpBz301Y;
	Thu, 18 Sep 2025 07:05:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758143105;
	cv=none; b=N2kq3aCn15R17QaJYSoA88Eo0kb2AZBQmoTrfNWqIcZyLsbbD9K5ssGOpdY/yLtnfUmHaJXZ4gKGFOFt7zUamx6eOg8vSqSENOI1hhBdVPFb8WAFSUpCUm4yrTeHRcYuJGjxFu1lQCTHGPpMBshwKJXbCAJwiS8CRdrSIabIdGDS6Z9NGhVjD/LZk8BiypP0s7z+qCyAq0TRbdtEsP3pQ4eINJXX79xFCqDHZOHMXqDyB4O4YJq3WVHW/e+ZHUBhjsixltEPOyCawR/st+SQPRiP+Y6rUh+KiJ06cNiepjEyGZ9evdNjmWl/YGf1LQGKNRhhwneuK87j5lhOVrssJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758143105; c=relaxed/relaxed;
	bh=o6w4t3UC27bwnN6JWA8ZdKSrOmat1bxK0b+u8I2fnrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cli/S6cadxfe+zkgWqZKvVQV3w/x1xlCUraItAK5Muy/8zird8qKIYLc3YughGESKBUAAcSiPZCD7sihGdVkWB05Z/l3ciyA5fK03AlZ8bSXGeXNiJLaDnAaZrI/+nF0b8LKVPri9NMS7V/bVH8aVWwVVwLZ7BMyOCEiaibfC6kpHUjY2HYRtJSjXs0P8WRzJ4qCsb4zfWlgKhBX+Z6FBqk6tLoVkLMlDUs5xUpIFgyfXtLUsmklgZRxwDvfFaOI1tCeRxpG733nNqQwxDooVLKlUUQ2pyo36lMgg50AJAVatL8Grr1mIR9pwiuz9S03eGVMBBNeWOkRVNC5Rv6hgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=jzmqQ6yI; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=jzmqQ6yI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRrrH3cwKz2yhD
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 07:05:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o6w4t3UC27bwnN6JWA8ZdKSrOmat1bxK0b+u8I2fnrs=; b=jzmqQ6yIl7UUKBiq97RnIjKZj7
	p34gFEmXC9MwDRV9+6uLT4qFjXNHIf76KL5Y84EFWs4Uce2LBIombd4RQtFq40iJbn+w9qMGhBElA
	cU4fBSc1/vemnhXbuckLVN2/RGWKQr/p3rb9O2IsS03Toq0H5cgnRB7R52igr/ntkn8o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyzKX-008jg4-51; Wed, 17 Sep 2025 23:04:45 +0200
Date: Wed, 17 Sep 2025 23:04:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rebecca Cran <rebecca@bsdio.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
Message-ID: <8b5625a5-56bf-49bc-b4cf-82c60460db65@lunn.ch>
References: <20250917180428.810751-1-rebecca@bsdio.com>
 <20250917180428.810751-3-rebecca@bsdio.com>
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
In-Reply-To: <20250917180428.810751-3-rebecca@bsdio.com>

Hi Rebecca

> +// Connected to host Intel X550 (ALTRAD8UD-1L2T) or
> +// Broadcom BCM57414 (ALTRAD8UD2-1L2Q) interface
> +&mac0 {

Thanks for the comments.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii1_default>;
> +
> +	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
> +		 <&syscon ASPEED_CLK_MAC1RCLK>;
> +	clock-names = "MACCLK", "RCLK";
> +
> +	use-ncsi;
> +
> +	nvmem-cells = <&eth0_macaddress>;
> +	nvmem-cell-names = "mac-address";
> +};
> +
> +// Connected to Realtek RTL8211E
> +&mac1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
> +
> +	nvmem-cells = <&eth1_macaddress>;
> +	nvmem-cell-names = "mac-address";
> +};

I see you did not manage to get phy-handle to work.

The problem i have is the lack of phy-mode = "rgmii-id".

Aspeed has a long history have getting phy-mode wrong. This has mainly
affected 2600, but as far as i understand, this is a 2500?

I've been pushing back on any 2600 DT using phy-mode = "rgmii". This
is 99% of the time wrong, since it indicates that the PCB has extra
long clock lines.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

What aspeed get wrong is that they configure the MAC to insert 2ns
delay. And this is hidden way, in the bootloader. As a result,
PHY_INTERFACE_MODE_RGMII gets passed to phy_connect(), when
PHY_INTERFACE_MODE_RGMII_ID should be passed. Its a case of two wrongs
combine to give a working system.

I've been pushing aspeed to clean up this mess. And to do that, i've
been rejecting DT with phy-mode = "rgmii". Most submissions has ended
up dropping ethernet support, and are now twiddling their thumbs
waiting for aspeed to cleanup the mess. Or anybody actually, there is
enough public information anybody could fix it, and probably end up
with a crate of beer/box of wine, etc.

Now, it is slightly different here. You don't have a phy-mode at
all. And all the other 2500 i looked at also don't have phy-mode
properties. You are relying on

        /* Default to RGMII. It's a gigabit part after all */
        err = of_get_phy_mode(np, &phy_intf);
        if (err)
                phy_intf = PHY_INTERFACE_MODE_RGMII;

This is equally wrong :-(

Now, there was somebody who tried getting around my push back on 2600
by simply deleting the phy-mode, and relying on this fallback code. I
said don't do that. Its just going to cause more problems when the code
gets cleaned up, and we have to remember there is an oddball platform.

At the time, i did not know 2500 was different, and none of the DTs
use phy-mode. So, i'm humming and harring. I set a precedent, no
phy-mode should get a patch rejected. But this is 2500, not 2600.

O.K. I will accept it, for 2500. Since none of the 2500 boards have
it, this is not an oddball platform. If the cleanup breaks it, it will
break all 2500 and that should get noticed pretty quickly.

So, for these two nodes only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

