Return-Path: <linux-aspeed+bounces-2859-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29453CCFA13
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Nov 2025 15:35:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4tzC2W1Jz2xqh;
	Tue, 11 Nov 2025 02:35:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762788935;
	cv=none; b=ne7LrE9k44PXqzohFMR2yg9mOZIDyfx96PxzLIJtwPoPdLoLGoxQixIVgK5CHZo59WglbjWb5P+Crkdcy2HfgP8gV1kv1I/g5oDuKvFd6yA8o8Fg/dReK5LQO0F0cD4RULBC1TLLbF6Ei46qQNjFzsGceVs04oJs52BRv+pZu2ZYJY+qlhJOOMQc3ifVRAJavYHEX+F+a6xg7C6LIJ3eKflbILi4BULI+cL2O44ZIKG2Fh5llHiLjCFo7gOs6hAg5x/WIGUnZluaGSxOrxTAuNegPUj0E7YKIrZljnCrS38SXi3t8kf1RKuTt4OmZvt8X2f37jaoWKZu3s45aV1PEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762788935; c=relaxed/relaxed;
	bh=01rfLZwpM4pmMKU3kqbEEzw3i2BzLBr0hbB6YkfV3no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9g3qvNb3siZN/QVrEBUk2IOkwLNBhDf+ZtJFHtyWZOT2XL3WapHOZj9wXrzlr9ewxreJUTjfQ1lEGjNPKeQDhxVNgKEenbibF0ef9gCZvvwp3qVf9R+5wfluhNFroZurmwGIoG3GIrZeAHWokS5D0DEEkVOExOWGYF+K03LQI2gepP+RNZVrk6mJe4QQLzPQlIsx5yhK19XO5y3nirLPmlUEt8jRQCJFGL/THuwkcS05+/C+VEHKAejdFvIMj+ZzNbf0eNVNaU2srnWgcwhW2IrNy4BuH8NpXsGYABkaHP0ig6+pz1lqUQFdujbokbSD8Hyv1ieKqli37JPu5TdhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=B0vBeX50; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=B0vBeX50;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4tzB421mz2xqZ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 11 Nov 2025 02:35:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=01rfLZwpM4pmMKU3kqbEEzw3i2BzLBr0hbB6YkfV3no=; b=B0vBeX50L5XIgkqjrniD4kQSsI
	sbc+Q3WoA0Z19I03hXsGH6xMRB6yrOs2MvmnCW9nxDEe+IvAzmQts2rvB0n+uCUWjToSn28T/4WH4
	O/jWqx8JNxLcvgL+fV9SkJhzTrr6bXtzXXOwU1KVkOKIvxJjUg8lIHcD16tWYd9XzuQU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vITvF-00DX7o-GK; Mon, 10 Nov 2025 16:35:13 +0100
Date: Mon, 10 Nov 2025 16:35:13 +0100
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
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
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
In-Reply-To: <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>

> +	/* Add a warning to notify the existed dts based on AST2600. It is
> +	 * recommended to update the dts to add the rx/tx-internal-delay-ps to
> +	 * specify the RGMII delay and we recommend using the "rgmii-id" for
> +	 * phy-mode property to tell the PHY enables TX/RX internal delay and
> +	 * add the corresponding rx/tx-internal-delay-ps properties.
> +	 */

I would not say that exactly. Normally you don't need
rx/tx-internal-delay-ps. It is only requires for badly designed boards
where the designer did not correctly balance the line lengths.  So i
would word this such that it is recommended to use "rgmii-id", and if
necessary, add small "rx/tx-internal-delay-ps" values.

> +	scu = syscon_regmap_lookup_by_phandle(np, "aspeed,scu");
> +	if (IS_ERR(scu)) {
> +		dev_err(dev, "failed to get aspeed,scu");
> +		return PTR_ERR(scu);
> +	}

This is an optional property. If it does not exist, you have an old DT
blob. It is not an error. So you need to do different things depending
on what the error code is. If it does not exist, just return 0 and
leave the hardware alone. If it is some other error report it, and
abort the probe.

> +
> +	ret = of_property_read_u32(np, "aspeed,rgmii-delay-ps",
> +				   &rgmii_delay_unit);
> +	if (ret) {
> +		dev_err(dev, "failed to get aspeed,rgmii-delay-ps value\n");
> +		return -EINVAL;
> +	}

Again, optional.

	Andrew

