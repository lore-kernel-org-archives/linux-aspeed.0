Return-Path: <linux-aspeed+bounces-1616-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED7FC83013
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Jul 2025 07:41:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bXBfB1kX3z30FR;
	Wed,  2 Jul 2025 17:41:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751442066;
	cv=none; b=BwhiOMHIOmfdSr9pnTZJmRsDkeDldZC1LBfe3tMPUnU6HTaha66sYA46EPla8TruTpqt0el8HYoCim3xua9+F3TPqsjz62YFUSI8+g6X7xV+Kmboi5z+mGwyPgfxnlDMf0K72LbQkwr+CUhv/W4VeAW/mGTdB8oNLn1K9tTEj46HWMqPdUb9OfW9Yo7tk4p5s3G58LhBm23ZxKSqyLrvFSlsmt/nadvT2aiP3myuqKOzvqLGvglWN0rGdpT8DIZ/RRGDwNiYGXddTyk+IJVtNmPwcDoF0/zjJdYBfgPsNwbqf/X4gxwmtNxyXewAgQiqxDLWTVqImSQdF0NOKVVOww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751442066; c=relaxed/relaxed;
	bh=g3H13LtSgQj1P8RdnugkkMSydyZVAi3d+H2HGvnEnuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhijFMhBrkfkeu7Skk+emOkgyfpSqKtnwdXOVxEwYncP+iX37+XYueU2foD753c2oEB4WYbHGFgsX36z0tnO5XF97nJ6cXCC6jf4q4Xeb+xZcvK+JuiJYGWOYmwd8XXaV6aVyhunuZpXw908G5JV5bCL6EBOr17M781gB9uwY7jxN9lAY+W0m6XiF4b1fW8QiMUvlo1yc2YsZrFsuDFccsD9Wmc0ZsJaVUbHgiKeaN5vBJaAi65UTnrHgids0JXp42ZQ0nd7W80YDENLTZGjL7Qjq0zik9jPvu+VKt3ZQdlazj7mTwEhfDGtbqxpaieD8wYMye95GMUh/hKuPVdItg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Kcys7Ugp; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Kcys7Ugp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bXBf62jgYz2ypV
	for <linux-aspeed@lists.ozlabs.org>; Wed,  2 Jul 2025 17:41:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g3H13LtSgQj1P8RdnugkkMSydyZVAi3d+H2HGvnEnuk=; b=Kcys7Ugp8rQKNiCWyTG7s6sUVv
	QlBDGrO0b/gCjZt2iBE4wlc6AKF/POB7eBKUT2vgJ+DdhOKyXYqOvD5PR3go1d0Jfv80adtrfx9Ye
	kYIBvINgOa/LvHawepNQhG6C2RxWjlMzJ/cmZ00gEXD2rgOWJkqnhXzvtURYNreVhX5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uWs5A-00HYLu-BX; Wed, 02 Jul 2025 09:40:40 +0200
Date: Wed, 2 Jul 2025 09:40:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: rentao.bupt@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH 5/5] ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC
Message-ID: <a6f6966b-50ee-4b4f-9422-96c6ac9391a2@lunn.ch>
References: <20250702050421.13729-1-rentao.bupt@gmail.com>
 <20250702050421.13729-6-rentao.bupt@gmail.com>
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
In-Reply-To: <20250702050421.13729-6-rentao.bupt@gmail.com>

On Tue, Jul 01, 2025 at 10:04:16PM -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Add initial device tree for the Meta (Facebook) Darwin AST2600 BMC.
> 
> Darwin is Meta's rack switch platform with an AST2600 BMC integrated for
> health monitoring purpose.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |  1 +
>  .../dts/aspeed/aspeed-bmc-facebook-darwin.dts | 92 +++++++++++++++++++
>  2 files changed, 93 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index 2e5f4833a073..debbfc0151f8 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-facebook-bletchley.dtb \
>  	aspeed-bmc-facebook-catalina.dtb \
>  	aspeed-bmc-facebook-cmm.dtb \
> +	aspeed-bmc-facebook-darwin.dtb \
>  	aspeed-bmc-facebook-elbert.dtb \
>  	aspeed-bmc-facebook-fuji.dtb \
>  	aspeed-bmc-facebook-galaxy100.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
> new file mode 100644
> index 000000000000..f902230dada3
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2021 Facebook Inc.
> +
> +/dts-v1/;
> +
> +#include "ast2600-facebook-netbmc-common.dtsi"
> +
> +/ {
> +	model = "Facebook Darwin BMC";
> +	compatible = "facebook,darwin-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial0 = &uart5;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +			      <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
> +			      <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
> +	};
> +
> +	spi_gpio: spi {
> +		num-chipselects = <1>;
> +		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +/*
> + * BMC's "mac3" controller is connected to BCM53134P's IMP_RGMII port
> + * directly (fixed link, no PHY in between).
> + * Note: BMC's "mdio0" controller is connected to BCM53134P's MDIO
> + * interface, and the MDIO channel will be enabled in dts later (when
> + * "bcm53xx" driver's probe failure is solved on the platform).
> + */
> +&mac3 {
> +	status = "okay";
> +	phy-mode = "rgmii";

How do RGMII delays work? Connections to switches have to be handled
different to PHYs, to avoid double delays. But is there extra long
clock lines? Or are you expecting the switch to add the delays?

      Andrew

