Return-Path: <linux-aspeed+bounces-3674-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B07210706C9
	for <linux-aspeed@archiver.kernel.org>; Sat, 14 Mar 2026 10:24:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXyBv3LVKz2xl0;
	Sat, 14 Mar 2026 21:24:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773483863;
	cv=none; b=DesGSFsYZf7YYc97uoZ4Nz6OvnHAE2BEh+6iVt0NpwyyBoDsVG0yOtUmQnSHESXzAo46G/9CwDgEqt6BcQMEsK09ZG4qdHI77rNetegg/trCroBYJy7sor/q9yEacxp3YsT8Re7cQGl8jXdxFJmloGERoXl4zWmFlR0hx0BClRgNXZ1WPn7XJU2OppRnZme9dcg2aF+OdQ1mT4LB+LF3803rc44NWLGVm4gbjLumi1xT+6h67JimaG4esiZp2XMobMaANbxHz6J39pB6eeH2vY53g94+aFmsqPiM3+0xEEeHoR7qUqSZpayqPa5VoAO0j1tqPjAa6cumGGu1fU0A9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773483863; c=relaxed/relaxed;
	bh=VT63MoyDk2yYg/aMmxJ3ylplQ1G1el+CFqngQaWxD9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdCSIc6nDkmq255x1yY2pDfmayAhm/l2qFkfBgFbhtrLnJNnXnFCb8gtiqf8RGNZG+MSdhLUxvX0QtftL6IxMRKOB3TS4oOMFnOk6ouK92BH2KyYqItFPs0e4M8c32NlmUZw2MVmSecwL4wenVT/+3OopxjTHFi2TPt8Yw0HgG/1WTIu7qCmBIeFpt4x3Dwnxx8iSx21BrZete0GT/O3nWeJBjOEl3A0ZKocEJT74P4KdnFpHUwunpQ5yo+NCZFezr+qzPB84BqGuZFZ0GI5DQlYxRMXUR/gol+4VUy3yL8AIj8j1vG+ikyAFYAJunk5Ji+RHTuxKyz4aFSjSl7AKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RQDW6WnV; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RQDW6WnV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXyBt4t3bz2xVT;
	Sat, 14 Mar 2026 21:24:22 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DBF10440A5;
	Sat, 14 Mar 2026 10:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F45C116C6;
	Sat, 14 Mar 2026 10:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773483860;
	bh=Ml/lEKonYkIliYF/LMmTBJQ2qVPdHCM46twoQHPrNRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQDW6WnVIy3RVOdnc3BHCsn3XXqrqpnd2AvzdZZ6jrrQAw9WJsdW5yO+Ppow/KV3y
	 FtgNQaV9jv2MDtwed31KOHgxokOTuyavl8vkljbG7mau4u+XMfn9U/zgDQ40dbWWwT
	 A7NErRvwFl4pfvg/tmLP5Oz1m2Cl8KhkTCbFXj64+ot8INpfqS/Mz6PyxDRN0AE1kj
	 7vHEnSZDW3XFLMGt+N+SSiDPrJWbNG3kvB3dYMsBoBGEBrBbIdZflpxniq2ioGg6kj
	 RJW34RJhg12PgAlPWmt4uRL+ghUyONP3iygDFL0397wIr33UbzzkbC8+uz8CSNQA2x
	 qMomNsmNPtbSA==
Date: Sat, 14 Mar 2026 11:24:18 +0100
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
Message-ID: <20260314-perch-of-eminent-swiftness-e4efcf@quoll>
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

Also, not matching your driver.

Best regards,
Krzysztof


