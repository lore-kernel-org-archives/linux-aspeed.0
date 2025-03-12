Return-Path: <linux-aspeed+bounces-982-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57560C28B28
	for <linux-aspeed@archiver.kernel.org>; Wed, 12 Mar 2025 12:12:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZCTyl6hMhz3btk;
	Wed, 12 Mar 2025 23:12:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741781535;
	cv=none; b=lPCHrY+TCjSN8HWxEgCu8/ID8P8LGU3OKXMm/ipVPO5/0UpdwJtJP6JyyswfzWo/6wX+99mYuRSDkZc9mK98Spcwehf4n2mWzT1N0AIEgOeW5G85BzcTZWkFZbySOnVaIMuZzAXFAbQzPinHgNbxXOzxu1Sq7TSNWzU+2Dz4wOqUEr+MwmLqpiKsIXkQlch64AtBkxpxN8HMixcVIac0JEeJdHSaCkVvGIqbFKieX/xXX+0QwScVX2gizD8uVTKPUHGsIoi+tWF66caem1typViqNFm3AVqm+U2c3tNQcHLR2oMgL1LC87IrhwXrBvHfTouIOXsqB1XqAG6OpUotVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741781535; c=relaxed/relaxed;
	bh=YuyUiiI7ZFuPPHGTzB32+a5/wwkD8Jfy7CZVbltjHtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US3o8vTVRvY2ZQVOo+eZMbi+3v4rE5xpdDYameMSLfuqrU8TxswDWrKaKF4ZKHmF1Tic9jtvXzGMXTA/lNac+jwZGZ4kjOBoi1P5jLcLi+pHxBtJzLw3bNEIZ6fNp4rmMly70JN/hGU8sPGYUrFo/v8bwTpXaFxS7bWtJAwA3Ff74AhzVxJy6iTaC+ctK/BKD/5d92zsHJw43erHiID5CyqPfXnC0Mu4cpNxfJAYLS9tW8GU3/oXnu7yGZoIXka0nIMjEYanWXSNVCsZ30yVS6Jp7Vcu4MfbQOyNBKd0puRrhx3ptkEu+V5CXDMW/YTAIq8JwP9fXO7mz1WI8kbl1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=eMKAcuAn; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=eMKAcuAn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZCTyj4hNHz3bmf
	for <linux-aspeed@lists.ozlabs.org>; Wed, 12 Mar 2025 23:12:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YuyUiiI7ZFuPPHGTzB32+a5/wwkD8Jfy7CZVbltjHtA=; b=eMKAcuAn2Tef46O2sREbd5JusY
	LdZ7uMoXii7OgFq2XCG/PvANlVkUthXXopVpdbVF4KS1LzveZh1HFUpIPonEMVHBAg344Ko/Mq8We
	I1yJauwZk1lslPLU35cn7dyV4rPgR19UmaU5x8cvODdxJrSF4CQFX4jok7x3mDI8j0u4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsKw8-004ebX-Q4; Wed, 12 Mar 2025 13:11:48 +0100
Date: Wed, 12 Mar 2025 13:11:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Willie Thai <wthai@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, kees@kernel.org,
	tony.luck@intel.com, gpiccoli@igalia.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, openbmc@lists.ozlabs.org,
	leohu@nvidia.com, tingkaic@nvidia.com, dkodihalli@nvidia.com,
	maryang@nvidia.com, pmenzel@molgen.mpg.de,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2] ARM: dts: aspeed: Add device tree for Nvidia's
 GB200NVL BMC
Message-ID: <9ccc845b-9392-4a37-8bca-4f54997126ce@lunn.ch>
References: <20250312045802.4115029-1-wthai@nvidia.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312045802.4115029-1-wthai@nvidia.com>

> +&mac0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy3>;
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +};

Please read the discussion again. "rgmii" is probably equally wrong as
"rgmii-rxid" you had in v1.

Please talk with Aspeed and ask them the clean up the mess they made
with RGMII delays. Until that happens, adding this node should wait.

     Andrew

