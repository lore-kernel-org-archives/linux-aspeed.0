Return-Path: <linux-aspeed+bounces-957-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7045FC19F32
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Mar 2025 06:39:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z72vV0kL5z2xJ8;
	Wed,  5 Mar 2025 17:39:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741156742;
	cv=none; b=nC0Vv0E2Hi+HX/cve/tzuXZuxtrJHMP/fS9E2a7LnnBjKDvxRRTWfdcyA71ddtWhOtS5e2OnhoOu4g0gwIZmnFqrspSj3CABB2Z0D17Pp0wZuJOx2xfoUKl9tlqFkGpJXEjwF1WS9vn1xcN2e7id2tVJwD3E5K/TaZpj88G9Ft8vi86YVcYcOZTdt04UOqgaaC8JM6JNcpLknKg2FQn3CANKdxu6OlHTMR40HgceTg2sQMtMJOND80+Z1sTM+0WlW0BTVACveRJIMHno+LJF3dlwTbxL8GxXYKCzr96za43z8mbEDZP2WlPRcKSfokDbLX9OEBH3exhNXPilvrRq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741156742; c=relaxed/relaxed;
	bh=v2uOL0k9bepafJ0G3XjnC8OlpN4LyVrrA1VKHBwJf14=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NBut1o/9q9f0NdqJpswdEbdCokV0VHejKm0By+acmW92o82G83FSvK9stzJaEHjqawbzdFsBp/zZoRswffkfArtVsVWBfoQKTSxXfeut7xkiY6RAav98Bha0UjqbjCXJSC2+Lb+e1b8iVsZdm3DOKNKEdncS1FiBcipndKfMYaoZLypflRArqgcWmUJCvXniijOMJNtI6v0q/VmcAk8zYU/s7fm/AER+ZAx6DQzil/dh6zlPp8Z1/9crkxYY5xUeGnJg6em9lvJVK5JbxERfxPQQAVnSOM1Ywe3bu+eUWyC+2dPkhHPi3CawkcF5orlyx/+/B8NLPQd+K1wtB3NaLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eqyhctWe; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eqyhctWe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z72vS5Pz4z2xGF
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 17:39:00 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AE707A45139;
	Wed,  5 Mar 2025 06:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4F0C4CEE2;
	Wed,  5 Mar 2025 06:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741156737;
	bh=qpI2PgQCDJLC7BAxPRiGKYKh9UkyRzVa0QxyYizlb6U=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=eqyhctWeY+yfRcKT9xvz+ZsWssjRVjnRBKOa78OrJIIUERS/9deQpUT/2a0MYgDhJ
	 nIbwCMDDaaoHmIuK95B8jgK4AcLT6Q0Q3ZYhEqlcfulDq3uqVM49rpsiWp/2nliko6
	 UtNlr9cGIB0tkg0lsByUum7ctY15riEFeeGznULDGCljspmkdZ7j6kH9rCx6jRqefG
	 HQIS9BDyzUhbb8qLc0SAEe9OQjwXJqsGJ7hOHg9qu5gKT/yc3QmQVT/OcYJkWcANmZ
	 Rv0GxezhnMmIUSMKaFE+tvVk45Bjzn/Ihsbf2y2QzqH13caYGSho1bCDACH8XoXndC
	 p8Am/DF50LsiQ==
Message-ID: <8740eeb8-9467-48bb-a911-e70c3da3c45a@kernel.org>
Date: Wed, 5 Mar 2025 07:38:49 +0100
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-binding: aspeed: Add LPC PCC controller
To: Kevin Chen <kevin_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, derek.kiernan@amd.com, dragan.cvetic@amd.com,
 arnd@arndb.de, gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
 <20250304104434.481429-2-kevin_chen@aspeedtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250304104434.481429-2-kevin_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2025 11:44, Kevin Chen wrote:
> Add dt-bindings for Aspeed for Aspeed LPC POST code capture controller.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

Missing 's'.

> 
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> index 5dfe77aca167..367847bd7e75 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> @@ -149,6 +149,35 @@ patternProperties:
>        - interrupts
>        - snoop-ports
>  
> +  "^lpc-pcc@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: false
> +
> +    description:
> +      The LPC pcc interface allows the BMC to listen on and record the data
> +      bytes written by the Host to the targeted LPC I/O pots.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - aspeed,ast2600-lpc-pcc
> +
> +      reg:
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      pcc-ports:

Missing vendor prefix

> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description: The LPC I/O ports to pcc

Description is too vague. Why would we encode I/O ports as some numbers
instead of GPIOs for example? If these are ports, why this is not a graph?

Missing constraints - min/maxItems, defaults, minimum/maximum etc.

> +
> +    required:
> +      - compatible
> +      - interrupts
> +      - pcc-ports
> +
>    "^uart-routing@[0-9a-f]+$":
>      $ref: /schemas/soc/aspeed/uart-routing.yaml#
>      description: The UART routing control under LPC register space
> @@ -176,6 +205,13 @@ examples:
>          #size-cells = <1>;
>          ranges = <0x0 0x1e789000 0x1000>;
>  
> +        lpc_pcc: lpc-pcc@0 {
> +            compatible = "aspeed,ast2600-lpc-pcc";
> +            reg = <0x0 0x140>;
> +            interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> +            pcc-ports = <0x80>;

So what 0x80 stands for?


Best regards,
Krzysztof

