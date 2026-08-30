Return-Path: <linux-aspeed+bounces-4872-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B61AC61DD9
	for <linux-aspeed@archiver.kernel.org>; Sun, 30 Aug 2026 20:57:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hY4FM1XNcz2y2Z;
	Mon, 31 Aug 2026 06:57:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788123447;
	cv=none; b=Cu2TAU7Qh7PwLJWTwECfKVG+KP5BOR/tj6vYaEKInZsXameFvBGsRfBusrav6AV/6YTU0BuVclv4HdR+k0bBNIVEDIBzlJy3dgtlaWIUAxr8skN0l4bSw9coSHZ+Wd348TMyBTxqFaARrEEwD8Dqdf3C8txQmcrodhL1ngjM6xHE/WxWMbRJykGqG7dCvfXyRcIDeLgALrDkgBxdRC+jhUZOf2CcjKML9rQ2Z7n907+MWzlB1vmLOupVYwKaRkdRyXcXTU7P3uDBsw1GnyfaUK6uWegBCQ+61odyW6vGa2SKaDxeHgJvismV46BJd9ag3OlDhhkMP/jly3UIehWMPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788123447; c=relaxed/relaxed;
	bh=fvp1pXNe5TqeRLtSD0qiAJjH/t/R2XXpNq+2z1rCEXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ciun8iJ4Cb9etJiwhvAoaxg44BS3ZwzUw+aKfCLsGKTTtXEeFLC63Wk++jTVwkZU/BiqQF/xjBViuHCiUrwbvs9RbORz6ty0uXUWVKPbcjdGKFVk+E0N+Et1Ab6IDdUfmi49LRVPbVp77debeyPWjBTkSXWnf9ewyQD/Q+l4QQea/fsXb0PqtmpOU/E+KNaa6ROB0+Xrn0GuO6y5iR8vt7LHeDragHu5QUKBF+2PJsSQi12PZ1rAp6ZQ2rNx+uVpNNjpLx/f1UwTfWcwK9dWevGn8V3YNVkAPTBcSRELorIIUUkGNQ//sDNTI273Rzxw+eiyyt8TUvY68ByfBnVbaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Vjh/aTjJ; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Vjh/aTjJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
X-Greylist: delayed 2012 seconds by postgrey-1.37 at boromir; Mon, 31 Aug 2026 06:57:24 AEST
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hY4FJ6qBNz2xwN
	for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 06:57:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fvp1pXNe5TqeRLtSD0qiAJjH/t/R2XXpNq+2z1rCEXU=; b=Vjh/aTjJEGC3nFUNrV6JDgufiv
	vaTbt6Pkv5qks/+2yHr3qWO9ssIQ9iRuffyV90OaMvgiW0ifnYe2Pg7a4F03VTx/uWY9qVZHKixg0
	NV7N/++3Qslszxy654Zlsr/GEnlZhbA2RDY2mHOUyIYOH0Om434kTC0LeTFiMNnsdvrA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x0m3l-00254S-3T; Sun, 30 Aug 2026 22:23:21 +0200
Date: Sun, 30 Aug 2026 22:23:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Message-ID: <d60f234e-1b9e-44cc-9bad-da79e794fe44@lunn.ch>
References: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
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
In-Reply-To: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>

On Sun, Aug 30, 2026 at 11:50:34PM +0530, Prasanth Kumar Padarthi wrote:
> Add device tree support for the ASRock Rack B650D4U BMC, which is
> based on the ASPEED AST2600 SoC.
> 
> The series adds the board compatible and describes the BMC memory,
> SPI NOR flash layout, UART console, and MAC0 connected to an
> RTL8211F Ethernet PHY.
> 
> The MAC0 RGMII timing configuration was validated on B650D4U
> hardware. With plain "rgmii", the PHY negotiated 1000baseT/Full but
> received no valid packets and accumulated RX CRC errors. With
> "rgmii-rxid", a 5000-packet test completed with 0% packet loss and
> no RX CRC errors. "rgmii-id" was also tested successfully, but the
> additional TX delay is not required, so "rgmii-rxid" is retained.

Please take a read of:

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

Does the PCB have 2ns of delay for TX, but notR RX?

     Andrew

