Return-Path: <linux-aspeed+bounces-1781-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05D8C83F25
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 05:01:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bn26F3MpNz30Qk;
	Wed, 23 Jul 2025 15:01:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753246885;
	cv=none; b=gZNYD4/r0ito0p7P4svo64LB2YSPQDAQF+EJf2xUdpXvW1TE66TtU618wT8v8x5CtfdZA8fxDQwA+TeLRO7h9hTBWsz9TrS3eXbd4H/McAXupZXqYUYUue20814Jjdog9kpyvCAhTCo2gHjVG3jzsOPPRdbP3HlV4F5Yn3hEudbSRLSlZTlddLdoOMwfs6s6DDiRxuh3+f8rAgWFOsUh0TKilRNl1pcii1DsUkhZ/q+mfuROSlKfAzwdTkY9Sj4CXEd4fuh3tpNlHSwpRRHQGqP3cDVploFtNv+T8CfVajrwkyITE5of0Mk1STdfR489FvodwQSVLqNO2JYVfUwy1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753246885; c=relaxed/relaxed;
	bh=Gbtt60PGwmO59soLlUcJpi8t7rKj2cyeP/n/zoRS0Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCKYBtowPShmA/Ty8cvtIDng4yn4MB044wk1z+16fANO5PbcGUPpydbIsM+ehN6AOeN7kuNM4RSqnu4AekNBT9Cyi5xFYGstcE6PS6ualbmEPcZNMX/4i35cX+UDk6xUdLfZ9JMMTNZsWuG5+VgqtpKb8Rce5q2tJOj7dRvLdEIhb2Y/gkB/A0Sq9javEDT76X5h7XjTYw7qCYWcDRKhHpvJHqw3ym296oCR1S6caLXeqDU95xMEaERo1AJozM9yEsYSCc6LKzyhpSsTuXBzDrsGxbC24ZMTPLYdLkV5InY0kdB3M8Et7MTfGT0Hrv2/e9stlykrdb/NvY6t3QazpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cuhHmj/h; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cuhHmj/h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bn26D4zVrz2xTh
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 15:01:24 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9FC1A46424;
	Wed, 23 Jul 2025 05:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F254C4AF0D;
	Wed, 23 Jul 2025 05:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753246881;
	bh=nr7OfTTQrE+gjAhHnV5WWfzbsPjiUAEdRwGAk43q3eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuhHmj/h/2uh5LXRhhsVjfjHHrUKXBRdr1z0kVTGl5x5086/1ix8pOobaIalqgpJ1
	 QurkgEcQj7LUZm0AxLoRw41hSmyTi8lFTTzTFDd9YIXxmzJVI15dAb8bNQoxhmQYgq
	 lJultjtbR/SxGDiif4Tqif7W/JkFpDibILCFduZdUyJDdnvzYjvikEbz7Z1ru1pjMT
	 0PmppaUR2/N7waKD5LLo0J/+tTlb4J9Fg5QH7QM8HL3bELgdtqUosctWrDb/ydLR4p
	 bAyr0qJBwVBEHJEw8AjUctRr0K3vnl9vZzdiDAecVQWBJ7p3CrDoHvEOCkdtxnMGrt
	 9Ttx035BFu5lQ==
Date: Wed, 23 Jul 2025 00:01:20 -0500
From: Rob Herring <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Kevin Chen <kevin_chen@aspeedtech.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
Message-ID: <20250723050120.GA1231854-robh@kernel.org>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-2-ryan_chen@aspeedtech.com>
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
In-Reply-To: <20250722095156.1672873-2-ryan_chen@aspeedtech.com>

On Tue, Jul 22, 2025 at 05:51:55PM +0800, Ryan Chen wrote:
> The AST2700 SoC contains two independent top-level interrupt controllers
> (INTC0 and INTC1), each responsible for handling different peripheral
> groups and occupying separate register spaces. Above them, PSP(CA35) GIC
> controller acts as the root interrupt aggregator. Accurately describing
> this hierarchical hardware structure in the device tree requires distinct
> compatible strings for the parent nodes of INTC0 and INTC1.
> 
> - Adds 'aspeed,ast2700-intc0' and 'aspeed,ast2700-intc1' compatible
>  strings for parent interrupt controller nodes. (in addition to the
>  existing 'aspeed,ast2700-intc-ic' for child nodes)
> - Clarifies the relationship and function of INTC0 parent
>  (intc0_0~x: child), INTC1 parent (intc1_0~x: child), and the GIC
>  in the documentation.
> - Updates block diagrams and device tree examples to illustrate
>  the hierarchy and compatible usage.
> - Refines documentation and example formatting.
> 
> This change allows the device tree and driver to distinguish between
> parent (top-level) and child (group) interrupt controller nodes,
> enabling more precise driver matching SOC register space allocation.

That's nice, but is an ABI break.

> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../aspeed,ast2700-intc.yaml                  | 158 +++++++++++++-----
>  1 file changed, 115 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> index 55636d06a674..bdc4d8835843 100644
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
> +        description: |

Don't need '|'.

> +          The first cell is the IRQ number, the second cell is the trigger
> +          type as defined in interrupt.txt in this directory.

Don't add links to legacy documents.

> +
> +      interrupts:
> +        minItems: 1
> +        maxItems: 6
> +        description: |
> +          The interrupts provided by this interrupt controller.
> +
> +      interrupts-extended:

Why do you have both interrupts and interrupts-extended? They are 
mutually exclusive and both are auto-magically supported. The schemas 
only have to document 'interrupts'.

> +        minItems: 1
> +        maxItems: 6
> +        description: |
> +          This property is required when defining a cascaded interrupt controller
> +          that is connected under another interrupt controller. It specifies the
> +          parent interrupt(s) in the upstream controller to which this controller
> +          is connected.
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

This node isn't an interrupt-controller.

> +        compatible = "aspeed,ast2700-intc0";
> +        reg = <0 0x12100000 0 0x4000>;
> +        ranges = <0x0 0x0 0x0 0x12100000 0x0 0x4000>;
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        intc0_11: interrupt-controller@1b00 {
> +          compatible = "aspeed,ast2700-intc-ic";
> +          reg = <0 0x12101b00 0 0x10>;
> +          #interrupt-cells = <2>;
> +          interrupt-controller;
> +          interrupts = <GIC_SPI 192 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +                       <GIC_SPI 193 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +                       <GIC_SPI 194 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +                       <GIC_SPI 195 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +                       <GIC_SPI 196 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +                       <GIC_SPI 197 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +        };
> +      };
> +
> +      intc1: interrupt-controller@14c18000 {
> +        compatible = "aspeed,ast2700-intc1";
> +        reg = <0 0x14c18000 0 0x400>;
> +        ranges = <0x0 0x0 0x0 0x14c18000 0x0 0x400>;
>          #address-cells = <2>;
>          #size-cells = <2>;
>  
> -        interrupt-controller@12101b00 {
> -            compatible = "aspeed,ast2700-intc-ic";
> -            reg = <0 0x12101b00 0 0x10>;
> -            #interrupt-cells = <2>;
> -            interrupt-controller;
> -            interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
> +        intc1_0: interrupt-controller@100 {
> +          compatible = "aspeed,ast2700-intc-ic";
> +          reg = <0x0 0x100 0x0 0x10>;
> +          #interrupt-cells = <2>;
> +          interrupt-controller;
> +          interrupts-extended = <&intc0_11 0 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>          };
> +      };
>      };
> -- 
> 2.34.1
> 

