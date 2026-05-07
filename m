Return-Path: <linux-aspeed+bounces-4007-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07DBCD343F
	for <linux-aspeed@archiver.kernel.org>; Thu,  7 May 2026 14:05:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBDXk6XRNz2xS3;
	Fri, 08 May 2026 00:05:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778162710;
	cv=none; b=hc4sv3wKI7t0OjcZAbJFj1lcCkes320FOTqy4DoFMiljOeEZxJIk4RgyIctttUVHHTvwuLsSxDk3l5sKt83If3Xtv7w7UeMDyvmVCZVZsqELhsWg+nJMTD/ZZk/f0B0Xw3vMOGBR++v4y/bUWUyGfHrXciXdM+eJx/MZx8wvLRe6RTXSxVWhnYqe6QgWdtamfAgtmREqrsA8k1HYVCK1PbaMpcjpYg6ZNXpoD49kXniPv8oQl5pAnRpDPe3FqmxR6oi/FtB3x6EMAfrbj52YKpo8JIzwuQ7mE+Pt+aZt0F2AFAJHkLsBs8AVwsopHt+3KcBtV6OH/zI8WJYl52h1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778162710; c=relaxed/relaxed;
	bh=w+EHvGzeJoaz+6vhvj3MgvBRhayltfc2X/2pXhenwgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RexbVykj+ubTYgOt9Ic9OLWUJIOzlgIWniTcL/mnspM5D8Hk53XHDe1j424drQ87CQLL5Yb8AYGJxj/7AMdsZpTFfcJb6znbg3P3XZBYfAijJeyotnCWblrevODKgsPZ1++SQ9FIA/vt5ScAARhAspBEOTVsow+tTu6yligz68XemS8Wy15gKIGmqYc8MpEQZNEXkgNMs/C615/tijCrXTNI6oFsvmTiQicozr6BHZC2SFhDKxZa60wiCHUoJKblcNSo7BhaRzkNyRsZPq6GMMlb2fIjDD5nAUkV8ZagqTqjd5OpFWnh06FKOP0wv4uE3QYfIO/RQozGRuszqplUXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n5o0ZA6o; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=oleksandr.shulzhenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n5o0ZA6o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=oleksandr.shulzhenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBDXg6vxCz2xPb;
	Fri, 08 May 2026 00:05:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778162709; x=1809698709;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dPp35F7u+iE4GjieIuoLvZ+oZS/hFrj5d010wTFX4OA=;
  b=n5o0ZA6ogGVkG0E+IuX4+KCDCYQkOeLADNfiAPPVGoj24Lp2EPawXN49
   5amjUpemGKBzlif52tzdrBFdVlWBSs75ietpwsTni/DUIAiwqMTSblFOt
   5CUlOtzGegReJqc8dfIuof55QG8yZUrkAsn3kIXoFzQD/WkDHIN2ehIIO
   P2pTm7zPAsF40a3JfmQzCPlHuSjXvuq+rGdx+Xk15watEMYmpwwdF7ZIp
   2nVRdx0nFsq4foVOOLeLKA3+SnrMab/XGWViwh/9fMi9gxXliw77KSKOF
   ywg5pCGXiiPPJ3t5Tl09lJTg3leJc2omwkEKm950jtTaT/3prymPEenmU
   w==;
X-CSE-ConnectionGUID: q/GSEc63Sk+MHrJjIukTMA==
X-CSE-MsgGUID: Kea+TSJSRNC0bgn/p5i+6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79049524"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="79049524"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 07:03:05 -0700
X-CSE-ConnectionGUID: 2z9pnWGBSuO1aNcXo9Ifhg==
X-CSE-MsgGUID: 4Va5ajhGQ2eo6kE1CYDHbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="236389351"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 07:03:05 -0700
Received: from [10.246.17.81] (unknown [10.246.17.81])
	by linux.intel.com (Postfix) with ESMTP id 328ED20B5713;
	Thu,  7 May 2026 07:03:00 -0700 (PDT)
Message-ID: <1d2ee312-24c0-4257-b933-d29eaf1a5fe9@linux.intel.com>
Date: Thu, 7 May 2026 16:03:00 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] soc: aspeed: Add AST2600 peripheral channel port I/O
 support
To: aspeedyh <yh_chung@aspeedtech.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, maciej.lawniczak@intel.com
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
 <20260313-upstream_espi-v1-3-9504428e1f43@aspeedtech.com>
