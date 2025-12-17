Return-Path: <linux-aspeed+bounces-3138-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49455D65C63
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Dec 2025 22:53:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWpxs3cTvz2xqj;
	Thu, 18 Dec 2025 09:53:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766012033;
	cv=none; b=BIxT5so6S44ETPhbUiF41YjLs3I1Oi/V0rownJAuMN1nNB5laTPScS9qeFz20P4HeHHsPAjPEACStr22LRuYZlsjNZ621g4cozqk/dzgWgFG+pDdW/nJPkDJfiVhiwLgl4uAXeMP1/DvXBKrMCvu/NUY71rPBUx29+MuRw7zohckMxbg9C/PUcUnu1A4tb+rkqhBDaFo6owg1rnU4ntVBHZZ4bJSnhn3DEeWihGvk9gBqiB6s8yEbzgKUjYjWsIsbPDwtE8QiqfZQsTAkOGGI9sXVipoRxzdar/nK1Rl92NPLU8GXa1SLj0C+1isHPYE8vhqtHuMruNCEFdQaMk/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766012033; c=relaxed/relaxed;
	bh=J1EO9nRN3BOzOyJvyc6Rau/FS5vQn8zuB3tbnQRn2do=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDigWwIE7f8wwAFIlgfq3f0JBljprMV7D+wO03toskYY9awSakzou4JBKEKn00efxIQB7kQyx1QJHZF4MSlVmSmeYD/kJ80sJ6QEY4tJKdKosfFaTrv1jR4EAQ+7EIYI12VhpGKq4fzOWXZkzHcOsoNGyKKPYVGlu4ufXvJpUvn5Fd2Lfuj6ESXDoW7KDYl1wce4+xkJkpJ07yXgBuFa6sqrl78nnI5bxMjP37LZ26k4jHRIOhLEZcV9/sQ11wqReUWiTnNYiG5d+yOOR+MiwTc+aDaKZxewPrQBqnuarxU5p6WZLe4x2MyDpHxtFoNNsUZ6TuJn80O9+VojWCkU9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=DB0aI9Lu; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=DB0aI9Lu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dWpxr4d2Gz2x99
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Dec 2025 09:53:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1766012032;
	bh=J1EO9nRN3BOzOyJvyc6Rau/FS5vQn8zuB3tbnQRn2do=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DB0aI9Lu6IkzUxPvmlzKi1NLFN8r/PmBrtmRFY8KT4Fe3rTAKnTkjsK11cfhX/CUp
	 tXWT5e+HaySUTzD3d4GwVolw4P0CpnP4ReH0wOAlFxahthjJYNYzsq0DO6j9J7R/gj
	 ppKIU8TPT/A/GKufXp4RouX0am0IlXPXN/dMNPebaO04RrK0mw6juY+GJToO2KbLEt
	 tmJMxbYhm9VCdzxwoCi7KP/sFDtnGuyxUGqQ5uYpdwT1N1PuQj4FpvsC5JtcAn7G6L
	 I8tGti09g1HiXqFYtFwaGOl0I6pWkvVv6g2bUP/bL1rCoOiUgfxEkw+iuLOg+Bb3Tf
	 ZvxpBg3R/DFpQ==
Received: from [192.168.68.115] (unknown [180.150.112.216])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 706157C1B2;
	Thu, 18 Dec 2025 06:53:51 +0800 (AWST)
Message-ID: <ee0acf89f82555a1c0705fba5818875811a3a27e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 2/2] ARM: dts: aspeed: add device tree for ASRock
 Rack ALTRAD8 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rebecca Cran <rebecca@bsdio.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 18 Dec 2025 09:23:50 +1030
In-Reply-To: <20251211165700.29206-3-rebecca@bsdio.com>
References: <20251211165700.29206-1-rebecca@bsdio.com>
	 <20251211165700.29206-3-rebecca@bsdio.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

Hi Rebecca,

On Thu, 2025-12-11 at 09:56 -0700, Rebecca Cran wrote:
> The ALTRAD8 BMC is an Aspeed AST2500-based BMC for the ASRock Rack
> ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q boards.
>=20
> Signed-off-by: Rebecca Cran <rebecca@bsdio.com>
> ---
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts
> b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts
> new file mode 100644
> index 000000000000..4898ddede1c2
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts
> @@ -0,0 +1,624 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +	model =3D "ASRock ALTRAD8 BMC";
> +	compatible =3D "asrock,altrad8-bmc", "aspeed,ast2500";
> +
> +	aliases {
> +		serial4 =3D &uart5;
> +		i2c50 =3D &nvme1;
> +		i2c51 =3D &pcie4;
> +		i2c52 =3D &pcie5;
> +		i2c53 =3D &pcie6;
> +		i2c54 =3D &pcie7;
> +		i2c55 =3D &nvme3;
> +		i2c56 =3D &nvme2;
> +		i2c57 =3D &nvme0;
> +		i2c58 =3D &nvme4;
> +		i2c59 =3D &nvme5;
> +		i2c60 =3D &nvme6;
> +		i2c61 =3D &nvme7;
> +		i2c62 =3D &nvme8;
> +		i2c63 =3D &nvme9;
> +		i2c64 =3D &nvme10;
> +		i2c65 =3D &nvme11;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "uart5:115200n8";
> +	};
> +
> +	iio-hwmon {
> +		compatible =3D "iio-hwmon";
> +		io-channels =3D	<&adc 0>, <&adc 1>, <&adc 2>, <&adc
> 3>,
> +				<&adc 4> ,<&adc 5>, <&adc 6>, <&adc
> 7>,
> +				<&adc 8>, <&adc 9>, <&adc 10>, <&adc
> 11>,
> +				<&adc 12>, <&adc 13>, <&adc 14>,
> <&adc 15>;
> +	};
> +

*snip*

> +&adc {
> +	status =3D "okay";

Please add the necessary pinctrl properties to request the ADC lines as
used for the iio-hwmon bridge. This ensures their exclusive use so they
can't otherwise be muxed as e.g. GPIOs and produce surprising system
behaviour.

> +};
> +

*snip*

> +&pinctrl {
> +	aspeed,external-nodes =3D <&gfx &lhc>;

This property is now set in aspeed-g5.dtsi so it's unnecessary to do so
here in the dts. I also have a cleanup at [1] that impacts it, so the
less we can propagate the problem the better

[1]: https://lore.kernel.org/all/20251211-dev-dt-warnings-all-v1-0-21b18b9a=
da77@codeconstruct.com.au/

Otherwise the patch looks okay to me.

Andrew

