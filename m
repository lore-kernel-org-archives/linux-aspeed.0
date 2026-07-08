Return-Path: <linux-aspeed+bounces-4434-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAE1C44501
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jul 2026 16:38:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwP1T3mCsz306N;
	Thu, 09 Jul 2026 02:38:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783528733;
	cv=none; b=M23DvuJgeBKiwRdN04aT5uXXZhYVl/x7UdcZVVr2hYPqCFTCCzBPCStdzltKp5IMMOx1t2TvwgiNSooLW2Lr/OiN6WIX17qsrUsrZMExYZty1aMGhwgPyAg+HUoZUKxucDjIkZwlzhqsCLZ+MjEPTpmMgjOMO+GKOoiSwDGCR/EB5sldcJ/LaNac7eJ0C9UDpPRuKkxIDHEUK4uweRMX8qu224JaUGyBG6b/QjRwstBbC7aT5uWAI6/hBagTPyvpyVzw7gI4J6IZHlWS/5VaD5e+5ajQrka1QBfnu5bGrS5shoEIumqWH4KY0RpMOGOF2TBwykzCrgeZ1VxtWxydGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783528733; c=relaxed/relaxed;
	bh=2E/foWG+GBw4iT2amZe5GTPBRmywetPiSoahCrwoJo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpHZv0ieSs+Lgu+fhnyypZun1NfGppoAi/7ca9afpv4P+kB62Lkuz3lADPEec1LqD8NGP0XGl/O7qPUUkHL4VLbsOAfayrXr0sPBN5hFt8m6FmfM194tk82tLynQ1HYj9ucTKoVnjGdzJF1w5KGGdilcCK0tK2AhvCn5+AQ+sa/f2WdCYCvg2K/TgzyJsvea2T21aRruiQH1q4VETMSwDJebuYEiGqI2VDYMeD4E4xtLFm4LLiLq+UckKqJHLZe81jn0d23uyQOlg4jsASzIIUAi22xxLKlFEvO4GY5OidO/wixad8OO/wLGbo09HZ3xoLjzBeDzzJ2bR6w4wXG0tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Wkgdns+7; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Wkgdns+7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwP1Q6c3kz2y7r
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Jul 2026 02:38:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2E/foWG+GBw4iT2amZe5GTPBRmywetPiSoahCrwoJo4=; b=Wkgdns+7FKN/7OvfARMas0Wy62
	BvrLXWVMBmU0pX3RgmMx+CIrySrPxjAhlJTpjKvRqN4VqxaZ3pSqJrpWE+SdXHb+WWjovvCKlZ5m6
	po+/T3o6oV75Xw7XRrhHUev+RcQV0bIi7A3fAkBrlT2yLT5kr5ZLS2yfr5yVyG6tx5cg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whVHq-00BLyX-N9; Wed, 08 Jul 2026 18:38:14 +0200
Date: Wed, 8 Jul 2026 18:38:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Gr=E9goire?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk,
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com, ninad@linux.ibm.com,
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: serial: 8250: aspeed: add compatible
 string for ast2600
Message-ID: <8eb54ff0-b8ce-44e6-8251-c19e0b6773cc@lunn.ch>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <cbe59dfba231dcd55fa86233dc076b017d67463a.1783524645.git.gregoire.layet@9elements.com>
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
In-Reply-To: <cbe59dfba231dcd55fa86233dc076b017d67463a.1783524645.git.gregoire.layet@9elements.com>

> -      polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH).  Only
> -      applicable to aspeed,ast2500-vuart.
> +      polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH). Only
> +      applicable to aspeed,ast2500-vuart and aspeed,ast2600-vuart.

nitpick, if you need to respin. Don't change to two spaces to
one.

Whitespace changes distract from real changes. So it is normal to put
them in a patch of their own. In this case, i don't think it needs to
change at all. Two spaces after a . is a common style.

      Andrew

