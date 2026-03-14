Return-Path: <linux-aspeed+bounces-3672-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6413610706C4
	for <linux-aspeed@archiver.kernel.org>; Sat, 14 Mar 2026 10:23:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXy9g25nPz2xjb;
	Sat, 14 Mar 2026 21:23:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773483799;
	cv=none; b=hsYyEkTl+gIKS5saQpXQ4V77+c7L2vuoQ7bjhtIZ/tOyDPYc/c1l6IJ8oQ3AG/KHDJMOip26m7SQGPhF4IXaqvUhJkFZy5TQO/7oh4Yt9c5qpN0leqHYIMAkDYEt2yN3px84QxQNfPjmLRXs9o3tn5710GsmUvluHR/gCs4FsMaRxpfF6IBWG0A9QJG5CkJnSBkeawNgxg0yGXXQIjxlMm2oZbhir9Rt69CHAjdOaTDIJaCqNaJRxgY++TIs7Y4EnXx/dNB5wltP29E7TF68FgFLVulnZj8/c8dV0Zcrr3CwbGwPxnmwbbqRwTLvQwGRW91XHDS2Mtm6wPxDQgMNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773483799; c=relaxed/relaxed;
	bh=MRB07cdJzB/tkrap4FE0HHlO3cJEFdlT5ADMGeesBcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5/efNVoqlSMlj3Puz2r6XItj99Hfj/ANKdlIqilDL7MGQyNoRdAP+Oam9zYZifkW0XHp5mSnrVii9ZzvDPSKtegUXf/Ww3zDqPXfMq0WU6tbnyqUBsYwZ12FySffC9KQmEg2pejZZ7Hg2mxry7xCAx+9d2sZbxv6j6hcp2y4LAWNMIopSsq9hT5/1a+OjVx/tPyERuB+45N3PVijHSIc1Wu610GD9oWwZZuFbYflEhjcoGlVeZH+4d+Jxt/n2b3l41ySpwChVwsngMhG8pY26au2P/7glb3GZc2QDHb8i3GEby16yNZ2c4TmVEBcGT+73Cuta6qsbfuSJFxGfrg0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OQZKEhRt; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OQZKEhRt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXy9f3pQ1z2xVT;
	Sat, 14 Mar 2026 21:23:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 133DD41A5E;
	Sat, 14 Mar 2026 10:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCA9C116C6;
	Sat, 14 Mar 2026 10:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773483795;
	bh=5PkAknHHM/kOX+aOCmxl/1qV4NYtdKOeDMzTVtjIgW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQZKEhRtm+fH056uWWAG9LnfwkY3iifEFZhSsmNoVk6WOzyn6lUXwKE3FCVQNsbYw
	 a3ZAloRiscW0UZofgoJDazvPz8inZJP1W7z/V2AZW8A8hNadAI9nJNapUlo73kwPsN
	 1wcpzYDFmP4nZ1JAWyzGGyL9EXZ8q4BRvbOuEA1fUIgMgTjHvE6PSlQXA7sqweISqL
	 nn6gi95nbCFr3cufZVhIR3yHTcRTVuvg13narL9U24Bb0UhvL2PMJLjFZOhP/T++dB
	 kshXcoKPv/q8Wiohwmuu7P0T0OnEad7OGQPuY2AGewC2IaoT36Y2enSeBNzJaLgpUx
	 ngiuA77++BW4g==
Date: Sat, 14 Mar 2026 11:23:13 +0100
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
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-of-aspeed : Add ast2700
 support
Message-ID: <20260314-naughty-tody-from-vega-116b3d@quoll>
References: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
 <20260313-sdhci-v1-1-91cea19c8a67@aspeedtech.com>
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
In-Reply-To: <20260313-sdhci-v1-1-91cea19c8a67@aspeedtech.com>

On Fri, Mar 13, 2026 at 01:27:56PM +0800, Ryan Chen wrote:
> Add the "aspeed,ast2700-sd-controller" compatible. The ast2700 sdhci
> controller requires an reset, so make the "resets" property mandatory
> for this compatible to reflect the hardware requirement.

Subject - there is never space before ':'

> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> index d24950ccea95..a2ff9a94db13 100644
> --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -26,6 +26,7 @@ properties:
>        - aspeed,ast2400-sd-controller
>        - aspeed,ast2500-sd-controller
>        - aspeed,ast2600-sd-controller
> +      - aspeed,ast2700-sd-controller

Missing blank lines everywhere in your patchset.

>    reg:
>      maxItems: 1
>      description: Common configuration registers
> @@ -37,6 +38,20 @@ properties:
>    clocks:
>      maxItems: 1
>      description: The SD/SDIO controller clock gate

Blank line

> +  resets:
> +    maxItems: 1

Blank line, just open any other bindings. If this is because you used
LLM, then obviously NAK, because we should not waste time to review
unsupervised poor quality LLM output. It is your task to review it, not
ours.

