Return-Path: <linux-aspeed+bounces-3095-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CC6D41C3C
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Dec 2025 14:08:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dRvZD2tbLz2xrM;
	Fri, 12 Dec 2025 01:08:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765462100;
	cv=none; b=BMmxhda1eQmYiSmzOwtC6lsMbfA5X3kZ4PTV3Uoxom1ZIn+wQohLypZgqP+B6y/OX1RSb7T1aHha9u6V/g6FdAGUT/nn0khS9KZVNSRCNhlPsmMiPjdxyvQu6dTtVG8gplWYqH/PnE4Kl77sv/jwoGaqpYAYFEXU8Na6GnYAKlCLhqFH982K/QMYWr5aBsWTXOrdZpi2kQCnD+9yR9Y0VLyI8Z+LWmcmlAFgVkK+UXswED28Q+8h9BOM522ePufC0ceLgh/E2ZNlsClCLJ0cn2CpyVS/9HYUINTrgxNFzmUgN9pYbvosQP81HEnf5aab1W+UYzb3YDDx3ZSEefeU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765462100; c=relaxed/relaxed;
	bh=frzh+UN34EhRr88zl7A0WKTrjUwHajM31hBfzRLj1lc=;
	h=From:Date:Content-Type:MIME-Version:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=LWssY/LGoU6JSOCgb/QhCkaJu1JdUo8W6ybKT+tEAp91GfI9ra4TkDTE8SuS0ruTemPnkdJdS6zJFpznIIMG8/LpXquaRddAbxOkTenmskREaQE/eO9f6ccYcMQrVijl0tZdUAD8twPW5xypMjK2X9dNOkEXhDE99Y53OhIVnPQASlt9JskVWBpmGGpjSWUOEa7LHszX//4n/d2HBTkIYwQ0prrwPww+FYUl3b6rf2XeWYHxvoZXSNCeKfsAoUJmy0rLeIxS/8TZcN+OP1PI3Gf6Ft7EsekuAsWDP4fvV1xOu2eVBcslFI529QfPxRrX2iU27h/nQ6mOrFTLpHnB7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=roDUA2KH; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=roDUA2KH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dRvZC2xz7z2xHP
	for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Dec 2025 01:08:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E04704437F;
	Thu, 11 Dec 2025 14:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F5DC116B1;
	Thu, 11 Dec 2025 14:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765462066;
	bh=vcRg1Eqi3odp7RefN9n5Z70f73goUkg5nxx720202Vc=;
	h=From:Date:Cc:To:In-Reply-To:References:Subject:From;
	b=roDUA2KHXrLZqRTAerROurGDYD6CGUgQEGdx69SsrlSvt+G8+AZDSryMeTFfO41+D
	 lYjZtPLhzCbKSXBZZz9MPNU0Yu4XKLkTxPVjRWG5sbbrRhOh4MjDjVigBHY6fC0qzO
	 9i9uIVJ0gJ2thItLg7wNEi2zmnDdpuUO8dp/JYZQ50pWmogLgpAJCaEVFnqHHz55oX
	 0TaGQ/y6CWsgD6Ors1S4OFqfpjVIAF9nf+oWQ8JZ6kTVUIx9sTP1Ekc2wCyMrkfoq1
	 bNcmTWMfs/Uo5yR2rj8obmBFwah07TrFEYaBarNzYQoHzVD4PTSzjg5ulzqqqO5kJa
	 l1BH10c5Rip2A==
From: Rob Herring <robh@kernel.org>
Date: Thu, 11 Dec 2025 08:07:44 -0600
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
Cc: joel@jms.id.au, cosmo.chou@quantatw.com, krzk+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, andrew@codeconstruct.com.au, 
 conor+dt@kernel.org, devicetree@vger.kernel.org
To: Cosmo Chou <chou.cosmo@gmail.com>
In-Reply-To: <20251211080311.242771-1-chou.cosmo@gmail.com>
References: <20251211080311.242771-1-chou.cosmo@gmail.com>
Message-Id: <176546187995.970978.16806289735144663383.robh@kernel.org>
Subject: Re: [PATCH] ARM: dts: aspeed: bletchley: Fix dt-schema warnings


On Thu, 11 Dec 2025 16:03:11 +0800, Cosmo Chou wrote:
> Update the device tree to fix dt-schema warnings:
> - Use generic node names for SPI, LEDs, and GPIO keys.
> - Update SPI GPIO properties to use the "-gpios" suffix.
> - Remove unused address/size cells from pca9539 nodes.
> - Use 'aspeed,int-vref-microvolt' in ADC nodes.
> - Remove unused 'aspeed,hw-timeout-ms' from i2c13.
> 
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-bletchley.dts  | 100 ++++++++++--------
>  1 file changed, 54 insertions(+), 46 deletions(-)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20251211 (exact match)
 Base: tags/next-20251211 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20251211080311.242771-1-chou.cosmo@gmail.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml






