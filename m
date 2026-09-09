Return-Path: <linux-aspeed+bounces-4979-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6044EC79FB6
	for <linux-aspeed@archiver.kernel.org>; Wed,  9 Sep 2026 23:43:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgHSr4fK6z3000;
	Thu, 10 Sep 2026 09:43:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788942721;
	cv=none; b=Xnk71w1lutDSGnxcA79b/EngemIWJemIzO4FRibtLHnn7wprSVmbxQE7ZLGqe3C+KYxYZ5fAxO29HLNM613SANR0YuN/txsPoeYn6LoP/8jDHY4e3NM+OYC4Bm9oXjZLQwp63ALSBZjA0RrpC15oIiifdzacTkxAsN9L/F+SeT1icFAFyRCTDutYtuMyKE01koOFiVyKwBdYA/ZRk1gi8Ivemr5XU0a7hTxS3fhfcfI2cPUftp8cq+C/9VRzACQyGp24Nqs8xprmZfqiITYSl1jiGNSujNN/pW1PCUN4TbmQzC6ztWl7ifPohhNlB40YrObq12gltpDEM2ob+WFK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788942721; c=relaxed/relaxed;
	bh=u90H3kvPiANnjYuJutZLUXCAY3/LlIec8aBZfM+ga7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJv54Ee3WNZ8SefdNis6Wg0Xn34HuVis7SoE8bdTzdgshZ5Bn2bYat/7JK+q4fSLXoeuTQ1M/+f8cNVrxGYKqBsUeBfPEAM9k8R9MkIV2c5VeBgSSyHuwHucqSE7lxuTq4CMi0axI9dbFdKCN+R+61OAO4ViLejOy5a9mY1olzo0elZNNgeq6RLK+rr3HcEssL9XRbaKUKClz45yn3xUX2zrYyH7VWxYK1sR1WP+H/TtONNZi/tYJShkx1NocZwQcX74X5MoxEgkULL2ojrcKwmJ3TVem5zudjpZuxpV2SImfkJ3Bp7R9pf7lrjrDndS1MqAK66GklvK2E3uap8IjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkuxpnB9; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkuxpnB9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvDc2n10z2ynZ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 09 Sep 2026 18:32:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EEBE1444EE;
	Wed,  9 Sep 2026 08:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BC11F00ADE;
	Wed,  9 Sep 2026 08:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788942686;
	bh=u90H3kvPiANnjYuJutZLUXCAY3/LlIec8aBZfM+ga7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AkuxpnB9gDnuD2XgPNSBlab6Z3PdHQZERsEVWHElRJ50N0hxy2uK6t/K1p5LnwKSd
	 qtR1Nn0oxXrp0Vq+zyk+Z9Ldye+U20odLWC1zmFhuQHw+ZhZHnC2TalDrd33l0VRd7
	 1+QjeDcfUDEXZ1/SI2cx5uvOLd8pEIuiOXVgaRQ5KL8UYBmPlur7NIfdjKU1Kthi42
	 XTXaN594AG5csFXG3PaK+GpEJFgrVjM9K7MKptTJWizdRoTqfSWWx/weuKBsITT+gd
	 uV66BafxxOZ3yiFCyIyskHjvm/Ps6rvzZf6aC4+nxYgZ//jhHHqt8qgqLb11IRQEb+
	 75bsSLWIb6ndA==
Date: Wed, 9 Sep 2026 10:31:17 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] phy: aspeed: Add AST2700 USB3.2 PHY driver
Message-ID: <5oamvlreciw524g3bpbemcpdpljc7thilejy6s4kwmt5hdjwcp@xmaef4eaurzk>
References: <20260701-upstream_usb3phy-v3-0-00e12315b6f9@aspeedtech.com>
 <20260701-upstream_usb3phy-v3-2-00e12315b6f9@aspeedtech.com>
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
In-Reply-To: <20260701-upstream_usb3phy-v3-2-00e12315b6f9@aspeedtech.com>

