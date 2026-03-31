Return-Path: <linux-aspeed+bounces-3812-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1856DFF60D3
	for <linux-aspeed@archiver.kernel.org>; Tue, 31 Mar 2026 06:47:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flJZQ2lCRz2ybQ;
	Tue, 31 Mar 2026 17:47:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774939630;
	cv=none; b=CX/IYapTcCzt0uEcvRYoijnTYGQc39dkwyuCROg32pcPmn3bjUMk8KbpzebfhziL8MCwM8KqfJxOSZsRHZ0PBdDVLQ4P6+HhYOuedpJmGnSRBibqOkqfsXKLWPuXoIBwWUImzvP+lzrqE9H4YSHRncackxX8UDfJMUIr9MICXFbQgeWXVvixpS6RDRfrCASotKDbkqPZ6fPxgUgmJVA7FP+EKgwD7wQRHS/HwWiHa+hZs3uqnvAqP1sWefREcsL/eD9rpVSjKTzSprDKKuclmB/VaBEbmI+36kYeomtDk8M3FKUiqKNOPtsa/2FiKgzSBRKmPBZrAKdaX6BpUR+70w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774939630; c=relaxed/relaxed;
	bh=47r9K84aQHii4xa02ABxmq26rEj0BLUtumOM+BCsiV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sqis3fA/qF03fqf/0JTWm8v6uOeouew1JJAkEMSSZ7prQtwImaOAtLDKpdgdpMiAI5JeYcJLnSkwjPtr2RghzRfsXeZiF48s9MpSch3tLUGHIdMRcWFDf5U2yAnql57yT29OcNpSmu0zsWbX8hku/KXeHB7lfXPC/aVG3ECSw/bb1EqE6qf9tOGU9FQRDI0qfCR2mZcsUc6HvXsDmkIUSDO9lGOP6dnJ3lkZ4wyULvyCMP1tzb8oCLVODRfncpF6twa0a2FNpAXi15HuTGnWbhkRD6QOiU9aneZQFks9mIlj+7YnNCCvp3uQY01HSeHYJnC50oqGq8alhWfTHyec3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GtbBV9lG; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GtbBV9lG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flJZP43dYz2xSb;
	Tue, 31 Mar 2026 17:47:09 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1F0C241791;
	Tue, 31 Mar 2026 06:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F053C19424;
	Tue, 31 Mar 2026 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774939627;
	bh=9Im09qmYZGWCtbT+mlfJFXb6Hn2kX5UH/o7ZzZP/L1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GtbBV9lGOF8Kq+J0uN0/aq0fHcjswO5NXh1oX/mmeHALzTL8VVJJ2U3XkcddvCK5/
	 2Zvo0pb4scqWdq9bt0PFAmwFSTlMQWAelrJbltpF3veYac79TSmRPJr07KJut3caek
	 UAzHx/T9MW9c3pCEYQUlMQocGKL8kA2Hy4Y2sL5+JG3OLeYhxR6KyqqClA6TfBeH13
	 LUsI70JcLiQbQl6F0EyKiZQnbH8aXtSFuAbYcDzW7ptApDNqJ07dwbZ0jQBAbxzSOV
	 qy8+soVAjjX+hVjRzUAopj0cI8bR3QgL890Kz73gwhJH6vFvwB0zCbCKoo6qzasK+b
	 dIpeH0HNEPLQA==
Date: Tue, 31 Mar 2026 08:47:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: jk@codeconstruct.com.au, andriy.shevchenko@linux.intel.com, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rayn Chen <rayn_chen@aspeedtech.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH v28 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and enable-dma properties
Message-ID: <20260331-fanatic-certain-bustard-fb13bc@quoll>
References: <20260330-upstream_i2c-v28-0-17bdae39c5cb@aspeedtech.com>
 <20260330-upstream_i2c-v28-2-17bdae39c5cb@aspeedtech.com>
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
In-Reply-To: <20260330-upstream_i2c-v28-2-17bdae39c5cb@aspeedtech.com>

On Mon, Mar 30, 2026 at 04:21:47PM +0800, Ryan Chen wrote:
> Add aspeed,enable-dma boolean property to indicate that DMA is
> available for transfers on this I2C bus.
> 
> Also add the aspeed,global-regs phandle to reference the AST2600
> global registers syscon node, containing the SoC-common I2C register
> set.
> 
> These properties apply only to the AST2600 binding. Legacy DTs remain
> unchanged.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> Changes in v28:
> - update commit message correspond with aspeed,enable-dma.
> - remove aspeed,transfer-mode and add aspeed,enable-dma property and
>   description.
> - Fix aspeed,enable-dma description to reflect hardware capability rather
>   than software behavior
> Changes in v27:
> - change aspeed,transfer-mode to aspeed,enable-dma.
> ---
>  .../devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml          | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> index de2c359037da..67b23d1a4cec 100644
> --- a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> @@ -37,6 +37,16 @@ properties:
>    resets:
>      maxItems: 1
>  
> +  aspeed,enable-dma:
> +    type: boolean
> +    description: Indicates this I2C controller instance has DMA capability.

Compatible implies that "I2C controller instance has DMA capability", no?

How two same devices, with exactly the same or compatible programming
model can have difference in the programming model for DMA (one lacks
it)?

Best regards,
Krzysztof


