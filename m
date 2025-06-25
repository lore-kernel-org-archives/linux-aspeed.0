Return-Path: <linux-aspeed+bounces-1570-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AB5C7EE2A
	for <linux-aspeed@archiver.kernel.org>; Wed, 25 Jun 2025 15:50:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bS5ql5rqkz3bsL;
	Thu, 26 Jun 2025 01:50:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750866611;
	cv=none; b=gY8TRB7adKA4UCGHHqjBqIhjQL8cSq9vjs/h4cGuKzXm7X4oH8iuasvvXqVLW89uHrg/jGivnKdtQA1PfZDX3GGUzo+qxcPZ/p84LAx9UFfDJ2ynEI4f1SI4wYRQ4LQVdfL5lLdBCgwAom8G6uB0y7WbksgJT60wQlKY0EZpWf32jAUO91MlPAsjCuYDMW0QCvYSQgjhkCDKQ4uj8N5Pxratf4Tpbrn5vGO251ga3wM/tKm179hFveeMc7XkZ3M6Icutfq3njgQY1VvMzSRfHxcYGHu4KPwlCOpFYKQQPJjpRuG7CqL5yjol12pzKhYFdeckfTdI0UuLB4ddIxyEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750866611; c=relaxed/relaxed;
	bh=oLxKI4JyMtdZXqdHaSu1opMu6/7d6hHYiJlAEmlOjKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXGFRxMrCIIZGF0ijn1h3wMWbXAseYua7kbZeWCgl1XMqpUO4HCUDZtzfgzxxmD9+7UNgZTMy9XPUWKmBxUr5yI4Vp1nJpp9bix9+quDAm18T/5c5gD6/3NdKzl3ueN8vzBvuS5rHSLo6o0/syggYa9KESwn92wc7p8B5ywZx8jnjeq+VoD7CYb9YYyaEsApX8jSr8F7N/KTdqSeYDqzxtnS5G99xYiZBZZtI3mcwjlTR6+FXeVqNpPplMIrHiJyLm+Ag4D4ugu5/DcbF/4P1OoCZ8OHb7ju9O7bCUJ+LAO1NuvjgJNYignikc5recxJ9XblN/v0yzQmDMeGvku/IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YtIVAZau; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YtIVAZau;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bS5qk6KVnz3bs2
	for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Jun 2025 01:50:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 57B8560010;
	Wed, 25 Jun 2025 15:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E806BC4CEEB;
	Wed, 25 Jun 2025 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750866608;
	bh=Ikf1eFPSR3XrPLb5x/K+vYHAnLYeiM6FKIqk0udcbtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YtIVAZauBqbEd5GWyvnZRNeQl3H6C176E1r7tRYFZFIW4SPAg0sQhb8cDSSM5Cqt0
	 AyUl2Pyh91tEfw3ZmF2baKJzGWXHjZteahiL0bVheUEhChUraFDAEBhgMdDbMRnGlO
	 IREv+IcsUfawLUnMDueEjgXqxVdio3BZdY7P58SQiqGHpDafnzFg61pfawQCQZ3S6V
	 SnI9Tayw35cwDEx6ZjsFTdlsYf1e3dDNEQEfXg+sqIere1bQVLbUy2luTPDUlypcWM
	 tDgqnqbF/oR3YKfD4Lr1J4U2qIX/+wjPGXAz/kqTk2BvLzNKZ34ynmSffPX23l2Smx
	 DPKs5MNB+HqzA==
Date: Wed, 25 Jun 2025 10:50:07 -0500
From: Rob Herring <robh@kernel.org>
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: jassisinghbrar@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Message-ID: <20250625155007.GA1489062-robh@kernel.org>
References: <20250625073417.2395037-1-jammy_huang@aspeedtech.com>
 <20250625073417.2395037-2-jammy_huang@aspeedtech.com>
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
In-Reply-To: <20250625073417.2395037-2-jammy_huang@aspeedtech.com>

On Wed, Jun 25, 2025 at 03:34:16PM +0800, Jammy Huang wrote:
> Introduce the mailbox module for AST27XX series SoC, which is responsible
> for interchanging messages between asymmetric processors.
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>

You didn't add Krzysztof's Reviewed-by...

> ---
>  .../mailbox/aspeed,ast2700-mailbox.yaml       | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
> new file mode 100644
> index 000000000000..0a5f43de5f28
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/aspeed,ast2700-mailbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2700 mailbox controller
> +
> +maintainers:
> +  - Jammy Huang <jammy_huang@aspeedtech.com>
> +
> +description:

You need '>' to preserve paragraphs.

> +  ASPEED AST2700 has multiple processors that need to communicate with each
> +  other. The mailbox controller provides a way for these processors to send
> +  messages to each other. It is a hardware-based inter-processor communication
> +  mechanism that allows processors to send and receive messages through
> +  dedicated channels.

And a blank line between paragraphs.

> +  The mailbox's tx/rx are independent, meaning that one processor can send a
> +  message while another processor is receiving a message simultaneously.
> +  There are 4 channels available for both tx and rx operations. Each channel
> +  has a FIFO buffer that can hold messages of a fixed size (32 bytes in this
> +  case).

And here.

> +  The mailbox controller also supports interrupt generation, allowing
> +  processors to notify each other when a message is available or when an event
> +  occurs.
> +
> +properties:
> +  compatible:
> +    const: aspeed,ast2700-mailbox
> +
> +  reg:
> +    maxItems: 2
> +    description:
> +      Contains the base addresses and sizes of the mailbox controller. 1st one
> +      is for TX control register; 2nd one is for RX control register.

Instead, just:

items:
  - description: TX control register
  - description: RX control register

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#mbox-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#mbox-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    mailbox@12c1c200 {
> +        compatible = "aspeed,ast2700-mailbox";
> +        reg = <0x12c1c200 0x100>, <0x12c1c300 0x100>;
> +        interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +        #mbox-cells = <1>;
> +    };
> -- 
> 2.25.1
> 

