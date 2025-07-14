Return-Path: <linux-aspeed+bounces-1694-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8444EC83F17
	for <linux-aspeed@archiver.kernel.org>; Mon, 14 Jul 2025 08:17:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bgZtk0TFCz3bsT;
	Mon, 14 Jul 2025 18:17:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752481053;
	cv=none; b=cdcYOHzmKfZt/vSWxkcKjxGOUtSjNjAuOdGWkpYxqSMHj7+vgAuQrO+udrdOBaczFF9UZ3e++tbyE2SSI+F13YvIwDFmIoMTP780WO0YrX2XcsrELa1N0IxalLXsBFkkBAnv6kDistDYAruMHdusDxRsDiXl6qZzeT64Jo81Lcavmdd6Kp2RJ8Ivncoy6M7a/Uahfhui3b7uwUQ8FQzr27B+571F4bETHO2kykB6EAw2BXTTeEvyZJkazrEj38Bqki1bX9AaA9C0SBel/rTYlHNxoP/CRV3GkildOXYUmz27VB6L3uKV9slUF9N2G56F9GZ07Jk79avOSk1r5FlD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752481053; c=relaxed/relaxed;
	bh=JSKx5SHEq33VxDPO5OHD3/BWPCuVvoi++4d98EY2cf0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NMY6uXvV2O6Nk8blrHaunnxbtyZMKG8go7OSoMOh5viAS9202/165uOCxuKepEaxFjjlhN52ZVy3RDV4oU9Qw13OM0f1S+nYyzxmq7K7K4Hbttl9YquA/WIHEde2IwR2P6v2zGO2tymF9zsxpINGnMsLQ4YU6IREpNilAjseDMAkDIJbe9L5+2AQnIF+M/8bkPjaG0fJM18J+XiXdi4m18F/ke3PIDY9/gTRMtAASQS0qa9EZJQGeta7XqkoD/EGCishKRP3F8+aQWLtecH3MO91DjjmmcfxoMDUDjH2LCLbBsQO/5FsKVbi0IXKfWZTvU+pMQEDhr5/omW5j4auaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JjU9wg+c; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JjU9wg+c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bgZth6HmLz3bqQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 14 Jul 2025 18:17:32 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 83A4660052;
	Mon, 14 Jul 2025 08:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23362C4CEED;
	Mon, 14 Jul 2025 08:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752481050;
	bh=HU6qaRX0H63WQNkChMnnlLrTNSnQpYkD+nlgW/FZX3w=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=JjU9wg+caJG31D0CW4bhBC6zj/xORL/KaedDTektBzMxDD00Ne35k+DcPKouPhcZ8
	 V+siYdxAN+xOF3XN/bSuv/wv6lQ8iIT5gqFGEW76EZCU87Kf3pqQecKJ2hfIPDR6u0
	 GMH73EEQQ1FXlyjMXNtfxfDUd+r3Fnln5FctxZNOazceKS1QOrgTSsWGT7d+MeHEn7
	 4HOruxq8gJLGD0xTE2fSGNtNkHiBiu+8dhSOkb5pOvIZOgqfqokMFd8ZqkBAEOQra5
	 Y6Ylb6tA4w1496Umb7Lueq4Ut1Xfy2/YoanxIIhR1M3Z/Ca7GM2S38NAJ2eV/1v62f
	 S2XmkXcPA39tw==
Date: Mon, 14 Jul 2025 03:17:29 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Joel Stanley <joel@jms.id.au>, 
 linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Chen <kevin_chen@aspeedtech.com>, 
 devicetree@vger.kernel.org
To: Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20250714071753.2653620-1-ryan_chen@aspeedtech.com>
References: <20250714071753.2653620-1-ryan_chen@aspeedtech.com>
Message-Id: <175248104913.1053585.2976024588034663905.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: aspeed: Refine
 AST2700 binding description and example


On Mon, 14 Jul 2025 15:17:53 +0800, Ryan Chen wrote:
> - Update block diagram for better readability and accuracy.
> - Clarify the relationship and function of INTC0, INTC1, and the GIC.
> - Documentation and example refine.
> 
> This enhances the documentation quality and helps developers understand
> the interrupt controller hierarchy and usage.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../aspeed,ast2700-intc.yaml                  | 155 +++++++++++++-----
>  1 file changed, 112 insertions(+), 43 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml: address-cells: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml: size-cells: missing type definition
Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dts:39.15-41: Warning (reg_format): /example-0/bus/interrupt-controller@12100000/interrupt-controller@1b00:reg: property has invalid length (12 bytes) (#address-cells == 2, #size-cells == 2)
Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: interrupt-controller@12100000 (aspeed,ast2700-intc0): '#address-cells', '#size-cells' do not match any of the regexes: '^interrupt-controller@', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: interrupt-controller@12100000 (aspeed,ast2700-intc0): interrupt-controller@1b00:reg:0: [0, 303045376, 16] is too short
	from schema $id: http://devicetree.org/schemas/reg.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: interrupt-controller@14c18000 (aspeed,ast2700-intc1): '#address-cells', '#size-cells' do not match any of the regexes: '^interrupt-controller@', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.example.dtb: interrupt-controller@14c18000 (aspeed,ast2700-intc1): interrupt-controller@100: 'interrupts' is a required property
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250714071753.2653620-1-ryan_chen@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


