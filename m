Return-Path: <linux-aspeed+bounces-1012-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D446CC282EC
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Mar 2025 13:04:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGZtV2dgnz2ypV;
	Tue, 18 Mar 2025 00:04:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742216658;
	cv=none; b=EzBsFd6M9HHze6ZeyGvFFmr7vUnQISXrImvxALf9FF5DpsAaIn0QDYDijEY0RX4bCz4OI0Qkul8Ve4I7J5eHHcJsKi/EuWJnjoPLOHs4StX81aGBfOqUkWbOrJy7HB0mToN+WI+DWaAd9tHQw3xKtb8MRJdgVENL6/QKLBPNom/lNsxKm6bbOK+jNXnQ6WqE5GnVv5mKE8gr8y2bHnygkm9I4Sdd3qiHe+1uPd6/95aeSsuWJwILYIGiHQN27TTK4UAVP/tZMTkSZx3vxZcdMXtPbciCxFIK0OgxvKy4Ff0aVp8XBAimyHiuNLnxIM1+R7eEQ8ZUKZl/mjl0TUfQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742216658; c=relaxed/relaxed;
	bh=QQDJSZlvsPxdtXrcfxhzYY3pnuTPlN7iObJIZ09ja6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCyDrw3FeOW8ptXrEL8MrdJREq89gZAXeUvcj4/yKaLAmNTQ2scK0mrMJ9Vp0JHeEIbsfmjttgBcnBZfMKJqmglPN6E6klysspZvgvWUwjhkFA5F4BsROcyPJMXgv/s/WarzxDfGaVSQND3fwoYZELakFvTHb3KMkSsE2+S2hIABHiO9td4N5NOoDjKKdj+7tl9rT0im9qZtmq5rDZO8dqh+WTu+a0KEMopQfGT/oAUMq+on/qNYz7aePlJmYi9/oDc9KdEa3UJIl0Ny9n1W31Z0AnVofhLHI2Wc3hUi2uVurf4VGz2QjcK1f0SC/UgTUSYMAFPKu77T8jz4GBFDpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=lYp3UZUY; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=lYp3UZUY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGZtT1RFGz2ydQ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Mar 2025 00:04:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QQDJSZlvsPxdtXrcfxhzYY3pnuTPlN7iObJIZ09ja6k=; b=lYp3UZUYsynZHh9SB8+AUqn7QV
	AyCwpZ8gMkzuLmEHDZlx0CX1cJWd/yocolMKVYsRv55tey9MEQwUSpi36y3RIBZAPtPPkU3wUiSOx
	ef+YKgM+xnNz05PyqngL0J8pWFoe17d+g4PUZE99fHXCZppS+aSBCwmUiLyNxV/j14aY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuA8M-0068KE-SL; Mon, 17 Mar 2025 14:03:58 +0100
Date: Mon, 17 Mar 2025 14:03:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, ratbert@faraday-tech.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, BMC-SW@aspeedtech.com
Subject: Re: [net-next 4/4] net: ftgmac100: add RGMII delay for AST2600
Message-ID: <dc7296b2-e7aa-4cc3-9aa7-44e97ec50fc3@lunn.ch>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
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
In-Reply-To: <20250317025922.1526937-5-jacky_chou@aspeedtech.com>

> +	u32 rgmii_tx_delay, rgmii_rx_delay;
> +	u32 dly_reg, tx_dly_mask, rx_dly_mask;
> +	int tx, rx;
> +
> +	netdev = platform_get_drvdata(pdev);
> +	priv = netdev_priv(netdev);
> +
> +	tx = of_property_read_u32(np, "tx-internal-delay-ps", &rgmii_tx_delay);
> +	rx = of_property_read_u32(np, "rx-internal-delay-ps", &rgmii_rx_delay);

> +	if (!tx) {

The documentation for of_property_read_u32() says:

 * Return: 0 on success, -EINVAL if the property does not exist,
 * -ENODATA if property does not have a value, and -EOVERFLOW if the
 * property data isn't large enough.

You need to handle EINVAL different to the other errors, which are
real errors and should fail the probe.

The commit message, and probably the binding needs to document what
happens when the properties are not in the DT blob. This needs to be
part of the bigger picture of how you are going to sort out the mess
with existing .dts files listing 'rgmii' when in fact they should be
'rgmii-id'.

> +		/* Use tx-internal-delay-ps as index to configure tx delay
> +		 * into scu register.
> +		 */
> +		if (rgmii_tx_delay > 64)
> +			dev_warn(&pdev->dev, "Get invalid tx delay value");

Return EINVAL and fail the probe.

	Andrew

