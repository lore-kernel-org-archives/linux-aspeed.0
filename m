Return-Path: <linux-aspeed+bounces-712-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65A8C021A0
	for <linux-aspeed@archiver.kernel.org>; Thu, 13 Feb 2025 13:55:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YtxXb0pPmz2yNP;
	Fri, 14 Feb 2025 00:55:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739454943;
	cv=none; b=NPTN2hoPDQlV/nn1jRrKHAS5jFO5xKVHoA8THJhgnpJ8p82QZ6+fHsh9wo9rXXUk0NPRJVK2cFojk4u/2m4m9UI+Rz71J/DuL1XAiL5piK3YarVwQZgNUUluhtI7jVu9AIss0MPIPf16vo9crQEz+azvYwTpPBAAtzux5sr4Rx+54P/flkOAfNq5vidAc2moLwSUzAXxBwe8g5sn3r9sMJ1/GkUvqeSmpSyLJCAGY3ieyr4cocnDKtLOYyt29nMzXIz84FSr6NAQsfui9R6olsyu7NShRs8rH95fhrPAmijijXysOM3fQmiiHFBFEJiYmyJRbO5X5fuM7WSLD6Jjlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739454943; c=relaxed/relaxed;
	bh=iSIJAx4EpNXrVsBR/rpvqubaa9T4PDr1XsPwpgCesCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lApQFoVLith6M0LeRy/pgl2oOkLV2uFjldmppXbr3vuc8hvqtaFJ9zp4sSMcvR+EQyq0IGg/NCbYLwFt4MbcEgAF94Yk2pMEVGQjcysF6PGKBEgh0GdDBuIrFJYIyj+ALkuAq4VUaF0GsXkxtpd8N6xnSW6vz2XGg5jw5YrAkRWphHmcaxDhcEEU+ca2i1GbXEXNhI2AdLHKc/xiOcQ8DsbocJVhWde70cey/5Xnn3NLLRAtN4jRZxhLBWfNbb6Smxa/kiGfu3gPu+OwSmuxa38cytFRr/sdwVJ2I4vezWqjoZxg1+m4KCiXMmFxaoBAmnV7HP4K+o+omEWjRps+qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=gkZtbL8j; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=gkZtbL8j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtxXY1BXXz2yN3
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 00:55:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iSIJAx4EpNXrVsBR/rpvqubaa9T4PDr1XsPwpgCesCw=; b=gkZtbL8jtyFaX5I7SQPe1yOCe9
	UWSxm5Ie8L9UyWPhu5BlROG5LnnlOBATL2gTmW8b7+NvDxFwlfulajbuPd/ZwZxWER6fDYhZIDIjB
	64NFBb8/q7lqP1EXLk/fZAh5drzeQeTVYUA3BSGfq3Q8KnIUUrJv6qv5MPc1zdWHkZSw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiZgZ-00DklN-Ck; Thu, 13 Feb 2025 14:55:23 +0100
Date: Thu, 13 Feb 2025 14:55:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, joel@jms.id.au,
	richardcochran@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] soc: aspeed: Add NULL pointer check in
 aspeed_lpc_enable_snoop()
Message-ID: <2d5c9d87-abbc-4118-9031-f2c7b5c96085@lunn.ch>
References: <20250212212556.2667-1-chenyuan0y@gmail.com>
 <f649fc0f8491ab666b3c10f74e3dc18da6c20f0a.camel@codeconstruct.com.au>
 <CALGdzuoeYesmdRBG_QPW_rkFcX7v=0hsDr0iX3u5extEL5qYag@mail.gmail.com>
 <8e6c7913fda39baa50309886f9f945864301660f.camel@codeconstruct.com.au>
 <CALGdzurifZaqatjGRZGxA4FyNBHOYJdVXpKHSM4hQdA3qZtYvQ@mail.gmail.com>
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
In-Reply-To: <CALGdzurifZaqatjGRZGxA4FyNBHOYJdVXpKHSM4hQdA3qZtYvQ@mail.gmail.com>

On Wed, Feb 12, 2025 at 07:50:49PM -0600, Chenyuan Yang wrote:
> Hi Andrew,
> 
> I've drafted the following patch to address the resource cleanup issue:

Please just follow the normal procedure of submitting a patch.

	Andrew

> 
> ```
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index 9ab5ba9cf1d6..4988144aba88 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -200,11 +200,15 @@ static int aspeed_lpc_enable_snoop(struct
> aspeed_lpc_snoop *lpc_snoop,
>   lpc_snoop->chan[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
>   lpc_snoop->chan[channel].miscdev.name =
>   devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
> + if (!lpc_snoop->chan[channel].miscdev.name) {
> + rc = -ENOMEM;
> + goto free_fifo;
> + }

You were asked to first add cleanup, then fix this possible NULL
pointer dereference.

> I have a couple of questions regarding the cleanup order:
> 
> 1. Do we need to call misc_deregister() in this case, considering that
> the registration happens before return -EINVAL?
> 2. If misc_deregister() is required, is there a specific order we
> should follow when calling misc_deregister() and
> kfree(lpc_snoop->chan[channel].miscdev.name);?

As a general rule, cleanup is the opposite order to setup.

Also, you want to do some research about that devm_ means.

	Andrew

