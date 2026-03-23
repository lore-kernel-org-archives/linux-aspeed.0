Return-Path: <linux-aspeed+bounces-3744-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF7CF483E6
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Mar 2026 19:07:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffjNM5Wymz2yWK;
	Tue, 24 Mar 2026 06:07:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774292851;
	cv=none; b=jC9q7jjv7yIogG+tYY4IjDQHNXnChwDidS01CLLYTlQKq4wfeJtKzaoqxXipZZe7WHhLwjoj5uTH4dheP6ViK1TA/DlYdVo/wW9gWFFhOCzDHrqa+Z8QYWt07s9XN7tm+ryUPkIMbVr0WK/DR14JjeKm2K6Or1Bb43w/b8Av0kzhJ/jmbsR77rfCp74oOlsBOYBSJuoq4W2e3ucJErCb+pHeNR9JhuRr+IAJBCDIOVDU8p2+ytASFFgwFbJMQ9LURVCl9lYUxcdet5BywmcJbc7LgQRMZA3eq79vpe0LBMFvONunukSLF/9yodRBl6i39OUdazRhJsyk6f9GM4jEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774292851; c=relaxed/relaxed;
	bh=fYL/eXlpQ0Y3emk7cgWwMjvtgVKbtEgeXwbwH+DCrqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCHPlevap8WeYbknLWMHo2VwMNfBXOlKjEGe4/zBSnz184I5K1kHsBjoBd1XIXbeQgBM+k4sYD7XdUU+gH7tl/5icgZxAwvn69yXl7riit2DapIKteNRzFdI7WoTm9n87joIxtgbAEr8W0KcVh8m/9VSwEBYEAmgh0jAsoAJiai27M8gqcMZvgoHIeU3QnZV2Hwp9g7KIhZdPZeN3NJdeP7kqaRaa6pbSw/a1XvVBFKopo7G9gXdECoQnQiNH97+nTShjkhMGVhBwl5EkyS09KqQK7h72tkDPxQDhL2dN99VRuPLozzk0pz8Cd46UHrTK5esyuae7gniOWXps+MXRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Pp5aJvVL; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Pp5aJvVL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffjNL0lX6z2yFb
	for <linux-aspeed@lists.ozlabs.org>; Tue, 24 Mar 2026 06:07:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5147860130;
	Mon, 23 Mar 2026 19:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5743C4CEF7;
	Mon, 23 Mar 2026 19:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774292842;
	bh=k6BhAGxLMFl7NhzH/eXpQ1O6oylKp7QR8k5ui8nFSuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pp5aJvVLMskMT+uHs+8toanS07SNVmScgY4HSZwxwVtCMSxkqe/cl1nwC+NrDzzL7
	 EX7lkaLUhURW2iUOMK2TBztiG09AN+WqeLTQR/m+GqX4uBMt+DSW/QT85CC2TZJBOn
	 zknjGTx9FBb4/d3pnkvTZ8ywMM4I3mHrtZwsB+HNU8G65s3fTS+JjaijntUWGYtUN6
	 wA6CtKzZ6NXUOFvyP4Y7xjk8taLp51T06KbQ9eV2zvr4guwBNzUU/gWEPQt58Ok7fO
	 O/rRVxRvASHHvTOEJj65e4zOQZd519YAOO4mwXTXbVIt5dFH1oRisWNyNkAR8pnGH9
	 ThTjzjl6agDGw==
Date: Mon, 23 Mar 2026 14:07:21 -0500
From: Rob Herring <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/5] dt-bindings: interrupt-controller: aspeed: Add
 AST2700-A2 support
Message-ID: <20260323190721.GA1013496-robh@kernel.org>
References: <20260306-irqchip-v2-0-f8512c09be63@aspeedtech.com>
 <20260306-irqchip-v2-1-f8512c09be63@aspeedtech.com>
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
In-Reply-To: <20260306-irqchip-v2-1-f8512c09be63@aspeedtech.com>

