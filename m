Return-Path: <linux-aspeed+bounces-143-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B772D4415E
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 Nov 2024 13:56:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xt5cr68RYz2xwH;
	Wed, 20 Nov 2024 00:56:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732024572;
	cv=none; b=D0TnRkjjjwOWf8MYx4NgOOXJskpPUA4fn2F2IWFGWFNubjEG8BjwCm4lewED3Zo1Gd42kn/u8aI1Zg17e8N/2COBGX3faed2Esi7XlZCOmApuqBUlB/2GmpnscLm1HCEN7wWKFo8IUa3MrJaeeZMJRrofKvEP2z2THnoDn8eyrEyd5OHmlirAw+m2Kvriv5WpwqB4EVsU8Bj3vXZVYvgP82JmiDLNrRJya2vVECehZH6WncjmvNpqhz9gaLdaOqTyMIhiHcLI/RZnId1c0uUOtry+T9gR4s9AudVP0fHEgV2UpCvMKIWv7iWHtcNMzAl0xyGVAcQ2J/GnikI4Unikg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732024572; c=relaxed/relaxed;
	bh=8phBlKnPGyquZpUR4CtoI5JKyG39N4jtaX8T9/dhoVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nt4uSt/6/EqAhV+ESrN/ixost3Hz9WSUEpz5GsSQH9MfHTQT2SiC3LNxxFUBoODXYRmevpB5Uk3+OWoxPWdQCNbrVuIOJmdCGLN0hflSebiNWc5k+ZSRzrKUyc8oXjq+22R209FTH8WKdEQctK6nzmZ4046cI+vSf7UbbzI8Wo+7+75DwHKphCJ6AF9g/1/wpdRwTN6+yHNqUma6VAeMtxaq5ebRtDCB8mKcZ0NJqEnVJKxNoywxWW1xQR2OkOEs15cYI/bEG2XjWhTw7DosBXjuDgA5voJMui7/Zm5rJmoociJkjrU1nMuGxJMS1lCx9YHuNiT8/DWMEOzPfWay1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Omq3yR3i; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Omq3yR3i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xt5cp5hczz2xtb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 00:56:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8phBlKnPGyquZpUR4CtoI5JKyG39N4jtaX8T9/dhoVE=; b=Omq3yR3iFFtSeRX03YohOOeDTb
	Gvg7+hksVB7P1htaGtkk6FzzVzmP3tupywqmcA63m9N43s5GhqyReBJQnh+N+x8nqk6ke8y8ERILN
	argxdK/h76qHrS1QPe1K5JU3+NV5pjuvjo9SR+lXP9m3Hg667DTYA97EPvWt2iA9tWFc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDOhu-00DoDg-Nf; Tue, 19 Nov 2024 14:55:54 +0100
Date: Tue, 19 Nov 2024 14:55:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	joel@jms.id.au, andrew@codeconstruct.com.au, f.fainelli@gmail.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: mdio: aspeed: Add dummy read for fire control
Message-ID: <27a39b05-3029-4b31-ada7-542e23e4de8b@lunn.ch>
References: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>
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
In-Reply-To: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>

On Tue, Nov 19, 2024 at 05:51:41PM +0800, Jacky Chou wrote:
> When the command bus is sometimes busy, it may cause the command is not
> arrived to MDIO controller immediately. On software, the driver issues a
> write command to the command bus does not wait for command complete and
> it returned back to code immediately. But a read command will wait for
> the data back, once a read command was back indicates the previous write
> command had arrived to controller.
> Add a dummy read to ensure triggering mdio controller before starting
> polling the status of mdio controller to avoid polling unexpected timeout.

Please have another attempt at writing the commit message.

> Fixes: a9770eac511a ("net: mdio: Move MDIO drivers into a new subdirectory")
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/net/mdio/mdio-aspeed.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
> index c2170650415c..373902d33b96 100644
> --- a/drivers/net/mdio/mdio-aspeed.c
> +++ b/drivers/net/mdio/mdio-aspeed.c
> @@ -62,6 +62,8 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8 st, u8 op, u8 phyad, u8 regad,
>  		| FIELD_PREP(ASPEED_MDIO_DATA_MIIRDATA, data);
>  
>  	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
> +	/* Add dummy read to ensure triggering mdio controller */
> +	(void)ioread32(ctx->base + ASPEED_MDIO_CTRL);

Maybe: /* Dummy read to flush previous write to controller */


    Andrew

---
pw-bot: cr

