Return-Path: <linux-aspeed+bounces-2302-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA26ACAC5A7
	for <linux-aspeed@archiver.kernel.org>; Sun, 21 Sep 2025 20:24:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVHlQ25Vwz300F;
	Mon, 22 Sep 2025 06:24:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758486258;
	cv=none; b=J1wALSeGHqMDUTEmKTL/85CcqEZY4+HlYCBTZt26Lo1gVwwFwMWJu7ob61ZGmKeCQ60AibZv+cWgA0ShQ3IalXCFdUZpouKK7LWp9LRu/wtPvc7Mm4vsqy0ddnk11mfqyo2gMuZ6lcpIJTHkc0fBFoR7iXeK6cftFkncLhkq7w0VSP7Msm3N4ncfvMEsf18o81CT2ethiWYsFa1qH80fffyI9WHPGoItS1d1LGdOHmzHaeVCzuTg9zaz5a+0fvIv6jCw3ivVeAQK/H7DGUI4aU5ViScRssfkeA5NmAs+UNGP3ZInZL7hDU6TsM1Rk2WrmWNoFNOJJJG0Xe7nOU5P6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758486258; c=relaxed/relaxed;
	bh=N6yIaPi7mcGJcAYGgK8aQktSJhsIi/eYMgFAw+22rRU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=DiuYhn4iOpuJplfWzmOjNJ/0hLwTclqkO/U0sN7y7lwbj/Yl5RrsQeexB59iWJE5j4hFGwV7iPkPw1bohjRAj3xHl2b+lNpXnR+FFeF9vHWpwZkTUWYnUj10AtJeestXY9XrFBccE4qRkOPmrHPtXb4E08JhBBzoox6a9kdz2eZSzm3UTHTu/PVinRfiEeY7q9gCKqXCbSKTgPoaSUafFMiva9RyQV31niR9MtlnQ7enmtEd82jnoFSprL4Fy2u4UVMIXCg8nv3G6xIi0lRyIKX4ZlIeML3Gin4GCcoS+rMb8wngbVTWLlNkx39EUdp8YASmyiBSHQGZjCOxTmgv5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SB96mFzF; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SB96mFzF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVHlP4c5zz2ywC
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Sep 2025 06:24:17 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9A03041A32;
	Sun, 21 Sep 2025 20:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C15AC4CEE7;
	Sun, 21 Sep 2025 20:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758486255;
	bh=n42wuk3fRc2TVRisCoqEGhMVO97pJsliEokdZLTtgUI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=SB96mFzFx1fA+tB5zsjOGmulcvPZ3f7kLIWRwJnPolR+dmBSkVTB37P4bwjml4/nd
	 GpGxSGxIrQoc0zJspuRDGi1+nOkBCXBJ9OG2Wj5SEEH96IrVwfBLeK0s1JDsFStHZr
	 t29ixiUlz/bp0kXVHRFalJVH1bVUSadLBjGCZ2BiWgz/PKsO4MWzevGATRrkUTyWip
	 UFMtEDdNvF8H1BbBNuJfBQPV4AH+eO1JvSWsZRxkpqK6ePAp+H+L9fNCp/mVsQAMYO
	 vmR008DqDTaAZ9wEqa2dOCESo8minO4EvGE7wMKHbjdROq/7AcSXCCWOr6t8mC6m3K
	 Gcp+MH9nKtdpw==
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
In-Reply-To: <20250917020539.3690324-2-ryan_chen@aspeedtech.com>
References: <20250917020539.3690324-1-ryan_chen@aspeedtech.com> <20250917020539.3690324-2-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v14 1/3] dt-bindings: clock: ast2700: modify soc0/1 clock define
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Mo Elbadry <elbadrym@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, William Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>, devicetree@vger.kernel.org, dkodihalli@nvidia.com, leohu@nvidia.com, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, ryan_chen <ryan_chen@aspeedtech.com>, spuranik@nvidia.com, wthai@nvidia.com
Date: Sun, 21 Sep 2025 13:24:13 -0700
Message-ID: <175848625348.4354.12803484068611642489@lazor>
User-Agent: alot/0.11

Quoting Ryan Chen (2025-09-16 19:05:37)
> -add SOC0_CLK_AHBMUX:
> add SOC0_CLK_AHBMUX for ahb clock source divide.
> mpll->
>       ahb_mux -> div_table -> clk_ahb
> hpll->
>=20
> -new add clock:
>  SOC0_CLK_MPHYSRC: UFS MPHY clock source.
>  SOC0_CLK_U2PHY_REFCLKSRC: USB2.0 phy clock reference source.
>  SOC1_CLK_I3C: I3C clock source.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to clk-next

