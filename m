Return-Path: <linux-aspeed+bounces-1229-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF85C3DA6D
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 May 2025 14:30:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b1xmV4nmQz3bbm;
	Wed, 21 May 2025 00:30:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747751434;
	cv=none; b=UwAGoCFgal9eU0YeUeOyesetdGFF/TToiclmF2Ul9zIX/j8+N0Zx/lippcEy/G8L/izhRst0ozZLApOZVVMr0oCzVP0ENHYRkiZDrQLnbNzxrc6c5AqEDxI/ARXBKD0ZwBLoR2SVL1If6Re3Xgk0NNcs4Pn9W1Cg9tg3Q3xmoBev3dvcTo/PkpasKahmKnLex8gfHpmUQ4XVI5C4HswSrYkpEQa7D/Wq/gncJHyI2WX0Uxe9hvLdhfBia76BiRyuNWR1RQsUhzaUuYaf0iIU/RlAackeq/Rwm1eaX8B2J4X74S575x2gIhbMo1cvxbh6gU2/Cp7erN1Vgq9TLNUl9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747751434; c=relaxed/relaxed;
	bh=60oYgzAqshuD6yLOKdWI/2Zup0hrKz6aeKRaimHYHAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNAFdnbsEpujHJRPkKv8G1fzIapTuOs+zH8flD55D9lE9kPNXevy5HlwcnGS8+bAaG9zuGJN4mhSir+9uqQ/eG3U0uFsqZ5I7T0ZUbaqZ9gdwUQkWd7620UPjycdk4fkGeVl8CveVouuXcsyrzuEgVVDje3aq4mkgRamVyNhNgI9hz2HrnJRTwS1N+PJCaRM8BQ1QxVtK18pIE9bjkFFb9fn1RFWeM+iuqvOK2GCUIF88twp4rh5lt8cJD1GSxtT5TrxA9NV7Bn2SgVuSPzSNxA+IJfxQZvm4HlP+K0A6pnvbOozI8N77wTY3U9nZUgrF3hrS2w6g4pERyiDbC8i6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=b1+f6y/q; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=b1+f6y/q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b1xmS5Fhfz2yr8
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 May 2025 00:30:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=60oYgzAqshuD6yLOKdWI/2Zup0hrKz6aeKRaimHYHAU=; b=b1+f6y/qH2058NF2o/xrWpwO2L
	8MoTZG0nKc3MTgGQfRLBEdPRafkGWEK3ijxCQ9bcpbumoeiNLv86XQr9TWXw/ZqLfeeD6OQBg83P1
	CaOiweBnQ5dCVPAv5On3ryybfKlhWBMlvWfjvQ0OfkUjmAvZBizf7FXaqJj3BJ71oYsM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uHNz0-00D8Jc-Gt; Tue, 20 May 2025 16:30:18 +0200
Date: Tue, 20 May 2025 16:30:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, BMC-SW@aspeedtech.com
Subject: Re: [net 0/4] net: ftgmac100: Add SoC reset support for RMII mode
Message-ID: <cfb44996-ad63-43cd-bbc5-07f70939d019@lunn.ch>
References: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
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
In-Reply-To: <20250520092848.531070-1-jacky_chou@aspeedtech.com>

On Tue, May 20, 2025 at 05:28:44PM +0800, Jacky Chou wrote:
> This patch series adds support for an optional reset line to the
> ftgmac100 ethernet controller, as used on Aspeed SoCs. On these SoCs,
> the internal MAC reset is not sufficient to reset the RMII interface.
> By providing a SoC-level reset via the device tree "resets" property,
> the driver can properly reset both the MAC and RMII logic, ensuring
> correct operation in RMII mode.

What tree is this for? You have net in the subject, but no Fixes:
tags?

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

