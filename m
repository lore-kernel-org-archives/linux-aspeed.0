Return-Path: <linux-aspeed+bounces-2300-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59EDCAC5A7
	for <linux-aspeed@archiver.kernel.org>; Sun, 21 Sep 2025 20:14:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVHXD1k4Vz300M;
	Mon, 22 Sep 2025 06:14:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758485676;
	cv=none; b=OtjNdzQSzS6l46x3aadcxcbaT7xR7tO9BuZPiLs1yyT9IIViEIBqbQu2TGD189uPnlR/3VrRaDBmmNcI5AAqiFzoE4m6McwUD0Ho6JvoPQ0X74C46+ENXQuGCBTpvjs8YSIRANI78gpmqyF9f+6Pti6rDWR7h/dACSKk7PG6R8GR4O4EI0mxQFb7/+GefwvEpNmm4NoZIsJWbHyK13E066D/XPl50X+r2x3SSUPXEt9P+ARUa1qELURIDoEjpnx+CGApdxYUhoAIVYugxqAOcTfs2A+fBrwne7pqkgOAT5LpNfScYgRO29ISfWqYUDfIOSMwmcvdz46cOXMF0bnXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758485676; c=relaxed/relaxed;
	bh=cl4D9hUZUtyBRnsjCdqkFO48i3UvAPyAgu61Fe1pMqA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:To:
	 Date:Message-ID; b=ZSK1W1E/nDLJgaGUPzzzjFp/3p1GH1JRhZZ3LAkdJTbHPGtZJtELGLMg/QFDN6fZMDds/r+nltWdZhblsXuIXJGtgKJBPUJwXHqyGYJQYejhvA4GXF3aKYN1MVA1lBQLvIqeXOdHsselIqPDhatoUHUt/sSoPKmiU1C+XRBrvGstmq1xc8bbm8RPu/snSWluLcV80PafA5oOtEhooXxOKaSNlD3h05DK7AUrCNT6UoBKjLeBqHX/19kNSKVeOJfkl+PjTwfjnst6bOufqQAVuaUVPpbsqT/k3939scJuIEb/14DXQHQc6V2YBkDxUBvZgceF46k7mCG+PWKTjg2FbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ft7MDVZh; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ft7MDVZh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVHXC58Khz2ywC
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Sep 2025 06:14:35 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 89DE1601E2;
	Sun, 21 Sep 2025 20:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22780C4CEE7;
	Sun, 21 Sep 2025 20:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758485672;
	bh=cl4D9hUZUtyBRnsjCdqkFO48i3UvAPyAgu61Fe1pMqA=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=ft7MDVZhvzwLKhSLnLGy4LeQsQqHDTT+WpQBwUZumZg35Q0aCxnefg3NgVlXMCdOz
	 aHocKJn8hvrxBJf7LdYUTlKCfjLsjYhrM8GowuDYuQtydIvjWRELRobP7nVHOIP9x8
	 rQCptIq89alfez9/H2/x1UypW/8/1yZFo7Cx3ZOltpvtgEzXvMHBfZERlM8Wmmnn8D
	 WW1uFGCTgUjNDP6gMe2L2HF6R2vPcg0QhGGM+oGevxWPs4tlTfK4kpG4fnsXeSNwMC
	 Kl8MlM7MM3VHbt7qmyXFHyGG2ncriGbvdU5iM4wnLS5nA6zdTgHPxbjDX16udYWBUP
	 huD0TIQDDNQbA==
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
In-Reply-To: <20250917020539.3690324-3-ryan_chen@aspeedtech.com>
References: <20250917020539.3690324-1-ryan_chen@aspeedtech.com> <20250917020539.3690324-3-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v14 2/3] reset: aspeed: register AST2700 reset auxiliary bus device
From: Stephen Boyd <sboyd@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Mo Elbadry <elbadrym@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, William Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>, devicetree@vger.kernel.org, dkodihalli@nvidia.com, leohu@nvidia.com, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, ryan_chen <ryan_chen@aspeedtech.com>, spuranik@nvidia.com, wthai@nvidia.com
Date: Sun, 21 Sep 2025 13:14:30 -0700
Message-ID: <175848567081.4354.110591763861485292@lazor>
User-Agent: alot/0.11

Quoting Ryan Chen (2025-09-16 19:05:38)
> The AST2700 reset driver is registered as an auxiliary device
> due to reset and clock controller share the same register region.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---

Applied to clk-next

