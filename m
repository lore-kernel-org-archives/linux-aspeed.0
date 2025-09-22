Return-Path: <linux-aspeed+bounces-2322-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D40CAC592
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Sep 2025 20:07:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVvKq3ZGfz2yr6;
	Tue, 23 Sep 2025 06:07:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758571663;
	cv=none; b=BR3WypmjGZdI9vkUw+9+uTHfxVXBTLzVLm9N0MGqV5RuhPVF0k69mT87/3p832ee5wXr9rMOSO51FgkOzzhHS4IsDoCrUbPHGNOKfp7U4EI7ISpHfLe45aC0Q41818cWJ94C9W97LPSOsjaQzkWGniQxhn13LM2ctjw2Mmkk2EYKQdxUgrt5rLIOfhbgkx+Eof1szoU3UZSWBzFvWV0SsR49qMR6dFoWWEXvKrJemGV7i6ixYWgnqOa8pPx3SV46SA4eVuBaYjfH2zZ1vibgACuDyx1lIXENLkUeCuIq+0HAfgLZxpB22270dNT9zNhdfoGgxl3cOYdidXCr0Ok17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758571663; c=relaxed/relaxed;
	bh=GbfWI5VgTCv69gvfXGCnl3FrrsHZpD1DeQLmU9ztvhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PesKlntoaUzW/UhxKltb/KizwysYC5Mt8c20NBnqVEZGzwJXaIzPsJAZwG65GR42+XwlRQd7FHOf7WgrJlZAN2cUfOxthynLz5JjkAJpsYu3ceKgA/WHqyuh46wrKZ9IkDlTqlIi0f5kHC1D0YF0q2txeyDoI40vkpb/nc1dKsD+Lu5d5Jtz32NPg/hcW37rgFZJyN0dNm6F8RRnb+3f7cplD7+jiOUbTnuaLWewCgelxRX8RWppYy3lRlbJVFWNmsDUakLZbFyozNWsLFJ/3kJGnHOgTtUeyauGvKfpyFPf6y1PDXabvZg/9XE/OyO6qLZ1uS7K6gWkL2w1cJwYdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=monluQec; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=monluQec;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVvKp4fPQz2ymg
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Sep 2025 06:07:42 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3EF876023D;
	Mon, 22 Sep 2025 20:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E0DC4CEF0;
	Mon, 22 Sep 2025 20:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758571660;
	bh=gtKQtJ/YDcC6QiYeZV6qf7suqJhBgfA3Ye1KfJV9y9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=monluQecJyK0YMI7Arhl/QJKcH/Sl5qAvE49lBKMiiNRTEcsRbHVSI6tfR2nrB5Mp
	 M1mtmvsGAb+4wriRQ7y4QP9+xxnGAXxgCAwjdB3KByeTtGLjBvCaBYeo6qvBerWL1C
	 x3+c9h+fVcrml7zamn/EPGmGbkIvK4Ogh4ltSLrdrU3nGY1BTRYUWYudIQHCvfUOPG
	 aMZWTIVIVnHT6xyxSyD/sIP+/dt4Rdft4QGCafqd+GBQZ07JdadR18cBcnJy17p6z1
	 LwW7IBHzoQgYqrMiyXWY7iLnSE8wa65PEqu/3t9TN+ovogrg1umBsLCJHHrR+FS6ok
	 lU82jti4gwd8Q==
Date: Mon, 22 Sep 2025 15:07:38 -0500
From: Rob Herring <robh@kernel.org>
To: Tan Siewert <tan@siewert.io>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add asrock x470d4u bmc
Message-ID: <20250922200738.GA1124791-robh@kernel.org>
References: <20250919185621.6647-1-tan@siewert.io>
 <20250919185621.6647-3-tan@siewert.io>
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
In-Reply-To: <20250919185621.6647-3-tan@siewert.io>

On Fri, Sep 19, 2025 at 08:56:18PM +0200, Tan Siewert wrote:
> The ASRock Rack X470D4U X470D4U is a single-socket X470-based microATX
> motherboard for Ryzen processors with an AST2500 BMC and either 32MB or
> 64MB SPI flash.
> 
> This mainboard exists in three known "flavors" which only differ in the
> used host NIC, the BMC SPI size and some parts that may be un-populated.
> 
> To keep the complexity low with the BMC SPI, use the 32MB layout
> regardless of the used SPI or mainboard flavor.
> 
> Signed-off-by: Tan Siewert <tan@siewert.io>
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../dts/aspeed/aspeed-bmc-asrock-x470d4u.dts  | 345 ++++++++++++++++++
>  2 files changed, 346 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index aba7451ab749..fae97b5183e5 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-asrock-e3c256d4i.dtb \
>  	aspeed-bmc-asrock-romed8hm3.dtb \
>  	aspeed-bmc-asrock-spc621d8hm3.dtb \
> +	aspeed-bmc-asrock-x470d4u.dtb \
>  	aspeed-bmc-asrock-x570d4u.dtb \
>  	aspeed-bmc-asus-x4tf.dtb \
>  	aspeed-bmc-bytedance-g220a.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
> new file mode 100644
> index 000000000000..bae2b521f708
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
> @@ -0,0 +1,345 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model = "Asrock Rack X470D4U-series BMC";
> +	compatible = "asrock,x470d4u-bmc", "aspeed,ast2500";
> +
> +	aliases {
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
> +			<&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
> +			<&adc 10>, <&adc 11>, <&adc 12>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		heartbeat {

led-0

This should have given you a warning. You did run "make dtbs_check" 
check the warnings, right?

Use "function" to define the function.

> +			/* led-heartbeat-n */
> +			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "timer";
> +		};
> +
> +		systemfault {

led-1

> +			/* led-fault-n */
> +			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
> +			panic-indicator;
> +		};
> +
> +		identify {

led-2

> +			/* led-identify-n */
> +			gpios = <&gpio ASPEED_GPIO(D, 6) GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +

