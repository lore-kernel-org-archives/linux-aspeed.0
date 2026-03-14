Return-Path: <linux-aspeed+bounces-3673-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B96410706C9
	for <linux-aspeed@archiver.kernel.org>; Sat, 14 Mar 2026 10:24:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXyBQ5gKzz2xjb;
	Sat, 14 Mar 2026 21:23:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773483838;
	cv=none; b=kX+YVC++BgiqhKfoYHKb6u0mIMRZg+WYEl6ZAsvw4bGDXSMEpxqHcZu4K6nGQSLsRj0T8tkD8vaBnjw/z100FJlKzDBhcYXgwPPB8+Yo+/pPJ8FkU0Q8kaUcm35FISu5McMi0xrRKVyIN2IkJcDImNYCiNv6Abn3zYHE1NqZL/j8FewknZS8gu8DZLz/OKH2DrTjCf9zahol8hiL/J5Catp/fn/FiBP3QB84smvzXseSkULvgLp5yftq2nwsYU3Hnx8KjvFRorjzqWwzEYdP1MwKwC7jQ56UY8dAhBPAZvrltniEV/eID0WjYwlk03XLWIXvYdnXiASYvjZ7MOmjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773483838; c=relaxed/relaxed;
	bh=ecIC7Cx0+X4PyCdNszbHSRQ/JqEk6Yq8c3tc3oyYojk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mL80Mgm2SpdxL+AF8BAP6PXzhf9ARw1H56gsSKaCwuuxTM2fPvbHpwS0KLdPLAyh/XpH2Fi9qdpOMPyLXYBx1pXNA+JnYs6A74k0eJ9Uw01bAdOYsCP1UKnXhvLa6HNJsfpGeFwAZVJOAqQ7lOq1NB074Rm5GVILe2wnjNNP0WXxtMbf0NCVXJSTdpbBNH/zjZQnBz5sXGgnCtd/UJ+JbBn+fLX+dtkG0Hf+iQSm4Bzj/hFarKZpQP0nPVXYOHOtxUF847KXqqL5UsMh+r4EP58xrAbe8iO5L5ZUP2ILsNk5XNbzXIPSRi8pfHDr04/9k+Bvh4l6sis9ucxdWQ4W5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fQfZyiSM; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fQfZyiSM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXyBQ1hLhz2xVT;
	Sat, 14 Mar 2026 21:23:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CE7426013A;
	Sat, 14 Mar 2026 10:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDDCC116C6;
	Sat, 14 Mar 2026 10:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773483834;
	bh=9tW88wtC23Nu5H1ydEbU0qbXKKzXQG4pyrrMW/FnfBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQfZyiSMrQ8sCNW+FgXGj8pS7B2I71bND85ID+aaX+dyaNsrK6Z2WF/Yzq8rtLc3z
	 lNaSGk7qEyKg8lTXtkndoebnJx74Dqadt3FXTYRtREm/THj6j5Avdy41R5Cxk2d1h3
	 mesHyl4ABmGIceuHiM7EXsWb9UPDGrFIRoTe5JMnsvzThU4FAdtKZKhgG9oECf5wiX
	 ulYn08uz4fXLtcA/kVRXmLW7ttkpPwe3ljwaMQEzlhicaKrmih08Kc6z8F3TqHuvTN
	 JWeKzyYRcIXCWoZHTqBB8VWbu1OTO4Q4TgOd2WBc6U3hzsQ9tTa1ZdBQ7wgdEUJaC1
	 51rErr4AXPbPA==
Date: Sat, 14 Mar 2026 11:23:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Andrew Jeffery <andrew@aj.id.au>, linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: sdhci-of-aspeed: Add ast2700 support
Message-ID: <20260314-flat-topaz-peacock-440a9c@quoll>
References: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
 <20260313-sdhci-v1-2-91cea19c8a67@aspeedtech.com>
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
In-Reply-To: <20260313-sdhci-v1-2-91cea19c8a67@aspeedtech.com>

On Fri, Mar 13, 2026 at 01:27:57PM +0800, Ryan Chen wrote:
> Add support for the AST2700 SOC in the sd controller driver. AST2700 sd
> controller requires an reset line, so hook up the optional reset control
> and deassert it during probe.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index ca97b01996b1..91c36245e506 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -520,6 +520,7 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
>  
>  {
>  	struct device_node *parent, *child;
> +	struct reset_control *reset;
>  	struct aspeed_sdc *sdc;
>  	int ret;
>  
> @@ -529,6 +530,15 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&sdc->lock);
>  
> +	reset = reset_control_get_optional_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(reset),
> +				     "unable to acquire reset\n");
> +	ret = reset_control_deassert(sdc->rst);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "reset deassert failed\n");
> +
>  	sdc->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(sdc->clk))
>  		return PTR_ERR(sdc->clk);
> @@ -577,6 +587,7 @@ static const struct of_device_id aspeed_sdc_of_match[] = {
>  	{ .compatible = "aspeed,ast2400-sd-controller", },
>  	{ .compatible = "aspeed,ast2500-sd-controller", },
>  	{ .compatible = "aspeed,ast2600-sd-controller", },
> +	{ .compatible = "aspeed,ast2700-sd-controller", },

So devices are fully compatible. You must express it in the bindings and
drop this hunk.

Best regards,
Krzysztof


