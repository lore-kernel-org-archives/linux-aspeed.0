Return-Path: <linux-aspeed+bounces-2301-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8841BCAC59A
	for <linux-aspeed@archiver.kernel.org>; Sun, 21 Sep 2025 20:14:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVHXK0N1rz301G;
	Mon, 22 Sep 2025 06:14:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758485681;
	cv=none; b=FrQklsJLNj3No5SsceLCSdWGssweMS7yl62U6FRpyMQA+3ZdBk7udq//zTFqUOKJfTj/q6szBiI5cvTplOMXD3WeB65waOPWi4hD/dKtGBNG/4YXUbiEBroetGT1WK7m9MMgdGadwKszLBBwgJPs3INRMC1CqaufIeS5+kNVa6x6NT5Zm70mAvFs58sEpg2Zee8zXljnyuTTQ2wmX1vyO7as/rt4/leW62GtvO+vE6Maes6qQO+ur30iW9296Y7DoovN4eaua5bqKtWv4telDYq0y7vbGn4d5gnG0u3HfRcuDp6N/XgPF3e1TQn36PNw8hJPLxR/QqEDybl1QmdAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758485681; c=relaxed/relaxed;
	bh=sxNUxatlX2j8pSiDe8L67uJzf4cC07GJgtefdwBeAOc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=eUXBsOsm8BeBZV+OrEnivz8gYQUHs6QQhuFly7Gb5X8lsJSGL0gDbLnYyiFaEJZBTfX1NwHI1AlImK86AXUpqSw539soVUlUxMSSxVBDq6YDvLK2tYQSauXpb4GDMriIQYlu7IC6WavTK+o6h5NaCkLMIASXwNAFynhydiI9PrL80MMcvGdsHfCi220dgVTHEOEeRAveFhBNuwWODZWRzdSBi+E6AjaYA6ICjFAMcOOyG4E6eliuTfVvx9T3/bkwQKBRtldPSzn0fB9yvHqVsbVD5X+d9dvB6t7pgJfl8B0Ws+qqTsrvbO1m9GN2238LtY9bkClYpiEvK7WhTqxeEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l+FCO1T8; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l+FCO1T8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVHXJ4NN2z2ywC
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Sep 2025 06:14:40 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C4712601E3;
	Sun, 21 Sep 2025 20:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E845C4CEE7;
	Sun, 21 Sep 2025 20:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758485678;
	bh=sxNUxatlX2j8pSiDe8L67uJzf4cC07GJgtefdwBeAOc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=l+FCO1T8tvENOND7RAa71AtzmmxkWP0XSoMcte7v/zC16QH0QouPQbhef+DT+YfSa
	 K25SW5z7RnbyTDpqldoshrGCtlTmD0w2nl5PsoheUsr40aPn0Qy5seXFb34w7FdsPJ
	 Hvq0HbGQzLh8kY//BA/+P/Q75Qh3/utaO+HhgSnjhlqJsbPNLxhemWqdSK8mr7ENz0
	 DD02q+ocPjpivFx1nI4PfFCmf6Q7nbRuKLa2rgk8AttUQCs0mooX0eQrNMmxzehQt/
	 vihxFlBUWkMxzWtaea8Nca3O9vX/GXg+RpDQ8fB3+BasCLoYwQyohIO3QT1bxaiHuv
	 mABM/E7M+CwLA==
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
In-Reply-To: <20250917020539.3690324-4-ryan_chen@aspeedtech.com>
References: <20250917020539.3690324-1-ryan_chen@aspeedtech.com> <20250917020539.3690324-4-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v14 3/3] clk: aspeed: add AST2700 clock driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: Brian Masney <bmasney@redhat.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Mo Elbadry <elbadrym@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, William Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>, devicetree@vger.kernel.org, dkodihalli@nvidia.com, leohu@nvidia.com, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, ryan_chen <ryan_chen@aspeedtech.com>, spuranik@nvidia.com, wthai@nvidia.com
Date: Sun, 21 Sep 2025 13:14:37 -0700
Message-ID: <175848567705.4354.18321442549280624891@lazor>
User-Agent: alot/0.11

Quoting Ryan Chen (2025-09-16 19:05:39)
> Add AST2700 clock controller driver and also use axiliary
> device framework register the reset controller driver.
> Due to clock and reset using the same register region.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> ---

Applied to clk-next

