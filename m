Return-Path: <linux-aspeed+bounces-5125-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D670FCA5FDD
	for <linux-aspeed@archiver.kernel.org>; Sat,  3 Oct 2026 14:42:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxpKB2yccz2y32;
	Sun, 04 Oct 2026 00:42:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791038558;
	cv=none; b=aGLI5g5/6+HO6xmQZoqTPcmefn2NGCrB8lwSvhbC9Zs2cYXQguNhXrHt2dtaWmJiQAVc1G4TGzSmT4asuDhDiSw2O61Xwpo0aYf83q1yGB9CIIJKAZqdzqKIBvNa0mDg1ZuIJD3PVpR8j/e/Rv0tTJ2agReG9FFiu+d2geC+7HpYIH68n30Al9SNMz7wyg3Em8MSb1YNsYqvY2yvGysmfr1NdbGj1y/I6M/u0glr2EKMmqVe0uutt9XtXoajLZ8KNf4BFOIpBsIz38yXh7w/gNUmcDZjAEfFcaUdwruSzy5JzmMpKOzIfm5RvRomZAcuh8lKdCSVT1HTvAWdVtm4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791038558; c=relaxed/relaxed;
	bh=gCF9tetbpMfQg3fMkPRL+OgJ850OtOdqqJtsAEmAaxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4u9U54TGQuPbDbO7O9dhV/G6eCHUVZj7Rh5jpfKBNMEVrf7J+ClXizKHi+sBqJj0Q7Gcoy6od+DRVGy2oxeeIxdAUsBeVAivs0zI+cEP2F+GZRnDa4TuxNq3HuEvCQc7GG7iCNB9/PXrti7p+jUh/8UDF7YLdDHEw7/TiePGoYYxNuIcy2aAEbnYuxVZd6GyZ+3mMffjZhoBZCOg5+AHtabb01NkQH8tVpG4M9xvft3LXEvG9+eEEp0d6oI6aWvgJTXUgo/12odKiycVK0acCdAkfOldPCQXdxnruLVz32br3humIB02iSmNZFVh8aQ2MxYLikPsCgdhLmEkfksIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QaH8YrQC; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QaH8YrQC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxpK95SSpz2y2K
	for <linux-aspeed@lists.ozlabs.org>; Sun, 04 Oct 2026 00:42:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5859B43EEB;
	Sat,  3 Oct 2026 14:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5511F0089B;
	Sat,  3 Oct 2026 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791038555;
	bh=gCF9tetbpMfQg3fMkPRL+OgJ850OtOdqqJtsAEmAaxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QaH8YrQCXluDW63hTphJmUmkFE6nG5mcrDtNhv7a0JKSrCGXHTUaRfxohiLxbQyZe
	 NHMakZELalf5KQnUx1sEGf9jZDg0vClMQcVWwK3+Z0smvyE7XXYa+Iu0WtA9sc7W8O
	 48eykD6tWDOsznoQDeDakMq2YjW02eeabCvv/f19f80CbX4Q388sRs0IYR/+/ITRVz
	 n+y1ZZk0e7iyQg9UIYY4g7AP+kmifAXjFP4fCQbImCE0kr/D5O+RCSlaZ2FJf6LyOe
	 kw6gz1YcgrGBKy3UJRJEkXX/VSCRb9GdE5+4CWD+CyaW1GFBC8OFqd4vdFYep28GZz
	 VkaMGyHMODVjA==
Date: Sat, 3 Oct 2026 16:42:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dawid Glazik <dawid.glazik@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, maciej.lawniczak@intel.com
Subject: Re: [PATCH 3/4] ARM: dts: aspeed: add Intel AVCRP BMC
Message-ID: <20261003-talented-perfect-rook-9ccf55@quoll>
References: <cover.1790344811.git.dawid.glazik@linux.intel.com>
 <9dadaaf04cae28e13057fa5d65023789f74483fb.1790344811.git.dawid.glazik@linux.intel.com>
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
In-Reply-To: <9dadaaf04cae28e13057fa5d65023789f74483fb.1790344811.git.dawid.glazik@linux.intel.com>

On Fri, Oct 02, 2026 at 06:32:44PM +0200, Dawid Glazik wrote:
> Add the initial AST2600 device tree for the Intel AVCRP BMC platform.
> 
> Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../dts/aspeed/aspeed-bmc-intel-avcrp.dts     | 321 ++++++++++++++++++
>  2 files changed, 322 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index 767f7c7652d5..ea4645ef9872 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -54,6 +54,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-ibm-rainier-4u.dtb \
>  	aspeed-bmc-ibm-sbp1.dtb \
>  	aspeed-bmc-ibm-system1.dtb \
> +	aspeed-bmc-intel-avcrp.dtb \
>  	aspeed-bmc-intel-s2600wf.dtb \
>  	aspeed-bmc-inspur-fp5280g2.dtb \
>  	aspeed-bmc-inspur-nf5280m6.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
> new file mode 100644
> index 000000000000..ba0091689172
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
> @@ -0,0 +1,321 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2026 Intel Corporation
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "Intel AVCRP BMC";
> +	compatible = "intel,avcrp-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS4,115200n8";

We moved to stdout property years ago.

Best regards,
Krzysztof


