Return-Path: <linux-aspeed+bounces-3795-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BC610D1490
	for <linux-aspeed@archiver.kernel.org>; Sun, 29 Mar 2026 00:05:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjvmN1mTQz2yYs;
	Sun, 29 Mar 2026 11:05:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774742756;
	cv=none; b=URhJE/MVzrJ12lQ/UlLaU3BPk9zLevlYtql6P8KrbVGUtrtyHadIkz6mWlY2Gzd/S7MgWp8AMROlFAAB4E9sudFmwtlBsDp1m8joxC4hsidziD64DcwY1bSlii3Y0UN2RdAup1tpC2dHdzDNVaA+lh8dZ2cPraZbenwgrmIj9H4X/wQI/5BTefaPZ7dzluqpSrKvNYDyRabDLAr/v6Culs6c+pLmhwwPaM4RVccDqLnFx+6ZROwSv73slYxsw6l5IrGCvuqUgvdd9FKw/ERn8Ofh8yAseHoqbzPYtDlstredYciZn1raBHbvs4bHUG1tWBEjSO8V9MNMtr10K0p0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774742756; c=relaxed/relaxed;
	bh=xcjE38flg+beXCyYhvfc5FSyv3vszAeQaaEqYfMJIcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRe5NVHLlFyNPP7Bq5mm1AY+JrYyjNp61WBpFSlE3bTDfLhATrttpaovLopzKFbPrCZUAyIiN0ymKmOTAuksOn9gPhe12LOWWekMr9PKQ1VneM1B/gUKfLRvGZq4RPQrXkgKu7id31X6PNRwfmh8/XsjaAtddjK0ygI3MiLh8CZ/Ode6odbaF6ZGHgpC3ndXUgGxuO/snQ206+68qVklyQvZ8auv+cRUJMnJtM99EPBAwxtnvOFbAkRlPfosPGlQfO6UWub+E3k2K+hdIMSzNkTQ5tltnx89kHndNjCFACj+si/UaQHyB7sywJpxFBFUyXXARVgxmRUiwSS9dOqY1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=lxv/6hvb; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=lxv/6hvb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjvmK60x6z2yYK
	for <linux-aspeed@lists.ozlabs.org>; Sun, 29 Mar 2026 11:05:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xcjE38flg+beXCyYhvfc5FSyv3vszAeQaaEqYfMJIcQ=; b=lxv/6hvbzGP/4c4zEr2Q8luyNd
	xhBfyzkSNK3UwaeDM0XQhZTPo6PSZvgstOY2FjpTSHPPr7pD+ZtpA2U5i1pBHMyLUgxy0g+r4k3R3
	AdHyEp6Ln/1O9K7lvIRr0aUCkGuFvkJE7m7Jz1grPsHZVkEhCns1Gu2Zgw7Rx9ENC+Tw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w6dek-00DqEm-Fj; Sun, 29 Mar 2026 01:05:30 +0100
Date: Sun, 29 Mar 2026 01:05:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: aspeed: Enable networking for Asus Kommando
 IPMI Card
Message-ID: <ed3d39df-0a0e-427b-86cf-b9b2d2094b51@lunn.ch>
References: <20260328-asus-kommando-networking-v1-1-66d308b88536@gmail.com>
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
In-Reply-To: <20260328-asus-kommando-networking-v1-1-66d308b88536@gmail.com>

On Sat, Mar 28, 2026 at 06:39:59PM -0500, Anirudh Srinivasan wrote:
> Adds the DT nodes needed for ethernet support for Asus Kommando, with
> phy mode set to rgmii-id.
> 
> When this DT was originally added, the phy mode was set to rgmii (which
> was incorrect). It was suggested to remove networking support from the
> DT till the Aspeed networking driver was patched so that the correct phy
> mode could be used.
> 
> The discussion in [1] mentions that u-boot was inserting clk delays that
> weren't needed, which resulted in needing to set the phy mode in linux
> to rgmii incorrectly. The solution suggested there was to patch u-boot to
> no longer insert these clk delays and use rgmii-id as the phy mode for
> any future DTs added to linux.
> 
> This DT was tested with a u-boot DT modified to insert clk delays of 0
> (instead of patching u-boot itself). [2] adds a u-boot DT for this
> device (without networking) and describes how to patch it to add
> networking support. If this patched DT is used, then networking works
> with rgmii-id phy mode in both u-boot and linux.

I've been looking at

https://elixir.bootlin.com/u-boot/v2026.04-rc5/source/drivers/clk/aspeed/clk_ast2600.c

And i don't see where mac2-clk-delay is implemented. Could you point
out the code?

Thanks
	Andrew

