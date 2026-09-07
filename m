Return-Path: <linux-aspeed+bounces-4965-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFFEC79FA0
	for <linux-aspeed@archiver.kernel.org>; Mon,  7 Sep 2026 06:28:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdcbM0z1mz2yvX;
	Mon, 07 Sep 2026 16:28:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788762527;
	cv=none; b=iKm69+Bgyy+t4GliV6hKQSAluBHKYixQXRSbti6uySE8NfpfRacWOaOwh3JrWvFhZwK53uKtB08MiWFxmeRsUuvpwGiJOA4WrDEpvUu6SHWUThd+5gRkAvG9eUQmn5eJg+aoijAixBjuyfhtJKwqos1sz4AR9Rr6OQPIa6CsMNBXiTYRvxJ0zdT3QqOqTI3tFR5UUnF9wJ+B9cjsM/kR3FsszIFWISZSifCBVoZSzrtrsF9XCLj26o3IpfTMvoSo8KUU7HrQQnpezOeWreLO1D31SwVJ/xsmnlB98I4CPZMifXw0P2A+T6O5HAsTSQBSJodklWs+L9ezCMFXH/C6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788762527; c=relaxed/relaxed;
	bh=Uhqq4SjaBmSEA8DrRzienxD9wkDqWA+Zx6N8pGJJeww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JK8TSxwGZHfZNVOVG6Rr4rBVHH+OHV6nulMpomgfwHErPw6EZE6JGKGPxredKmYZgXBbQOBIWbI/ZX6ns4AvKLtqye+U4Q8/97/MweR+Stn3VAiD/E5gRkSAKfUmm7ilRTJivwZh4cctQbrax46ahDRahmkZ8hBSh8ozatLkAHJIEs44Xl7RBp7Zw58sMBgrDZwSScqQhFdzLMvzN2AhjNDTTo7sJSeHxTl+ORjcI5TTJ0Q5ygGD9/pRfaMZ4xi8rUGQvg6RgF/PGvPoa4rYB2gackGcgdaxJ7AcbSjVS22914qENLGWxLFK72Pb68/MWYN6bOyYL8e8E+JJZeMWsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IUwKfgSX; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IUwKfgSX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdcbJ714bz2xlw
	for <linux-aspeed@lists.ozlabs.org>; Mon, 07 Sep 2026 16:28:44 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D09444400F;
	Mon,  7 Sep 2026 06:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875B91F00A3E;
	Mon,  7 Sep 2026 06:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788762522;
	bh=Uhqq4SjaBmSEA8DrRzienxD9wkDqWA+Zx6N8pGJJeww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IUwKfgSXh8wAdVB1uda8oKDagMq50nSkJhaFjwhDyuGAD3ciKsn5vjkrHlMvx/Obk
	 JdYVD7Uam5OKyLbP7PFdopgxr+qqh/u+JqI0da9ll9OsitD7c0pnDc4XadVLHt1gIY
	 oR9e+eMtkdoo6XVhED+5xhSTCB2IXUytDO0oFrVeQ06lXPfC+ryATeaf5ddDz3jQ6H
	 OtaDsKNJIZxMgY2hiXHdid70AoC2fp4ka7dzh1NrgA+sNT80wVyk0cMTgAgoVuox85
	 KPfmTPxlePELs0TMtduVJBl7T/OlMpDvdtadNObM97Ef7wulPvuJsw+YuxPTTwAMlc
	 Ar3KFzJXHquRw==
Date: Mon, 7 Sep 2026 08:28:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: i3c: Document the AST2700 I3C controller
Message-ID: <20260907-imaginary-economic-oyster-57cdd6@quoll>
References: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
 <20260901-b4-i3c-hci-ast2700-v1-1-19909e7cbd7e@aspeedtech.com>
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
In-Reply-To: <20260901-b4-i3c-hci-ast2700-v1-1-19909e7cbd7e@aspeedtech.com>

On Tue, Sep 01, 2026 at 07:35:28PM +0800, Billy Tsai wrote:
> The AST2700 I3C controller implements the MIPI I3C HCI programming
> model, extended with an ASPEED in-house control block and a PHY
> programming window advertised through an HCI vendor extended
> capability. Follow the existing aspeed,ast2600-i3c precedent of
> describing SoC integrations of a common I3C IP in their own schema.

What precedent exactly?

Are you now bringing some LLM slop arguments here?

