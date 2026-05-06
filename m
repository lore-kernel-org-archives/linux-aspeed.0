Return-Path: <linux-aspeed+bounces-3999-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2F1CD342F
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 May 2026 01:29:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9HqZ2fKYz2xfB;
	Wed, 06 May 2026 11:29:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778030986;
	cv=none; b=MAp2aiJ4+zJBVaKRYHBRxsSqtGPqmytvPeAU+MiqloeZ4e9/Ye+PwRPS6k+ArIcppw+y5D+9XKVANHTHKEcV5y9/FKP+t2Z/tkPczHPpwuiJ5PP5eQ1bsKtAUjg/KIn26lUFiMRIx/vLo129u0judoe1DDsS18QRG6oMBzrRuiCjveNwy6CSN6wLN6AS1szfG9AL2sz1VWcSxdi/oGCxZUfhwZkOZKPT67rXk7GgHBqb2mBrdQS/F+srlFws0D7BP3qj6a4hcBcVM9rzg8MqhZudISrdmwlEPfdD94LyNA0EETXNfBbGfZ0BqscogBJ5i7U9OPlCD6yg969hzrmM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778030986; c=relaxed/relaxed;
	bh=X9JPR0fXV1xn74qhDnvre+VB41yzIRf3W0JU2ou8rLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz9/R3QGfdp4fhltHfsggq/O3pp785K3QOkmvf12cQMTob9ovjS/NhtwcM4UkzcfC594wVczFtm6C5NMzmO17NwWHCo2yg29w/1VhQYF4Hf5vN5kabLY9zu/pt5oRpWjskEjiqr7I9lCcTH5+rWIerlOEM4P0h8t2COAuh4LcfglhTwhA/9JSZIv4dengKkIFXN/p2+BjcSOsIbtEeV2PcirOc+CTkHb7TrxD177rfgiqkmaKMVu+1cs7hDIiQtoj1xaXcv+YnhcVgc1pgcdFS3kC0RK5TjrzFtkhEcgpqUzRZhwk8F6euxJdzRmf15nTB+I7hfJQ7/0yRlAi8ka7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TdKcHrrY; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TdKcHrrY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9HqY0CvRz2xdR;
	Wed, 06 May 2026 11:29:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 038B260123;
	Wed,  6 May 2026 01:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76678C2BCB4;
	Wed,  6 May 2026 01:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778030982;
	bh=wP89bVMkLCeV8uSax+sj7j6o99tqYb4LbJiJy8rGNWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TdKcHrrYbi/YQ5FiZUEcsDuRtsloLjS0sYVrYW2xhn81Va7VxiDuhGimwsO7+rFJu
	 Gj0z82hCvP0E9ld0m5c+z55pLNX2wRQQrUqaPAKAfRP7A8WaxKaFFMc/AOkojuYCkp
	 jhON0wdJj+F5wIpvz6eOy7v2f+LdpYlSuA2yx8g0EI96Yxfh8HmWU1uI2N6hTRrQN/
	 CSS4g82Xvl9CAAWloRdOnZzicC+dmvdjCkZWBzCpKqKV9WqonHiDToIorpyu2xQ6Bl
	 RXmiH0Z/NpxsYF6EQwMB4bC/zPDN9SPZ8+HKgR7MVzHpw+LSeYsyTK37IZO+ZNYNJt
	 FZ0FBdRNO7F3A==
Date: Tue, 5 May 2026 20:29:40 -0500
From: Rob Herring <robh@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v8 1/3] dt-bindings: pinctrl: Add
 aspeed,ast2700-soc0-pinctrl
Message-ID: <20260506012940.GA258045-robh@kernel.org>
References: <20260428-upstream_pinctrl-v8-0-eb8ef9ab0498@aspeedtech.com>
 <20260428-upstream_pinctrl-v8-1-eb8ef9ab0498@aspeedtech.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-upstream_pinctrl-v8-1-eb8ef9ab0498@aspeedtech.com>

On Tue, Apr 28, 2026 at 05:49:45PM +0800, Billy Tsai wrote:
> Add a device tree binding for the pin controller found in the
> ASPEED AST2700 SoC0.
> 
> The controller manages various peripheral functions such as eMMC, USB,
> VGA DDC, JTAG, and PCIe root complex signals.
> 
> Describe the AST2700 SoC0 pin controller using standard pin multiplexing
> and configuration properties.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../pinctrl/aspeed,ast2700-soc0-pinctrl.yaml       | 187 +++++++++++++++++++++
>  1 file changed, 187 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2700-soc0-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2700-soc0-pinctrl.yaml
> new file mode 100644
> index 000000000000..ef500209d81e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2700-soc0-pinctrl.yaml
> @@ -0,0 +1,187 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/aspeed,ast2700-soc0-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2700 SoC0 Pin Controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description:

