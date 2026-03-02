Return-Path: <linux-aspeed+bounces-3578-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440FDEB362B
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Mar 2026 18:08:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPn445dHRz3bn7;
	Tue, 03 Mar 2026 05:08:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772474916;
	cv=none; b=E+5KoWWWl1iEk+4SBM7Ug6WdgW+kJzwVLDkeCbFs/cIcUkXEF3t9Ky2zo96aMkd+hKB+gV4/2MNNtwh9pW+nkTLhrqykXM2vY2vt+JBvlvkF2xfpmD4UCpPfX8Q3lY9NfTzAysZeQCmW0lz57Iejty1+9HEBS0zZUu1cLQwBaIjwIe/icqXmprVyew5LvYNPpqIW+Hprm4dul/syUBixAdxQvprR5haAD85S6cFZeq+BzTfCFmbLAuKKN5MMmCjkajlsNKLHW11xTvs12b3TUA9WRWKkPVn5c4+xVKSLQFZ3QvbAfYcxxWtop2DJwvy8ofnh8N7CpN9uC/elKgQgog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772474916; c=relaxed/relaxed;
	bh=CLPUXhVrrl5QkMzjH5mUtpnyTmkgWM8SI70aL7C8RrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8CLKaCFOKls6rWjo2Sh/KU+aFiNOxbDV8Nmm0S46SR7t7K+ssBRH/5qwLAz2AeYw3qqZCG4taGoQ76+KOjiXnhpyqkSsSc+dixdpLCREYGOt1CkIfk93GIF026GhGIpTohPIWRjxL15ovzza9rQfqf9CHT9LbgcGzsPScFdzpSnjV9l5hYAiVBEiFjij3QdIkJSDYLAf1X8JF1U7cDmzbkTbmPmIh8bho+a/aVNAeiu7tX5v058Dw9EufgZNMapg1By49AelUe8Zxw5aLsx5rGofewltzKU+RirexbTzyJjaeVfN53+4cLXe0i3Qjz2O9U463QE0b6Q0eJLXs6mXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=XRRBkTEc; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=XRRBkTEc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPn440HNMz3bn4
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Mar 2026 05:08:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CLPUXhVrrl5QkMzjH5mUtpnyTmkgWM8SI70aL7C8RrU=; b=XRRBkTEc7bDHuakd9vZCJt1Y9V
	lmFV+qXLMCNS+d3/vQGdUf6hoC3xENg1EfuBry1YYdFrL0yFAZ24Ng0TTYhcp02X0XVBKSOseFIwY
	8ACEGFnOmF/iz2Li8QsKlwljsx5Z2EgReewomye0gve3PHj2RrDE60S1OvVBNIPiEM5Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vx7gj-009idt-Cp; Mon, 02 Mar 2026 19:08:13 +0100
Date: Mon, 2 Mar 2026 19:08:13 +0100
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
Subject: Re: [PATCH net-next v6 0/5] Add AST2600 RGMII delay into ftgmac100
Message-ID: <81c7c39f-8e52-4749-9f87-0ea707114821@lunn.ch>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
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
In-Reply-To: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>

On Mon, Mar 02, 2026 at 06:24:27PM +0800, Jacky Chou wrote:
> This patch series adds support for configuring RGMII internal delays for the
> Aspeed AST2600 FTGMAC100 Ethernet MACs. It introduces new compatible strings to
> distinguish between MAC0/1 and MAC2/3, as their delay chains and configuration
> units differ.
> The device tree bindings are updated to restrict the allowed phy-mode and delay
> properties for each MAC type. Corresponding changes are made to the device tree
> source files and the FTGMAC100 driver to support the new delay configuration.
> 
> This enables precise RGMII timing configuration for AST2600-based platforms,
> improving interoperability with various PHYs

Please add more about backwards compatibility. With just a quick look,
i'm not convinced it is. So it is missing text in the commit message
and probably comments in the code explaining how it works.

    Andrew

