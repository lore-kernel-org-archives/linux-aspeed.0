Return-Path: <linux-aspeed+bounces-1954-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C03BCA0EDC
	for <linux-aspeed@archiver.kernel.org>; Thu, 14 Aug 2025 08:04:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c2d6l1Q13z30W5;
	Thu, 14 Aug 2025 18:03:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755158639;
	cv=none; b=i7d5O1L7vgFekbzBCzJU8Vzh/iAF89Pm04kC/XSWSXf7hNTSMGdDFOj5dErhY3sLQN6Hs4pKhOZTB8fbLZ5CcZflPEbyHFQIE3T6N5eat2J2BAOaWX8STv2+u/e4a/x/HbA2FbxNB72S5URe/CliqNyAhBqEp4eMjpbZFyoBKzm5OQrM98EL17lU3jqCrsDH32Zaq7zOd6jzL80VfxzPIQebwrQYWrxt8mnaIhB/8+zsrY5QD9A9a7eVcQZ+Vp9Da8GkEqoO2YuOaqoC/h1QlkvsIp8BL5RLKDj+nA58nUx8OL2e4Sor+9q6psTX5A3IKUwL1itlvdQ9fFKadYNosg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755158639; c=relaxed/relaxed;
	bh=W1AAD98/pMC4llkuyRBMvH/G0ZNX1c8a6i9RG3YNpCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIGoVk5I7hgFsBC5aInAIDESaCcWSwH5YwIoHQ/1axvN8vrcS9rPJLKCmBKNOXzXFPm/s2c3eWvhf8I+s4HacBuo4Jl8P6VhFTF7QUKOOmwS3k2Z/R/iilIPO46z7+7AvmES/ZiWQKac5znQxSdyCW7anEOhS8oKBA2Vr1oMMuM0vO0U9ezxU316vdoc64aYLaGu4V1JuS1TW7KPdOuG7fQJz/rwyOGYIUbh6zjVnJYC2lGdXvmYxQqVYVJzUM06Vf5f9XEKDkWRx4YMGxDhffTBncEpcFWrLTYf35RVuJVE1bhen30UHwmCm7/fjkE+HNMFMaN/RkgB6ynTUUO9wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Y0QPM3oC; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Y0QPM3oC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c2d6k3VsXz30VR
	for <linux-aspeed@lists.ozlabs.org>; Thu, 14 Aug 2025 18:03:58 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E6D5E44518;
	Thu, 14 Aug 2025 08:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342F5C4CEEF;
	Thu, 14 Aug 2025 08:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755158635;
	bh=X3Zkv1GgYGEV/PFrhjV6JjLBSwA81+ffdc9QPdchXLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0QPM3oCyMK9LWNRNmg59i3pAgrctvv8lnJBbGzCuDxjDcLS7utfL0DmwKI0yFcs3
	 KL+xoza2Ywl9NslWcJ9zrBL25photeR9qQI+4PtMKU0RrWpuWjwSmj+ujtvvkyKqWi
	 xcC9OH2qzbJOqjV6OHFgnYBbEiwPKUllpthQbNaTQqhk+piDNONSb2KXV6HuC3O3nx
	 zRw2GLuDnxvEYkz0oYB8TnHK690hqLWxX884VsND1y8fe7d+sxk37Pcxs9k8HHS9RP
	 OAFT8UjwaXQ02146plSOQyVNK4hhbUb3WIrFLwX7wWywlsx4m8yZFvSbWRt4UvVQPN
	 EW6hIEZvRnGEQ==
Date: Thu, 14 Aug 2025 10:03:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Kevin Chen <kevin_chen@aspeedtech.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v4 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent compatibles and refine documentation
Message-ID: <20250814-auspicious-thundering-jaybird-b76f4f@kuoka>
References: <20250812100830.145578-1-ryan_chen@aspeedtech.com>
 <20250812100830.145578-2-ryan_chen@aspeedtech.com>
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
In-Reply-To: <20250812100830.145578-2-ryan_chen@aspeedtech.com>

On Tue, Aug 12, 2025 at 06:08:29PM +0800, Ryan Chen wrote:
> AST2700 contains two independent top-level interrupt controllers (INTC0,
> INTC1). Each occupies its own register space and handles different sets of
> peripherals. Above them, the PSP (CA35) GIC is the root interrupt
> aggregator. In hardware, INTC1 outputs are routed into INTC0, and INTC0
> outputs are routed into the GIC.
> 
> Introduce distinct compatibles for these parent blocks so the DT can model
> the hierarchy and register space layout accurately:
> 
>   - aspeed,ast2700-intc0  (parent node at 0x12100000)
>   - aspeed,ast2700-intc1  (parent node at 0x14c18000)
> 
> The existing child compatible:
> 
>   - aspeed,ast2700-intc-ic
> 
> continues to describe the interrupt-controller instances within each INTC
> block (e.g. INTC0_0..INTC0_11 and INTC1_0..INTC1_5).
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../aspeed,ast2700-intc.yaml                  | 158 +++++++++++++-----
>  1 file changed, 115 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> index 55636d06a674..81304b53c112 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> @@ -10,6 +10,33 @@ description:
>    This interrupt controller hardware is second level interrupt controller that
>    is hooked to a parent interrupt controller. It's useful to combine multiple
>    interrupt sources into 1 interrupt to parent interrupt controller.
> +  Depend to which INTC0 or INTC1 used.
> +  INTC0 and INTC1 are two kinds of interrupt controller with enable and raw
> +  status registers for use.
> +  INTC0 is used to assert GIC if interrupt in INTC1 asserted.
> +  INTC1 is used to assert INTC0 if interrupt of modules asserted.
> +  +-----+   +---------+
> +  | GIC |---|  INTC0  |
> +  +-----+   +---------+

