Return-Path: <linux-aspeed+bounces-5110-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D72CA5FC4
	for <linux-aspeed@archiver.kernel.org>; Fri,  2 Oct 2026 09:03:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx2rX4Yjvz2yPG;
	Fri, 02 Oct 2026 19:03:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790931820;
	cv=none; b=daLPBCW842sCGg2sveesU/9jdZI9aaOkcrtDkUGmS7GAejaKWaCjJUwpCm2BICMVoVchmNOxAqE1T21MQjjBjv1LlY5DgYIUU35Jgj3928G63qQe55bVknd1ATVxnkNiXBQywZr9ICHsJYSy1oefOi9H935/E4m4Y+Oet8GTz10/n6kitWAsU4woPkJc38MmlOCtzmfsEiz1Z8b8z1P4vwGNQnRpGXmNsH+vBeSXqM/erZojePGue1hz8CRnCFpleDwLNPbofI9a2i8DioLoRVahshKHhha7FwWzveOT6+rGfNfsjhgsSHdrWxcc7j4naETgA0hNIVwp+L13FrI6HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790931820; c=relaxed/relaxed;
	bh=yQxZFijEU5LHsqzlp6kC4YKHFl6QGIvDQevjxQ5kmyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFF0I8BmqMgbWy19ugpSpcLQTrhQDflSPMiSbzSSc+wrEyf7jZVNdpKsj2CKfJjAed6mNjYJw1banaqUpYlWpiT4Kr5dP5eVsi58JbRCbxNyyPrGYvdv+jJ9nokeVmh+6oBCyP6+OAurNlXx+EvkM+iZD0I9hA7ad71r8ifVdKVHoO+CyTzczm2llhcPoqN7qnkJ/66g43G+LGZ72I82INRps1jC7BnGEOWSVJcgtRVdkkegOq3PB9Dpafm3L0LXC/Tf8mvKH7kC9bB9Hw4omPJ0xWlRnb6fBN4M6fu3QpR6ye8x0WncpySkeTEcgaOM1xgIwthw+XkLUEpzU9H2eA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMhj128m; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMhj128m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx2rX07rdz2yDc
	for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Oct 2026 19:03:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C2A4441356;
	Fri,  2 Oct 2026 09:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEB21F000FF;
	Fri,  2 Oct 2026 09:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790931817;
	bh=yQxZFijEU5LHsqzlp6kC4YKHFl6QGIvDQevjxQ5kmyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PMhj128mwMLV5wxS5AIrCVz7sWVTvHfeMTUmtJNuQMrV/fEjwjC0ANphjgG8OAaNq
	 OSLjHK3uCMbVUpu0mYgpgErTjWVVLMe9WD7+Qrr5bkigcdQh4JqDmMxKeowUhRgbC0
	 b4p3M2Qu8uNS3IUEhscAJJbzwNepyc6xXKFYSRQNyWVYLpn2dojmo2Z2XD+A6996u7
	 //Au+sbQQ2UqZ4xnXAlvCyahXqXAyat9yvVYB6EKZSHsLZUErIHJK/BxjevvjRJnYQ
	 YpmjFn7W1D6cztpU0QScfgv7W6g2OZuTnXdZD6pGJ73e53km2ZfcjQ16G2dOJRVw0z
	 i78vsxykvbi7g==
Date: Fri, 2 Oct 2026 11:03:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: Add syscon property for
 multi-SCU SoCs
Message-ID: <20261002-succinct-voracious-orangutan-fdac5e@quoll>
References: <20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com>
 <20261001-ast27xx-adc-upstream-v2-1-2f9c15cc0064@aspeedtech.com>
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
In-Reply-To: <20261001-ast27xx-adc-upstream-v2-1-2f9c15cc0064@aspeedtech.com>

On Thu, Oct 01, 2026 at 05:50:36PM +0800, Billy Tsai wrote:
> The ADC's reference-voltage trimming data lives in a System Control
> Unit (SCU) register. SoCs with a single SCU instance let the driver
> locate it without any additional information, but SoCs such as AST2700
> that expose more than one SCU node need an explicit phandle to
> disambiguate which one holds the trimming data.
> 
> Add an "aspeed,trim-syscon" phandle property, and require it for the
> AST2700 compatibles since they are the first multi-SCU SoCs supported
> by this driver.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Assisted-by: Claude:claude-sonnet-5

Your SoB is the last one.

With this fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


