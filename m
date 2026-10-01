Return-Path: <linux-aspeed+bounces-5099-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD99CA5FB3
	for <linux-aspeed@archiver.kernel.org>; Thu,  1 Oct 2026 05:56:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwLlT4YwQz2yMP;
	Thu, 01 Oct 2026 15:56:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790834213;
	cv=none; b=nad3oHQElTnow5FvUKYhF0qX4bEdkxHPZAIAGz/F4isZBw/O20HVGDQic5mhG+wFhz3jH0g9NsvdSBn7KQ0KCwGPtOHJLmQB5UODX55y67akGJOeG48JlwJHlFUXBIbdQEeGWgH8aq7kYMe0d6AfFJaDKCZOnZYfvUDp8y5rurZ8r321mfCpgRiXGjFJEkwV9yJKVESM0lJKfz7b7+MqTuMMgC8FQnEgQyQJXuhmd+ZENzkIbzgLBllRNaSHnGHC90JIO86J61EOv+j8cdUp3o9+RjdDGmiOrrtEXqixwiNr3XR6mqSnjvZm3Ld1W7OAerRHwLBHH1tOSW5sBDPFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790834213; c=relaxed/relaxed;
	bh=ZDxsokV5obQ5C8QUjCgm5Et9Kq1WK82QzPRqqhS1oSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WADsKbIzo8sx3BaUNoKcQCb9ut7MRvEtekt8eDJfrIf+AHioupGC5QTBwml0OUeP3ZSaA4/YyHH6ZOXFsJ4pP+6VgV4gFB+zDSKLgeOqCkRFaYet7V5PBfwqIctSBsOLE49dsckMl0QKt5IWp1w67XZPo6nJAZqFSL+Tdgxm3KaHZ3xRGyvzbPeUtsGbka+3pnKPB/1QiF6/JmGPvi/REIBgIi2NZk1MRhp681D91lT0yxySosS2o6jPk/K6IW+HY6omgTQM9ozcXrklhotVO/BtTY6Qkbm2PejjvKNfIC4ubgq3MWIV2czi8wTcx3MDIxJJ+6RSFEANX5tm1N9OFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JS1OLHY7; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JS1OLHY7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwLlS3dN7z2xsW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Oct 2026 15:56:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A21BC43693;
	Thu,  1 Oct 2026 05:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AB81F000FF;
	Thu,  1 Oct 2026 05:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790834209;
	bh=ZDxsokV5obQ5C8QUjCgm5Et9Kq1WK82QzPRqqhS1oSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JS1OLHY7AHmn7gnE2QX4jLhMDKzXZfIViXHr4j4k0n84XCeGcPItrHrlq4kwPc/g7
	 VWuc+LL0Aw0XmJSh9tYVPvlj28ZO6K7GVqrPD75ctqrAeWX3eNL4SYtrnYDgCRwiiH
	 pGhCtHnoJpzsIIVWMaW35sYlNJLZXFMxRTtI/dBNg172RjS0GPVSBjmVlIAFeA4wI+
	 R+Zsy0mRxV+xjjEcNMWcQccSGH6piG6qRlp4MkMI8VX+H0CQ1gXQ6LfAafU4ZSTj6w
	 GrbimXZxT3+1HTdKmwMey2dnVlNCcLPFTtzNr6xvjrXjxzWxsvuw49o8uWT8ZsIYIA
	 fp+L5qpppAvSw==
Date: Thu, 1 Oct 2026 07:56:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: Add syscon property for
 multi-SCU SoCs
Message-ID: <20261001-obedient-stimulating-worm-0ae11c@quoll>
References: <20261001-ast27xx-adc-upstream-v1-0-5ace57533418@aspeedtech.com>
 <20261001-ast27xx-adc-upstream-v1-1-5ace57533418@aspeedtech.com>
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
In-Reply-To: <20261001-ast27xx-adc-upstream-v1-1-5ace57533418@aspeedtech.com>

On Thu, Oct 01, 2026 at 11:28:44AM +0800, Billy Tsai wrote:
> The ADC's reference-voltage trimming data lives in a System Control
> Unit (SCU) register. SoCs with a single SCU instance let the driver
> locate it without any additional information, but SoCs such as AST2700
> that expose more than one SCU node need an explicit phandle to
> disambiguate which one holds the trimming data.
> 
> Add an optional "syscon" phandle property, and require it for the
> AST2700 compatibles since they are the first multi-SCU SoCs supported
> by this driver.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Assisted-by: Claude:claude-sonnet-5
> ---
>  .../bindings/iio/adc/aspeed,ast2600-adc.yaml       | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
> index 249101b55cf4e..0d6b10450cfa8 100644
> --- a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
> @@ -67,6 +67,11 @@ properties:
>      description:
>        Inform the driver that last channel will be used to sensor battery.
>  
> +  syscon:

Missing vendor and descriptive name. Please read writing bindings.

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Required on SoCs with more than one SCU instance (e.g. AST2700).

Describe the purpose, not open code schema.

> +
>  required:
>    - compatible
>    - reg
> @@ -74,6 +79,18 @@ required:
>    - resets
>    - "#io-channel-cells"
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - aspeed,ast2700-adc0
> +              - aspeed,ast2700-adc1
> +    then:
> +      required:
> +        - syscon
> +
>  additionalProperties: false
>  
>  examples:
> @@ -95,4 +112,15 @@ examples:
>          #io-channel-cells = <1>;
>          aspeed,int-vref-microvolt = <2500000>;
>      };
> +  - |
> +    #include <dt-bindings/clock/aspeed,ast2700-scu.h>
> +    #include <dt-bindings/reset/aspeed,ast2700-scu.h>

No need for a new exmaple for one new property.

Best regards,
Krzysztof


