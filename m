Return-Path: <linux-aspeed+bounces-4295-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71A6CDB470
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Jun 2026 07:15:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glYB80ZLYz2yYq;
	Wed, 24 Jun 2026 17:15:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782285343;
	cv=none; b=fKkCqzKCyYoPOOgOBoLvwKN109T9xbIOqsu3qUssM2ptchJwAH+88wuNMAXV77/jkHaLadU82+SCzuMDb4HP/qhJEDA+t4M1R4sUmal8GbX7jIn3H4O6Bgh0bRie0d/pUJ+lntIX0RT2hit6lHX/4AwNcVbiVt1xDMbg2AFHtCR7/h5FCS7VKbU3VA8OZ21dTeQhBL2YhVdgIslXVFnBoWw+RnUCbID5VEc378zy8R3v5fg2GV6/kyL122G7XbN+XG6oFs3rokN19GTJv9ZhkeTKgBTSlsufoBvCX5U4FDyPm8cgu5xncOK6PrzlOyc/NoPgaC0XGCAxE+951/1R8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782285343; c=relaxed/relaxed;
	bh=ONVxwC+Td25N43rGDzHnzsanpqUWTvIc0+6pDMU/MTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9c5GngyArs+i2shTiHgNNwlKK2zBu6Hx3FIjT1nhr+08urEzSAFyJeL7HSlVsY03gY3VCZ5XKgW1ss4SdL8OJFkEsFeFKYO7t5waKGXh8oXMpIjW6IX2lcA2RzS6LD1WyE7iGYQJ/mJwroM9T0ng914FQWwyPEC1/tjRsxljnTfFO8bDcxYW85jY1dGDHz8jbj7SqKFkCdWFCywhGWLm8BXRTdrWlHVRNl1m1oLZGzwRd5JLgWNSvPW1bHwe9zEX2vC8LbsbN7xCPcTyddoxSOBP/7BE6By1rJiBeOM2sc+ehzdBsGh3E8u24skgXXQTpEqPHb/rjWgA7lwMLUDQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PTBFnWrT; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PTBFnWrT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glYB61xQjz2yQn
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Jun 2026 17:15:42 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 40203601F3;
	Wed, 24 Jun 2026 07:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24E31F000E9;
	Wed, 24 Jun 2026 07:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782285339;
	bh=ONVxwC+Td25N43rGDzHnzsanpqUWTvIc0+6pDMU/MTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PTBFnWrTnSlnRm7wA9VA1PKnERY9yuPOvIvAeqhs1Yt6aoGxjRIfYBkjLVOQMbeNz
	 kVBap/AwGkGSkpKtQ/39UY6tYC5h2Hxi7VKuzuAsEwE7Q8mVB/PU7I7Y4eJKS9ET6Q
	 zysZDCaCETP5NWRPz+SMh2iLvN3vwxYg3pK9Ax+i//noDUm+RX8Zntiq8Pd3FC1Ldt
	 PVyQL0gk9ZzMeM3ekhH4GVnrOpee7EB9Key3pzQBLLna0L0Ke76QM41Z4gJZ49GMV7
	 uKzysiCphyE2UP/cXefVGblMHKlA92DT3p3TmpOZ+BzGgY0nAwKsi+rplH5Naor63Q
	 2WpjSkr7z9qIw==
Date: Wed, 24 Jun 2026 09:15:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?R3LDqWdvaXJl?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: serial: 8250: aspeed: add compatible
 string for ast2600
Message-ID: <20260624-realistic-spiked-parrot-db1d9c@quoll>
References: <cover.1782224059.git.gregoire.layet@9elements.com>
 <80d983887dfdfc7e70a6db95f8cb95b7312f3044.1782224059.git.gregoire.layet@9elements.com>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <80d983887dfdfc7e70a6db95f8cb95b7312f3044.1782224059.git.gregoire.layet@9elements.com>

On Tue, Jun 23, 2026 at 02:25:39PM +0000, Gr=C3=A9goire Layet wrote:
> The ast2600 was using the ast2500 vuart compatible string.
> This change makes it possible to have ast2600-specific properties.
>=20
> Signed-off-by: Gr=C3=A9goire Layet <gregoire.layet@9elements.com>

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/sub=
mitting-patches.rst#L830

> ---
>  .../devicetree/bindings/serial/8250.yaml      | 20 +++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documen=
tation/devicetree/bindings/serial/8250.yaml
> index bb7b9c87a807..3cbd0f532e15 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -23,7 +23,9 @@ allOf:
>      then:
>        properties:
>          compatible:
> -          const: aspeed,ast2500-vuart
> +          anyOf:

This should be oneOf (by convention and actually more accurate meaning).

> +            - const: aspeed,ast2500-vuart
> +            - const: aspeed,ast2600-vuart
>    - if:
>        properties:
>          compatible:
> @@ -287,17 +289,19 @@ properties:
>    aspeed,sirq-polarity-sense:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: |
> -      Phandle to aspeed,ast2500-scu compatible syscon alongside register
> -      offset and bit number to identify how the SIRQ polarity should be
> -      configured. One possible data source is the LPC/eSPI mode bit. Only
> -      applicable to aspeed,ast2500-vuart.
> +      Phandle to aspeed,ast2500-scu or aspeed,ast2600-scu compatible sys=
con
> +      alongside register offset and bit number to identify how the SIRQ
> +      polarity should be configured. One possible data source is the LPC=
/eSPI
> +      mode bit. Only applicable to aspeed,ast2500-vuart and
> +      aspeed,ast2600-vuart.
>      deprecated: true
> =20
>    aspeed,lpc-io-reg:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>      maxItems: 1
>      description: |
> -      The VUART LPC address.  Only applicable to aspeed,ast2500-vuart.
> +      The VUART LPC address. Only applicable to aspeed,ast2500-vuart and
> +      aspeed,ast2600-vuart.
> =20
>    aspeed,lpc-interrupts:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> @@ -305,8 +309,8 @@ properties:
>      maxItems: 2
>      description: |
>        A 2-cell property describing the VUART SIRQ number and SIRQ
> -      polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH).  Only
> -      applicable to aspeed,ast2500-vuart.
> +      polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH). Only
> +      applicable to aspeed,ast2500-vuart and aspeed,ast2600-vuart.
> =20

More important, where is documenting of the actual compatible?


Best regards,
Krzysztof


