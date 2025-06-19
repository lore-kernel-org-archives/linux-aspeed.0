Return-Path: <linux-aspeed+bounces-1506-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E659C7115B
	for <linux-aspeed@archiver.kernel.org>; Thu, 19 Jun 2025 20:00:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bNWgs5MfQz2xck;
	Fri, 20 Jun 2025 06:00:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750363257;
	cv=none; b=fpKLRz+Z7FiuPNDn58L4tJYz/WOqiDzIHSxJ0atvxOkmzNc6mK2RATtWoBAvRmmOqGfSqEh8/4chXabYqXM8TbeBlT63IOZrJV4u0RmcRSYRGvU9MxqMWGR35Z978RH/BkmO+TIRpW6S2FH5ftktWYEvprVsE6HECiROWeXkRy7OUG24pnCEmBUd7fbhSe8GrGoHwLVHUU4HgE3SgCswgAKUNp6ZUn9nbrvFn0XbZCSi0oAKWoA4SjckZDjl9MDLf0XcHHtLS0I5YCBiEZdg/oeA8TmM52wr/jRucOxGn4uBkYo1qCOXJ86COMuwr7Em17Ok6eShQpW9Ictjx9Vwog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750363257; c=relaxed/relaxed;
	bh=W2J0i+WG/PKJ/ZkG9vyA2DkvGy1gkKZsqlYj/4o9WVc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=HQo6gLh65uhz/bYnle3KQcu/VNE7qXI8stNGzceUyexCzK5wtE+ovOrpuS5G9nPtGtubdEQCHmJT/uT1Wz4J0BNFJcm1yeg6gQgzHGODtEGh0v4S+PLwjU/RcZDCaf3E3l65f6kEOq09/bdTLilQPsbS76m+ea8ayc4XWrNWMJv87SOtNq5YhuR6rp2OAmkEsVArRcO3/uGHmHUtykoIUEbirmEDPHtxVVS3cXsK2IWT+vCX5NwX0ofU/Ke1QsWGZbkKyQ9/bAb6QNnUpYHehdcSkLz5xr7CzDij2S1YI5OK5vg7vTT1XSx3nh8waQoNRDHKQVNtTiY4fDYBLvyeMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UJ02kzcb; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UJ02kzcb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bNWgr5yxGz2xS2
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Jun 2025 06:00:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id F39E7A54405;
	Thu, 19 Jun 2025 20:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3DBC4CEEA;
	Thu, 19 Jun 2025 20:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750363253;
	bh=W2J0i+WG/PKJ/ZkG9vyA2DkvGy1gkKZsqlYj/4o9WVc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UJ02kzcbZJZeiNEHd5b99bUhLyNEtRcBgfSKjSh+UOnyIc7kkQLDZFtwAZMz1ywhz
	 7/SXXYjPRqVYlVdLVBpLLnv/0AdaP5zLVChg+Tw4+8CuqLhghPw+PajRVJop8jHJ9g
	 7aoYF4o1rAUSU1tRakIJq4BHPyQC8FaUyLbmoWCiZBNWED3ibxKpPtxLs2xYsmhpcb
	 Vr6I1QEx469iI9xEYTi15uvFqFwAkO0grFJvGWl5RJE9ZA69jqpzL1JDIOzpxWohyg
	 2CMKHT1xuftnB62ZsAJGxOJ0TjfrmYKLdeRI+zzmBb9xPjdtnPFonlS4Dca3fHGxVo
	 xLXoKV1K/Wewg==
Content-Type: text/plain; charset="utf-8"
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250610012406.3703769-3-jacky_chou@aspeedtech.com>
References: <20250610012406.3703769-1-jacky_chou@aspeedtech.com> <20250610012406.3703769-3-jacky_chou@aspeedtech.com>
Subject: Re: [net-next v2 2/4] dt-bindings: clock: ast2600: Add reset definitions for MAC1 and MAC2
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, mturquette@baylibre.com, p.zabel@pengutronix.de, BMC-SW@aspeedtech.com, Conor Dooley <conor.dooley@microchip.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 19 Jun 2025 13:00:52 -0700
Message-ID: <175036325275.4372.17530886047439204374@lazor>
User-Agent: alot/0.11

Quoting Jacky Chou (2025-06-09 18:24:04)
> Add ASPEED_RESET_MAC1 and ASPEED_RESET_MAC2 reset definitions to
> the ast2600-clock binding header. These are required for proper
> reset control of the MAC1 and MAC2 ethernet controllers on the
> AST2600 SoC.
>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

