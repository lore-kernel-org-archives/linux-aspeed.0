Return-Path: <linux-aspeed+bounces-3060-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93366D3B7E7
	for <linux-aspeed@archiver.kernel.org>; Mon,  8 Dec 2025 13:47:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dQ3FR0d2Cz2yYJ;
	Tue, 09 Dec 2025 00:47:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765201643;
	cv=none; b=FhNyVjkLxgepF45QgxeEKN8ikO2mXo/3M2X3Ctt7YQmbBBR7QEu3A1lANxrTnLAgXK48iWUKMDsA+RXzXyYP1nuQy2NzY4MONoaflPEVG8IE9DM8KuRpJEf2Uo4GH6miQnaAC641ncpr+0Sot7+61ErkQ3KiNRrXRqv/UFwWsRSJCJFlMgyfmQGWSQwAoTh9RMf0paayS5ItiNND/lmolvps8TFlk4Vbfr7vp35Tn5XsA24uJ6Hw4TVXQT5OGFhxDdjxDfVnI8FE4D0ZRx/jn+pi2LbtBw3ZEHB8jd23YuH+fEslXcR+TlCnSxGCpUsdenN5ywfKX8YFGVk91MPvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765201643; c=relaxed/relaxed;
	bh=A/sml+u6a8CEZsJFpF3d5AMtMazVBG0Mrdny6cktA2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwmJSbSXQrjLt3IS6VGBGJMfIGKavbZTbnnGZyw+1q4qVEDf5Wp88iTLWu0Fc4npUpatSDFPa4LSRmk65kUrpkPmO1SSDumOuPY0hUwJnrmwo1KtdGEAPB9QwHkrz9e18MfldmjR14Vk1XKRReToZsAPoiuc9sYiz4Fx+SoS+4kTFIxVh6DwBKZGLh0gZZpGArXlETMlftCDfF/WN2ekxZkHCuFKnXkMnB6+qEJpgSSdpqkJgqzQswFISBfhHphrcG2/9Uwj5RMpRthlP71W/QQcg2KaVSCov8enJ8Igd3cxw1AUrqmyC4bn008Pzltb1fjxtCEZL7sEC+btms9r7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ko9nLS11; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ko9nLS11;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dQ3FN5S8cz2yTK
	for <linux-aspeed@lists.ozlabs.org>; Tue, 09 Dec 2025 00:47:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=A/sml+u6a8CEZsJFpF3d5AMtMazVBG0Mrdny6cktA2Q=; b=ko9nLS11fjpRJtP5ZP4Kif3Ed7
	pWgzCrQ8dYO8fzp2in8a69Z7yuhGG0c7SMlpivS1hnC3oWaXuUR/tuVW5V3Ikbmu9SPJazlbMl4jb
	Wt7nNgjpMPpM/7L8Irnqv8ubW3bdbxVwoIjVU0392LbCuhcWZFpq/OIxA0K00Tu8WG9o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vSbZf-00GNYB-T0; Mon, 08 Dec 2025 14:46:47 +0100
Date: Mon, 8 Dec 2025 14:46:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Potin Lai <potin.lai@quantatw.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mdio: aspeed: add dummy read to avoid
 read-after-write issue
Message-ID: <57860c7c-2294-4ea6-a998-8bc92dda2ed2@lunn.ch>
References: <20251208-aspeed_mdio_add_dummy_read-v1-1-0a1861ad2161@aspeedtech.com>
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
In-Reply-To: <20251208-aspeed_mdio_add_dummy_read-v1-1-0a1861ad2161@aspeedtech.com>

On Mon, Dec 08, 2025 at 02:49:56PM +0800, Jacky Chou wrote:
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
> Fixes: 737ca352569e ("net: mdio: aspeed: move reg accessing part into separate functions")

That seems like an odd Fixes: tag. That is just moving code around,
but the write followed by a read existed before that. Why not:

commit f160e99462c68ab5b9e2b9097a4867459730b49a
Author: Andrew Jeffery <andrew@aj.id.au>
Date:   Wed Jul 31 15:09:57 2019 +0930

    net: phy: Add mdio-aspeed
    
    The AST2600 design separates the MDIO controllers from the MAC, which is
    where they were placed in the AST2400 and AST2500. Further, the register
    interface is reworked again, so now we have three possible different
    interface implementations, however this driver only supports the
    interface provided by the AST2600. The AST2400 and AST2500 will continue
    to be supported by the MDIO support embedded in the FTGMAC100 driver.
    
    The hardware supports both C22 and C45 mode, but for the moment only C22
    support is implemented.
    
    Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
    Reviewed-by: Andrew Lunn <andrew@lunn.ch>
    Signed-off-by: David S. Miller <davem@davemloft.net>


    Andrew

---
pw-bot: cr

