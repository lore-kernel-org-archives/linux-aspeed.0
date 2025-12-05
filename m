Return-Path: <linux-aspeed+bounces-3052-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D62DD32D62
	for <linux-aspeed@archiver.kernel.org>; Fri,  5 Dec 2025 14:49:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dNDmh1nL4z2xPT;
	Sat, 06 Dec 2025 01:49:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764946180;
	cv=none; b=K0yVL4GgqnhKXUnumAxqfLzLaYDohRvufSHaeJ/khdwwEkOcWJS2L+9bI+w+FI7ddeJBwL+73VntzH8sO6DOl6r7whnuLmmjM8cG+dhprPFK4w9PEoZUdHWK7aGPPebUUHOW1ce889l7rii3PmrSDNcwj5DGVIIgeW4jhCRgKsVyjXEn0c5dw4pUEz9TU8CX68t/bNLdxsmg3pclXH2w3mxn+t4uRQXj5io+H+pTem1kdyO7xAcDv9gdpk3ChVA2NKucfDVXijO6kz3DcdWSGUnIV99yjAV8TKF+3H/5NeLzJm7l6lLPgWa2BBi4f2dzKGY69BMZSQBf/DitcJaBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764946180; c=relaxed/relaxed;
	bh=yBbh9YfFHCCqVeddEkBPEg6ghYqmMa7/9RWA+WpI8VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OShCrvqc627X7aPAEJ7KaWYfPQUivdvZJcoavku4C6sPS4EGmGpQepfjg01avAsMXy9qbkj2WMZNXHnPZ/M6yRdVI38SJWRvmNz8VyKZH9UNHYiArZBCW5+rrrDFXz0jIvbiTdYPDX5Mdol3bl47FSTZxZxRQzu7JHcyfgrI+vYUddqEe7ucZ2smWbx8sCIUGFxGpr4+pTT8Bwmauyt8C5Vrcir+S3wf44UNKsp1c0uBPD0mHtF1fKipdHQJAbWqar+LPpx3v7Kboj+zfAajWr5gXmM+yIeD/T1gwdTycdhaVHIMCsOPpoQ3+KEDtCKWpJCEYoTH+axJcNvcdC20IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ceyFAXvx; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ceyFAXvx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dNDmf67dmz2xP8
	for <linux-aspeed@lists.ozlabs.org>; Sat, 06 Dec 2025 01:49:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C33B160156;
	Fri,  5 Dec 2025 14:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49447C4CEF1;
	Fri,  5 Dec 2025 14:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764946176;
	bh=y46lOh3uiDJdon0wY2+qojpA7h8dJLDS70+GF62iHwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ceyFAXvxphL0FT5av2Xs7vcxFoSccfTGt/iVLs9wP/iXQUsfJccu6awsubBHZ46Zz
	 oftzNfAjw+rTQfd4d2Hj1S0DzVRt2bLZ3mFgwyuTBHgsnQBn2QvotZct+5eTAmHrhR
	 lsRZm8CXbm4oRZwCKjmQDMsBYu9nd5M5XsfX/fDgMn4KrBc7+bFxCwbBJoowEyuRDg
	 bVwUMixp7XwNJ3+1Ne46bXzmmWkfBEgwpJHpOZVuZk9FpTWUwYlC9QXA8YCPEJIadx
	 9AXqkt7DygY7c+Wh3L9WfG/WnHy6VtkBGNj9uXQyDuafH4j8vWvvOhAdyGfwzy2wAA
	 o0GuaxsFmrOGA==
Date: Fri, 5 Dec 2025 08:49:29 -0600
From: Rob Herring <robh@kernel.org>
To: Rebecca Cran <rebecca@bsdio.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Billy Tsai <billy_tsai@aspeedtech.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: hwmon: (aspeed,g5-pwm-tacho) Move
 info from txt to yaml
Message-ID: <20251205144929.GA76422-robh@kernel.org>
References: <20251204210238.40742-1-rebecca@bsdio.com>
 <20251204210238.40742-4-rebecca@bsdio.com>
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
In-Reply-To: <20251204210238.40742-4-rebecca@bsdio.com>

On Thu, Dec 04, 2025 at 02:02:36PM -0700, Rebecca Cran wrote:
> Move the documentation for the aspeed,ast2400-pwm-tacho and
> aspeed,ast2500-pwm-tacho devices from a text file to yaml file.
> 
> This allows for dts files containing these devices to be validated.
> 
> Where the text file documenation of required properties differ from the
> implementation, prefer the implementation and update the schema to
> match.
> 
> "#size-cells" was 1 but implementation is 0.
> "#cooling-cells" was marked as required but appears optional.
> 
> In the fan subnode, "cooling-levels" is optional according to the code
> in drivers/hwmon/aspeed-pwm-tacho.c.

Please see this one:

