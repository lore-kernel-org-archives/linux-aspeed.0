Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C409606A330
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 01:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mySf9XVQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPRMl12mHz2xBb;
	Wed, 11 Nov 2026 12:51:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794361907;
	cv=none; b=Ag8anBFElRbVGcS1Hzv1/LK+SFg5/lo/MUqmTFEKfFL3LTfPrWlKnwibyKZuWtc3EywW7IYlN5I+kVMgHz+ifm2KQjfiYCHhOUUHsRKc0q/ajXK8ffJSf6Yj8rxd8iFktgbNpAz1+FdHnW89xsnelx0WbOxIJLQcIYNJkJduwHrSEe3oFgmluL+yngTP0d403eyZJ47Kqe41iAsap6xqLOFUU9zXGCTJGLFfC6E3bmtauqoVaXM7xiO1NDgeAvoPYMUtAtc8T2/rtXFhJaRYYXzEjtD0IK2guPoGxY8cluswSIQRIeyfGYCABzd7h4KiLS0ovR1wFouVf04l7uaZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794361907; c=relaxed/relaxed;
	bh=OJWRJnqwXadUVsht/Q2DFEwLV7TOry8KzPZeVNhA4yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSzBF8s8tDyRFmTmZy3zzdStkcxHn1cRoOOM8OasOQNBskyN8BzweDoiKmXR8ihaJKuwpCR0DXf3iZCH9DBly+aJ6LHfAfrwMZ7tTc+FJasi5jLJ7Eop1TpBRshAp3PjV7tgTXDQ712hOCkMA85B+oT+NEVylUFykzvbuNX5r929rw+beWf15agUn2oO/EGQuNvi2WpTY4LK/Jqf/3q2ZpNudbbPQoj09yWWscjXjP5vSuPRzd+94n9MLaZEzrc7LclmoRr23aLzeiB583f6HKrSfG8ZFn+D6SE8c3p49Mk3qDR+jLLvoZgo7B1Mc6g8rEJ/P0I7vESEG1Z20SxuJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mySf9XVQ; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mySf9XVQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPRMj0MSlz2xBK;
	Wed, 11 Nov 2026 12:51:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OJWRJnqwXadUVsht/Q2DFEwLV7TOry8KzPZeVNhA4yo=; b=mySf9XVQwFmioK8Lp43oGmhZHA
	PkxEtdO4+vINJ69AxBvKVEduIJnYfS1bUcQ8f2rFTNMH45FEyMBww/bgNLceL29jAyC1jKiQimM/O
	eXC49pMGyYtrGwsqi3aoC4HaDpEMGPgjYEffWO9GNmftYwnsrsC5gxN+iurYCpieVpiU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQxUe-00FcwI-AE; Wed, 11 Nov 2026 02:51:20 +0100
Date: Wed, 11 Nov 2026 02:51:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Huang <jackyhuang@nvidia.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>, devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC
Message-ID: <9e83c1b9-0bfa-4a37-8253-3740dd7d0b62@lunn.ch>
References: <cover.1793705210.git.jackyhuang@nvidia.com>
 <70b7dd4c538ce72a2caf3b4420af3889e9b2dab7.1793705210.git.jackyhuang@nvidia.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70b7dd4c538ce72a2caf3b4420af3889e9b2dab7.1793705210.git.jackyhuang@nvidia.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> +/*
> + * On-board PHY uses RX and TX RGMII internal delays
> + * so phy-mode is rgmii-id
> + */

This comment is not really correct.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287


> +&mac0 {
> +	phy-handle = <&ethphy0>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +/* NCSI MAC */
> +&mac2 {
> +	phy-mode = "rmii";
> +	pinctrl-0 = <&pinctrl_rmii3_default>;
> +	pinctrl-names = "default";
> +	use-ncsi;
> +
> +	status = "okay";
> +};
> +
> +/* MDIO for schematic MAC1 PHY */
> +&mdio0 {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};

But these nodes themselves are O.K.

    Andrew

