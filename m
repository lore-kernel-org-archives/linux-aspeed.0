Return-Path: <linux-aspeed+bounces-693-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA13DC021A1
	for <linux-aspeed@archiver.kernel.org>; Tue, 11 Feb 2025 08:17:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YsZ7f1fVXz2yNt;
	Tue, 11 Feb 2025 19:17:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739261870;
	cv=none; b=dhjg+6ctuQ171Wk4YXwTqWiTaQ8RlwvKzOwCrLWxXQq+pLjWQwb8vXcKe1MYVlbhT667nzuOnWQJG0ZEOpp4zN77xE7tzz8vI3roxSZAtxIkXZbkWplSYbtPt1kQ0FJs0GK/nxjcfnyMu9fVI5ub6JlaQydFVSB2BggHcZstdXNhXIbViP9x4nsMYXlrvM2c+EG1GEPviOT8tUZB9lqX2RGCyHEFlLIh8+ZeeeLUlF49DqRqcMjGIrh1bcR7ej9I1OFYfC/NwC6u7g1SvDMf6aEJ1U4Gsquqc4PPN2dtWccj7i4Hs7Z/3M8S8cag3NeeVWkpDMDE4SwcZieeMfR2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739261870; c=relaxed/relaxed;
	bh=k9WySju8gNe1rIx5TXt5dUVyvNo491eZ5wqE3A6V9/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHCogm3rBQScUe8bxadouwN2695HF3QU+lILpyKBphVOqtXnBbxPUYnEhM7ducPFU3RIGdIObismhhs1MBKOZnEKIZMoefp4Kg0cp3X1wR2ih1NEhRNOol+8zREX53McUK5Enfd5VdvIXw3nDg1qqBG7+/F2NWsxNPHaA2eOyi6xIA2MCyHIr+gMj47Hn54S45nW3UL3VkSjDmk3zMvm/HQxAERqNelOP32H+cnJO5FFgNPAEm5MyBRAy4vH0B6YG4p03sQKXhQ2MDGMSG/W8HolxQSXLRx2RBR0BcLcwfFWUVr0ESHE/vb5l+ElVfwQt40hV5zMo6xtBdkCbHZbzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fi8qdzTN; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fi8qdzTN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YsZ7c6nnGz2y34
	for <linux-aspeed@lists.ozlabs.org>; Tue, 11 Feb 2025 19:17:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7012CA4014E;
	Tue, 11 Feb 2025 08:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DB8C4CEE6;
	Tue, 11 Feb 2025 08:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739261865;
	bh=Rhu162EIhM1z2w4T5glLEdRgvuphMT5lNfv79kXrgZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fi8qdzTNv5o5L6fULK5uB2A8iFz0rpLxfz9BzCcQbs++3URe8eKfSZyPMv0nGybMa
	 ENrEJh94hP0C8V+77xFjgzwwam64bLelN/HEgdamZ7MmlHYUAm3O3kQcww8Pp1vF89
	 gqBgHPMW6KrAG1RuvyYW1kI+4cLMj+KJaMVJ9vPNd1uZ4NGrI/PydQOtkzLiaNHOVz
	 p7EgbGECVZ+jfPckA1DTVPSavkJV0ih5VQbkcRIyVdV2Cv8KVvhXrOCxHv8NGaVVfL
	 8xd+tbRE8u9h4N1UeDwahSTZqxFm6Pc68LkMpMXcxuKvv0azhCbEsUAM6iR640mJE3
	 X2qJ4ZNQc4nmQ==
Date: Tue, 11 Feb 2025 09:17:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, linux-clk@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
 define
Message-ID: <20250211-encouraging-free-aardwolf-0fabb1@krzk-bin>
References: <20250210085004.1898895-1-ryan_chen@aspeedtech.com>
 <20250210085004.1898895-2-ryan_chen@aspeedtech.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210085004.1898895-2-ryan_chen@aspeedtech.com>

On Mon, Feb 10, 2025 at 04:50:02PM +0800, Ryan Chen wrote:
> remove soc0 clock:

Why? Your commit msg must explain why. What is obvious from the diff,
isn't it?

>  SOC0_CLK_UART_DIV13
>  SOC0_CLK_HPLL_DIV_AHB
>  SOC0_CLK_MPLL_DIV_AHB
> add soc0 clock:
>  SOC0_CLK_AHBMUX
>  SOC0_CLK_MPHYSRC
>  SOC0_CLK_U2PHY_REFCLKSRC
> add soc1 clock:
>  SOC1_CLK_I3C
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  include/dt-bindings/clock/aspeed,ast2700-scu.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/aspeed,ast2700-scu.h b/include/dt-bindings/clock/aspeed,ast2700-scu.h
> index 63021af3caf5..c7389530629d 100644
> --- a/include/dt-bindings/clock/aspeed,ast2700-scu.h
> +++ b/include/dt-bindings/clock/aspeed,ast2700-scu.h
> @@ -13,18 +13,17 @@
>  #define SCU0_CLK_24M		1
>  #define SCU0_CLK_192M		2
>  #define SCU0_CLK_UART		3
> -#define SCU0_CLK_UART_DIV13	3

NAK, ABI break without any explanation.

>  #define SCU0_CLK_PSP		4
>  #define SCU0_CLK_HPLL		5
>  #define SCU0_CLK_HPLL_DIV2	6
>  #define SCU0_CLK_HPLL_DIV4	7
> -#define SCU0_CLK_HPLL_DIV_AHB	8
> +#define SCU0_CLK_AHBMUX		8

NAK, ABI break without any explanation.

Best regards,
Krzysztof


