Return-Path: <linux-aspeed+bounces-3341-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2ECD41150
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Jan 2026 09:53:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsJFg6G1cz2yFm;
	Thu, 15 Jan 2026 20:53:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768470791;
	cv=none; b=OsFDOsVC9pa4UWOvknXsorKh31j62EJnfSe6HB70Kj74vxzSeT4hZyCc8Y0eFa9TuRga/PTd6BdFKVxOW+KFteIb77xLr3MavpII7l5xpW1YaySuUfe2+MivufTB7simfJoE4yZZmNGkwwMBErZpwyd4GVWZmnREI0Lfgoc8HBvz7oKlCnjBXXprvxSLt2Xrs8q5nbRFpnMNh1iq/O2AhTk/zLlWbExWptlSqEtSHYUOPvLeYe7ZbS71fhq2Uk6dxrwVvWgF5nRtfYBguSSyz4X+DZRii8ghz+HRbVB86+/ZNh7PLV2sNZTP1J4T3R6Vo66TK0KLLgtgwoqix4YAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768470791; c=relaxed/relaxed;
	bh=34ePLiQweY9GaVt0+JeMBd4C7K5vjm7UpK2K4R8k86w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQarF/Fa27QiG+/KlRsRJgZP6uKcXaKL1k2VvTGuncEievpvK9ikfN32xtnYTfJSJBHhh+G0qTrHBG+qDuSrnV0MPD7MCNjrZR6kEV+AQLNTCnIsgRm3mBERwono2H0Mp/Qr2naft7bN5ec2U0/SsHFiR186Ooc6koMaEK2bc9y6jfNFwxnTF8+LXQoH390hSHztLLNRYXpZnQdGNYRowqT91uoA2jhOuEo7fy+ATi4eo+KrDIiH+CxTFAxGkjuSr/sbwm+g9i94o9LZCD/2JXH2lRKWPU1wq/BTLPrBXSxbMH0jfz4HPyYdxkSw/ujvsOTsSpZ1wFj69ene5veQpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SEb+448v; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SEb+448v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsJFg28P4z2xNg
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 20:53:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2397B601B9;
	Thu, 15 Jan 2026 09:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D54CC116D0;
	Thu, 15 Jan 2026 09:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768470788;
	bh=nQRGCmfmTv/HFL3TGgfPhp5kkEYvJqdN5RCn3LswyN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SEb+448vdOLkMsqGqmm0r51xQieYMuN9whjnOzn4yQXYQueUi2b3wJijiiBXFQKHh
	 vMjUi9ELwJx1NtfnQAWQIaWi5vuNYyaCkeWxCeVBYFb7wlXbuTqB47Pq+yHplO34/p
	 e04Q5DJm4FtFwXf77ev6yugp+uUgJ0OY2we+6CyfBpoWoYF6l4aVtuxEzVsZAg2X/F
	 JrcFBBk9IvPQpz8hqDdObSP6ckWaPhvMxdR9u4/RhPaGNzUyi6lowmf2rBh3F3VVNw
	 AYEVLGihQzQFfc5bO7VjTGroJzZCzRXJV0tErqiv/7JUT0WmF1qXrcJMtAJ7g7gKsf
	 Dhi+Fp29CRTZg==
Date: Thu, 15 Jan 2026 10:53:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] phy: add AST2700 usb3.2 phy driver
Message-ID: <20260115-jaguarundi-of-optimal-fruition-09d32e@quoll>
References: <20260114-upstream_usb3phy-v1-0-2e59590be2d7@aspeedtech.com>
 <20260114-upstream_usb3phy-v1-2-2e59590be2d7@aspeedtech.com>
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
In-Reply-To: <20260114-upstream_usb3phy-v1-2-2e59590be2d7@aspeedtech.com>

On Wed, Jan 14, 2026 at 03:13:11PM +0800, Ryan Chen wrote:
> Add AST2700 USB3.2 PHY driver support.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/phy/aspeed/Kconfig           |  13 ++
>  drivers/phy/aspeed/Makefile          |   2 +
>  drivers/phy/aspeed/phy-aspeed-usb3.c | 236 +++++++++++++++++++++++++++++++++++
>  3 files changed, 251 insertions(+)
> 
> diff --git a/drivers/phy/aspeed/Kconfig b/drivers/phy/aspeed/Kconfig
> new file mode 100644
> index 000000000000..93bb5a913633
> --- /dev/null
> +++ b/drivers/phy/aspeed/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +#
> +# PHY drivers for ASPEED
> +#
> +
> +config PHY_ASPEED_USB3
> +	tristate "ASPEED USB3 PHY driver"
> +	select GENERIC_PHY
> +	depends on ARCH_ASPEED

COMPILE_TEST

> +	default n

It's the default, so maybe you meant 'ARCH_ASPEED'?

Best regards,
Krzysztof


