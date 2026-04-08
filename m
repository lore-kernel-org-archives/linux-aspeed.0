Return-Path: <linux-aspeed+bounces-3867-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BF7FD5F95
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Apr 2026 07:52:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frFfB1crkz2yVP;
	Wed, 08 Apr 2026 17:52:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775634754;
	cv=none; b=djleYFdBiCUJQaK+iZVJVLLTgtzehkntenJ7hBzxtXPdvkItAyCl4Xr32XuBORH9l71Sbl30YzGr0PFPJctBPEZEf+9H6tlMcva2s7qQMlMAlamNtDAeFGhE76R/caman/t/7bSPnT128e4K2qtLV4t/+nCRmzQmJHWZpK6QyWuMSG/aVlIDnryRdYHit3xF9wi/XaayaGQWgvluZqlW28Av0AQv3ytP8yR7i4LFUzpKFLJfSzYbZi9oXaMvODfVDZmzJ4gC7gDBSxx8zCm70TaOLIqEouO+2R+icChSmgMmd2QnMSFks6VL4i4+SioxX3wUW5jgDDzT2z6C1L+r6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775634754; c=relaxed/relaxed;
	bh=dJkcrKpMsomWsfu3HRoQuW6Uqe86+81cvDsG/ByrGck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDmCHMqcULk5o1lNrOqOv7jB1NJPvVZXnjCZIrQzN+SJ5mo+As7TuFw3X1CaejL/V4rVey7Tng43yMpp+E3JCsgbjZF+2ywx/VfvROhBRjfQy4xIMpvg60BMwAtnCn8s2TtC3IY12pdZEF0sCsqiLyzgX5edKcPZmG9zGOPKcWOcr0Tp6sm6ePsK4GDNqhCY3XyHC/+lWBf+EuggcS42VFkHgehwfJyp/6qxAZxfi7yUhCHat7xtNsuvSYiHeYOYGXcA/1PO45nU7cvCR4l3oe0XgCohFofxF3oFaJbau4fF60/c86CCupb+uWcEYV360pdYmL8GfW2voDfIsOzWog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ih4NSeC2; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ih4NSeC2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frFf92nyvz2yC9
	for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Apr 2026 17:52:33 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 02D35600AD;
	Wed,  8 Apr 2026 07:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CDBC19424;
	Wed,  8 Apr 2026 07:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775634749;
	bh=xNY9tEvKoYhfTQH3M8/Q4r7s7A/d71rffbc/9uF1Xa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ih4NSeC2UtjrjEgv+qhj7RtI0dtNt/8E6c+4i94k1Sj4TamaIc7W7ZxK5Nm3QtmCC
	 Vd760WYlfNXMixdwpwsP9oZDAvw006FAcAu3INDBMcTNgYdsHgQizXVaxgh+9qQrDi
	 aEOoCclvi3jirOCzCYmkZ4X/4BZG7dPnqnX2ySRZSg3/gT+sH+q6ZQgHd/0VtTlVwS
	 H4dkYCWlUU8f9MFq91Kxjd18brVjj1jF81dUN5DG2ePwLMEu/HVqu+5IlOSSFpbBjW
	 aBNIQQthwmBjWJCTX63DLrRjrLEsatuBMFYVSJ6yGjFIvHfG9DgQMXmEwBfm8Y7xtw
	 LxCvoacfK38aQ==
Date: Wed, 8 Apr 2026 09:52:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Colin Huang <u8813345@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, colin.huang2@amd.com
Subject: Re: [PATCH 2/3] ARM: dts: aspeed: anacapa: add EVT1 devicetree and
 point wrapper to it
Message-ID: <20260408-glorious-vehement-robin-b6def3@quoll>
References: <20260407-anacapa-devlop-phase-devicetree-v1-0-97b96367cac3@gmail.com>
 <20260407-anacapa-devlop-phase-devicetree-v1-2-97b96367cac3@gmail.com>
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
In-Reply-To: <20260407-anacapa-devlop-phase-devicetree-v1-2-97b96367cac3@gmail.com>

On Tue, Apr 07, 2026 at 09:54:33PM +0800, Colin Huang wrote:
> This change introduces a development-phase devicetree for the
> Facebook Anacapa BMC EVT1 hardware revision and updates the Anacapa
> wrapper DTS to reference it.
> 
> A dedicated EVT1 DTS is added for revision-specific hardware while
> keeping a single, Anacapa entrypoint used by the build and deployment
> flow. The top-level aspeed-bmc-facebook-anacapa.dts
> 
> Signed-off-by: Colin Huang <u8813345@gmail.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-anacapa-evt1.dts    | 1069 ++++++++++++++++++++
>  .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     | 1064 +------------------
>  2 files changed, 1070 insertions(+), 1063 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
> new file mode 100644
> index 000000000000..a29b7fa1155b
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
> @@ -0,0 +1,1069 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/dts-v1/;
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +	model = "Facebook Anacapa BMC";
> +	compatible = "facebook,anacapa-bmc-evt1",
> +		     "facebook,anacapa-bmc",
> +		     "aspeed,ast2600";

Test your DTS before you send, not after. Your binding clearly said
something else.


Best regards,
Krzysztof