> 
> The controller takes a core clock for PHY timing and two reset-names
> lines: its own reset and a DMA engine reset shared by all I3C
> controllers on the SoC.
> 
> The PHY timings derived from the core clock and bus rate assume
> nominal bus loading. Boards with long traces, weak pull-ups, or
> capacitive loading need different ratios and setup periods, so
> document properties to override the push-pull and open-drain SCL
> periods, the SDA TX hold time, the tCAS/tCBP periods, and the SCL low
> period used for a repeated START or STOP.
> 
> Boards without external I3C pull-up resistors can use the PHY's
> built-in pull-ups instead. The achievable resistance depends on the
> voltage domain of the pins (high-voltage vs low-voltage), which can be
> determined from the pin group assigned to the bus. Reuse bias-pull-up
> (pincfg-node.yaml) for the strength in Ohms; it is declared on this
> node rather than a pin-config node since the pull-up switch is part of
> the I3C PHY, not the broader SoC pin control IPs.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Assisted-by: Claude:claude-fable-5
> 
> ---
> We considered formally expressing bias-pull-up's dependency on a
> pinctrl state in the schema, but couldn't find a clean way to say
> "depends on whichever pinctrl-N is active" without hard-coding
> pinctrl-0 specifically, which would be wrong in general (a node's
> active pin state doesn't have to sit at index 0). We've added
> pinctrl-0 to the example to illustrate the typical usage instead,
> without a formal schema-level dependency.
> ---
>  .../bindings/i3c/aspeed,ast2700-i3c-hci.yaml       | 133 +++++++++++++++++++++
>  1 file changed, 133 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i3c/aspeed,ast2700-i3c-hci.yaml b/Documentation/devicetree/bindings/i3c/aspeed,ast2700-i3c-hci.yaml
> new file mode 100644
> index 000000000000..19ecb5b15038
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/aspeed,ast2700-i3c-hci.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i3c/aspeed,ast2700-i3c-hci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2700 I3C controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description:
> +  The AST2700 I3C controller implements the MIPI I3C HCI programming model,
> +  extended with an ASPEED in-house control block and a PHY programming window
> +  that are advertised through an HCI vendor extended capability.
> +
> +properties:
> +  compatible:
> +    const: aspeed,ast2700-i3c-hci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: Core controller reset.
> +      - description: DMA engine reset shared by all I3C controllers.
> +
> +  reset-names:
> +    items:
> +      - const: core
> +      - const: dma
> +
> +  bias-pull-up:
> +    $ref: /schemas/pinctrl/pincfg-node.yaml#/properties/bias-pull-up
> +    enum: [177, 231, 261, 317, 400, 470, 550, 600, 750]
> +    description:
> +      Enable the PHY-internal pull-ups on SCL and SDA and select their
> +      strength, in Ohms. High-voltage pins support 400, 470 or 600 Ohms,
> +      and low-voltage pins support 177, 231, 261, 317, 400, 550 or 750
> +      Ohms. When absent the internal pull-ups stay disabled and the bus
> +      relies on external pull-ups.
> +
> +  aspeed,pp-scl-high-ns:
> +    description:
> +      Push-pull SCL high period. Overrides the value derived from the
> +      i3c-scl-hz bus rate.
> +
> +  aspeed,pp-scl-low-ns:
> +    description:
> +      Push-pull SCL low period. Overrides the value derived from the
> +      i3c-scl-hz bus rate.
> +
> +  aspeed,od-scl-high-ns:
> +    default: 380
> +    description:
> +      Open-drain SCL high period.
> +
> +  aspeed,od-scl-low-ns:
> +    default: 620
> +    description:
> +      Open-drain SCL low period.
> +
> +  aspeed,sda-tx-hold-ns:
> +    default: 10
> +    description:
> +      SDA output hold time relative to the SCL edge.
> +
> +  aspeed,cas-ns:
> +    minimum: 39
> +    description:
> +      Clock-after-start (tCAS) period driven after a START condition.
> +      When absent it is derived from the SCL low period of the
> +      applicable bus context, clamped to the protocol minimum.
> +
> +  aspeed,cbp-ns:
> +    minimum: 20
> +    description:
> +      Clock-before-stop (tCBP) period driven before a STOP condition.
> +      When absent it is derived from the SCL low period of the
> +      applicable bus context, clamped to the protocol minimum.
> +
> +  aspeed,sr-p-scl-low-ns:
> +    default: 40
> +    description:
> +      SCL low period used while preparing a repeated START or STOP
> +      condition, kept separate from the push-pull SCL low period to
> +      satisfy the MIPI I3C clock stalling requirements.

Probably I3C maintainers should weight in here and help - should these
be made generic for all I3C controllers? I am surprised some "standard"
I3C controller needs to configure this as the single one. No other ever
needed...

Best regards,
Krzysztof


