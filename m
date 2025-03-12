Return-Path: <linux-aspeed+bounces-984-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F49C28B28
	for <linux-aspeed@archiver.kernel.org>; Thu, 13 Mar 2025 04:26:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZCvZb4Ttzz30TK;
	Thu, 13 Mar 2025 15:26:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741810903;
	cv=none; b=JiM1J4Z+Mu5W5S975R6iZeeMEC7RQ1HIkYNWEMYjK2cIwsAJ//9ktl9YSfSTw+zo/Xs04TSR2pI2aEFr1Wtm0tnGE5bvLgbIaecILzfyQByYZThmdXxviqkGI4VEmkqPuYXuJuKmEnFPbP+BlOu1HiWF1skiAa9PbbWm0zosPmoJt2kjgsZ94W4sVSON7se/omE20/HQkmPpOgSU3OwS9wF4u+gwHTKj2leWEAa4JdbXwHiztqowVK0h6NBoW+AQfK4u2G+MFcwSx3/6CugoppbPXRSwdJylzuZ09e4VgvOKZ45JgsIFGIRq3lp3GUoaBOZLrmX6dMF2xmz2q5qwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741810903; c=relaxed/relaxed;
	bh=XJq56dJU39DFehvtgnhOtq4RDHwyEOqLxQdWadwXTOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoqeoM8b60asa/ougpKcHIS+nOUCOm70S9wJ1DHyKt2fN3jUSVlvq/hzLRm/XSBMHOzgdC2pIf3cUFk4jFCuIsFAQj15C28glPsObWkQmlp8CfkUDgxWQgAGhNl11DtzqVJHS5jGaVQbpY5CBxhRlk4LUI245SDnFhOrRhjnY+YeFWURrcPdUhhbwB5ySEqv7kpi/7YoDyiutr+BmWuYd6PJyqpnmcrPQYsFMuhYGPJaFkU1z6V5VVI6L+vScKrGiyRziCvcDjcECU/FxUpu6Nbf8Bi8BLMA+S+Rzkx6LdqOaiL6ZPhXyEeGF2CdvujTCE90gqWsNLk4W/6ndnhBHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hwW7OVW3; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hwW7OVW3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZChqV3vwZz30T1
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Mar 2025 07:21:42 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2ECD3A471C0;
	Wed, 12 Mar 2025 20:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86521C4CEDD;
	Wed, 12 Mar 2025 20:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741810898;
	bh=eZn3M9mlWfZG7ziWvPoqQ68DoQzsS5rAy2tHFPgSILA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwW7OVW36sV8XQpcekGwjWUAKZLABPhGuMylzhTZiktBd3awgZ8au4CoUwbL4uSeh
	 877BnH6qV+pN6RN6/86qYDdHcnDBMWCyNnzejm4Kw3wUmVY/M2BUmxwP8LRzLATHJO
	 Y+bD5YmoJc6/EdLNIq3s73S3xeGTdKq8ujVFjOUqJ2OIQGHxJC0MfIaxMU6w7w9MqU
	 1KAMC7c7VCOI23sJ54sOfcYN/iEqOGfFwKFdPkuQHF3cmPWynJzZj7GS3TpWfTvZuF
	 EnRmUWGp+LZAD1W2d/7xLQramMsP23g4Kqa2CCMqlCSzKCnA25vwN4tjElVTw3/ssh
	 VFuKlz/yTi6Hg==
Date: Wed, 12 Mar 2025 21:21:32 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: patrick@stwcx.xyz, andrew@codeconstruct.com.au, linux@roeck-us.net,
	wim@linux-watchdog.org, joel@jms.id.au,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Peter.Yin@quantatw.com,
	Patrick_NC_Lin@wiwynn.com, BMC-SW@aspeedtech.com,
	chnguyen@amperecomputing.com, aaron_lee@aspeedtech.com