https://lore.kernel.org/all/20251029185448.2121857-1-robh@kernel.org/

> 
> Signed-off-by: Rebecca Cran <rebecca@bsdio.com>
> ---
>  Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.yaml | 91 ++++++++++++++++++++
>  Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt  | 73 ----------------
>  2 files changed, 91 insertions(+), 73 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.yaml
> new file mode 100644
> index 000000000000..b23c3519604b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2023 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,g5-pwm-tacho.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2400/AST2500 PWM and Fan Tacho controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The ASPEED PWM controller can support up to 8 PWM outputs. The ASPEED Fan
> +  Tacho controller can support up to 16 Fan tachometer inputs.
> +
> +  There can be up to 8 fans supported. Each fan can have one PWM output and
> +  one/two Fan tach inputs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-pwm-tacho
> +      - aspeed,ast2500-pwm-tacho
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^fan@[0-9]+$":
> +    $ref: fan-common.yaml#
> +    unevaluatedProperties: false
> +    properties:
> +      aspeed,fan-tach-ch:
> +        description:
> +          The tach channel used for the fan.
> +        $ref: /schemas/types.yaml#/definitions/uint8-array
> +
> +    required:
> +      - reg
> +      - aspeed,fan-tach-ch
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - reg
> +  - pinctrl-names
> +  - pinctrl-0
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    pwm_tacho: pwmtachocontroller@1e786000 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #cooling-cells = <2>;
> +        reg = <0x1E786000 0x1000>;
> +        compatible = "aspeed,ast2500-pwm-tacho";
> +        clocks = <&syscon ASPEED_CLK_APB>;
> +        resets = <&syscon ASPEED_RESET_PWM>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
> +
> +        fan@0 {
> +                reg = <0x00>;
> +                cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
> +                aspeed,fan-tach-ch = /bits/ 8 <0x00>;
> +        };
> +
> +        fan@1 {
> +                reg = <0x01>;
> +                aspeed,fan-tach-ch = /bits/ 8 <0x01 0x02>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt b/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt
> deleted file mode 100644
> index 8645cd3b867a..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -ASPEED AST2400/AST2500 PWM and Fan Tacho controller device driver
> -
> -The ASPEED PWM controller can support upto 8 PWM outputs. The ASPEED Fan Tacho
> -controller can support upto 16 Fan tachometer inputs.
> -
> -There can be upto 8 fans supported. Each fan can have one PWM output and
> -one/two Fan tach inputs.
> -
> -Required properties for pwm-tacho node:
> -- #address-cells : should be 1.
> -
> -- #size-cells : should be 1.
> -
> -- #cooling-cells: should be 2.
> -
> -- reg : address and length of the register set for the device.
> -
> -- pinctrl-names : a pinctrl state named "default" must be defined.
> -
> -- pinctrl-0 : phandle referencing pin configuration of the PWM ports.
> -
> -- compatible : should be "aspeed,ast2400-pwm-tacho" for AST2400 and
> -	       "aspeed,ast2500-pwm-tacho" for AST2500.
> -
> -- clocks : phandle to clock provider with the clock number in the second cell
> -
> -- resets : phandle to reset controller with the reset number in the second cell
> -
> -fan subnode format:
> -===================
> -Under fan subnode there can upto 8 child nodes, with each child node
> -representing a fan. If there are 8 fans each fan can have one PWM port and
> -one/two Fan tach inputs.
> -For PWM port can be configured cooling-levels to create cooling device.
> -Cooling device could be bound to a thermal zone for the thermal control.
> -
> -Required properties for each child node:
> -- reg : should specify PWM source port.
> -	integer value in the range 0 to 7 with 0 indicating PWM port A and
> -	7 indicating PWM port H.
> -
> -- cooling-levels: PWM duty cycle values in a range from 0 to 255
> -                  which correspond to thermal cooling states.
> -
> -- aspeed,fan-tach-ch : should specify the Fan tach input channel.
> -                integer value in the range 0 through 15, with 0 indicating
> -		Fan tach channel 0 and 15 indicating Fan tach channel 15.
> -		At least one Fan tach input channel is required.
> -
> -Examples:
> -
> -pwm_tacho: pwmtachocontroller@1e786000 {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	#cooling-cells = <2>;
> -	reg = <0x1E786000 0x1000>;
> -	compatible = "aspeed,ast2500-pwm-tacho";
> -	clocks = <&syscon ASPEED_CLK_APB>;
> -	resets = <&syscon ASPEED_RESET_PWM>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
> -
> -	fan@0 {
> -		reg = <0x00>;
> -		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
> -		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
> -	};
> -
> -	fan@1 {
> -		reg = <0x01>;
> -		aspeed,fan-tach-ch = /bits/ 8 <0x01 0x02>;
> -	};
> -};
> -- 
> 2.47.3
> 