Same problem as last time. This tells me intc0 has not children...

> +            +---------+
> +            |         |---module0
> +            | INTC0_0 |---module1
> +            |         |---...
> +            +---------+---module31
> +            |---....  |
> +            +---------+
> +            |         |     +---------+
> +            | INTC0_11| +---| INTC1   |
> +            |         |     +---------+

...This tells that inc1 has no children (only intc0_11, which you said
is aspeed,ast2700-intc-ic !!!)....
(keep scrolling)

> +            +---------+     +---------+---module0
> +                            | INTC1_0 |---module1
> +                            |         |---...
> +                            +---------+---module31
> +                            ...
> +                            +---------+---module0
> +                            | INTC1_5 |---module1
> +                            |         |---...
> +                            +---------+---module31
>  
>  maintainers:
>    - Kevin Chen <kevin_chen@aspeedtech.com>
> @@ -17,49 +44,70 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> -      - aspeed,ast2700-intc-ic
> +      - aspeed,ast2700-intc0
> +      - aspeed,ast2700-intc1
>  
>    reg:
>      maxItems: 1
>  
> -  interrupt-controller: true
> +  '#address-cells':
> +    const: 2
>  
> -  '#interrupt-cells':
> +  '#size-cells':
>      const: 2
> -    description:
> -      The first cell is the IRQ number, the second cell is the trigger
> -      type as defined in interrupt.txt in this directory.
> -
> -  interrupts:
> -    maxItems: 6
> -    description: |
> -      Depend to which INTC0 or INTC1 used.
> -      INTC0 and INTC1 are two kinds of interrupt controller with enable and raw
> -      status registers for use.
> -      INTC0 is used to assert GIC if interrupt in INTC1 asserted.
> -      INTC1 is used to assert INTC0 if interrupt of modules asserted.
> -      +-----+   +-------+     +---------+---module0
> -      | GIC |---| INTC0 |--+--| INTC1_0 |---module2
> -      |     |   |       |  |  |         |---...
> -      +-----+   +-------+  |  +---------+---module31
> -                           |
> -                           |   +---------+---module0
> -                           +---| INTC1_1 |---module2
> -                           |   |         |---...
> -                           |   +---------+---module31
> -                          ...
> -                           |   +---------+---module0
> -                           +---| INTC1_5 |---module2
> -                               |         |---...
> -                               +---------+---module31
>  
> +  ranges: true
> +
> +patternProperties:
> +  "^interrupt-controller@":

... but this tells me that intc0 and intc1 has children.

> +    type: object
> +    description: Interrupt group child nodes
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - aspeed,ast2700-intc-ic
> +
> +      reg:
> +        maxItems: 1
> +
> +      interrupt-controller: true
> +
> +      '#interrupt-cells':
> +        const: 2
> +        description:
> +          The first cell is the IRQ number, the second cell is the trigger
> +          type.
> +
> +      interrupts:
> +        minItems: 1
> +        maxItems: 6
> +        description: |
> +          The interrupts provided by this interrupt controller.
> +
> +      interrupts-extended:
> +        minItems: 1
> +        maxItems: 6
> +        description: |
> +          This property is required when defining a cascaded interrupt controller
> +          that is connected under another interrupt controller. It specifies the
> +          parent interrupt(s) in the upstream controller to which this controller
> +          is connected.

No, you do not define two. Only interrupts.

> +
> +    oneOf:
> +      - required: [interrupts]
> +      - required: [interrupts-extended]
> +
> +    required:
> +      - compatible
> +      - reg
> +      - interrupt-controller
> +      - '#interrupt-cells'
>  
>  required:
>    - compatible
>    - reg
> -  - interrupt-controller
> -  - '#interrupt-cells'
> -  - interrupts
>  
>  additionalProperties: false
>  
> @@ -68,19 +116,43 @@ examples:
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
>      bus {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      intc0: interrupt-controller@12100000 {
> +        compatible = "aspeed,ast2700-intc0";
> +        reg = <0 0x12100000 0 0x4000>;
> +        ranges = <0x0 0x0 0x0 0x12100000 0x0 0x4000>;
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        intc0_11: interrupt-controller@1b00 {
> +          compatible = "aspeed,ast2700-intc-ic";
> +          reg = <0 0x12101b00 0 0x10>;


... and that's quite wrong unit address. Also no resources in the
parent, so this entire split seems superficial and incorrect.

This binding is not improving. You are not responding to REAL problems
described to you. What's more, you send it in a way making our life
difficult, look:

b4 diff '20250812100830.145578-2-ryan_chen@aspeedtech.com'
Using cached copy of the lookup
---
Analyzing 3 messages in the thread
Could not find lower series to compare against.

Best regards,
Krzysztof


