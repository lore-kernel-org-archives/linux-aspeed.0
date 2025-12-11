Return-Path: <linux-aspeed+bounces-3091-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22B9D41C36
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Dec 2025 13:30:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dRtk93BRjz2xNk;
	Fri, 12 Dec 2025 00:30:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765459809;
	cv=none; b=P6JWxk/QRBGZepB/aVB8zQhXtUDHPw0VnQjEyTRUFZU4n5hZg+ASQQ6rf81pf7cOGesc3UYiI+6/xL9VrMem7IbbE82rHkzj5G7riXrBIt8+tGpkfTF+LzvDmJl8VnzI2sSSs1p8muDYIzyt8HRqJK4c2Gs/ZtN16evJAq4KXI270Kc9rzL6k403iVI66QsMpVyoY00kjxYczPwRFygYRTepCNilpBUbvAGY8qqd/k5/1eskYHr1dWJWCbMbLmHfdbr0HI+zQXxEXD8p8wK/iBVKtbKMaGMCdWKz9gl1UG7NqlGIC9dcB+ktD3MrBF2OQWuUchllro8JrMvL+D99sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765459809; c=relaxed/relaxed;
	bh=PfFxejg/br2zDaiaEBdU9ZBdpu/3APgsmRYKWbR2RV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhUnoF+H6vG+U45rzRqAYR90J651epkiaLVJlu1tB44b4zMjkufD5ivhYiYTUZ5ARjYFaYYFxiashrliu/oq1tmLTAGg+5cYYZnqguiJKwlkkIaVqmH2/WXMfUlJkNR/w6vZJyDSeR5qSj9SguBYQd/8ZHcrjAJZ6Ap/w11F007VgfVSCESM5IC9l8lgCcY8CTy1jZa1ZKorSVUozUZgTRIxmV/p8opZhyjtLwmHMmyJlxGuySbOdalI2UslDYrctoQSD8YYI4x0/y6PcwHymp9qs4RVf2QJV6TibwTaJ4RlDaKYjgLkTLc0cMYbFoI4ysJ3KirDZ9ZmJmEIiHRbQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=P04z5f9Q; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=P04z5f9Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dRtk41pL4z2xLR
	for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Dec 2025 00:30:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PfFxejg/br2zDaiaEBdU9ZBdpu/3APgsmRYKWbR2RV4=; b=P04z5f9QZhAjh49Y13gbduOzqp
	vV0qjgaGNF2sYUMqiw8k9BpvW1l0DPcwMmbvMmXV31PKHlCovv5/Jms0qP4AD55otX18xsVdDdYeG
	jLjA5stL9swHDLi/q94ykBcZAtxj0s/q/UgX5pPCDfEP3rJvRHJgEmfh4htwQZCklaCc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vTgjQ-00Ge9n-Si; Thu, 11 Dec 2025 14:29:20 +0100
Date: Thu, 11 Dec 2025 14:29:20 +0100
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
	linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH net v3] net: mdio: aspeed: add dummy read to avoid
 read-after-write issue
Message-ID: <f53fcaf3-0154-4cc7-87be-ab815fa8b6f5@lunn.ch>
References: <20251211-aspeed_mdio_add_dummy_read-v3-1-382868869004@aspeedtech.com>
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
In-Reply-To: <20251211-aspeed_mdio_add_dummy_read-v3-1-382868869004@aspeedtech.com>

On Thu, Dec 11, 2025 at 02:24:58PM +0800, Jacky Chou wrote:
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
> Fixes: f160e99462c6 ("net: phy: Add mdio-aspeed")
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

