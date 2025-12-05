Return-Path: <linux-aspeed+bounces-3051-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0486DD2F7EF
	for <linux-aspeed@archiver.kernel.org>; Fri,  5 Dec 2025 13:52:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dNCVw3pkWz2xc2;
	Sat, 06 Dec 2025 00:52:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764942760;
	cv=none; b=mtvjuAwGF2IUIrGlkBLLEajonFK3q5X0rCfYWVZr05B7CVTWEnfI093tO2GJgQtAqBELnUVcNsupf7f6LDL79t6hd/aIjhZcfcvqH8qMckFP+YQJIeOAoT3B3B/O5EmrxbdcJq/kiCixMOQO4mP0QutNTQR+VA1e++32CeaM2kQFc4DGK31b+es1E96q/zB20JPHmNbT4He0ebn2jlmBDQ5kECgqCi4hxDR+5atreYxCO4gWLPInW3kGvOh2/oUvj0u1EG/rJ+ZTJ0PPwN4rdaLN8X3vMsONo2zGJkuM3pV2d5xhwrXUcQY3HYniU4zr9imTRPnM2y2OZeRihjnzjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764942760; c=relaxed/relaxed;
	bh=45fevIuzzwdxiIaiuDVXIFaxf4ZsoS1h5rOMT7+v7qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hnr30hXf+GvCMh9hieAwI5Wzfw/GL36lfLiaMbDyq4IccBdZrfOdLkjI8tbtWvBJS4fWXZ4/KheajTCK8Me+OF+wG5mNmNDOzOI3a8g/fAwm7zUfZmMxKLsPhXsLtG+nzb5Aat0xKsgMf36qOpqA4ubKnLw5p5GSKcDo/DJomvj9aZT0lkgjriHWDF+HfHnSzEzLnj/CmlyyrrEpZT8h9XqCsOhhl8fNsYhGUr+XP+7IajkbTgtO0LuTBez9KUW5YGMYUCimp8x6VH02p6bFkXnb/Z8LQxnXN+d2lRL+UXq0q4O9TV0zINsxLUfQSLZlG5f/XjHRWp3QTO0ia5cHuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=dlqjxq1o; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=dlqjxq1o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dNCVt3RZkz2xGY
	for <linux-aspeed@lists.ozlabs.org>; Sat, 06 Dec 2025 00:52:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=45fevIuzzwdxiIaiuDVXIFaxf4ZsoS1h5rOMT7+v7qs=; b=dlqjxq1oVt9Er6eo9vth9vX0gR
	eztKjUHcbALGVrKoPeu0Vvd/09R/aNtIbQtbYNm9rPcjYBV68HyB0YxkIGbjpEoMqNbls4/tE3p8y
	ifODQ2BErblRzyYv9e/ZaWvhI6CnU/FWJBZWquJc0kvSq9VWaRwl2eUEBXudw8IYLYh0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vRWEG-00G5sa-09; Fri, 05 Dec 2025 14:52:12 +0100
Date: Fri, 5 Dec 2025 14:52:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mdio: aspeed: add dummy read to avoid
 read-after-write issue
Message-ID: <230147e8-e27b-48e1-9a62-7aa8abc3f492@lunn.ch>
References: <20251205-aspeed_mdio_add_dummy_read-v1-1-60145ae20ea7@aspeedtech.com>
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
In-Reply-To: <20251205-aspeed_mdio_add_dummy_read-v1-1-60145ae20ea7@aspeedtech.com>

On Fri, Dec 05, 2025 at 09:37:22AM +0800, Jacky Chou wrote:
> The Aspeed MDIO controller may return incorrect data when a read operation
> follows immediately after a write. Due to a controller bug, the subsequent
> read can latch stale data, causing the polling logic to terminate earlier
> than expected.
> 
> To work around this hardware issue, insert a dummy read after each write
> operation. This ensures that the next actual read returns the correct
> data and prevents premature polling exit.
> 
> This workaround has been verified to stabilize MDIO transactions on
> affected Aspeed platforms.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

This seems like a bug fix. Please add a Fixes: tag, for base it on
net, not net-next.

> ---
>  drivers/net/mdio/mdio-aspeed.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
> index e55be6dc9ae7..00e61b922876 100644
> --- a/drivers/net/mdio/mdio-aspeed.c
> +++ b/drivers/net/mdio/mdio-aspeed.c
> @@ -62,6 +62,12 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8 st, u8 op, u8 phyad, u8 regad,
>  		| FIELD_PREP(ASPEED_MDIO_DATA_MIIRDATA, data);
>  
>  	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
> +	/* Workaround for read-after-write issue.

Blank line before the comment please.

    Andrew

---
pw-bot: cr