Content-Language: en-US
From: "Shulzhenko, Oleksandr" <oleksandr.shulzhenko@linux.intel.com>
In-Reply-To: <20260313-upstream_espi-v1-3-9504428e1f43@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/2026 11:07 AM, aspeedyh wrote:
> Add initial support for the AST2600 eSPI peripheral channel handling of
> port I/O transactions used for LPC-style accesses.
>
> This patch does not yet implement peripheral memory read or write
> cycles. Support for those transactions will be added in a follow-up
> patch once the remaining transport and buffer handling pieces are in
> place.
>
> Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
> ---
>   drivers/soc/aspeed/espi/Makefile       |   2 +-
>   drivers/soc/aspeed/espi/aspeed-espi.c  |  24 +++
>   drivers/soc/aspeed/espi/ast2600-espi.c | 139 ++++++++++++++++
>   drivers/soc/aspeed/espi/ast2600-espi.h | 291 +++++++++++++++++++++++++++++++++
>   4 files changed, 455 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/aspeed/espi/Makefile b/drivers/soc/aspeed/espi/Makefile
> index d96dc030e23b..30f9dbf92a0f 100644
> --- a/drivers/soc/aspeed/espi/Makefile
> +++ b/drivers/soc/aspeed/espi/Makefile
> @@ -1 +1 @@
> -obj-y += aspeed-espi.o
> +obj-y += aspeed-espi.o ast2600-espi.o
> diff --git a/drivers/soc/aspeed/espi/aspeed-espi.c b/drivers/soc/aspeed/espi/aspeed-espi.c
> index 15d58b38bbe4..e369738119bc 100644
> --- a/drivers/soc/aspeed/espi/aspeed-espi.c
> +++ b/drivers/soc/aspeed/espi/aspeed-espi.c
> @@ -13,15 +13,28 @@
>   #include <linux/reset.h>
>   
>   #include "aspeed-espi.h"
> +#include "ast2600-espi.h"
>   
>   struct aspeed_espi_ops {
>   	void (*espi_pre_init)(struct aspeed_espi *espi);
>   	void (*espi_post_init)(struct aspeed_espi *espi);
>   	void (*espi_deinit)(struct aspeed_espi *espi);
> +	int (*espi_perif_probe)(struct aspeed_espi *espi);
> +	int (*espi_perif_remove)(struct aspeed_espi *espi);
Should it be int? I don't see any error condition returned
>   	irqreturn_t (*espi_isr)(int irq, void *espi);
>   };
>   
> +static const struct aspeed_espi_ops aspeed_espi_ast2600_ops = {
> +	.espi_pre_init = ast2600_espi_pre_init,
> +	.espi_post_init = ast2600_espi_post_init,
> +	.espi_deinit = ast2600_espi_deinit,
> +	.espi_perif_probe = ast2600_espi_perif_probe,
> +	.espi_perif_remove = ast2600_espi_perif_remove,
> +	.espi_isr = ast2600_espi_isr,
> +};
> +
>   static const struct of_device_id aspeed_espi_of_matches[] = {
> +	{ .compatible = "aspeed,ast2600-espi", .data = &aspeed_espi_ast2600_ops },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, aspeed_espi_of_matches);
> @@ -88,6 +101,14 @@ static int aspeed_espi_probe(struct platform_device *pdev)
>   	if (espi->ops->espi_pre_init)
>   		espi->ops->espi_pre_init(espi);
>   
> +	if (espi->ops->espi_perif_probe) {
> +		rc = espi->ops->espi_perif_probe(espi);
> +		if (rc) {
> +			dev_err(dev, "cannot init peripheral channel, rc=%d\n", rc);
> +			goto err_deinit;
> +		}
> +	}
> +
>   	rc = devm_request_irq(dev, espi->irq, espi->ops->espi_isr, 0,
>   			      dev_name(dev), espi);
>   	if (rc) {
> @@ -121,6 +142,9 @@ static void aspeed_espi_remove(struct platform_device *pdev)
>   	if (!espi)
>   		return;
>   
> +	if (espi->ops->espi_perif_remove)
> +		espi->ops->espi_perif_remove(espi);
> +
>   	if (espi->ops->espi_deinit)
>   		espi->ops->espi_deinit(espi);
>   
> diff --git a/drivers/soc/aspeed/espi/ast2600-espi.c b/drivers/soc/aspeed/espi/ast2600-espi.c
> new file mode 100644
> index 000000000000..8effd0404d1f
> --- /dev/null
> +++ b/drivers/soc/aspeed/espi/ast2600-espi.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright Aspeed Technology Inc.
> + */
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/reset.h>
> +
> +#include "aspeed-espi.h"
> +#include "ast2600-espi.h"
> +
> +static void ast2600_espi_perif_isr(struct aspeed_espi *espi)
> +{
> +	u32 sts;
> +
> +	sts = readl(espi->regs + ESPI_INT_STS);
> +
> +	if (sts & ESPI_INT_STS_PERIF_PC_RX_CMPLT)
> +		writel(ESPI_INT_STS_PERIF_PC_RX_CMPLT, espi->regs + ESPI_INT_STS);
> +}
> +
> +static void ast2600_espi_perif_sw_reset(struct aspeed_espi *espi)
> +{
> +	u32 reg;
> +
> +	reg = readl(espi->regs + ESPI_CTRL);
> +	reg &= ~(ESPI_CTRL_PERIF_NP_TX_SW_RST
> +		 | ESPI_CTRL_PERIF_NP_RX_SW_RST
> +		 | ESPI_CTRL_PERIF_PC_TX_SW_RST
> +		 | ESPI_CTRL_PERIF_PC_RX_SW_RST
> +		 | ESPI_CTRL_PERIF_NP_TX_DMA_EN
> +		 | ESPI_CTRL_PERIF_PC_TX_DMA_EN
> +		 | ESPI_CTRL_PERIF_PC_RX_DMA_EN
> +		 | ESPI_CTRL_PERIF_SW_RDY);
> +	writel(reg, espi->regs + ESPI_CTRL);
> +
> +	udelay(1);
> +
> +	reg |= (ESPI_CTRL_PERIF_NP_TX_SW_RST
> +		| ESPI_CTRL_PERIF_NP_RX_SW_RST
> +		| ESPI_CTRL_PERIF_PC_TX_SW_RST
> +		| ESPI_CTRL_PERIF_PC_RX_SW_RST);
> +	writel(reg, espi->regs + ESPI_CTRL);
> +}
> +
> +static void ast2600_espi_perif_reset(struct aspeed_espi *espi)
> +{
> +	u32 reg;
> +
> +	writel(ESPI_INT_EN_PERIF, espi->regs + ESPI_INT_EN_CLR);
> +	writel(ESPI_INT_STS_PERIF, espi->regs + ESPI_INT_STS);
> +
> +	writel(0x0, espi->regs + ESPI_MMBI_INT_EN);
> +	writel(0xffffffff, espi->regs + ESPI_MMBI_INT_STS);
> +
> +	reg = readl(espi->regs + ESPI_CTRL2);
> +	reg &= ~(ESPI_CTRL2_MCYC_RD_DIS_WDT | ESPI_CTRL2_MCYC_WR_DIS_WDT);
> +	writel(reg, espi->regs + ESPI_CTRL2);
> +
> +	reg = readl(espi->regs + ESPI_CTRL);
> +	reg &= ~(ESPI_CTRL_PERIF_NP_TX_DMA_EN
> +		 | ESPI_CTRL_PERIF_PC_TX_DMA_EN
> +		 | ESPI_CTRL_PERIF_PC_RX_DMA_EN
> +		 | ESPI_CTRL_PERIF_SW_RDY);
> +	writel(reg, espi->regs + ESPI_CTRL);
> +
> +	reg = readl(espi->regs + ESPI_CTRL) | ESPI_CTRL_PERIF_SW_RDY;
> +	writel(reg, espi->regs + ESPI_CTRL);
> +}
> +
> +int ast2600_espi_perif_probe(struct aspeed_espi *espi)
> +{
> +	ast2600_espi_perif_reset(espi);
> +	return 0;
> +}
> +
> +int ast2600_espi_perif_remove(struct aspeed_espi *espi)
> +{
> +	u32 reg;
> +
> +	writel(ESPI_INT_EN_PERIF, espi->regs + ESPI_INT_EN_CLR);
> +
> +	reg = readl(espi->regs + ESPI_CTRL2);
> +	reg |= (ESPI_CTRL2_MCYC_RD_DIS | ESPI_CTRL2_MCYC_WR_DIS);
> +	writel(reg, espi->regs + ESPI_CTRL2);
> +
> +	reg = readl(espi->regs + ESPI_CTRL);
> +	reg &= ~(ESPI_CTRL_PERIF_NP_TX_DMA_EN
> +		 | ESPI_CTRL_PERIF_PC_TX_DMA_EN
> +		 | ESPI_CTRL_PERIF_PC_RX_DMA_EN
> +		 | ESPI_CTRL_PERIF_SW_RDY);
> +	writel(reg, espi->regs + ESPI_CTRL);
> +	return 0;
> +}
> +
> +/* global control */
> +irqreturn_t ast2600_espi_isr(int irq, void *arg)
> +{
> +	struct aspeed_espi *espi;
> +	u32 sts;
> +
> +	espi = (struct aspeed_espi *)arg;
> +	sts = readl(espi->regs + ESPI_INT_STS);
> +
> +	if (!sts)
> +		return IRQ_NONE;
> +
> +	if (sts & ESPI_INT_STS_PERIF)
> +		ast2600_espi_perif_isr(espi);
> +
> +	if (sts & ESPI_INT_STS_RST_DEASSERT) {
> +		/* this will clear all interrupt enable and status */
> +		reset_control_assert(espi->rst);
> +		reset_control_deassert(espi->rst);
> +
> +		ast2600_espi_perif_sw_reset(espi);
> +		ast2600_espi_perif_reset(espi);
> +
> +		/* re-enable eSPI_RESET# interrupt */
> +		writel(ESPI_INT_EN_RST_DEASSERT, espi->regs + ESPI_INT_EN);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +void ast2600_espi_pre_init(struct aspeed_espi *espi)
> +{
> +	writel(ESPI_INT_EN_RST_DEASSERT, espi->regs + ESPI_INT_EN_CLR);
> +}
> +
> +void ast2600_espi_post_init(struct aspeed_espi *espi)
> +{
> +	writel(ESPI_INT_EN_RST_DEASSERT, espi->regs + ESPI_INT_EN);
> +}
> +
> +void ast2600_espi_deinit(struct aspeed_espi *espi)
> +{
> +	writel(ESPI_INT_EN_RST_DEASSERT, espi->regs + ESPI_INT_EN_CLR);
> +}
> diff --git a/drivers/soc/aspeed/espi/ast2600-espi.h b/drivers/soc/aspeed/espi/ast2600-espi.h
> new file mode 100644
> index 000000000000..309479ee1187
> --- /dev/null
> +++ b/drivers/soc/aspeed/espi/ast2600-espi.h
> @@ -0,0 +1,291 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Register definitions for Aspeed AST2600 eSPI controller
> + * Copyright 2026 Aspeed Technology Inc.
> + */
> +#ifndef AST2600_ESPI_H
> +#define AST2600_ESPI_H
> +
> +#include <linux/bits.h>
> +#include <linux/irqreturn.h>
> +#include "aspeed-espi.h"
> +
> +/* registers */
> +#define ESPI_CTRL				0x000
> +#define   ESPI_CTRL_FLASH_TX_SW_RST		BIT(31)
> +#define   ESPI_CTRL_FLASH_RX_SW_RST		BIT(30)
> +#define   ESPI_CTRL_OOB_TX_SW_RST		BIT(29)
> +#define   ESPI_CTRL_OOB_RX_SW_RST		BIT(28)
> +#define   ESPI_CTRL_PERIF_NP_TX_SW_RST		BIT(27)
> +#define   ESPI_CTRL_PERIF_NP_RX_SW_RST		BIT(26)
> +#define   ESPI_CTRL_PERIF_PC_TX_SW_RST		BIT(25)
> +#define   ESPI_CTRL_PERIF_PC_RX_SW_RST		BIT(24)
> +#define   ESPI_CTRL_FLASH_TX_DMA_EN		BIT(23)
> +#define   ESPI_CTRL_FLASH_RX_DMA_EN		BIT(22)
> +#define   ESPI_CTRL_OOB_TX_DMA_EN		BIT(21)
> +#define   ESPI_CTRL_OOB_RX_DMA_EN		BIT(20)
> +#define   ESPI_CTRL_PERIF_NP_TX_DMA_EN		BIT(19)
> +#define   ESPI_CTRL_PERIF_PC_TX_DMA_EN		BIT(17)
> +#define   ESPI_CTRL_PERIF_PC_RX_DMA_EN		BIT(16)
> +#define   ESPI_CTRL_FLASH_EDAF_MODE		GENMASK(11, 10)
> +#define   ESPI_CTRL_VW_GPIO_SW			BIT(9)
> +#define   ESPI_CTRL_FLASH_SW_RDY		BIT(7)
> +#define   ESPI_CTRL_OOB_SW_RDY			BIT(4)
> +#define   ESPI_CTRL_VW_SW_RDY			BIT(3)
> +#define   ESPI_CTRL_PERIF_SW_RDY		BIT(1)
> +#define ESPI_STS				0x004
> +#define ESPI_INT_STS				0x008
> +#define   ESPI_INT_STS_RST_DEASSERT		BIT(31)
> +#define   ESPI_INT_STS_OOB_RX_TMOUT		BIT(23)
> +#define   ESPI_INT_STS_VW_SYSEVT1		BIT(22)
> +#define   ESPI_INT_STS_FLASH_TX_ERR		BIT(21)
> +#define   ESPI_INT_STS_OOB_TX_ERR		BIT(20)
> +#define   ESPI_INT_STS_FLASH_TX_ABT		BIT(19)
> +#define   ESPI_INT_STS_OOB_TX_ABT		BIT(18)
> +#define   ESPI_INT_STS_PERIF_NP_TX_ABT		BIT(17)
> +#define   ESPI_INT_STS_PERIF_PC_TX_ABT		BIT(16)
> +#define   ESPI_INT_STS_FLASH_RX_ABT		BIT(15)
> +#define   ESPI_INT_STS_OOB_RX_ABT		BIT(14)
> +#define   ESPI_INT_STS_PERIF_NP_RX_ABT		BIT(13)
> +#define   ESPI_INT_STS_PERIF_PC_RX_ABT		BIT(12)
> +#define   ESPI_INT_STS_PERIF_NP_TX_ERR		BIT(11)
> +#define   ESPI_INT_STS_PERIF_PC_TX_ERR		BIT(10)
> +#define   ESPI_INT_STS_VW_GPIO			BIT(9)
> +#define   ESPI_INT_STS_VW_SYSEVT		BIT(8)
> +#define   ESPI_INT_STS_FLASH_TX_CMPLT		BIT(7)
> +#define   ESPI_INT_STS_FLASH_RX_CMPLT		BIT(6)
> +#define   ESPI_INT_STS_OOB_TX_CMPLT		BIT(5)
> +#define   ESPI_INT_STS_OOB_RX_CMPLT		BIT(4)
> +#define   ESPI_INT_STS_PERIF_NP_TX_CMPLT	BIT(3)
> +#define   ESPI_INT_STS_PERIF_PC_TX_CMPLT	BIT(1)
> +#define   ESPI_INT_STS_PERIF_PC_RX_CMPLT	BIT(0)
> +#define ESPI_INT_EN				0x00c
> +#define   ESPI_INT_EN_RST_DEASSERT		BIT(31)
> +#define   ESPI_INT_EN_OOB_RX_TMOUT		BIT(23)
> +#define   ESPI_INT_EN_VW_SYSEVT1		BIT(22)
> +#define   ESPI_INT_EN_FLASH_TX_ERR		BIT(21)
> +#define   ESPI_INT_EN_OOB_TX_ERR		BIT(20)
> +#define   ESPI_INT_EN_FLASH_TX_ABT		BIT(19)
> +#define   ESPI_INT_EN_OOB_TX_ABT		BIT(18)
> +#define   ESPI_INT_EN_PERIF_NP_TX_ABT		BIT(17)
> +#define   ESPI_INT_EN_PERIF_PC_TX_ABT		BIT(16)
> +#define   ESPI_INT_EN_FLASH_RX_ABT		BIT(15)
> +#define   ESPI_INT_EN_OOB_RX_ABT		BIT(14)
> +#define   ESPI_INT_EN_PERIF_NP_RX_ABT		BIT(13)
> +#define   ESPI_INT_EN_PERIF_PC_RX_ABT		BIT(12)
> +#define   ESPI_INT_EN_PERIF_NP_TX_ERR		BIT(11)
> +#define   ESPI_INT_EN_PERIF_PC_TX_ERR		BIT(10)
> +#define   ESPI_INT_EN_VW_GPIO			BIT(9)
> +#define   ESPI_INT_EN_VW_SYSEVT			BIT(8)
> +#define   ESPI_INT_EN_FLASH_TX_CMPLT		BIT(7)
> +#define   ESPI_INT_EN_FLASH_RX_CMPLT		BIT(6)
> +#define   ESPI_INT_EN_OOB_TX_CMPLT		BIT(5)
> +#define   ESPI_INT_EN_OOB_RX_CMPLT		BIT(4)
> +#define   ESPI_INT_EN_PERIF_NP_TX_CMPLT		BIT(3)
> +#define   ESPI_INT_EN_PERIF_PC_TX_CMPLT		BIT(1)
> +#define   ESPI_INT_EN_PERIF_PC_RX_CMPLT		BIT(0)
> +#define ESPI_PERIF_PC_RX_DMA			0x010
> +#define ESPI_PERIF_PC_RX_CTRL			0x014
> +#define   ESPI_PERIF_PC_RX_CTRL_SERV_PEND	BIT(31)
> +#define   ESPI_PERIF_PC_RX_CTRL_LEN		GENMASK(23, 12)
> +#define   ESPI_PERIF_PC_RX_CTRL_TAG		GENMASK(11, 8)
> +#define   ESPI_PERIF_PC_RX_CTRL_CYC		GENMASK(7, 0)
> +#define ESPI_PERIF_PC_RX_DATA			0x018
> +#define ESPI_PERIF_PC_TX_DMA			0x020
> +#define ESPI_PERIF_PC_TX_CTRL			0x024
> +#define	  ESPI_PERIF_PC_TX_CTRL_TRIG_PEND	BIT(31)
> +#define	  ESPI_PERIF_PC_TX_CTRL_LEN		GENMASK(23, 12)
> +#define	  ESPI_PERIF_PC_TX_CTRL_TAG		GENMASK(11, 8)
> +#define	  ESPI_PERIF_PC_TX_CTRL_CYC		GENMASK(7, 0)
> +#define ESPI_PERIF_PC_TX_DATA			0x028
> +#define ESPI_PERIF_NP_TX_DMA			0x030
> +#define ESPI_PERIF_NP_TX_CTRL			0x034
> +#define   ESPI_PERIF_NP_TX_CTRL_TRIG_PEND	BIT(31)
> +#define	  ESPI_PERIF_NP_TX_CTRL_LEN		GENMASK(23, 12)
> +#define	  ESPI_PERIF_NP_TX_CTRL_TAG		GENMASK(11, 8)
> +#define	  ESPI_PERIF_NP_TX_CTRL_CYC		GENMASK(7, 0)
> +#define ESPI_PERIF_NP_TX_DATA			0x038
> +#define ESPI_OOB_RX_DMA				0x040
> +#define ESPI_OOB_RX_CTRL			0x044
> +#define	  ESPI_OOB_RX_CTRL_SERV_PEND		BIT(31)
> +#define	  ESPI_OOB_RX_CTRL_LEN			GENMASK(23, 12)
> +#define	  ESPI_OOB_RX_CTRL_TAG			GENMASK(11, 8)
> +#define	  ESPI_OOB_RX_CTRL_CYC			GENMASK(7, 0)
> +#define ESPI_OOB_RX_DATA			0x048
> +#define ESPI_OOB_TX_DMA				0x050
> +#define ESPI_OOB_TX_CTRL			0x054
> +#define	  ESPI_OOB_TX_CTRL_TRIG_PEND		BIT(31)
> +#define	  ESPI_OOB_TX_CTRL_LEN			GENMASK(23, 12)
> +#define	  ESPI_OOB_TX_CTRL_TAG			GENMASK(11, 8)
> +#define	  ESPI_OOB_TX_CTRL_CYC			GENMASK(7, 0)
> +#define ESPI_OOB_TX_DATA			0x058
> +#define ESPI_FLASH_RX_DMA			0x060
> +#define ESPI_FLASH_RX_CTRL			0x064
> +#define	  ESPI_FLASH_RX_CTRL_SERV_PEND		BIT(31)
> +#define	  ESPI_FLASH_RX_CTRL_LEN		GENMASK(23, 12)
> +#define	  ESPI_FLASH_RX_CTRL_TAG		GENMASK(11, 8)
> +#define	  ESPI_FLASH_RX_CTRL_CYC		GENMASK(7, 0)
> +#define ESPI_FLASH_RX_DATA			0x068
> +#define ESPI_FLASH_TX_DMA			0x070
> +#define ESPI_FLASH_TX_CTRL			0x074
> +#define	  ESPI_FLASH_TX_CTRL_TRIG_PEND		BIT(31)
> +#define	  ESPI_FLASH_TX_CTRL_LEN		GENMASK(23, 12)
> +#define	  ESPI_FLASH_TX_CTRL_TAG		GENMASK(11, 8)
> +#define	  ESPI_FLASH_TX_CTRL_CYC		GENMASK(7, 0)
> +#define ESPI_FLASH_TX_DATA			0x078
> +#define ESPI_CTRL2				0x080
> +#define   ESPI_CTRL2_VW_TX_SORT			BIT(30)
> +#define   ESPI_CTRL2_MCYC_RD_DIS_WDT		BIT(11)
> +#define   ESPI_CTRL2_MCYC_WR_DIS_WDT		BIT(10)
> +#define   ESPI_CTRL2_MCYC_RD_DIS		BIT(6)
> +#define   ESPI_CTRL2_MMBI_RD_DIS		ESPI_CTRL2_MCYC_RD_DIS
> +#define   ESPI_CTRL2_MCYC_WR_DIS		BIT(4)
> +#define   ESPI_CTRL2_MMBI_WR_DIS		ESPI_CTRL2_MCYC_WR_DIS
> +#define ESPI_PERIF_MCYC_SADDR			0x084
> +#define ESPI_PERIF_MMBI_SADDR			ESPI_PERIF_MCYC_SADDR
> +#define ESPI_PERIF_MCYC_TADDR			0x088
> +#define ESPI_PERIF_MMBI_TADDR			ESPI_PERIF_MCYC_TADDR
> +#define ESPI_PERIF_MCYC_MASK			0x08c
> +#define ESPI_PERIF_MMBI_MASK			ESPI_PERIF_MCYC_MASK
> +#define ESPI_FLASH_EDAF_TADDR			0x090
> +#define   ESPI_FLASH_EDAF_TADDR_BASE		GENMASK(31, 24)
> +#define   ESPI_FLASH_EDAF_TADDR_MASK		GENMASK(15, 8)
> +#define ESPI_VW_SYSEVT_INT_EN			0x094
> +#define ESPI_VW_SYSEVT				0x098
> +#define   ESPI_VW_SYSEVT_HOST_RST_ACK		BIT(27)
> +#define   ESPI_VW_SYSEVT_RST_CPU_INIT		BIT(26)
> +#define   ESPI_VW_SYSEVT_SLV_BOOT_STS		BIT(23)
> +#define   ESPI_VW_SYSEVT_NON_FATAL_ERR		BIT(22)
> +#define   ESPI_VW_SYSEVT_FATAL_ERR		BIT(21)
> +#define   ESPI_VW_SYSEVT_SLV_BOOT_DONE		BIT(20)
> +#define   ESPI_VW_SYSEVT_OOB_RST_ACK		BIT(16)
> +#define   ESPI_VW_SYSEVT_NMI_OUT		BIT(10)
> +#define   ESPI_VW_SYSEVT_SMI_OUT		BIT(9)
> +#define   ESPI_VW_SYSEVT_HOST_RST_WARN		BIT(8)
> +#define   ESPI_VW_SYSEVT_OOB_RST_WARN		BIT(6)
> +#define   ESPI_VW_SYSEVT_PLTRSTN		BIT(5)
> +#define   ESPI_VW_SYSEVT_SUSPEND		BIT(4)
> +#define   ESPI_VW_SYSEVT_S5_SLEEP		BIT(2)
> +#define   ESPI_VW_SYSEVT_S4_SLEEP		BIT(1)
> +#define   ESPI_VW_SYSEVT_S3_SLEEP		BIT(0)
> +#define ESPI_VW_GPIO_VAL			0x09c
> +#define ESPI_GEN_CAP_N_CONF			0x0a0
> +#define ESPI_CH0_CAP_N_CONF			0x0a4
> +#define ESPI_CH1_CAP_N_CONF			0x0a8
> +#define ESPI_CH2_CAP_N_CONF			0x0ac
> +#define ESPI_CH3_CAP_N_CONF			0x0b0
> +#define ESPI_CH3_CAP_N_CONF2			0x0b4
> +#define ESPI_VW_GPIO_DIR			0x0c0
> +#define ESPI_VW_GPIO_GRP			0x0c4
> +#define ESPI_INT_EN_CLR				0x0fc
> +#define ESPI_VW_SYSEVT1_INT_EN			0x100
> +#define ESPI_VW_SYSEVT1				0x104
> +#define   ESPI_VW_SYSEVT1_SUSPEND_ACK		BIT(20)
> +#define   ESPI_VW_SYSEVT1_SUSPEND_WARN		BIT(0)
> +#define ESPI_VW_SYSEVT_INT_T0			0x110
> +#define ESPI_VW_SYSEVT_INT_T1			0x114
> +#define ESPI_VW_SYSEVT_INT_T2			0x118
> +#define ESPI_VW_SYSEVT_INT_STS			0x11c
> +#define ESPI_VW_SYSEVT1_INT_T0			0x120
> +#define ESPI_VW_SYSEVT1_INT_T1			0x124
> +#define ESPI_VW_SYSEVT1_INT_T2			0x128
> +#define ESPI_VW_SYSEVT1_INT_STS			0x12c
> +#define ESPI_OOB_RX_DESC_NUM			0x130
> +#define ESPI_OOB_RX_DESC_RPTR			0x134
> +#define	  ESPI_OOB_RX_DESC_RPTR_UPDATE		BIT(31)
> +#define   ESPI_OOB_RX_DESC_RPTR_RP		GENMASK(11, 0)
> +#define ESPI_OOB_RX_DESC_WPTR			0x138
> +#define   ESPI_OOB_RX_DESC_WPTR_RECV_EN		BIT(31)
> +#define   ESPI_OOB_RX_DESC_WPTR_SP		GENMASK(27, 16)
> +#define   ESPI_OOB_RX_DESC_WPTR_WP		GENMASK(11, 0)
> +#define ESPI_OOB_TX_DESC_NUM			0x140
> +#define ESPI_OOB_TX_DESC_RPTR			0x144
> +#define	  ESPI_OOB_TX_DESC_RPTR_UPDATE		BIT(31)
> +#define ESPI_OOB_TX_DESC_WPTR			0x148
> +#define	  ESPI_OOB_TX_DESC_WPTR_SEND_EN		BIT(31)
> +#define ESPI_MMBI_CTRL				0x800
> +#define   ESPI_MMBI_CTRL_INST_SZ		GENMASK(10, 8)
> +#define   ESPI_MMBI_CTRL_TOTAL_SZ		GENMASK(6, 4)
> +#define   ESPI_MMBI_CTRL_EN			BIT(0)
> +#define ESPI_MMBI_INT_STS			0x808
> +#define ESPI_MMBI_INT_EN			0x80c
> +#define ESPI_MMBI_HOST_RWP(x)			(0x810 + ((x) << 3))
> +
> +/* collect ESPI_INT_EN bits for convenience */
> +#define ESPI_INT_EN_PERIF			\
> +	(ESPI_INT_EN_PERIF_NP_TX_ABT |		\
> +	 ESPI_INT_EN_PERIF_PC_TX_ABT |		\
> +	 ESPI_INT_EN_PERIF_NP_RX_ABT |		\
> +	 ESPI_INT_EN_PERIF_PC_RX_ABT |		\
> +	 ESPI_INT_EN_PERIF_NP_TX_ERR |		\
> +	 ESPI_INT_EN_PERIF_PC_TX_ERR |		\
> +	 ESPI_INT_EN_PERIF_NP_TX_CMPLT |	\
> +	 ESPI_INT_EN_PERIF_PC_TX_CMPLT |	\
> +	 ESPI_INT_EN_PERIF_PC_RX_CMPLT)
> +
> +#define ESPI_INT_EN_VW			\
> +	(ESPI_INT_EN_VW_SYSEVT1 |	\
> +	 ESPI_INT_EN_VW_GPIO    |	\
> +	 ESPI_INT_EN_VW_SYSEVT)
> +
> +#define ESPI_INT_EN_OOB		\
> +	(ESPI_INT_EN_OOB_RX_TMOUT |	\
> +	 ESPI_INT_EN_OOB_TX_ERR |	\
> +	 ESPI_INT_EN_OOB_TX_ABT |	\
> +	 ESPI_INT_EN_OOB_RX_ABT |	\
> +	 ESPI_INT_EN_OOB_TX_CMPLT |	\
> +	 ESPI_INT_EN_OOB_RX_CMPLT)
> +
> +#define ESPI_INT_EN_FLASH		\
> +	(ESPI_INT_EN_FLASH_TX_ERR |	\
> +	 ESPI_INT_EN_FLASH_TX_ABT |	\
> +	 ESPI_INT_EN_FLASH_RX_ABT |	\
> +	 ESPI_INT_EN_FLASH_TX_CMPLT |	\
> +	 ESPI_INT_EN_FLASH_RX_CMPLT)
> +
> +/* collect ESPI_INT_STS bits for convenience */
> +#define ESPI_INT_STS_PERIF			\
> +	(ESPI_INT_STS_PERIF_NP_TX_ABT |		\
> +	 ESPI_INT_STS_PERIF_PC_TX_ABT |		\
> +	 ESPI_INT_STS_PERIF_NP_RX_ABT |		\
> +	 ESPI_INT_STS_PERIF_PC_RX_ABT |		\
> +	 ESPI_INT_STS_PERIF_NP_TX_ERR |		\
> +	 ESPI_INT_STS_PERIF_PC_TX_ERR |		\
> +	 ESPI_INT_STS_PERIF_NP_TX_CMPLT |	\
> +	 ESPI_INT_STS_PERIF_PC_TX_CMPLT |	\
> +	 ESPI_INT_STS_PERIF_PC_RX_CMPLT)
> +
> +#define ESPI_INT_STS_VW			\
> +	(ESPI_INT_STS_VW_SYSEVT1 |	\
> +	 ESPI_INT_STS_VW_GPIO    |	\
> +	 ESPI_INT_STS_VW_SYSEVT)
> +
> +#define ESPI_INT_STS_OOB		\
> +	(ESPI_INT_STS_OOB_RX_TMOUT |	\
> +	 ESPI_INT_STS_OOB_TX_ERR |	\
> +	 ESPI_INT_STS_OOB_TX_ABT |	\
> +	 ESPI_INT_STS_OOB_RX_ABT |	\
> +	 ESPI_INT_STS_OOB_TX_CMPLT |	\
> +	 ESPI_INT_STS_OOB_RX_CMPLT)
> +
> +#define ESPI_INT_STS_FLASH		\
> +	(ESPI_INT_STS_FLASH_TX_ERR |	\
> +	 ESPI_INT_STS_FLASH_TX_ABT |	\
> +	 ESPI_INT_STS_FLASH_RX_ABT |	\
> +	 ESPI_INT_STS_FLASH_TX_CMPLT |	\
> +	 ESPI_INT_STS_FLASH_RX_CMPLT)
> +
> +/* function operators */
> +void ast2600_espi_pre_init(struct aspeed_espi *espi);
> +void ast2600_espi_post_init(struct aspeed_espi *espi);
> +void ast2600_espi_deinit(struct aspeed_espi *espi);
> +int ast2600_espi_perif_probe(struct aspeed_espi *espi);
> +int ast2600_espi_perif_remove(struct aspeed_espi *espi);
> +int ast2600_espi_vw_probe(struct aspeed_espi *espi);
> +int ast2600_espi_vw_remove(struct aspeed_espi *espi);
> +int ast2600_espi_oob_probe(struct aspeed_espi *espi);
> +int ast2600_espi_oob_remove(struct aspeed_espi *espi);
> +int ast2600_espi_flash_probe(struct aspeed_espi *espi);
> +int ast2600_espi_flash_remove(struct aspeed_espi *espi);
> +irqreturn_t ast2600_espi_isr(int irq, void *arg);
> +#endif
>


