Return-Path: <linux-aspeed+bounces-2725-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4C2CCF9E3
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Nov 2025 03:49:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0vbY0zn3z3bf2;
	Tue,  4 Nov 2025 14:49:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762228185;
	cv=none; b=mapclK+45LmVZ+KyLe72uovcB9jP0FTCSjw8LdZra9yxl2keaKISV7ufKw36Q+VFKqAgXOW94MNQZDwwYXR0v4wShehLXe2z7NB3ZqRdZ1WVKg9UrSGMT/CUX23lgw15ALvRAbBvKqDz7VJhug5jK/i/xdevyrwrKxhgWcuevMmbn35AEOoj1Budlb0buG8Pf6921ktgblb0GxoxCVqSCz7ayKu89fVZCWOjJ6FgfUxaBLs7jfj8cUQE/LIpQmgW6gguXE2L7pXoENA/q7mVedOgY7cWEfXGfo964Agd40zuOb1zFtSCeQLWScs8HHWPe3w1hlLdPn8zk7BMQitVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762228185; c=relaxed/relaxed;
	bh=KKcdMdVUcB++neaXWMBwYyImzHSwG/N24sLqEytUYkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjwAEFdaD38dX5OF5yqlsaM/p7vS/F0VV9NRMz8hgrK8g2YLCyEQamFCWuzQGU5CQJdcV+wcL3QL3w0oo1ipCFqfMRY+9idAQudw2F10uGo7WAHuwvrHgBCSojNPM8zjkSLMOmeXZvyr1N9wS0ofeydELCwxKAI2Kzgx4Mim48pRp/9T5nhjtwG5KBAd5KJLbFjlDlzvHF8leDKx0BHSt3iJsKY3wZdmcise/iucu2XnKRhs6wc09oNBTlVT00UwsTtLc1mSqJzqjccUaKXm2gAzeqNqJmczKBQpT1WhgG/puO5/8ky1mkikFBogEQbDoaTLjxHv4Wu+lCCL7xT34A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Rp/1Rkqf; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Rp/1Rkqf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0vbX0gLSz304H
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Nov 2025 14:49:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KKcdMdVUcB++neaXWMBwYyImzHSwG/N24sLqEytUYkY=; b=Rp/1RkqfFdft8wuBvYka9zL9cx
	CNK1zBVvheHgxEvgA12K3H++qoqgHv0N0at+AD4RyEfKhnKqbGYWkMoLVN2BeoJe/LRt29ANKTkNX
	hUy+7UU69/9XNJI1txi2rLjg1487X5K1IdO/TOISULFGdhupCnOuJiimTsCRY67x2Nx0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vG82j-00CqtK-Be; Tue, 04 Nov 2025 04:49:13 +0100
Date: Tue, 4 Nov 2025 04:49:13 +0100
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
Subject: Re: [PATCH net-next v3 3/4] ARM: dts: aspeed: ast2600-evb: Configure
 RGMII delay for MAC
Message-ID: <aeb33ab2-4a50-4651-8bd7-8fa2bf854c87@lunn.ch>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-3-e2af2656f7d7@aspeedtech.com>
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
In-Reply-To: <20251103-rgmii_delay_2600-v3-3-e2af2656f7d7@aspeedtech.com>

> +	scu = <&syscon>;

This property can be moved into the .dtsi file. It should not matter
if .dts files are using the old compatible, it will be ignored. But
having it in the .dtsi makes it easier to .dts files changing to the
new compatible.

	Andrew

