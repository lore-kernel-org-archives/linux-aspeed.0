Return-Path: <linux-aspeed+bounces-2742-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5E7CCF9E3
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Nov 2025 10:08:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d140Q1rwvz3bf8;
	Tue,  4 Nov 2025 21:08:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762250902;
	cv=none; b=fcEY8R6wsTl1Desqie60EMcBQBTrRZz3PoRkO0DdZ6AjJiKkZzG9NtUNqVkF9mvfQ/2m+dkDdNPrCWa48F1qbWe2BhNnx5QRr/uO3VvMggdK0ebMQ3Nby2VL+6QKWDRN/Em6zwGEDOl9/V2w2F/PHpWaijDEcRwnxxkCV55xLH/8BMyuov+itGaYEGPj0Pz9qwa2JyJEwtezuafxGSv5w5kMfgFm7BYDHLscIVIIuslx+f+R5L4ILxKtiZgh4xCP+M/Rpwv9g3hNXm8sVfduafyGLNz+drh7/4CuDfATPCHGRR4cKDiygI6cPzkhz/u1QON1ZIo7tKiQcDJ5x5f/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762250902; c=relaxed/relaxed;
	bh=UdZLTCI+Yo35fJ2RRGRjjNNpS0Qcv7D95HtE6X6CoPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkZf0kuhiamaGjEGfmi12+mUdtJk0wbpsAgdmQFI1BQ1Mr2CQkCW4mT/nYXr5uSn6FGDLWe5HSzH9xoiimB4njBSYZFiadShgjOQ4xYrS8gaCYPpqJNSGFv4pZn+8oFqzsuyPTCTE7DUFFfQKdT/yCa3g4wqPnIphjF80N4w1b6/220aI3/8kQaRrQJ49L4XHD+i7LzZ+k0ykLAsPsfJGQjRHwK8kUtPMrPxgvvjweDTK/OB65hIMDwTVrk1eH4bqeE56rG797LDRPhdymtBKIv8XfUXaeNG4CFLstTqAFWbl7xvpmX0VEm2aftFumJyBnl5/bmYt4h2JFeYdi5eMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=a6lVN0C3; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=a6lVN0C3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d140P52JWz3bf3
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Nov 2025 21:08:21 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4C31B43B8C;
	Tue,  4 Nov 2025 10:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37DBC4CEF7;
	Tue,  4 Nov 2025 10:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762250899;
	bh=qO3WBVAPbxP4+oRxYAr9CsbFrExWM8O4nijZWjABxME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6lVN0C3JfLA+t8d+cw2jvUcx4IUtu2rer97kxIxwOGMSLifiMZaYjQTCecyvc0n3
	 P3cH8j4yB1SFDCHLuuABNfDtunGs6hi/F5VI+Afjbe5LajAtRHAHLsYkvz7WfLpQvF
	 nX2tMp2UuoS1ZMVQWe8xnywDIGLlkPjdd5W9q9wrBwuES3mLonzP4oXyWsacWa1DDS
	 MYnBWEhRe9nTQ8Bt/X3lFg4cOoXx3snKeiq6n6KgBXeaQ3cMl4Z6+wc5lACf/uF8Sr
	 Be3Xw4HON5okRjC2sFcic33cOiePOLkMGi91bPWw16VxNeGYTAfjxI7r5b9fboj1C6
	 qgl2Nc4iOAXQg==
Date: Tue, 4 Nov 2025 11:08:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add AST2700 ADC compatible
 strings
Message-ID: <20251104-enthusiastic-cinnamon-urchin-da480a@kuoka>
References: <20251103105217.1764355-1-billy_tsai@aspeedtech.com>
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
In-Reply-To: <20251103105217.1764355-1-billy_tsai@aspeedtech.com>

On Mon, Nov 03, 2025 at 06:52:16PM +0800, Billy Tsai wrote:
> Add the compatible strings "aspeed,ast2700-adc0" and "aspeed,ast2700-adc1"
> to the binding for the Aspeed ADC. These new compatibles represent the
> ADC instances found on the AST2700 SoC, which are similar to the AST2600
> but have their trimming data located at different SCU offset.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml         | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