Need '>' if you have paragraphs.

> +  The AST2700 features a dual-SoC architecture with two interconnected SoCs,
> +  each having its own System Control Unit (SCU) for independent pin control.
> +  This pin controller manages the pin multiplexing for SoC0.
> +
> +  The SoC0 pin controller manages pin functions including eMMC, VGA DDC,
> +  dual USB3/USB2 ports (A and B), JTAG, and PCIe root complex interfaces.
> +
> +properties:
> +  compatible:
> +    const: aspeed,ast2700-soc0-pinctrl

blank line

> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  '-state$':
> +    description: |
> +      Pin control state.
> +
> +      If `function` is present, the node describes a pinmux state and must

Use regular quotes.

> +      specify `groups`.
> +
> +      For pin configuration, exactly one of `groups` or `pins` must be
> +      specified in each state node. Group-level configuration applies to all
> +      pins in the group. Pin-level configuration may be supplied in a
> +      separate state node for individual pins; when both group-level and
> +      pin-level configuration apply to the same pin, the pin-level
> +      configuration takes precedence.
> +
> +    type: object
> +    allOf:
> +      - $ref: pinmux-node.yaml#
> +      - $ref: pincfg-node.yaml#
> +      - if:
> +          required:
> +            - function
> +        then:
> +          required:
> +            - groups
> +      - oneOf:
> +          - required:
> +              - groups
> +          - required:
> +              - pins
> +
> +    additionalProperties: false
> +
> +    properties:
> +      function:
> +        enum:
> +          - EMMC
> +          - JTAGDDR
> +          - JTAGM0
> +          - JTAGPCIEA
> +          - JTAGPCIEB
> +          - JTAGPSP
> +          - JTAGSSP
> +          - JTAGTSP
> +          - JTAGUSB3A
> +          - JTAGUSB3B
> +          - PCIERC0PERST
> +          - PCIERC1PERST
> +          - TSPRSTN
> +          - UFSCLKI
> +          - USB2AD0
> +          - USB2AD1
> +          - USB2AH
> +          - USB2AHP
> +          - USB2AHPD0
> +          - USB2AXH
> +          - USB2AXH2B
> +          - USB2AXHD1
> +          - USB2AXHP
> +          - USB2AXHP2B
> +          - USB2AXHPD1
> +          - USB2BD0
> +          - USB2BD1
> +          - USB2BH
> +          - USB2BHP
> +          - USB2BHPD0
> +          - USB2BXH
> +          - USB2BXH2A
> +          - USB2BXHD1
> +          - USB2BXHP
> +          - USB2BXHP2A
> +          - USB2BXHPD1
> +          - USB3AXH
> +          - USB3AXH2B
> +          - USB3AXHD
> +          - USB3AXHP
> +          - USB3AXHP2B
> +          - USB3AXHPD
> +          - USB3BXH
> +          - USB3BXH2A
> +          - USB3BXHD
> +          - USB3BXHP
> +          - USB3BXHP2A
> +          - USB3BXHPD
> +          - VB
> +          - VGADDC
> +
> +      groups:
> +        enum:
> +          - EMMCCDN
> +          - EMMCG1
> +          - EMMCG4
> +          - EMMCG8
> +          - EMMCWPN
> +          - JTAG0
> +          - PCIERC0PERST
> +          - PCIERC1PERST
> +          - TSPRSTN
> +          - UFSCLKI
> +          - USB2A
> +          - USB2AAP
> +          - USB2ABP
> +          - USB2ADAP
> +          - USB2AH
> +          - USB2AHAP
> +          - USB2B
> +          - USB2BAP
> +          - USB2BBP
> +          - USB2BDBP
> +          - USB2BH
> +          - USB2BHBP
> +          - USB3A
> +          - USB3AAP
> +          - USB3ABP
> +          - USB3B
> +          - USB3BAP
> +          - USB3BBP
> +          - VB0
> +          - VB1
> +          - VGADDC
> +
> +      pins:
> +        enum:
> +          - AB13
> +          - AB14
> +          - AC13
> +          - AC14
> +          - AD13
> +          - AD14
> +          - AE13
> +          - AE14
> +          - AE15
> +          - AF13
> +          - AF14
> +          - AF15
> +
> +      drive-strength:
> +        enum: [3, 6, 8, 11, 16, 18, 20, 23, 30, 32, 33, 35, 37, 38, 39, 41]
> +
> +      bias-disable: true
> +      bias-pull-up: true
> +      bias-pull-down: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pinctrl@400 {
> +        compatible = "aspeed,ast2700-soc0-pinctrl";
> +        reg = <0x400 0x318>;
> +        emmc-state {
> +            function = "EMMC";
> +            groups = "EMMCG1";
> +        };
> +    };
> 
> -- 
> 2.34.1
> 

