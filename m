Return-Path: <linux-aspeed+bounces-1904-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED55C87FD1
	for <linux-aspeed@archiver.kernel.org>; Tue,  5 Aug 2025 15:39:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxHfC32pJz3bmQ;
	Wed,  6 Aug 2025 01:39:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754408355;
	cv=none; b=YtB7D+4DB5nQQJGMn70sedUoWZnVYJHacMmA1+v8oTweMioMwrh+MHkVMNUYF9X0XiFyFthhZtM3yxlf+qT9T3vcrKBwKnGKosR+vtLqpg9tJw/NbaAyId4RlXRtmGje+XxalWg11/qqfdTJGjHbTlIjt+Lxzib3Q7ZnnJ8OFZtvDQFE1CMEnd3JqCcvh/ca3bY9lHoGTTToN/UotsSr/8KasrtsyXN6iCs3L5RVYrVfHvhWCBm+92Igvmh0TdoOYYfGoePM3WKIdUi9SYJDGJYJyfjFI9MQWMJ9FD/m8Jlj0uthozWa76ZcPFvzDdnyAEdBXC3rDCVwrZAIHFCHKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754408355; c=relaxed/relaxed;
	bh=gWuv6gUEHahmSEcdFXSzDw18Wc9BRfxVlwU/I9dRzTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtT2Sq0Hyc80suTRnaiVf3KVGWBkJWmnCn9aEa9akfBgOW0E5aGxaJz6YHBun/IBGneFe1E+bn5xt52umYK70UZONgjTa+FDGAA/mdTfe6YtH2qbp38IzlbrWCuDKiIiJDU5dSdIBoMyGW3XMmTiQFjcWoe0JKiCObWrVLfDXre0Q9B/bcPZrgIijl2UjqMC1nqjTXWamHJiuaF9u3/LM0aD0CNC/kJpPGHlLdzCVzECd6rq+H24g/M2xYEDQMG54Alp17YjupddUwy2jhvJktZMFWHdSHl1suYTXqL10MMWHA2qXzNT3UsmM84PPylWJs6zYGi8lAjG6y9I0HyDQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tvLIBxj8; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tvLIBxj8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxHfB35mFz3bkg
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Aug 2025 01:39:14 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7FA01A56620;
	Tue,  5 Aug 2025 15:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E53C4CEF0;
	Tue,  5 Aug 2025 15:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754408351;
	bh=Sfc3xMxHGqVoflK676SStVZbw5uDGyunMmKEB2eOesM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvLIBxj8IsgIX41sw53OtzX3fdSThyLyVyGhoI1inGTzM5sMCj5lU9fDrUeBDXkUd
	 aKZd4ZF2s2RWT+H3CnkZFF+w7jF7GgHW8UBtprj+4UVk4Zk5LBFJVwPdVcgFwgu5zA
	 DpVn4bKnqDeuI7G9lSY1QVAjN4L7LkdnISkvQFOJjJbXhC1ONbkAwrSnfCWkiZScoI
	 b7dJkTlw1a8merA/t75DOoawK+KnPSH6o12t33UxdV/RJyve4f8cHuGdKPqdxIuoTB
	 0q99GD1EaJ7h6gVRa3dku3gsRFpk3Ba0r0dmdriLLPz/mcuSQ9C5s+4BJ+JjuyfwFK
	 mPLUnqRSi/iSg==
Date: Tue, 5 Aug 2025 10:39:08 -0500
From: Rob Herring <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 SCU
 interrupt controllers
Message-ID: <20250805153908.GA1807801-robh@kernel.org>
References: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
 <20250804053445.1482749-3-ryan_chen@aspeedtech.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250804053445.1482749-3-ryan_chen@aspeedtech.com>

