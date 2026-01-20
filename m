Return-Path: <linux-aspeed+bounces-3409-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BC8CA5FB8
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 Jan 2026 17:13:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwYnv5fxYz2xQB;
	Wed, 21 Jan 2026 04:13:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768929235;
	cv=none; b=l1SMPeeQUpNqhdS/wN/tud4ELKyafFlgy48WFK9qwJY6yBnjtirGx59ZBLJXIe/B6npkEcFnMHv1f1eQ5euppWv+RajucTJbd69vjeGWbfjqmnzzRTb19+xf1X6WXmvzyCLn1aaZRs/kwG/nOzlzCqI5cRaH4DG6QXvnxVZ3Zdf6IdUnANtxIACWlIQhbwGpI0QIS8jk6ceWKEXHxlhgxh3nK0H4wi9YJdvJ20kedoaDLUf2Df1cXVi6n98zvVotV8n8+8V9NYBrNgoOKGO1k72CP7Y6WALoKphNN9bjr9xQBrWV5A6xOl43qVB5aRaL3eYXeHSHnFXIDfm+v0WhXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768929235; c=relaxed/relaxed;
	bh=l8hiawV26Vv+bQT0ragLMCSj+JMcDW/G0WxHYmhWSSo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KtpHa6ASU2b7ZBB0x5Jca96FVxYmBsDjlhxtZi7rWwU+8JTZk8FXy5+SE2g2kkUoCD6j31vV4bPYvNKxRpctAIC7YWOI2ycIk97NQ7JobrfSRRAsUeDsmxdqdkAgFva9QqsNNelS7ME7oJIChPNUK2lm/TdzRrbQaI06uTVFa6XGVyzXUtS0XC8DgZf30Yc2+Umna3+TBhFAYxSJ6w+Z0T2V63VF2maoN0btkKw3ab0IF1e+I7wD6Nbcs8yBFcB8YHEqpBTOgEmi5tMVzRgNiltnr+KmfBCYyYEFAZpPmxWsZ7A8wQ/azo5gDv+p1X5ZFFd9SVr3b0WLSPSp67RDNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZN/OaL86; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZN/OaL86;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwYnt6Qtmz2x9M
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Jan 2026 04:13:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 26D8144063;
	Tue, 20 Jan 2026 17:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F143C16AAE;
	Tue, 20 Jan 2026 17:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768929232;
	bh=FCXUTifsoE5ms3846pZc5X2+cn49qG54H5gxPe63MiE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZN/OaL86bOdC6IT7QGy65HSNIb4kEOeBIdUSX4/ywGgfkLO0g/ysRy+uUCedRSk6L
	 /7ldB+MuNTI8ZN6BAobOyyExx/lJYLUv99rokkj0ggeP9X0MOjvEoqNRg3rx37/ww4
	 AkM3YmkKZQJ/1Dlq06eEgKdLuwLvu+2P9rHbQrdfqPD8EPsTrpOcieAgTo+B6z6C+v
	 oyWLQJrVJ1t7QW+Fvmg8cnUr+chDtH49RJer6ZIxDO8gPhzXst88+PFikgTSAsgBss
	 IFwDX/6nyGE+R1dtv2Qz1MpO5QRuygPNb/KnpC2z80oOT4cfGpp1mGhCFPlmXbXzil
	 u8IvFZdYw2gfg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260109-dev-dt-warnings-mfd-v1-1-1aabe37e9a14@codeconstruct.com.au>
References: <20260109-dev-dt-warnings-mfd-v1-1-1aabe37e9a14@codeconstruct.com.au>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: Document smp-memram subnode
 for aspeed,ast2x00-scu
Message-Id: <176892922879.2358656.10600094966614086692.b4-ty@kernel.org>
Date: Tue, 20 Jan 2026 17:13:48 +0000
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Fri, 09 Jan 2026 17:05:18 +1030, Andrew Jeffery wrote:
> The platform initialisation code for the AST2600 implements the custom
> SMP bringup protocol, and searches for the relevant compatible. As a
> consequence, define the requisite node and the compatible string, which
> in-turn tidies up the dtb check results.
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: Document smp-memram subnode for aspeed,ast2x00-scu
      commit: d9c80c6393900f810cf30fb33f93c7f762c0ff4d

--
Lee Jones [李琼斯]


