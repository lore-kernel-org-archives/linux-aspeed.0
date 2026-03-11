Return-Path: <linux-aspeed+bounces-3646-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC671125875
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Mar 2026 19:49:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWLtl1knKz3cCK;
	Thu, 12 Mar 2026 06:49:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773258591;
	cv=none; b=OQRFbF8e2Nbtng95u79MdlUKqSgs5L8aaEnD4V90WezJGaBl2RUptWaI9AAWaORyp3p3x+/PoIElTEdrF2kalj1uiP02Wng7n3F4ojmN+FrHOYDP22cL7bYUg35k2i+nssviHtPdCkCM/DPFklecERtn0024K6nGyGPqnQMQt8mEsZ0OVWp7/XDEZFmqx/hJjl2nxmvNNPb9gM6CuM/MTYtq9gH2G30sGfm1Fz+xPE7l/lMVnfx+SZ7VATwQxKMwrTXe8rXYfk0oT0T/OR8/74tGJ1BrcPCU6QvrsymCTAfbZkUZgRHaeMldiWqGBRl22mwv4BJNkXizhyeYwnpn2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773258591; c=relaxed/relaxed;
	bh=BL70AeZN9UK2m7sj41DcGvsRBuEFD6s19+k/6cH7f7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YE9XxHFxTPp3TR1rs6tKTFLyP+H1XPCKiuPheLecKXOuFM1KvMlKVBOsK83/P5zOg1bLh6wO8zd5q6L0TZjogb/BP0cQN65UwFBcQi5SzUJ7CsBQdE218De/3Q0SAyilWh2DxO+NJXANPTDsXQ6tBEyK5fUcQDmEtGlv+6RzDDEMaP/SXlwIkvn5z8HdngtKN06XxCdXL9EHcHYfNa/DAba7dt87fu68rXkYGHxBLzWAavF1ZuGLfv2molfYF8U9IfyOpfWVwoWoT7JBHq6PrOTDKlUp4JQOgNkHfAzhXvYQWnx0vKLEVqNyyAdwn/3ARsRXrtjTQuyU+0/cZjWWQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=5J99swfh; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=5J99swfh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWLtk2WZrz303F
	for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Mar 2026 06:49:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BL70AeZN9UK2m7sj41DcGvsRBuEFD6s19+k/6cH7f7g=; b=5J99swfhm2ay0BaMoydJFYnjjn
	3ByWBx6Q6qo0wbdoP74koAHuUCqF1nZBJ6dNS5TdxyvQ1mRTFYN6ormC/47L3mWGLYfzwza1ybRvU
	ZMr6eLRzSIqZIJw7/GBVpE4Cvv887GaRfSjEaMtJsRiX84NixG8ghwA+mBYC4rfz/vz4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w0PYi-00BELU-Ej; Wed, 11 Mar 2026 20:49:32 +0100
Date: Wed, 11 Mar 2026 20:49:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>,
	Mike Hsieh <Mike_Hsieh@quantatw.com>,
	Potin Lai <potin.lai@quantatw.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Add Meta SanMiguel BMC
Message-ID: <368b7c5d-6a28-4eb7-9b58-9f2a63443af1@lunn.ch>
References: <20260311-sanmiguel_init_dts-v3-0-2b4d1ab7a8a1@gmail.com>
 <20260311-sanmiguel_init_dts-v3-2-2b4d1ab7a8a1@gmail.com>
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
In-Reply-To: <20260311-sanmiguel_init_dts-v3-2-2b4d1ab7a8a1@gmail.com>

> +&mdio0 {
> +	status = "okay";
> +	ethphy0: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&mac0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy0>;
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +};

For this only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