Subject: Re: [PATCH v7 1/1] watchdog: aspeed: Update bootstatus handling
Message-ID: <20250312202132.GA1072616@ax162>
References: <20250113093737.845097-1-chin-ting_kuo@aspeedtech.com>
 <20250113093737.845097-2-chin-ting_kuo@aspeedtech.com>
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
In-Reply-To: <20250113093737.845097-2-chin-ting_kuo@aspeedtech.com>

On Mon, Jan 13, 2025 at 05:37:37PM +0800, Chin-Ting Kuo wrote:
> The boot status in the watchdog device struct is updated during
> controller probe stage. Application layer can get the boot status
> through the command, cat /sys/class/watchdog/watchdogX/bootstatus.
> The bootstatus can be,
> WDIOF_CARDRESET => System is reset due to WDT timeout occurs.
> Others          => Other reset events, e.g., power on reset.
> 
> On ASPEED platforms, boot status is recorded in the SCU registers.
> - AST2400: Only a bit is used to represent system reset triggered by
>            any WDT controller.
> - AST2500/AST2600: System reset triggered by different WDT controllers
>                    can be distinguished by different SCU bits.
> 
> Besides, on AST2400 and AST2500, since alternating boot event is
> also triggered by using WDT timeout mechanism, it is classified
> as WDIOF_CARDRESET.
> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>  drivers/watchdog/aspeed_wdt.c | 81 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 79 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
...
> +static void aspeed_wdt_update_bootstatus(struct platform_device *pdev,
> +					 struct aspeed_wdt *wdt)
> +{
> +	const struct resource *res;
> +	struct aspeed_wdt_scu scu = wdt->cfg->scu;
> +	struct regmap *scu_base;
> +	u32 reset_mask_width;
> +	u32 reset_mask_shift;
> +	u32 idx = 0;
> +	u32 status;
> +	int ret;
> +
> +	if (!of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2400-wdt")) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		idx = ((intptr_t)wdt->base & 0x00000fff) / resource_size(res);

This division breaks the build when CONFIG_ARM_LPAE is enabled, which
selects CONFIG_PHYS_ADDR_T_64BIT, turning resource_size_t into a 64-bit
type.

$ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- mrproper multi_v7_lpae_defconfig all
arm-linux-gnueabi-ld: drivers/watchdog/aspeed_wdt.o: in function `aspeed_wdt_update_bootstatus':
drivers/watchdog/aspeed_wdt.c:257:(.text+0x80c): undefined reference to `__aeabi_uldivmod'

> +	}
> +
> +	scu_base = syscon_regmap_lookup_by_compatible(scu.compatible);
> +	if (IS_ERR(scu_base)) {
> +		wdt->wdd.bootstatus = WDIOS_UNKNOWN;
> +		return;
> +	}
> +
> +	ret = regmap_read(scu_base, scu.reset_status_reg, &status);
> +	if (ret) {
> +		wdt->wdd.bootstatus = WDIOS_UNKNOWN;
> +		return;
> +	}
> +
> +	reset_mask_width = hweight32(scu.wdt_reset_mask);
> +	reset_mask_shift = scu.wdt_reset_mask_shift +
> +			   reset_mask_width * idx;
> +
> +	if (status & (scu.wdt_reset_mask << reset_mask_shift))
> +		wdt->wdd.bootstatus = WDIOF_CARDRESET;
> +
> +	/* clear wdt reset event flag */
> +	if (of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2400-wdt") ||
> +	    of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2500-wdt")) {
> +		ret = regmap_read(scu_base, scu.reset_status_reg, &status);
> +		if (!ret) {
> +			status &= ~(scu.wdt_reset_mask << reset_mask_shift);
> +			regmap_write(scu_base, scu.reset_status_reg, status);
> +		}
> +	} else {
> +		regmap_write(scu_base, scu.reset_status_reg,
> +			     scu.wdt_reset_mask << reset_mask_shift);
> +	}
> +}
> +

Cheers,
Nathan

