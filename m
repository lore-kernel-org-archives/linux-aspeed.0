Return-Path: <linux-aspeed+bounces-2726-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5546CCFA00
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Nov 2025 03:55:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0vkP0gssz3bf2;
	Tue,  4 Nov 2025 14:55:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762228541;
	cv=none; b=dZq01mrpTiuwZhlos3ERfhcegJ/uuKIuYGO/y4+jANmxmNX0jeHDNHnhgh6xpBHuXZ/qIQcQVnsv3L0C2ys0x0r1qSXzmsrvOrPF+85bmooJXq2k1w9ySYL41neDo+jroG9qQAziTHW9GpPpD1tgo4RgE/0BA1I4RA69UhmwyQFpOQwjKyGYyoXvsWYCKalI90v6Lbt2oa7X7FU8C2IlHx3eElKNV1+UIvHxjejKXlkbO6YQiFb6zUId7Eo682HmCNnm5FgI/MblamsyXolRx5JuOwfvPPjV/KvHwVXHb+ra8U0nxO5NgJ3AMiQrloAypFndSCcWqxW6i41PS4oXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762228541; c=relaxed/relaxed;
	bh=idHMrjalzGqAPV1VfgktusSm/NyH50rSWJqFE6LBFhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQMRfW0eCsAgAATodHe6O6SHqzRzBKAk4KMeArKK1cxJm+TZcyA6dGcnVSb81sL/pJW3r3mny2H6Casc6O2oWwGM5gg+8jOJ1lPoNfrcwyJdk2VsOMc1hEatDyk1J0dsaB7qWcuc9QesGQuj3tnwlyehu3OW4Bns6HFPmhQq+tuWmFlBQTkKXfR3idRezmDrpcGUqEPTo/7q1bLcCiAXOVA1KCFWfX6x0B8IMjzZWlD9TAd6/HpUPVOQpeyP3GJqoOxiizRmHBIQKE9+Mgq1QetCbF8K+QcgLydmPvuf792OQk1FF/HSpRVemHV38ZwYoMLXnxGXD3vhdG2gL/a/mA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=37wmGEZH; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=37wmGEZH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0vkN2gsxz304H
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Nov 2025 14:55:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=idHMrjalzGqAPV1VfgktusSm/NyH50rSWJqFE6LBFhk=; b=37wmGEZHza0JpMy6KrNjpNoaHh
	awWe9G9SC5NDk6DNekv9Zv6eOExuGGa1WVWVa8OPsi4vh4bjDVdiDTyjiHoXT0dYFerj0gctmkD4+
	KxzK8ZGzu0Sca0JELGXqozQK59V/xldtcrbJ7FashfzrGQ0eVnqpLZxP8hg4j3nSBT9o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vG88d-00CqvP-LY; Tue, 04 Nov 2025 04:55:19 +0100
Date: Tue, 4 Nov 2025 04:55:19 +0100
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
Subject: Re: [PATCH net-next v3 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <fc3f159a-0919-46d1-9fd8-8dc263391691@lunn.ch>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-4-e2af2656f7d7@aspeedtech.com>
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
In-Reply-To: <20251103-rgmii_delay_2600-v3-4-e2af2656f7d7@aspeedtech.com>

> +	rgmii_tx_delay = DIV_ROUND_CLOSEST(rgmii_tx_delay, rgmii_delay_unit);
> +	if (rgmii_tx_delay >= 32) {
> +		dev_err(&pdev->dev,
> +			"The index %u of TX delay setting is out of range\n",
> +			rgmii_tx_delay);

The index is not really interesting here, it is not something a DT
author uses. It is the delay in ps in the .dts file which is too big.

       Andrew