On Mon, Aug 04, 2025 at 01:34:45PM +0800, Ryan Chen wrote:
> The AST2700 SoC follows the multi-instance interrupt controller architecture
> introduced in the AST2600, where each SCU interrupt group (IC0–IC3) is treated
> as an independent interrupt domain.
> 
> Unlike the AST2600, which uses a combined register for interrupt enable and
> status bits, the AST2700 separates these into distinct registers: one for
> interrupt enable (IER) and another for interrupt status (ISR). This architectural
> change requires explicit handling of split registers for interrupt control.
> 
> - Register definitions and configuration for AST2700 SCU IC instances
>   (compatible: aspeed,ast2700-scu-ic0/1/2/3)
> - Initialization logic for handling split IER/ISR registers
> - Chained IRQ handling and mask/unmask logic
> - Table-driven registration using IRQCHIP_DECLARE per compatible
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/irqchip/irq-aspeed-scu-ic.c | 240 ++++++++++++++++++++++------
>  1 file changed, 195 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
> index 1c7045467c48..b6f3ba269c5b 100644
> --- a/drivers/irqchip/irq-aspeed-scu-ic.c
> +++ b/drivers/irqchip/irq-aspeed-scu-ic.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Aspeed AST24XX, AST25XX, and AST26XX SCU Interrupt Controller
> + * Aspeed AST24XX, AST25XX, AST26XX, AST27XX SCU Interrupt Controller
>   * Copyright 2019 IBM Corporation
>   *
>   * Eddie James <eajames@linux.ibm.com>
> @@ -34,11 +34,42 @@
>  	GENMASK(5, ASPEED_AST2600_SCU_IC1_SHIFT)
>  #define ASPEED_AST2600_SCU_IC1_NUM_IRQS	2
>  
> +#define ASPEED_AST2700_SCU_IC0_EN_REG	0x1d0
> +#define ASPEED_AST2700_SCU_IC0_STS_REG	0x1d4
> +#define ASPEED_AST2700_SCU_IC0_SHIFT	0
> +#define ASPEED_AST2700_SCU_IC0_ENABLE	\
> +	GENMASK(3, ASPEED_AST2700_SCU_IC0_SHIFT)
> +#define ASPEED_AST2700_SCU_IC0_NUM_IRQS	4
> +
> +#define ASPEED_AST2700_SCU_IC1_EN_REG	0x1e0
> +#define ASPEED_AST2700_SCU_IC1_STS_REG	0x1e4
> +#define ASPEED_AST2700_SCU_IC1_SHIFT	0
> +#define ASPEED_AST2700_SCU_IC1_ENABLE	\
> +	GENMASK(3, ASPEED_AST2700_SCU_IC1_SHIFT)
> +#define ASPEED_AST2700_SCU_IC1_NUM_IRQS	4
> +
> +#define ASPEED_AST2700_SCU_IC2_EN_REG	0x104
> +#define ASPEED_AST2700_SCU_IC2_STS_REG	0x100
> +#define ASPEED_AST2700_SCU_IC2_SHIFT	0
> +#define ASPEED_AST2700_SCU_IC2_ENABLE	\
> +	GENMASK(3, ASPEED_AST2700_SCU_IC2_SHIFT)
> +#define ASPEED_AST2700_SCU_IC2_NUM_IRQS	4
> +
> +#define ASPEED_AST2700_SCU_IC3_EN_REG	0x10c
> +#define ASPEED_AST2700_SCU_IC3_STS_REG	0x108
> +#define ASPEED_AST2700_SCU_IC3_SHIFT	0
> +#define ASPEED_AST2700_SCU_IC3_ENABLE	\
> +	GENMASK(1, ASPEED_AST2700_SCU_IC3_SHIFT)
> +#define ASPEED_AST2700_SCU_IC3_NUM_IRQS	2
> +

The reason for ic0/ic1 compatibles before was the enable field was 
different. Now it's at least at the same shift. Do you really need a 
different value for IC3? 

The register addresses should come from "reg". I don't understand why 
they are hardcoded in the driver.

Rob

