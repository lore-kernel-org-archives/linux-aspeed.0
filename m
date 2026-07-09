Return-Path: <linux-aspeed+bounces-4452-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA7CC44508
	for <linux-aspeed@archiver.kernel.org>; Thu,  9 Jul 2026 08:55:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwpgp3xK9z3c9w;
	Thu, 09 Jul 2026 18:55:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783587302;
	cv=none; b=m/zXgnHrE9optK0YsL7zUTyB9eKNpKeoToo8GG0ExvOvY8/2sptaTKXkeOcD9rUoQVmEh+l8zxsWxPKe3JvRCFKg4LLN6fIO5bBxqhn7mxhrn9hiCbTZLbPw+JIvkSRzyNnRiDXnen64fBzY/ynKodDCjXO0mY9IUFTfT/LLgakrqlXEsdvThcTMAguyfcq4Np/4/UzkYbXyI/TMTqkwPKdA+R7ITVn3Qur0kMzM5JmONty+PbBwUh4+LndrxDEJC8wVynK57EJO4PO4AGlfjFYCoxKFxsqlA3Z2bFDPK3L0w8GOGFpg0JQ3Q2BVRI7k3SMcb/hUvCMSBVNlFnvVEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783587302; c=relaxed/relaxed;
	bh=E+NtRvec8F8aekKuz6iezeEslYswvJ60lH8RuxMxcZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2S1PrOTo897ACiy+x40VwELi7L3q63qyM5UUhK+P2PnS5hOQEcGKAMzpcEJzezPlhwWLVF6nihMR6PJJbJrLbPI94qv7nyc2JRXAbKVGPWL9DrLe8LnL2pXXIgryqC88XTQye8wuR18cTPoeHqXyb9JFx3c6/mqnMiWbRs1t/uTvaskMbTvz61yTC70u5Vb6Dx9kGf1vTHEKE7Q2mLeFzrHbAh7V52O7tIehXdwCDsYoQaXnHzlsiNNVMxnYCBqikDZ6erHehqjszhLsNGpvf/5KnS1Imri0cGu3I3hWO8C0Ek5auWhiyRh3k+cbozL4mRZ91MuygHgumFWuBNehA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ev/MX5jc; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ev/MX5jc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwpgn46F4z3byT
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Jul 2026 18:55:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B656243F84;
	Thu,  9 Jul 2026 08:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2D41F0155C;
	Thu,  9 Jul 2026 08:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783587297;
	bh=E+NtRvec8F8aekKuz6iezeEslYswvJ60lH8RuxMxcZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ev/MX5jc/Q/G6Qw04KbVPZw5mRQE+925mjjdbilnfAAOVJNfB1vqvULVLTCS81vKk
	 wN2ytgPlflg25QwFvcSP2Mv0/Og4TU7H5c3xEcu8NHXE2ECgL5+5plo48ZJQVghFzF
	 ARE7QFfwFhP2oxWPJQtYxV8h4ax//Sd33HlQF2Bo5rtU+5NcVs10Z9Cev8yw3fQhzM
	 74/hC6VBgPCPGTR9nk/d7uzrDgXFSYvRHsdwaKfU4yNLh06rO1EPX2L5jhL+ypVDGJ
	 d3Hgo4aJ7/3SoluWgBzvIxxhHBj0j/dKNRgKt+m0jpCu4Y9TGMHVfy4bB/NJB0jyl8
	 5sg4Dq9ZRwf1A==
Date: Thu, 9 Jul 2026 10:54:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?R3LDqWdvaXJl?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] dt-bindings: serial: 8250: aspeed: add
 aspeed,vuart-over-pci bool prop
Message-ID: <20260709-shaggy-discreet-dodo-e5ffbb@quoll>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <501428d6a6cb1548bf357c25313dbc319724ead2.1783524645.git.gregoire.layet@9elements.com>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <501428d6a6cb1548bf357c25313dbc319724ead2.1783524645.git.gregoire.layet@9elements.com>

On Wed, Jul 08, 2026 at 03:35:54PM +0000, Gr=C3=A9goire Layet wrote:
> The ASPEED AST2600 has 2 Virtual UARTs accessible over PCI.
> The ASPEED AST2600 can be used as a PCI device.
> 2 Virtual UART can be exposed to the host via this PCI device.
> These are 8250-compatible register sets and can be used to have UART
> communication between the PCI BMC and the host.
>=20
> This boolean can be set to specify if a VUART is used over PCI. A VUART
> over PCI needs a syscon phandle. The syscon gives a regmap to the SCU,
> which is used to set the enable bits of the PCI device.
> On the aspeed's chips, the clocks phandle already points at the SCU node.
> But deriving the regmap from the clock provider would misuse the clocks
> binding. An explicit syscon phandle states the dependency directly.
>=20
> Signed-off-by: Gr=C3=A9goire Layet <gregoire.layet@9elements.com>
> ---
>  .../devicetree/bindings/serial/8250.yaml      | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documen=
tation/devicetree/bindings/serial/8250.yaml
> index 8f22121381fc..2ea8981bba80 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -27,6 +27,16 @@ allOf:
>              enum:
>                - aspeed,ast2500-vuart
>                - aspeed,ast2600-vuart
> +  - if:
> +      required:
> +        - aspeed,vuart-over-pci
> +    then:
> +      required:
> +        - syscon
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2600-vuart

else:
=2E..
disallow new properties (see example-schema)

>    - if:
>        properties:
>          compatible:
> @@ -223,6 +233,12 @@ properties:
>            - const: uartclk
>            - const: reg
> =20
> +  syscon:

That's explicitly forbidden by writing bindings (and mentioned as the
antipattern in my older talks about DT).

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the SCU syscon, used to enable the VUART over the BMC P=
CI
> +      device. Only applicable to aspeed,ast2600-vuart.
> +
>    dmas:
>      minItems: 1
>      maxItems: 4
> @@ -316,6 +332,12 @@ properties:
>        polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH). Only
>        applicable to aspeed,ast2500-vuart and aspeed,ast2600-vuart.
> =20
> +  aspeed,vuart-over-pci:
> +    type: boolean
> +    description:
> +      Enable the VUART over the BMC PCI device. Only applicable to
> +      aspeed,ast2600-vuart.
> +
>  required:
>    - reg
>    - interrupts
> --=20
> 2.54.0
>=20

