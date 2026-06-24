Return-Path: <linux-aspeed+bounces-4296-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5695DCDB470
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Jun 2026 07:17:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glYDd5mkWz2yYq;
	Wed, 24 Jun 2026 17:17:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782285473;
	cv=none; b=JjBzTtevjmX/qNicsnu0tt+CaRe0V1gd0gk9iwbQl4FaRFAgJ+bSy4Wr4p/e50LyPBIk4aNr+cqizesF0wHQzOCKx5bhMV32OifHWH3ME6z2gaqdDaZZSuuRmwnYRT6vrIl9tE6fP1e0iPajs5IauNy0pMp58KX7D4Is0bYmg2KpUHGmsdTI/YiWxQ6RgZaR4sgyTliJaPc/1FXFMRXmzw/LycNxiPLBVYmjI6Jwn7o/s1Cl+ALr+BmAVbr8OFGIVyAAmtnOAjC8ZwmzYg9wS/++Iw6txL8Pv+TS9Q413AeTgu6S6LowPkGAosH1Z7TWtcPFMiFNzQp5lmoFgWrWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782285473; c=relaxed/relaxed;
	bh=dP2bxkYNQAeUz5jXWdGEqjkG4n1wBe44kDAAGlvauTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrcZhFNH8AcW5U8+rzemy+DJVGrxgYGJEKUrp5loCTAS8r1+Mqt9yHlKNp+ZPFd/XMWC4ILyA0nJddQj3sLOh/X97KKrekHW+3Hi64jGVCuZ+2/zsD1OQdMOrE8mYhxi9Zs+eaakN+hbZbssuDImMGvIsJ6xoDdmfat1HbX8XF1kAF2GqzR49xZUx39V+FjpuxYeoavMRqYydDfbgYDja6O6QtdZfwEmpPF9zOJp9sYrVIAeuWFdD0ehOwkRoLgS766H1nHb/EfeV1d5iYzs4/6nILvdusKHcZf1Mhv/Pfc5tm8Mb9AA82p8d2BhCBMHixkAD0cRo8DUuwoJAJ/wLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtuAD2as; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtuAD2as;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glYDd192Qz2yQn
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Jun 2026 17:17:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8566460138;
	Wed, 24 Jun 2026 07:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B20D1F000E9;
	Wed, 24 Jun 2026 07:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782285470;
	bh=dP2bxkYNQAeUz5jXWdGEqjkG4n1wBe44kDAAGlvauTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LtuAD2asFoZDWxbMQVUtn9sTSbYKT59fb9iCV0goDWLpHd+yi/m7h/0gdHtW0eeDX
	 x4pZx/3/GwA9Q3xCVpNSB1QAEcqXvLK3JzACoc0Py0HZvjGupZq+7GRNGwsnGq3buW
	 hiyDbgF/jxMd0P9heVz3ZbV26O/y8VgN3KWIlyUSVpCXFTw7T0ML1vsUXWe7T799Is
	 T36sCSg0bsqR+d3e+2ipyN3NX+p1Mtx4P2HHEq3huzLy4KxoyXK5zYdWSz77P/nyK5
	 +hEFV3Ye5xpU3GzN0cLZkVIJS+3m6X+eYEO/9K1zgrcM8SdyVe5wsrVyYlCA6vlW2i
	 5a18kkJlgUqMQ==
Date: Wed, 24 Jun 2026 09:17:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?R3LDqWdvaXJl?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] dt-bindings: serial: 8250: aspeed: add
 aspeed,vuart-over-pci bool prop
Message-ID: <20260624-original-vigorous-mayfly-dfceac@quoll>
References: <cover.1782224059.git.gregoire.layet@9elements.com>
 <73b2bd81ce70814612e6d3cb689c3296de742aaf.1782224059.git.gregoire.layet@9elements.com>
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
In-Reply-To: <73b2bd81ce70814612e6d3cb689c3296de742aaf.1782224059.git.gregoire.layet@9elements.com>

On Tue, Jun 23, 2026 at 02:25:40PM +0000, Gr=C3=A9goire Layet wrote:
> The ASPEED AST2600 has 2 VUART accessible over PCI.

What does that mean? How UART can be accessible over PCI bus?


> This boolean can be set to specify if the VUART is used over PCI.
>=20
> Signed-off-by: Gr=C3=A9goire Layet <gregoire.layet@9elements.com>
> ---
>  .../devicetree/bindings/serial/8250.yaml          | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documen=
tation/devicetree/bindings/serial/8250.yaml
> index 3cbd0f532e15..b03797f4674d 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -26,6 +26,14 @@ allOf:
>            anyOf:
>              - const: aspeed,ast2500-vuart
>              - const: aspeed,ast2600-vuart
> +  - if:
> +      anyOf:
> +        - required:
> +            - aspeed,vuart-over-pci
> +    then:
> +      properties:
> +        compatible:
> +          const: aspeed,ast2600-vuart
>    - if:
>        properties:
>          compatible:
> @@ -312,6 +320,13 @@ properties:
>        polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH). Only
>        applicable to aspeed,ast2500-vuart and aspeed,ast2600-vuart.
> =20
> +  aspeed,vuart-over-pci:
> +    type: boolean
> +    default: false

There is no such syntax. Please do not introduce own style. Instead,
look at other files how this is done.

> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Enable the VUART over the BMC PCI device. Only applicable to
> +      aspeed,ast2600-vuart.

Best regards,
Krzysztof


