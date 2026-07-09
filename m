Return-Path: <linux-aspeed+bounces-4451-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FD6C43458
	for <linux-aspeed@archiver.kernel.org>; Thu,  9 Jul 2026 08:51:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwpbB5Gzxz3c9w;
	Thu, 09 Jul 2026 18:51:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783587062;
	cv=none; b=Ux6K02sP7DvIHpDD1Zfu0K1ZU2UXjrjSJyYxVXTfTFg3CJC4rK+qqZzOWqwI3KNbA6Zj/0ph2y5ONiY7Wx36PLKEynAN2sPZx/r9tR7eLhxt6oCO3y352Tuf52h1F2KJoGDKqOx4t10nT1sXPuMK/iIAQeWQ5hzWiyxrU9xjzMkNKV1F+PMpaUWVi81aNB+gfl43+CFR3BENItGGrAYJTQrWeVkTT9tnlGSqfQx1GX0Z0aoiDIClJ1uhzdINWkz7beXDIZZAhTxSczmXVnUMiq6hklmorq/ImFJyn1EVimS+KLaZjI+8iWNVQ1y1RmhPvPrK/XfbM3V3sSKNUfOBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783587062; c=relaxed/relaxed;
	bh=a1rwfWs0eVUYLQvnn313Ek+k2iZwPDLH9jg+S7+NtUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsjvLegVep6y3+6h36uC86XRkP2ICr6Hrv+JhLwlzvIa1RxSoQb/cBLIoxDOhFHT1K9Qq6hLQrzbWOEtyxyNcUuC0XxxtSm8h5Ng4ZCByiobPpQi0cqi85JJVl7mkESQnv2BlEZsQPA/8XW4hl8mC2Q8UIj+Ht0uyWuqB+JaHL0tO29U0h5eYkSvF9tOdUnmfWAb5DuT02gO1GgIzQLclqnrHsvu1oTZn9oRP5fmlpxZ0ZvMOokDTcKWCFlSc6LznFr7Fml1zXtnBkekwt3mgRDpQFyrZwKjqNeR+RycJqGfwaNTR8RsoJnNOC1lhoxJVmwgKs/g85ta6npGFmPXrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxaMoZ7D; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxaMoZ7D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwpb92qmNz3c6n
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Jul 2026 18:51:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 49F5243436;
	Thu,  9 Jul 2026 08:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6478A1F000E9;
	Thu,  9 Jul 2026 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783587058;
	bh=a1rwfWs0eVUYLQvnn313Ek+k2iZwPDLH9jg+S7+NtUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gxaMoZ7DMEct622BGXXQ2Ri8Sr/J+tvZNU6g0FIegAoymMY/llbxd69ppfm/oxOj8
	 F/ygKBf7/fmoDsb4JgXAudUtdk+OVg8nZMkEddDkCi+oINbIN2XjQMqrCqvvYyNcai
	 T++YqXgDP4X5eCQRe5sUImYg26aXYViq8185n4MMoadByVpazZw4C8lFvxMSTdnjhz
	 Iug1z0tdGaZ6DJPqWaNhmNrVLYwxK9IRWFk0GLyCD/rg3VNeX49FxbyvX2qGyWzvGz
	 QNk3i4hWWa7yOqO61Yw8sZmWB2wq/50RN15U9kBPW1u/NSS9f2ekmTeEqX07oEjgiT
	 o9qFAb6Fe4YWg==
Date: Thu, 9 Jul 2026 10:50:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?R3LDqWdvaXJl?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: serial: 8250: aspeed: add compatible
 string for ast2600
Message-ID: <20260709-convivial-classy-mouse-db0b2d@quoll>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <cbe59dfba231dcd55fa86233dc076b017d67463a.1783524645.git.gregoire.layet@9elements.com>
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
In-Reply-To: <cbe59dfba231dcd55fa86233dc076b017d67463a.1783524645.git.gregoire.layet@9elements.com>

On Wed, Jul 08, 2026 at 03:35:53PM +0000, Gr=C3=A9goire Layet wrote:
> The ast2600 was using the ast2500 vuart compatible string.
> Make it possible to have ast2600-specific properties.

Then add these properties here as well. Adding a new device is one
commit: its compatible and its properties.

>=20
> Signed-off-by: Gr=C3=A9goire Layet <gregoire.layet@9elements.com>
> ---
>  .../devicetree/bindings/serial/8250.yaml      | 24 ++++++++++++-------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documen=
tation/devicetree/bindings/serial/8250.yaml
> index bb7b9c87a807..8f22121381fc 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -23,7 +23,10 @@ allOf:
>      then:
>        properties:
>          compatible:
> -          const: aspeed,ast2500-vuart
> +          contains:
> +            enum:
> +              - aspeed,ast2500-vuart
> +              - aspeed,ast2600-vuart
>    - if:
>        properties:
>          compatible:
> @@ -106,6 +109,9 @@ properties:
>        - const: ns16850
>        - const: aspeed,ast2400-vuart
>        - const: aspeed,ast2500-vuart
> +      - items:
> +          - const: aspeed,ast2600-vuart
> +          - const: aspeed,ast2500-vuart
>        - const: intel,xscale-uart
>        - const: mrvl,pxa-uart
>        - const: nuvoton,wpcm450-uart
> @@ -287,17 +293,19 @@ properties:
>    aspeed,sirq-polarity-sense:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: |
> -      Phandle to aspeed,ast2500-scu compatible syscon alongside register
> -      offset and bit number to identify how the SIRQ polarity should be
> -      configured. One possible data source is the LPC/eSPI mode bit. Only
> -      applicable to aspeed,ast2500-vuart.
> +      Phandle to aspeed,ast2500-scu or aspeed,ast2600-scu compatible sys=
con

This is a deprecated property, so it cannot apply to a new device -
aspeed,ast2600-vuart. You cannot use deprecated code for new bindings or
device support.


> +      alongside register offset and bit number to identify how the SIRQ
> +      polarity should be configured. One possible data source is the LPC=
/eSPI
> +      mode bit. Only applicable to aspeed,ast2500-vuart and
> +      aspeed,ast2600-vuart.
>      deprecated: true

Best regards,
Krzysztof


