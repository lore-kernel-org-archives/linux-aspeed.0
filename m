Return-Path: <linux-aspeed+bounces-1721-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00637C83F27
	for <linux-aspeed@archiver.kernel.org>; Wed, 16 Jul 2025 08:27:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bhq154l69z3bby;
	Wed, 16 Jul 2025 18:27:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752654441;
	cv=none; b=J8gcNRypwWwQ6kuGKGRJ9VxMp/MSeQ9vbsZJxCW1fcvsSESk566LljnLLm0Sr2+VN0Iaf3MDr4z0fypM2gTsTk2PX0LaglVNlMdrloa+4UXGqlhwZD8Egt51/HVqPfbZzKDwxlqgysoCOUhyGPrSOx1Vkehc+7B5icQsgY1r7qfDi+WJgou0/KreGy6q8qQuFS2KXDn3kTx10cdNt4Bde9E3Td7rbuyr6fsfzENEoMwQoxTrUQZlCodj79nTMot7xhKDXEgTMi+yVOWVY18o4zCH2ryg1DRMSA9s3pGCP0iiphWP6qjA1sGazgYtLK29MKJm7MscE+2KCDu70iUguA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752654441; c=relaxed/relaxed;
	bh=Bmh4CYTvClTqEnnoR+LMXehgw+R4HPYGsu74Uz3UHnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcZfjgnGpm6ucCJTQNj769EYzZcc/KPdQP3ZHzHb1/lhKc+DSwIdD1heEMXzikG1FQbu8ia32GIoOXxzQJIbao4lfh2YVN1YGDcFR7M9qhrgcNnJQFm8TSu9Nz8ymc87VM9ors7PvSzIf5yEBspL9DuRfBBWG1ncH8DOY1PFl0i6JhM+q/MQRplX1Oak8DNnoHI6avkVdQ1gzyNLK+LRo9JDSxpf719wlfxhdb3mVvxSDrOcF/xTGfvd/UP1PKKKumLS4zjYVgiPfrxuzQK1mUJQpEWlVRn+XHstMo20jpZ/PsJSbfMfbnkxe53jrS5LK7Jo6VRQXdBIdmZFgYCvCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=be89xxRr; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=be89xxRr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhq146BsKz30VV;
	Wed, 16 Jul 2025 18:27:20 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 11DEE5C67DE;
	Wed, 16 Jul 2025 08:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F140C4CEF0;
	Wed, 16 Jul 2025 08:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752654438;
	bh=jA5FOSjFCNJGkBGVQ3T0NygKzKDwksb4u4k+DuY6Ba4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=be89xxRrv9xuxcIrfDxAYLIU64qDm+AhV8+M6ZIRIHCV6NppRf5AJ8o0NCluJ2xnX
	 hSiKyhZD+ICPEpqMknx+RBzxKFD5dm6ESQ2smgvsBvzpQDiBzd+uOsuEKINp2NBc+4
	 Ow9bH4ecBU8nxkuGEmi5Vm76U/1jskLNLgCK+j8iE9IcqlssP94zZCzNxubpn1bglP
	 8QBH0Vaaf13M+t1q580dgn/uJViuDVecG6wZ2QfQpJP4eRa95IUBj1iMy0rXCPp1+u
	 x/q8hOrqYIxVowZRisT94c+q6Wr+Jlzz9bc39vjnwJ2fUOJL4NLrvO8Vty7rZ0Kjdd
	 gEwd8c0O2CWpw==
Date: Wed, 16 Jul 2025 10:27:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, p.zabel@pengutronix.de, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2 03/10] dt-bindings: PCI: Add ASPEED PCIe RC support
Message-ID: <20250716-watchful-enigmatic-condor-0fc6b3@krzk-bin>
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
 <20250715034320.2553837-4-jacky_chou@aspeedtech.com>
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
In-Reply-To: <20250715034320.2553837-4-jacky_chou@aspeedtech.com>

On Tue, Jul 15, 2025 at 11:43:13AM +0800, Jacky Chou wrote:
> This binding describes the required and optional properties for

No, describe the hardware, not "this binding".

> configuring the PCIe RC node, including support for syscon phandles,
> MSI, clocks, resets, and interrupt mapping. The schema enforces strict
> property validation and provides a comprehensive example for reference.

Don't say what schema does or does not. It's completely redundant.
Describe the hardware.

Your entire commit is redundantn and not helpful at all.

> 

...

> +
> +  aspeed,ahbc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the ASPEED AHB Controller (AHBC) syscon node.
> +      This reference is used by the PCIe controller to access
> +      system-level configuration registers related to the AHB bus.
> +      To enable AHB access for the PCIe controller.
> +
> +  aspeed,pciecfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the ASPEED PCIe configuration syscon node.
> +      This reference allows the PCIe controller to access
> +      SoC-specific PCIe configuration registers. There are the others
> +      functions such PCIe RC and PCIe EP will use this common register
> +      to configure the SoC interfaces.
> +
> +  aspeed,pciephy:

No, phys are not syscons. I already told you that in v1.

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the ASPEED PCIe PHY syscon node.
> +      This property provides access to the PCIe PHY control
> +      registers required for link initialization and management.
> +      The other functions such PCIe RC and PCIe EP will use this
> +      common register to configure the PHY interfaces and get some
> +      information from the PHY.
> +
> +  interrupt-controller:
> +    description: Interrupt controller node for handling legacy PCI interrupts.
> +    type: object
> +    properties:
> +      '#address-cells':
> +        const: 0
> +      '#interrupt-cells':
> +        const: 1
> +      interrupt-controller: true
> +
> +    required:
> +      - '#address-cells'
> +      - '#interrupt-cells'
> +      - interrupt-controller
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus-common.yaml#

No other binding references this. Don't write completely different code
than all other SoCs. This entire binding is written such way.

> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2600-pcie
> +    then:
> +      required:
> +        - aspeed,ahbc
> +    else:
> +      properties:
> +        aspeed,ahbc: false
> +
> +required:
> +  - reg
> +  - interrupts
> +  - bus-range
> +  - ranges
> +  - resets
> +  - reset-names
> +  - msi-parent
> +  - msi-controller
> +  - aspeed,pciecfg
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - interrupt-controller
> +
> +unevaluatedProperties: false
> +
> +patternProperties:
> +  "^pcie@[0-9a-f,]+$":

Why do you need it? Also, order things according to example schema.

Best regards,
Krzysztof


