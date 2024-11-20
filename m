Return-Path: <linux-aspeed+bounces-152-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D0ED60D17
	for <linux-aspeed@archiver.kernel.org>; Wed, 20 Nov 2024 09:51:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xtc7j1Slzz2yRC;
	Wed, 20 Nov 2024 20:51:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4d48:ad52:32c8:5054:ff:fe00:142"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732096273;
	cv=none; b=RNNfB757ZKZLPgDmpNZHtuvCI7ChJaXosP1t4SGH9VhKlLx955emEs7xVl5PMPhNN1bOj1bhlp0M62nX/NPYmf3OcTKWSq4ojNCMsw/bOPe2YqgZoV7b2IpHRRP9VHQEp25M1YA1ZC3lQ3FVxcsiT6WwH6pZii8xX8GuQv4AShg7Vj1taSihgQYOaWIy8nK4JLG57c3m91QIo0q45Qijk6PPQ8+DpoJ+bXFO13WFgyVpcRAmzGNyinUD5fKHX2FsS1WN0MY1rb/cB30RcIOESdrY0zFcfylj6NN3kRklnz6Y/6CQptjEIkv3h8ENpL3MNLE3eFnd6RzYdlrHLBsdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732096273; c=relaxed/relaxed;
	bh=kZTawVyREwEbEOOkp3Rqm/v6gSKb/kMRQbLscX9yHuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daoUE6WKQXHAInvCRB0aiIrb6WZk51BO7LoASVSJ9gUX1S/l/gxP6Fv9C4+YFg/JV29AtoHD2N6Yd4I+c6qA38GuNP1gqLqOdxx987OqhuH5y8pqUqpPcXyueSTg/4HVRx0XjMoCsjZweE8nBP3R5VjbLkVX/LVcO+TFkQpJ+9Qu5DWL/03Allvlo9KZM50Xb8PpMljn2v5la8aXgCVfgAUYZy4/I6A/2Alot6p2Qdg+7j9zqSzGxUZGs3RKJT/CED8inMv1A9t6Ty3swZcizEsSWWfjlTsTwf0yyUq+k7R9qB1La1169tFSrc+LATb+in0BmRJk8R2FzAlTzhwZcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; dkim=pass (2048-bit key; secure) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=igZMxffb; dkim-atps=neutral; spf=none (client-ip=2001:4d48:ad52:32c8:5054:ff:fe00:142; helo=pandora.armlinux.org.uk; envelope-from=linux+linux-aspeed=lists.ozlabs.org@armlinux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=armlinux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=igZMxffb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=armlinux.org.uk (client-ip=2001:4d48:ad52:32c8:5054:ff:fe00:142; helo=pandora.armlinux.org.uk; envelope-from=linux+linux-aspeed=lists.ozlabs.org@armlinux.org.uk; receiver=lists.ozlabs.org)
X-Greylist: delayed 458 seconds by postgrey-1.37 at boromir; Wed, 20 Nov 2024 20:51:08 AEDT
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xtc7c4DBfz2xsM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 20:51:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kZTawVyREwEbEOOkp3Rqm/v6gSKb/kMRQbLscX9yHuw=; b=igZMxffbTRUyD8L+1EoUfrdzky
	RSCaES81zeNcd2+z6BGEANUnUTKU4IfjdGt+u85jLekbR7U1rsHoncYLr4zg5cR1nKwjoKFdG6/ZC
	Qx1umwuHGU1wHui6vx5IHTK9UBcFgRWsI0n1SAEWTnn1X1jXAcTFRL0C5pnH9XXUKpIfyWrRfpzry
	66FUMXQBG2L1hvu0eYY+ZzUPvAe1h6j3tzVaDsT7lFo+FrDcVo3WgPrkzuiMEfWkTrd001NvRabRJ
	Ewjn/XKISUqt3m0EGepTbsEloWWyFSGQBTDbYsE57tavrghZxu5A4lu+kEOy8NcKfOSmKvCWETIyW
	oYTXeekg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41692)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tDhEg-0005D4-0P;
	Wed, 20 Nov 2024 09:42:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tDhEb-0006zB-1H;
	Wed, 20 Nov 2024 09:42:53 +0000
Date: Wed, 20 Nov 2024 09:42:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	joel@jms.id.au, andrew@codeconstruct.com.au, f.fainelli@gmail.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: mdio: aspeed: Add dummy read for fire control
Message-ID: <Zz2vHWLYTRKIG7GK@shell.armlinux.org.uk>
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
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 19, 2024 at 05:51:41PM +0800, Jacky Chou wrote:
> When the command bus is sometimes busy, it may cause the command is not
> arrived to MDIO controller immediately. On software, the driver issues a
> write command to the command bus does not wait for command complete and
> it returned back to code immediately. But a read command will wait for
> the data back, once a read command was back indicates the previous write
> command had arrived to controller.
> Add a dummy read to ensure triggering mdio controller before starting
> polling the status of mdio controller to avoid polling unexpected timeout.
> 
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

I'd change that comment to:

	/* The above write could be posted, causing the timeout below to
	 * be inaccurate. Ensure the controller starts before we start the
	 * timeout.
	 */

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

