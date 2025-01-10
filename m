Return-Path: <linux-aspeed+bounces-425-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64822E77188
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 15:46:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV5bq70dYz3cWD;
	Sat, 11 Jan 2025 02:46:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736523975;
	cv=none; b=V21VbMq7SUe0eSusKP4rH2ZXVEHIAPsRpDnTntMRUDuVA7mO03Gvcvm3ck1stDIEaV5ZUPerRHP7JjVvOywbQSlBn4WymDsoAaOyADhu6iy7lcTT9/Mel5ZnNsGlOaNS4rYZfjIwuZworEO2xF/d1X1QkhriNstK+0MAJvnVo0SHVORuXlXobBUkviq6wO6CKERPLEaByxrziOrlp62gW5NqgSYZaR/wIChCWXfBmM0Uz+zPbbcyhaSkyMZtdSRS47QQ7l3SXgNhMRbuQQT3zSh4YnfSL2wV/3/WhY7hCBYWbWIql3ikYSHR3nmoNGY3w8Vv9sc4vF6ZcJOIhCsrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736523975; c=relaxed/relaxed;
	bh=VJxwM3WLpwpOdwtGqbX4sAm2IOUfoTLER9LnPrwAEXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5R5KylGTmZWwNtRLoFZKhHCCT2LSrz/G5VsvByE8FA0fyGwLeqXLZCYHFToVa0bZLRvfWJJpCXeLGjwbBdgWfeKY0FP5l60/RD8egbGmfFvPeZXirgbogjrkFw5/ryPQc7aMcDv9D0JARfq/KXO7sLtnszLSXpZeTWNwDhv480TSMqjj6UmmoTuRDeJ87MIRo9IM7Nv9Ac63L778ROWSb+PnYsI1keLRl0U5xvXvv1mfa6R3U/wirCX/vr961tBKVFETMGeEu+1YG8WWKwef4EYaOU4n5BApENQV9qFuqbrD1J5Crn8MjVTFIGKH08sDVojeTxY8P6985o0uRNwVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gLjryIoI; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gLjryIoI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV5bq0vWlz3cCd
	for <linux-aspeed@lists.ozlabs.org>; Sat, 11 Jan 2025 02:46:15 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 88B37A4256C;
	Fri, 10 Jan 2025 15:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827ECC4CED6;
	Fri, 10 Jan 2025 15:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736523972;
	bh=/8GMOElXMtMIbUyIggey7sDVja7GADbZTVd1RMjScU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLjryIoICBCAn4RWSOXPvWcJrcEziG7VuEmgqNLSTnzguoARMzsN5z4j3pH2Liah+
	 L3eea5ZhoLjrE7Jt/KeGQuUdbwP+xGF7Q+zIoAndLGfJfM3UhqL+BRil4GtuBVHjdz
	 NZieh7PDa9+c266ZiU0cJDhwdIzozt3GlmmG7rQVMNURbwTYUjnhZuBh+qi1djIVjK
	 M+HvBkvfj2RGjy9pVdtynM8Y+T8yclKi/xDjSTBsqxQ2Hhu2nMWfVuK1ETISpXcP55
	 6ETfoUAwwkDMqAxxRFesCEizq7CC5jLB0bLqGoI9gJ9lardbnq+Nk5ozzbbDfGLKl3
	 5ZKg08qvwh/QQ==
Date: Fri, 10 Jan 2025 09:46:11 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>, Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Correct indentation
 and style in DTS example
Message-ID: <173652396977.2926418.10522811816537772235.robh@kernel.org>
References: <20250107131108.246898-1-krzysztof.kozlowski@linaro.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107131108.246898-1-krzysztof.kozlowski@linaro.org>


On Tue, 07 Jan 2025 14:11:08 +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../aspeed,ast2400-vic.yaml                   | 10 +++----
>  .../brcm,bcm7120-l2-intc.yaml                 | 30 +++++++++----------
>  2 files changed, 20 insertions(+), 20 deletions(-)
> 

Applied, thanks!


