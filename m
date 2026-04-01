Return-Path: <linux-aspeed+bounces-3827-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D2A1076378
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Apr 2026 06:36:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flwJ22RDyz2ygY;
	Wed, 01 Apr 2026 17:36:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775025410;
	cv=none; b=jYZLZEgAGMEPqvxAqMN7/Qv+YlJnxVVfrOFX4jNd8U7k/g+kYrvS+UAcKMOhMs04l/3w16hozePeOeCU6Md/H/Ol8VLxOV/nrt9P92CPeAfrrIn6w4+99OsVfe3xX27CgLuhp0l4ErutufCAou4kQgH/xBrvmkBqN8sF4FAmMkWWbm53m5rVE43xwigFNbQHEPsyXyuBo2X96cYjfl0sY1TFv2HOrYa+ciXEjC5iv+LjbO67T4tmOdIdHD2ldcFtwHjWmp7MouoiuPr71WWQ7gZgGF7nOwOdgIvn53pO59Nnm9N2GNQWvHJBIThjgqD3dPwxAJLSDMIrv4hidhJrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775025410; c=relaxed/relaxed;
	bh=ftHoyVmvZnIVA+sb7/p5Y71g5eMx8Lig/YeiQ+8uuTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqZaDLGt8FeBBl0UAc/Ii5pQHwTGmTd53yBze30iyYPtKmsheZDjN1mAweHf2+6LsXQeoNSJ7A9JISEdPrnCW4Af2JadpPWDPXrTrvExSgC/7Zx1+n5pKXfPGzNE8t8yc6xDO2dlyrpxGas8Zz/8Dk8LnxHuXHFIo2y375SV2JDNsEms81bsgN6B4O6ulijDz3GHMQWxtXK4SgO6c9QJ+Rj8q1OWWnnCdTo2c+E/AwqXypyeVwjUlfHJBcJ/cn3XPs/y1VlbH5atlaBuE3GjMeS1To58DpebwW+XRXSN/9R4udzoXGSxoStMP4EjAubqrt6MSir34ano3TJ3CZF9BQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WclfYtAf; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WclfYtAf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flwJ12wkTz2xb3;
	Wed, 01 Apr 2026 17:36:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B7AEE60120;
	Wed,  1 Apr 2026 06:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA7CC4CEF7;
	Wed,  1 Apr 2026 06:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775025406;
	bh=+DFyPkJ1QSfX7H4m+XwGecn09bxaPGHmqQ4ZAuy0BBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WclfYtAfA+jn1T5q2pKAdFGdE/1Z56hq/WPtVIjGLF1grcmjCmdcco2N+sVAvb8zP
	 11+2vjA3wehcpSNIcPibPfNkLImDnpjVozhHCpKjb1N12x1NYrPxFX6gik0brUwBs6
	 ozM8AkmjzU2MrTEXEx5Gzdkpf63/Qkc19d7K2YtrsNXPyzNDcLYd3SCI48+ypDoQ1+
	 sm3PxF7fNJPClSpGQ5sD4jZ+D4pjn4HQ5wYwHB8sa9zAQIPLkmvM2mEBN8QwEZbJHw
	 QVcgh+WUtH7DYHzOEgy9F1rTOznu5Jz4Da3ZrhmFPppNfx2UjUZrfGJr/mb9qEf6ax
	 /gUpVa6CGMt6Q==
Date: Wed, 1 Apr 2026 08:36:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: mfd: aspeed,ast2x00-scu: Describe
 AST2700 SCU0
Message-ID: <20260401-adept-zebra-of-bloom-5bb68b@quoll>
References: <20260331-upstream_pinctrl-v5-0-8994f59ff367@aspeedtech.com>
 <20260331-upstream_pinctrl-v5-2-8994f59ff367@aspeedtech.com>
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
In-Reply-To: <20260331-upstream_pinctrl-v5-2-8994f59ff367@aspeedtech.com>

On Tue, Mar 31, 2026 at 03:31:17PM +0800, Billy Tsai wrote:
> AST2700 consists of two interconnected SoC instances, each with its own
> System Control Unit (SCU). The SCU0 provides pin control, interrupt
> controllers, clocks, resets, and address-space mappings for the
> Secondary and Tertiary Service Processors (SSP and TSP).
> 
> Describe the SSP/TSP address mappings using the standard
> memory-region and memory-region-names properties.
> 
> Disallow legacy child nodes that are not present on AST2700, including
> p2a-control and smp-memram. The latter is unnecessary as software can
> access the scratch registers via the SCU syscon.
> 
> Also allow the AST2700 SoC0 pin controller to be described as a child
> node of the SCU0, and add an example illustrating the SCU0 layout,
> including reserved-memory, interrupt controllers, and pinctrl.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/mfd/aspeed,ast2x00-scu.yaml           | 117 +++++++++++++++++++++
>  1 file changed, 117 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> index a87f31fce019..86d51389689c 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> @@ -46,6 +46,9 @@ properties:
>    '#reset-cells':
>      const: 1
>  
> +  memory-region: true
> +  memory-region-names: true

Missing constraints. From where did you take such syntax (so I can fix
it)?

Best regards,
Krzysztof