On Wed, Jul 01, 2026 at 02:58:18PM +0800, Ryan Chen wrote:
> Add AST2700 USB3.2 PHY driver support.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Just couple of nitpicks below. Once they are addressed:

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

> ---
>  drivers/phy/Kconfig                  |   1 +
>  drivers/phy/Makefile                 |   1 +
>  drivers/phy/aspeed/Kconfig           |  15 +++
>  drivers/phy/aspeed/Makefile          |   2 +
>  drivers/phy/aspeed/phy-aspeed-usb3.c | 236 +++++++++++++++++++++++++++++++++++
>  5 files changed, 255 insertions(+)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 19f3b7d12b7d..85fa381978f8 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -171,6 +171,7 @@ config PHY_XGENE
>  source "drivers/phy/allwinner/Kconfig"
>  source "drivers/phy/amlogic/Kconfig"
>  source "drivers/phy/apple/Kconfig"
> +source "drivers/phy/aspeed/Kconfig"
>  source "drivers/phy/axiado/Kconfig"
>  source "drivers/phy/broadcom/Kconfig"
>  source "drivers/phy/cadence/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index d7aa516bcc49..c6dd02003bbe 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
>  obj-$(CONFIG_GENERIC_PHY)		+= allwinner/	\
>  					   amlogic/	\
>  					   apple/	\
> +					   aspeed/	\
>  					   axiado/	\
>  					   broadcom/	\
>  					   cadence/	\
> diff --git a/drivers/phy/aspeed/Kconfig b/drivers/phy/aspeed/Kconfig
> new file mode 100644
> index 000000000000..7b5f48db2be8
> --- /dev/null
> +++ b/drivers/phy/aspeed/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +#
> +# PHY drivers for ASPEED
> +#
> +
> +config PHY_ASPEED_USB3
> +	tristate "ASPEED USB3 PHY driver"
> +	select GENERIC_PHY
> +	depends on (ARCH_ASPEED || COMPILE_TEST)
> +	help
> +	  Enable this to support the USB 3.2 PHY on the Aspeed AST2700 SoC.
> +	  It supports SuperSpeedPlus Gen2x1 (10 Gbps), SuperSpeed (5 Gbps),
> +	  High Speed (480 Mbps), Full Speed (12 Mbps) and Low Speed
> +	  (1.5 Mbps), and is paired with the DWC3 USB controller.
> diff --git a/drivers/phy/aspeed/Makefile b/drivers/phy/aspeed/Makefile
> new file mode 100644
> index 000000000000..d96d9d73a009
> --- /dev/null
> +++ b/drivers/phy/aspeed/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_PHY_ASPEED_USB3)		+= phy-aspeed-usb3.o
> diff --git a/drivers/phy/aspeed/phy-aspeed-usb3.c b/drivers/phy/aspeed/phy-aspeed-usb3.c
> new file mode 100644
> index 000000000000..eff148faa14c
> --- /dev/null
> +++ b/drivers/phy/aspeed/phy-aspeed-usb3.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2026 Aspeed Technology Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +#define PHY3S00		0x00
> +#define PHY3S00_INIT_DONE		BIT(15)
> +#define PHY3S00_SRAM_BYPASS		BIT(7)
> +#define PHY3S00_SRAM_EXT_LOAD	BIT(6)

If you want to mix register offsets and bitfield definitions, then you need to
use indent to differentiate:

	#define PHY3S00			0x00
	#define  PHY3S00_INIT_DONE	BIT(15)
	#define  PHY3S00_SRAM_BYPASS	BIT(7)
	...
	#define PHY3S04			0x04
	...

> +#define PHY3S04		0x04
> +#define PHY3C00		0x08
> +#define PHY3C04		0x0C

Use lowercaps for all hex values

- Mani

-- 
மணிவண்ணன் சதாசிவம்

