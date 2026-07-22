Return-Path: <linux-aspeed+bounces-4517-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20156C4451C
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 06:13:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4kT33D66z2y1F;
	Wed, 22 Jul 2026 16:13:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784700791;
	cv=none; b=nK8MFbHcJ+W2dbI48LRtUL1+5LNT5t+JDsmAS2MFx224oMatVfae5benfyTwId1xaO0/MrnA1EtVBOF73aEvmL80REN7OXn1WN4yC5XwBeF6XfunMfY8eFrutBcpkkp/RpZ4tVH13qP37euWj+2/7FqutS6Mbdb+WZiMcY5o5oPQ5s64s5X+R3q+AjDq0OCCxn5b7MKOLVeYXfooPk5YytJPvS90eSSXEXGcqRW02maWBvWUw3rRelTwdWe5JxZFGfWWRe21eT4WZNlLP39xc4wztzLmLZ8bAKwt/vDsBMz5sPc0aX1/l0qKcSBc5tsIxa+tim7gm9BnCZbdABdwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784700791; c=relaxed/relaxed;
	bh=Ug4T2uoLqHNHdXUQQzhAnOc8fa3my8JhfBBgqQcfeKw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H66JibHAIo5hpGaz6HWV9p4a6zV6KwFA7lGN4oY3c18akK2Jnz+KuV9SVV0nKmYpCRZt9+KCFXEVgen/HJ88sUpKsXHYmNI/gNhvX0DtB/yMgc6gSS9ABdc23DjMehMRhUurmF36upSJkXCE4lpyEQq4hJPCUzRYifKP8d2QoYk1CFID8RkKhK35bbAOp00cAQkQdp4BDSNsZBpX8f6DE/gvcIj3PRJw/YQKXjmmN4cRl/1xIjjzys6qvRo7PToZxAcdtoQFiv8Kt0zKmKq2wemuQXaf3PrZua4i7Q8RrXpf2CRMbCoPATZJgkUXob7JscsOMQUMCjUcxkS51D04+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=gqxYy5kD; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=gqxYy5kD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4kT16LfCz2xJT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 16:13:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784700789;
	bh=Ug4T2uoLqHNHdXUQQzhAnOc8fa3my8JhfBBgqQcfeKw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gqxYy5kDnmCPIsNsjxIuVC58gepqjtBpUsZ5sEUP2pRwXreMJeMP/eHfwjD9Qe2wD
	 Gc4xCdDnheBh3T34CZxkyBA5OZbc89RrYALc8P2JBKDOkICQbcylsUnHb86a6aIL5x
	 MGaAk7Jm4eeaQEafALhnh1cCSTFuBbDl3pTcp0O+5TvmDRnKcb5lgWq9Lo+2yJqdF3
	 q64EdjWmaZqXGj8ZnIYInpBqMqAovAew0aE2teTw8D5XJCdXvaY0srzLY0p1tHPBJb
	 uXvx1hChv3KnoL10l7L4R/B3hnz//9yGR85x3jIydXhIIgKoKivna+aSctOynS80kw
	 50Hm87myUVTnA==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CB2FD65B37;
	Wed, 22 Jul 2026 14:13:07 +0800 (AWST)
Message-ID: <92837fb6c6dc9d25de5cb91d338cb8de9544c0ce.camel@codeconstruct.com.au>
Subject: Re: [PATCH] clk: aspeed: ast2700: select AUXILIARY_BUS
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Karl Mehltretter <kmehltretter@gmail.com>, Stephen Boyd
 <sboyd@kernel.org>,  Michael Turquette <mturquette@baylibre.com>, Ryan Chen
 <ryan_chen@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>, Brian Masney <bmasney@redhat.com>, 
	linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 22 Jul 2026 15:43:07 +0930
In-Reply-To: <20260712160301.98941-1-kmehltretter@gmail.com>
References: <20260712160301.98941-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

On Sun, 2026-07-12 at 18:03 +0200, Karl Mehltretter wrote:
> The AST2700 clock driver also exposes the SoC reset controller: it hands
> its register base to a reset auxiliary device via
> devm_auxiliary_device_create(), which the separate ASPEED reset driver
> (RESET_ASPEED) then binds to. That create call needs the auxiliary bus
> core (AUXILIARY_BUS), not the reset driver itself, but COMMON_CLK_AST2700
> does not select AUXILIARY_BUS.
>=20
> It builds today only because RESET_ASPEED selects AUXILIARY_BUS and is
> normally enabled alongside the clock driver. On a randconfig with
> COMMON_CLK_AST2700=3Dy and RESET_ASPEED=3Dn, nothing pulls the auxiliary =
bus
> in and the kernel fails to link:
>=20
> =C2=A0 ld: drivers/clk/aspeed/clk-ast2700.o: in function `ast2700_soc_clk=
_probe':
> =C2=A0 clk-ast2700.c:(.text+0x147c): undefined reference to `__devm_auxil=
iary_device_create'
>=20
> Select AUXILIARY_BUS directly, as other clock drivers that create
> auxiliary devices do, so it builds regardless of the reset driver.
>=20
> Fixes: fdc1eb624ddc ("clk: aspeed: add AST2700 clock driver")
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