On Fri, Mar 06, 2026 at 04:07:23PM +0800, Ryan Chen wrote:
> Introduce a new binding describing the AST2700 interrupt controller
> architecture implemented in the A2 production silicon.
> 
> The AST2700 SoC has undergone multiple silicon revisions (A0, A1, A2)
> prior to mass production. The interrupt architecture was substantially
> reworked after the A0 revision for A1, and the A1 design is retained
> unchanged in the A2 production silicon.
> 
> The existing AST2700 interrupt controller binding was written against
> the pre-production A0 design. That binding does not accurately describe
> the interrupt hierarchy and routing model present in A1/A2, where
> interrupts can be routed to multiple processor-local interrupt
> controllers (Primary Service Processor (PSP) GIC, Secondary Service
> Processor (SSP)/Tertiary Service Processor (TSP) NVICs, and BootMCU
> APLIC) depending on the execution context.

Unless you intend to maintain both bindings for some period, then you 
should just squash the removal here. If both are going to be maintained 
then patch 5 should not be applied yet.

> 
> Hardware connectivity between interrupt controllers is expressed using
> the aspeed,interrupt-ranges property.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> 
> ---
> Changes in v2:
> - Describe AST2700 A0/A1/A2 design evolution.
> - Drop the redundant '-ic' suffix from compatible strings.
> - Expand commit message to match the series cover letter context.
> - fix ascii diagram
> - remove intc0 label
> - remove spaces before >
> - drop intc1 example
> ---
>  .../aspeed,ast2700-interrupt.yaml                  | 189 +++++++++++++++++++++
>  1 file changed, 189 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-interrupt.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-interrupt.yaml
> new file mode 100644
> index 000000000000..13398ff8be12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-interrupt.yaml
> @@ -0,0 +1,189 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-interrupt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2700 Interrupt Controllers (INTC0/INTC1)
> +
> +description: |
> +  The ASPEED AST2700 SoC integrates two interrupt controller designs:
> +
> +    - INTC0: Primary controller that routes interrupt sources to upstream,
> +      processor-specific interrupt controllers
> +
> +    - INTC1: Secondary controller whose interrupt outputs feed into
> +      INTC0

Wrap lines at 80 char.

> +
> +  The SoC contains four processors to which interrupts can be routed:
> +
> +    - PSP: Primary Service Processor (Cortex-A35)
> +    - SSP: Secondary Service Processor (Cortex-M4)
> +    - TSP: Tertiary Sevice Processor (Cortex-M4)
> +    - BMCU: Boot MCU (a RISC-V microcontroller)
> +
> +  The following diagram illustrates the overall architecture of the
> +  ASPEED AST2700 interrupt controllers:
> +
> +                  +-----------+                +-----------+
> +                  |   INTC0   |                | INTC1(0)  |
> +                  +-----------+                +-----------+
> +                  |   Router  | +-----------+  |   Router  |
> +                  | out   int | +Peripheral +  | out   int |
> +  +-----------+   |  0     0  <-+Controllers+  | INTM      | +-----------+
> +  |PSP GIC  <-|---+  .     .  | +-----------+  |  .     .  <-+Peripheral +
> +  +-----------+   |  .     .  |                |  .     .  | +Controllers+
> +  +-----------+   |  .     .  |                |  .     .  | +-----------+
> +  |SSP NVIC <-|---+  .     .  <----------------+  .     .  |
> +  +-----------+   |  .     .  |                |  .     .  |
> +  +-----------+   |  .     .  <--------        |  .     .  |
> +  |TSP NVIC <-|---+  .     .  |       |    ----+  .     .  |
> +  +-----------+   |  .     .  |       |    |   |  O     P  |
> +                  |  .     .  |       |    |   +-----------+
> +                  |  .     .  <----   |    --------------------
> +                  |  .     .  |   |   |        +-----------+  |
> +                  |  M     N  |   |   ---------+  INTC1(1) |  |
> +                  +-----------+   |            +-----------+  |
> +                                  |                  .        |
> +                                  |            +-----------+  |
> +                                  -------------+  INTC1(N) |  |
> +                                               +-----------+  |
> +  +--------------+                                            |
> +  + BMCU APLIC <-+---------------------------------------------
> +  +--------------+
> +
> +  INTC0 supports:
> +    - 128 local peripheral interrupt inputs
> +    - Fan-in from up to three INTC1 instances via banked interrupt lines (INTM)
> +    - Local peripheral interrupt outputs
> +    - Merged interrupt outputs
> +    - Software interrupt outputs (SWINT)
> +    - Configurable interrupt routes targeting the PSP, SSP, and TSP
> +
> +  INTC1 supports:
> +    - 192 local peripheral interrupt inputs
> +    - Banked interrupt outputs (INTM, 5 x 6 banks x 32 interrupts per bank)
> +    - Configurable interrupt routes targeting the PSP, SSP, TSP, and BMCU
> +
> +  One INTC1 instance is always present, on the SoC's IO die. A further two
> +  instances may be attached to the SoC's one INTC0 instance via LTPI (LVDS
> +  Tunneling Protocol & Interface).
> +
> +  Interrupt numbering model
> +  -------------------------
> +  The binding uses a controller-local numbering model. Peripheral device
> +  nodes use the INTCx local interrupt number (hwirq) in their 'interrupts' or
> +  'interrupts-extended' properties.
> +
> +  For AST2700, INTC0 exposes the following (inclusive) input ranges:
> +
> +    - 000..479: Independent interrupts
> +    - 480..489: INTM0-INTM9
> +    - 490..499: INTM10-INTM19
> +    - 500..509: INTM20-INTM29
> +    - 510..519: INTM30-INTM39
> +    - 520..529: INTM40-INTM49
> +
> +  INTC0's (inclusive) output ranges are as follows:
> +
> +    - 000..127: 1:1 local peripheral interrupt output to PSP
> +    - 144..151: Software interrupts from the SSP output to PSP
> +    - 152..159: Software interrupts from the TSP output to PSP
> +    - 192..201: INTM0-INTM9 banked outputs to PSP
> +    - 208..217: INTM30-INTM39 banked outputs to PSP
> +    - 224..233: INTM40-INTM49 banked outputs to PSP
> +    - 256..383: 1:1 local peripheral interrupt output to SSP
> +    - 384..393: INTM10-INTM19 banked outputs to SSP
> +    - 400..407: Software interrupts from the PSP output to SSP
> +    - 408..415: Software interrupts from the TSP output to SSP
> +    - 426..553: 1:1 local peripheral interrupt output to TSP
> +    - 554..563: INTM20-INTM29 banked outputs to TSP
> +    - 570..577: Software interrupts from the PSP output to TSP
> +    - 578..585: Software interrupts from the SSP output to TSP
> +
> +  Inputs and outputs for INTC1 instances are context-dependent. However, for the
> +  first instance of INTC1, the (inclusive) output ranges are:
> +
> +    - 00..05: INTM0-INTM5
> +    - 10..15: INTM10-INTM15
> +    - 20..25: INTM20-INTM25
> +    - 30..35: INTM30-INTM35
> +    - 40..45: INTM40-INTM45
> +    - 50..50: BootMCU
> +
> +maintainers:
> +  - ryan_chen@aspeedtech.com
> +  - andrew@codeconstruct.com.au

