Return-Path: <linux-aspeed+bounces-1671-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA3DC83F03
	for <linux-aspeed@archiver.kernel.org>; Wed,  9 Jul 2025 07:46:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bcVR26ddVz2ydj;
	Wed,  9 Jul 2025 17:46:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752047182;
	cv=none; b=JVpr+8o4ad6YTObdlkVQQytjXmaZ7pz251biWfdtQWWrO6PwG84mFKUxcGOtqDfhH7jMeQIz0qouk/1z/mxt2C6AA8kR7sNvUsnJxTzVW6huX63PbSewCh6cF3e1sf7jfwvgCiMe6OgOzHI9jnPWTGXY3N+ATeSBLPRo4PZbtilF5mzYIlwsYkHhZZ5s48W1SdURarKwVin7ySez8er6CvBAieo2LbqJjE2xuMT54DUiQyMW2hP0+xlJrsOY989YPGiZPbRmtLTh9WaLjLoZZKzEd0EqV5InN5/VsjNWYXvrVHvPiouKjJ6VPqcCBpDhCTyy5Rq1iBZq2vOdkn6ewA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752047182; c=relaxed/relaxed;
	bh=CNfQTV7B3oSxpshS66kWT9Q7EFeqRmmFv5pnApUcJw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyAJJcxL5sty3Z55NzJrOyN4TxzHHYWteV1Dp1iOtWCzs8gxSxPaVrcoJUeKJpnHi07sicPYzXtUkmiGwOp9e9EKuoy70kIiWm4eUDmcaCdqaPrwaGYRGoRi1+m+oXH+VJ/xp0Ca7G1GAWe8C728zsUCZcLS9CEmcT4u5fQjUo0dRY3baEkGNuvR2/3/t55Q/GXouMFbabDqe+U/8uyw9stYIqsSaTHGo8YWbyxbLOLwWJgMPYM/D2Nvob0O2IeAqajFnLTEbGKlFGKJ/iNcK4O/UhVGnl1ZzcslFPbDDzEo5GnOqH3AH5pZ5VFR1UMczoR1OPqicvsXGUKzcCmdTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q39oaTT7; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q39oaTT7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bcVR00P8nz2xQ5
	for <linux-aspeed@lists.ozlabs.org>; Wed,  9 Jul 2025 17:46:20 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6EA6E433A4;
	Wed,  9 Jul 2025 07:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B652AC4CEF1;
	Wed,  9 Jul 2025 07:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752047178;
	bh=Wwooc6QvI3kYRhEkAEkhHkOtrspGXOlhQ25M+ckDh6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q39oaTT7JgmUspVLiFLnfUlaaB++PVEVePT5m2vVkkxes5HC4AjSnH30DyNAhn+F+
	 KF8uoSwT2ve62Rwl7HPcULJmMQM9Y0y6MSw0EAWE1aa3/XyApqvQNlaoe7Fsgqj6W0
	 hllNHbLHaSD229VQ5LW+5Maxddp4pAOpmIzWUHGqE5tMm8mZCtwxriCwRmVOrulx1e
	 P5MZJOpDla8VM5U4qfeJtbH6mCob0YljtHCKLLVbLQ3qIKd/z/O0FvGH4Gx/PtI707
	 gaNqzHnTMNEbBom9LXZJH8c5JlnD69aVb0mYhl3SFWPRpRtKv9GRABXpv4l9AoaWAK
	 V/TGZSWy/x12g==
Date: Wed, 9 Jul 2025 09:46:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, horms@kernel.org, 
	jacob.e.keller@intel.com, u.kleine-koenig@baylibre.com, hkallweit1@gmail.com, 
	BMC-SW@aspeedtech.com
Subject: Re: [net-next v4 1/4] dt-bindings: net: ftgmac100: Add resets
 property
Message-ID: <20250709-simple-blue-chinchilla-164051@krzk-bin>
References: <20250709070809.2560688-1-jacky_chou@aspeedtech.com>
 <20250709070809.2560688-2-jacky_chou@aspeedtech.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709070809.2560688-2-jacky_chou@aspeedtech.com>

On Wed, Jul 09, 2025 at 03:08:06PM +0800, Jacky Chou wrote:
> In Aspeed AST2600 design, the MAC internal delay on MAC register cannot
> fully reset the RMII interfaces, it may cause the RMII incompletely.
> Therefore, we need to add resets property to do SoC-level reset line to
> reset the whole MAC function that includes ftgmac, RGMII and RMII.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml       | 21 ++++++++++++++++---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


