Return-Path: <linux-aspeed+bounces-2305-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20096CAC5A7
	for <linux-aspeed@archiver.kernel.org>; Sun, 21 Sep 2025 20:38:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVJ3r5Wtbz2ywC;
	Mon, 22 Sep 2025 06:38:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758487112;
	cv=none; b=dmzCpLFIzyaAxyeW76MXpOTmMdaotxrNiJEAs2ZLGdlosYaqOgQ1ddYQW9+1rxbxskSzqwE3O1zSyfEABapRfRGgq+VUfQCszNNVtA4l+hqVKoofkCvSus33q7PjmtP+UXRvKkwN5+oFvBEIsiFMc2HRtBNZlFi/MYccBHBtHSlagX8oD7XI2DED6WFwzM28TcGxFPINs9xG4e0WDhsH1Gx1t+0/T9zzfrvpga1cd2IdX1O4Qmzt4Rvj+SPwLwiFNl9ENzNH7G/XajcQFdwsKwm4cXO0K0d+sLemsBtCSs9FiY3I7afyXQUm9E3ilTdXe2Mxqw9J9aG/XPMP5zs7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758487112; c=relaxed/relaxed;
	bh=664LabPHOiNvimtsi/IFnBJfHn2xokuoEExuJfQJL7I=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=EvMWMR7GdF/hbyjkugW80E+y6cONA3wIzDcIYRLhqKS2n2TpdrKGbQE6Mf/nIx9E1I1zHiAc1ZS8/rAgTBum8iY4np077C33kXU/7jC9JtlEhFJSgTWDy0muTk12k+TUe+6KLvlIh+ZTKHhVCmJRAkVE+n/q4xkUyVLKXXnLKH5FX9Iif9oOuQpJjt/CPmL6/tAEMwobS2WeMxYnOD8fx1Q/0HZjVpr6Oh4I+NXR6T4iO16qkZwY6gPnu7C6+YAG0mvb1K6GEGFHIm0BPb6zOxRHrBu+u271EXF6jsVY3g8HY56DiDVVYEeixt0MTXw67E5FJBbsO9qy1edGuJ1rIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q6j3ObP6; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q6j3ObP6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVJ3r1Frcz2ySb
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Sep 2025 06:38:32 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D0555601E2;
	Sun, 21 Sep 2025 20:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59247C4CEE7;
	Sun, 21 Sep 2025 20:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758487109;
	bh=664LabPHOiNvimtsi/IFnBJfHn2xokuoEExuJfQJL7I=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=q6j3ObP6TW154twM40m9wHw5PjCCgK6yRKrCXOqEW6g6oLVAGrf54tkDoaBPw4pyd
	 63B7o2KrcCh+sRjLxBjxt9uYu4WKeGsthUk44e0TR2uE1MPyaabhF+Hj4TAQEQgp9W
	 S/vRV9j4OgzrzAFX8E0cAw/rcQ1ERnA9UNRrp4iqoYCt1vaZkzDjE3MwciKBkEyS6p
	 y2WuFXzqxWFY/4k4IzDchRidSJoYNzSSbHBVH9JFXHQzvTrzLL75p6Kn32fKSAmIHp
	 /Fg0Ezyz4Zr8W+6Pgz7zbhSsrMGkMlkIjrcF8BkVQzYNtpkrFp+ttCEdtILZyqtHCQ
	 6gsJXiDfA41Vg==
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
In-Reply-To: <175848567705.4354.18321442549280624891@lazor>
References: <20250917020539.3690324-1-ryan_chen@aspeedtech.com> <20250917020539.3690324-4-ryan_chen@aspeedtech.com> <175848567705.4354.18321442549280624891@lazor>
Subject: Re: [PATCH v14 3/3] clk: aspeed: add AST2700 clock driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: Brian Masney <bmasney@redhat.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Mo Elbadry <elbadrym@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, William Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>, devicetree@vger.kernel.org, dkodihalli@nvidia.com, leohu@nvidia.com, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, ryan_chen <ryan_chen@aspeedtech.com>, spuranik@nvidia.com, wthai@nvidia.com
Date: Sun, 21 Sep 2025 13:38:27 -0700
Message-ID: <175848710791.4354.5032800251620826265@lazor>
User-Agent: alot/0.11

Quoting Stephen Boyd (2025-09-21 13:14:37)
> Quoting Ryan Chen (2025-09-16 19:05:39)
> > Add AST2700 clock controller driver and also use axiliary
> > device framework register the reset controller driver.
> > Due to clock and reset using the same register region.
> >=20
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > Reviewed-by: Brian Masney <bmasney@redhat.com>
> > ---
>=20
> Applied to clk-next

Unapplied. Found some problems.

