Return-Path: <linux-aspeed+bounces-3056-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AC7D3B7D4
	for <linux-aspeed@archiver.kernel.org>; Sat,  6 Dec 2025 18:31:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dNxdt5pS2z2xpg;
	Sun, 07 Dec 2025 05:31:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765045874;
	cv=none; b=JiABgxQSTioXrxn/WFNr9jKBMVcMhbDQHMlHIZk3aAK3zg79jKsrETgFvEOu66aSe+TWW18YvKb0lB28GdDFY4wfOdBiy2IdKLU7ukSS5ooKpT62eG3nXg18X44FefXfJQGIYQaeAgTJFBR73HQa9JtmfgalYwFavH3EQMjF1FNxZfNUPlW0yU6uK0Zdaodl3AwyZqNFeRzGcK/0CJ6PGwx5G/lM9F6AN3NFQ+OalojOjSLRxsTr1ZHbc77Sf2ULpmjRa23H99eYZbU+lgrYKGz26r9F5Xmz7QuMrCwnnnUK0Z6wBIADRuq78pKukJu6UsAfZffUsNYvUCPOMHvo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765045874; c=relaxed/relaxed;
	bh=eR0JCfMa1hihJEB4R5UGxkldICyGNBsZvCir+nP242w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1jBVZ7D46NWNZSFO0EtJYVtKl9bG67wnP2xOSIgxI+ENaqzU6WMjxqOqeOJFXr+OQZXj1cXCHYU9Il7QmG43d98uQOhwyZteRFVsPhNU4Ge3wPcoaicHgtFx8jnQXK46bpTy6SHcM45MkThkzYU0wInVymFCUFExH4b2XRkB1x3xAqDsSGzRyEkUNPHnKIojE1hxMrlZYMXQdyxwC9iFCpm/knZ4LaY0KcaUHlQa+hhprpPuRCEVM8PG6LWBeYSh00fQsV69ktQmmoCCj3NgwxQG6DVEGM5fiAvkH6vDmfiHQGVS80OLuK/Z5mWXYtfvExqTknN1mjF6XntUvnLNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=g2JY95hL; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=g2JY95hL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dNxdq4gwVz2xS5
	for <linux-aspeed@lists.ozlabs.org>; Sun, 07 Dec 2025 05:31:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eR0JCfMa1hihJEB4R5UGxkldICyGNBsZvCir+nP242w=; b=g2JY95hL/fpCt3IAxbHjjZze1g
	NYe+DQdbIM+LqdtZJ6bhsSOOj1t9LK4k1orHdP9yjpElpPx0++/6dMKom7LZLW9UNbw4Rzh3NP6b7
	A/QYdrmOsE3D0ZhKtsm1AoL0nyT+rWiR/cQDSMVRTBLQIz07X3f4Py/fvW6jYnGbtEHw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vRx38-00GDwx-L4; Sat, 06 Dec 2025 19:30:30 +0100
Date: Sat, 6 Dec 2025 19:30:30 +0100
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
Subject: Re: [PATCH net-next v5 3/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <8a991b33-f653-4f0c-bbea-b5b3404cdfe6@lunn.ch>
References: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
 <20251205-rgmii_delay_2600-v5-3-bd2820ad3da7@aspeedtech.com>
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
In-Reply-To: <20251205-rgmii_delay_2600-v5-3-bd2820ad3da7@aspeedtech.com>

> @@ -1907,6 +2179,10 @@ static int ftgmac100_probe(struct platform_device *pdev)
>  		priv->rxdes0_edorr_mask = BIT(30);
>  		priv->txdes0_edotr_mask = BIT(30);
>  		priv->is_aspeed = true;
> +		/* Configure RGMII delay if there are the corresponding compatibles */
> +		err = ftgmac100_set_internal_delay(priv, &phy_intf);
> +		if (err)
> +			goto err_phy_connect;

Thinking forward to when you add 2700 support, i really think you need
to break the probe up into helpers for 2500 and before, 2600 and in
the future 2700. You currently have a couple of tests on the
compatible which you can reduce to one.

In fact, this driver has 10 calls to of_device_is_compatible(). I
think you should first refactor the code to list each compatible in
ftgmac100_of_match[], and add a data structure which contains an enum
of the MAC type. You can then transfer this to priv, and replace all
the of_device_is_compatible() tests to just look at the enum value.

	Andrew

