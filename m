Return-Path: <linux-aspeed+bounces-631-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D25C02193
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Feb 2025 15:30:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YnS3v1tvYz2yb9;
	Wed,  5 Feb 2025 02:30:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738683019;
	cv=none; b=f7GNHQG2XR8IOkvi1i3fDfMGzOgLlRTjdCFvQLXYZG6sWewBC++VblSvR2luv03/RlROP+lqKVRoFQA45ySMXgv2zTASSXIfWtRL5gci+wl8YdUBGm8qDgzryCqvR4aQdRL/xpKdYUNrThWK+I56pzA3pVqpZnePuelCdhHMItYUyRCkuP/2pk1NlKXyCRJVSvV/cJase2I/KXElilmgjcmFu/7FTtwnRx4r0bCHhwYRLyVnMEjTChhhi/xmN+n5BMpOy5pQ1LdlrXI/YEcDZ+PENXwF26WAQdQQNlxKG/n+yJ+9Pwf1nJzieK7mjXUmEDzvSgtaCRmJ2siPUaDXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738683019; c=relaxed/relaxed;
	bh=hBpyFZ1CZQePd+pfRsZccI2jC1/RRRZX9WNFjxxNtPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNjpU7V4ekoWoD3Be9x8zWSsozuM6GQxKWQbgBWpqfTOwpNxGmk/2qMg5GdpJRwPDIOSMaNsiwsMSIkYjsJ501v6kYRebcpfChS4icG8i4yMCaRUwk3GtcRifMHzLwctZfrbrRukgPFs80aM7VK4cSCvrU853KNaCQ2k18A3iSf5X3gWJn7Z9dGPdoO+WVUSAARrLHi0vmTek24ItEF8zTUGOakibwZdZNDLwywvWf/bFF7PJVwMZNqjSXGm8g8Ct6VctBtMchY+GwenzaqExO79hDMZXxv/iGsRtiHSBExPbxCluq+73GHEYRsO4R6hodzM4DRTCapKQM1+5Nwtsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rxFt1+76; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rxFt1+76;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YnS3t1Y1Bz2xVq
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Feb 2025 02:30:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3E8B5A428E6;
	Tue,  4 Feb 2025 15:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F517C4CEE2;
	Tue,  4 Feb 2025 15:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738683014;
	bh=w12EPpGUmvzDudWzppT/O+ACvWWy08Cbo3XC+tGv3iY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rxFt1+76LToM21A8s0ynlnAIwt78hr6Di4Rj31ycjaxNsQldtEz4HGEKhDCpZBIoU
	 Xq7Uyz1X4dOfpnShEge2okV+AlHBJXtcWuP46mvOedK7nxngJBLhC9mfqClLlHO4AK
	 m+iBiNjJZnet6vZuKO6jTDzRyc/CYRlBuu40fbiQTidRQ+FjMq4imH0KziZHiC07Vs
	 yHXFoZLweaKE9xL0bnUKC6Uai0BGtZPAOhRb+gLgYbIyPKjDVAV9MTomKE5Jk+0r3r
	 Z1Ki34lpSJDD3f7NpPDeqiev2aYna2qG+7mqi/vzbvodKXpJ1+Z96jQ2BaoarLuvEX
	 +0olbUxhCUEmw==
Date: Tue, 4 Feb 2025 07:30:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, qat-linux@intel.com,
 linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Johannes
 Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
Message-ID: <20250204073011.5f6ca125@kernel.org>
In-Reply-To: <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>
References: <cover.1738329458.git.geert+renesas@glider.be>
	<1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
	<e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Feb 2025 17:26:04 +0900 Vincent Mailhol wrote:
> On 31/01/2025 at 22:46, Geert Uytterhoeven wrote:
> > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > constants.  However, it is very common to prepare or extract bitfield
> > elements where the bitfield mask is not a compile-time constant.  
> 
> Why is it that the existing FIELD_{GET,PREP}() macros must be limited to
> compile time constants?

Hard no, some high performance networking drivers use this on 
the fastpath. We want to make sure that the compiler doesn't
do anything stupid, and decomposes the masks at build time.

The macros work just fine for a *lot* of code:

$ git grep -E 'FIELD_(PREP|GET)\(' | wc -l
22407

BTW aren't u32_get_bits(), u32_replace_bits() etc. not what 
you need in the first place? I think people don't know about
those, with all due respect the way they are coded up looks 
like an IOCCC submission..

