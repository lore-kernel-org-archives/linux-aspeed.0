Return-Path: <linux-aspeed+bounces-139-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D815D60D0A
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 Nov 2024 01:52:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XsnYl6Hc2z30JH;
	Tue, 19 Nov 2024 12:52:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731981147;
	cv=none; b=hSk/By4gEBn6EgPdaO/nPIeWfRfyTk0zZv7p4hV+NchVqI9xaeixE9de2D82CXL1KQ8WwBd/wdNPh4OFm/ZGGlX2C6w5fv+v4QHxn25CCmFZ7Y9SCGknkkMJO3e3dVSx9O9zJbwdLl8nvyRK5Dr3tGbaZLgBjDtd6vvXh05+M90fainhbSyZn5ZrF8yzXRza+JQQcJb9vDb46i7AAMcmiz9Ai1G+pZXAZ/typ74TsUjjFG9SqMkX+gRemTGp1BxIv/MjgHKM5AncQR7uOYBhJ81vmKVFBZ54PgYvHE8xJpfV94aAaMovslbNAa5oPSBTcUz2+ShkRa6r08KsiPikPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731981147; c=relaxed/relaxed;
	bh=SxM76o8BGy53AtlOJoitl7JV8kJz7mesTX75V2BZ4D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krdkle9FOgn+7YRxdbFh6rCrQIHEgC3bjAp+qVu3h11gKQgRuHtnnYHj/nEuDvltP692s9XEYornrcFAbV2c0g94/h8LOnFSThx/B07ax+vfij4rDqK2Vo6zsZwghM/QOwVsVdXRU6g1JWzdQjXODLY8o9uJmiYhwDowP5ee6wknBpFqNOSxSuMvXzxhakEXTWxXTD6qr3J6S1YCf5WjZ87y/49piYp48rse/kHC+rmXAbMgI7Tji+fWNuqkFXt9QZ6AsGN88xoM4lxa2zSKHL4YUll7FWJ1kXHXr1ALwCkXfx7mzLFiztMk/foCTInV3eb9m/14JnCYF7zCAa54ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=qokv2DXP; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=qokv2DXP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
X-Greylist: delayed 126 seconds by postgrey-1.37 at boromir; Tue, 19 Nov 2024 12:52:26 AEDT
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XsnYk6qT0z3028
	for <linux-aspeed@lists.ozlabs.org>; Tue, 19 Nov 2024 12:52:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=SxM76o8BGy53AtlOJoitl7JV8kJz7mesTX75V2BZ4D4=; b=qo
	kv2DXPF5NrFtTmXJuEOhpovQLZUIAGFuSld5TeLwIPl4mLkHcAF1mYH216IVlMWFOR4wCy9/us05n
	wPB7GLUOqbaKO12CCPHEKGt2dCOpkA+ildcppazSaUoNRItAVq6uDUkenkPYF6Km+XGmoh7xYVLE4
	Nwvweckmq3fDjYo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDDPX-00DjZv-5j; Tue, 19 Nov 2024 02:52:11 +0100
Date: Tue, 19 Nov 2024 02:52:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, hkallweit1@gmail.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next 3/3] net: mdio: aspeed: Add dummy read for fire control
Message-ID: <b8986779-27eb-4b60-b180-24d84ca9a501@lunn.ch>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
 <20241118104735.3741749-4-jacky_chou@aspeedtech.com>
 <0d53f5fbb6b3f1eb01e601255f7e5ee3d1c45f93.camel@codeconstruct.com.au>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d53f5fbb6b3f1eb01e601255f7e5ee3d1c45f93.camel@codeconstruct.com.au>

On Tue, Nov 19, 2024 at 09:35:39AM +1030, Andrew Jeffery wrote:
> Hi Jacky,
> 
> On Mon, 2024-11-18 at 18:47 +0800, Jacky Chou wrote:
> > Add a dummy read to ensure triggering mdio controller before starting
> > polling the status of mdio controller.
> > 
> > Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> > ---
> >  drivers/net/mdio/mdio-aspeed.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-
> > aspeed.c
> > index 4d5a115baf85..feae30bc3e78 100644
> > --- a/drivers/net/mdio/mdio-aspeed.c
> > +++ b/drivers/net/mdio/mdio-aspeed.c
> > @@ -62,6 +62,8 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8
> > st, u8 op, u8 phyad, u8 regad,
> >                 | FIELD_PREP(ASPEED_MDIO_DATA_MIIRDATA, data);
> >  
> >         iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
> > +       /* Add dummy read to ensure triggering mdio controller */
> > +       (void)ioread32(ctx->base + ASPEED_MDIO_CTRL);
> 
> Why do this when the same register is immediately read by
> readl_poll_timeout() below?
> 
> If there is a reason, I'd like some more explanation in the comment
> you've added, discussing the details of the problem it's solving when
> taking into account the readl_poll_timeout() call.

Also, is this a fix? Should it have a Fixes: tag? If so, it should not
be part of this series, assuming the older devices have the same
issue.

	Andrew