Name and email address please.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2700-intc0
> +      - aspeed,ast2700-intc1
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 1
> +    description: Single cell encoding the INTC local interrupt number (hwirq).
> +
> +  aspeed,interrupt-ranges:
> +    description: |
> +      Describes how ranges of controller output pins are routed to a parent
> +      interrupt controller.
> +
> +      Each range entry is encoded as:
> +
> +        <out count phandle parent-specifier...>
> +
> +      where:
> +        - out:     First controller interrupt output index in the range.
> +        - count:   Number of consecutive controller interrupt outputs and parent
> +                   interrupt inputs in this range.
> +        - phandle: Phandle to the parent interrupt controller node.
> +        - parent-specifier: Interrupt specifier, as defined by the parent
> +                            interrupt controller binding.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 3
> +    items:
> +      description: Range descriptors with a parent interrupt specifier.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - aspeed,interrupt-ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    interrupt-controller@12100000 {
> +        compatible = "aspeed,ast2700-intc0";
> +        reg = <0x12100000 0x3b00>;
> +        interrupt-parent = <&gic>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +
> +        aspeed,interrupt-ranges =
> +          <0 128 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +          <144 8 &gic GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> +          <152 8 &gic GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> +          <192 10 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> +          <208 10 &gic GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
> +          <224 10 &gic GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>,
> +          <256 128 &ssp_nvic 0 0>,
> +          <384 10 &ssp_nvic 160 0>,
> +          <400 8 &ssp_nvic 144 0>,
> +          <408 8 &ssp_nvic 152 0>,
> +          <426 128 &tsp_nvic 0 0>,
> +          <554 10 &tsp_nvic 160 0>,
> +          <570 8 &tsp_nvic 144 0>,
> +          <578 8 &tsp_nvic 152 0>;
> +    };
> 
> -- 
> 2.34.1
> 

