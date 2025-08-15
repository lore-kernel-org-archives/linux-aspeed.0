Return-Path: <linux-aspeed+bounces-1972-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D176CA0ED1
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Aug 2025 18:23:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3Vq90Hykz3cjR;
	Sat, 16 Aug 2025 04:23:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755282212;
	cv=none; b=ZTrmRZPiWtGOd9aofM8hqQjnSLCT1ye+9fHswRqPqgSZm94pdCTsCrNLX5IWFQ292AVgB4KWHNQgOJucX+B57PMMnzb45Z5vI8sXFu7WsgQ0avhnyCdurihLOOhCvL062smycUXYyQl5p/JGOiTzHVV1NzLaWwAKbqXCOORZP3vEeilcMKh26m0cBaYRxXqlqnhAm5uqm8gcdCsaReJY7G12Rv98jnP0DZD174KaFRNmot6EsIZ6D1rTVIMEYBddQzZXK52LEvpqbaHA/rdi++F2aMIQQfl2CQf7jz5GLmcfhDkDvbtIRGVcosn0eDbazOGurjguZZ+vQyI8TjvtMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755282212; c=relaxed/relaxed;
	bh=wyQuAg7wHg8xPlkwj5ueliqGmECn9lBdw6/y92GmRzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ex0CtGgAN7Nxl5S4RcovfPvjatxuboBps0wrhP5exhl+x5v/HHENR2rQh15NwFcN8FmSxsKQehlyFaidV4/ijBDLwlvus/i5gD9QGb/3rNbbXWRQgRauAyR8uu0Qj/PT5RX+wjN6n5KMOKpBheVHnLUQIvnrjkg5MV0g5J63KO+oy4XcZDzDGE+a12Rix/b8QVkdCU30V2b3aqpjk36F7msI+7egA3eDQDMTJnMX46K0b2vMVlBCVZ2ca6aY7cpWd/683SfMsl5wNSdOFyKrFiMd+0gLTu9qDKXploqxbqoPpiHn1NMZjI8ou7iODm4wqAsDIxaJWujUE3nZYOpGRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=n/45N6OG; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=n/45N6OG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3Vq839xjz3cjQ
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 04:23:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wyQuAg7wHg8xPlkwj5ueliqGmECn9lBdw6/y92GmRzc=; b=n/45N6OGRV3bCfvLHGn3LmHV8A
	re3KLppUfb3uwkIiPx0oJBx9dNZAOBkoKFNLc7hUyVoOnpnuZ2/CtqrsdMTaCaGSAyhGbfcoo0sY9
	p+7kT80BQe2dJCO3YnGoF66HMv1zgjCS4AlJE5FB/++t900OV+YgnCMRga4AkXxCkxbM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umz54-004qod-Ok; Fri, 15 Aug 2025 20:23:10 +0200
Date: Fri, 15 Aug 2025 20:23:10 +0200
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
Subject: Re: [net-next v2 4/4] net: ftgmac100: Add RGMII delay configuration
 for AST2600
Message-ID: <d0948803-b1cb-4a8b-8c4d-55785d5ba39b@lunn.ch>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
 <20250813063301.338851-5-jacky_chou@aspeedtech.com>
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
In-Reply-To: <20250813063301.338851-5-jacky_chou@aspeedtech.com>

On Wed, Aug 13, 2025 at 02:33:01PM +0800, Jacky Chou wrote:
> In AST2600, the RGMII delay is configured in SCU register.
> The MAC0/1 and the MAC2/3 on AST2600 have different delay unit with
> their delay chain.
> These MACs all have the 32 stage to configure delay chain.
>       |Delay Unit|Delay Stage|TX Edge Stage|RX Edge Stage|
> ------+----------+-----------+-------------+-------------+
> MAC0/1|     45 ps|        32 |           0 |           0 |
> ------+----------+-----------+-------------+-------------+
> MAC2/3|    250 ps|        32 |           0 |          26 |
> ------+----------+-----------+-------------+-------------+
> The RX edge stage of MAC2 and MAC3 are strating from 26.

strating? 

> +static void ftgmac100_set_internal_delay(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct regmap *scu;
> +	u32 rgmii_tx_delay;
> +	u32 rgmii_rx_delay;
> +	int dly_mask;
> +	int dly_reg;
> +	int id;
> +
> +	if (!(of_device_is_compatible(np, "aspeed,ast2600-mac01") ||
> +	      of_device_is_compatible(np, "aspeed,ast2600-mac23")))
> +		return;
> +
> +	/* If lack one of them, do not configure anything */
> +	if (of_property_read_u32(np, "tx-internal-delay-ps", &rgmii_tx_delay)) {
> +		dev_warn(&pdev->dev, "failed to get tx-internal-delay-ps\n");
> +		return;
> +	}
> +	if (of_property_read_u32(np, "rx-internal-delay-ps", &rgmii_rx_delay)) {
> +		dev_warn(&pdev->dev, "failed to get tx-internal-delay-ps\n");
> +		return;
> +	}

If these properties are required, but are missing, the DT blob is
broken. Please return -EINVAL, and fail the probe.

Please make all errors in this function due to a bad DT blob fatal.

	Andrew

