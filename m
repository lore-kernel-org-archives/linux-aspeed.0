Return-Path: <linux-aspeed+bounces-3342-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBF7D41149
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Jan 2026 09:54:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsJGl5MtHz2yFm;
	Thu, 15 Jan 2026 20:54:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768470847;
	cv=none; b=MJIzhRA4Mxqzksx9vQNocraF4OoqC1wi0KDrI/FdK4yt9gba7o9s6jdUylID3uPmTY12V+Wjy9htwo2gwTiH4J6tEe7la8BEBPJ5PPPTnZ2M5OBsioih41G5zrNT1Don/X1KTwWjkhU3x6JIUGes+5grXm/fMg0Hv8eN8Qjc3ERruTmRa/cSGJbA1DfoX/Jj7IrG8yhj4MQbNnBbEKOgBNlkNxYdb2vsWW7UWZjxbOxIiYCDpdmDJKukTY2kQfjfcVgt6DE52f1yq7PT/7FSsna8cemJyRKf6ZtMOmabMLqBWHqJRh0ZlUvhsw6TDJ2E27tDiH5ezL+sFYd3I3+OGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768470847; c=relaxed/relaxed;
	bh=73WOwkJLL7iSfNQnuhhw0SEVGcjxcZqbf/znKTcFg2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQVTkafQItDAuaPgewb0WTrGLkxFFhMj/dDJpQJzpVs6MQdLl6oo2Wrf0Lp2mg70l3oqjaFFMXxBTJvolw471w0jJ2W7xwOD3wiFyAmwZduN/zXRG2ES9XDblXeprSjbEmwXVhYYl/xf/VYg6uqGkb+PlcOOJRRQNYVmpEBoj3AH3bvK0/c5l8Y4MItzTuDS6fIfdLvfe8W6QQYygpN8bh/CKuMj1vxGJJOjq1fj3OqRNfi2V69kutj5zMimzZt1zesiDKhIxL5QbnGZuBxGvIBtwcdy4v9a/1O4I1J3iu8ynJ76PB6HvhzcUa71po8C4TwmsSNLgpqpucUypzkpiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lGYM9Ku4; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lGYM9Ku4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsJGl1F8kz2xNg
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 20:54:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4DA94601B3;
	Thu, 15 Jan 2026 09:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C13C116D0;
	Thu, 15 Jan 2026 09:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768470843;
	bh=rkwmLhl2NdMkUxqtMKpON4EP2ZPIE5XSzoXvo0xv198=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lGYM9Ku4NOF+zHabNVCMzyZz6JHwydepB5DeMtLL8+Gi5kFK2EGFz7vjFpQTErOk/
	 +yTyrBwGatJcfNAlQ+ArcnCg45NghWuqqOHz6nItZV6lMvm+/5CA8m3nme7TtP3Dd/
	 r9S3RJYxgG/G6WYCr/TyQfqPpeMw9NuaV5Ms4jXSweXjHK1eye66cxaAYFeR32/3hN
	 nxeyEOIzQWgUQIKcp3tU7lbnTw2E15qsmOtNOrI/Uzq78NC737x5pVnCqYYg3V6msS
	 JMEN8vUVdQiEzqep2nnhYDxQrYn3aUCYQqt5wZNUT7OgnzpHzXFtDmP/529+Ma9XGA
	 xRbAXI5W9eMKw==
Date: Thu, 15 Jan 2026 10:54:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: aspeed: Document AST2700 USB3.0 PHY
Message-ID: <20260115-tricky-invaluable-snake-abec06@quoll>
References: <20260114-upstream_usb3phy-v1-0-2e59590be2d7@aspeedtech.com>
 <20260114-upstream_usb3phy-v1-1-2e59590be2d7@aspeedtech.com>
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
In-Reply-To: <20260114-upstream_usb3phy-v1-1-2e59590be2d7@aspeedtech.com>

On Wed, Jan 14, 2026 at 03:13:10PM +0800, Ryan Chen wrote:
> Document AST2700 USB3.2 PHY. This IP is connected between
> USB3 controller and PHY module.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../bindings/phy/aspeed,ast2700-usb3-phy.yaml      | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/aspeed,ast2700-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/aspeed,ast2700-usb3-phy.yaml
> new file mode 100644
> index 000000000000..83da224d99b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/aspeed,ast2700-usb3-phy.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/aspeed,ast2700-usb3-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2700 USB 3.2 PHY
> +
> +maintainers:
> +  - Ryan Chen <ryan_chen@aspeedtech.com>
> +
> +properties:
> +  compatible:
> +    const: aspeed,ast2700-usb3-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: USB 3.0 PHY clock

Drop description, obvious, you just repeated the block name

> +
> +  resets:
> +    maxItems: 1
> +    description: USB 3.0 PHY reset

Ditto

> +
> +  '#phy-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - '#phy-cells'

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


