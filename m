Return-Path: <linux-aspeed+bounces-2299-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0148CAC59A
	for <linux-aspeed@archiver.kernel.org>; Sun, 21 Sep 2025 20:14:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVHX373mvz300F;
	Mon, 22 Sep 2025 06:14:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758485667;
	cv=none; b=TYaeSsjaKg2YkGKLSrKXhz2JwVKILy+grl1hEo17Knzo2sBznPEbhpOHR8ocCHvyBOSGdWS2SgWvu7O2eI2pnz+xIwIKlYnk52w3X0IdRGm26JNaLtwLGFAoL91jevqsLZ/8xpmQdrdAfXiZEliv0oTG1hZOScPscM5ldl/wHzDyBZN+n33NzaTjjQq+H7xX9QVcZlhFYxvfy1zgAYhr4n/NNKTrJILhfOxcJIlav/TRPZxafIkY+DI7ZFDas1Ts9yMlUJFBodivcKTAz6/qGtLGMIHCQnn8VcTqcop0v2OO0O8EHrPXYCxasKQxjF0y3wulX/KWr2odDGeTxiIIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758485667; c=relaxed/relaxed;
	bh=N6yIaPi7mcGJcAYGgK8aQktSJhsIi/eYMgFAw+22rRU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=gXh9fB/vKY/fE4RQoB2E+99v/tnZ4lwpynojK1ht7o5XvPJzP8yaqXBlqSbL0N1PdD3IpL8qPh8Y+DKsegNnlgDPFImK2TRE4WfS4eyxOmHfFhJ7PRg4ZNG6e47QuEzTOmLJmO/LYfBjWmSlP/7vBMMUqJNhwFAIIpz9NtfeFS2W+qHQRzH7wNeNqIPIaffXaxhsxtUrKBzucPEEn40rOjw+CBsw2AguykYgdNeTtdLsUpdPmGr6/AJqbyxNR2Iy2YztNCy537FA1f3Y1N7RyQkLYyLHu6CsPEVaVBpCdaY13rxeH9Cte/v42Rxu+KBYwwrvyy7cTgV+PNv3Hq3+Bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ik1F8vFl; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ik1F8vFl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVHX31fCZz2ywC
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Sep 2025 06:14:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4D74D43F1F;
	Sun, 21 Sep 2025 20:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A8FC113D0;
	Sun, 21 Sep 2025 20:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758485664;
	bh=n42wuk3fRc2TVRisCoqEGhMVO97pJsliEokdZLTtgUI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ik1F8vFlhgeEufvWs7RZ9i4++Y6dbD/OC6O/1znESUCp+t8/7tBmKMDz1O0+4kRKN
	 GCBaTdy9VJOKZkLEtKBArW9mo9B8QGGp9UtvCe0ET0GHRfPktVBWzJHqUBKyrJlmip
	 d4ROLrGMv8ZxI9OHZK9KnxWsezjFEMynoT64DLlHlwZufX9RznzuJL4GOV/YeQspLE
	 3Tr8zuvp6MqeT8sedQst3GjqHi3+TAj29+jYvjgAuZxXW/vDvctl5QRj8J3Z09mtDf
	 BDLD/wl6fx3c+hOLPHgk6xkH6Kser6Ng3rDkF67roBvbiFrrc+BAZA1zx9MB9nHQv8
	 /fTg/12iOYKpg==
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
Date: Sun, 21 Sep 2025 13:14:22 -0700
Message-ID: <175848566245.4354.2484705489084607414@lazor>
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

