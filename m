Return-Path: <linux-aspeed+bounces-1560-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00FCC77B7F
	for <linux-aspeed@archiver.kernel.org>; Wed, 25 Jun 2025 00:28:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bRjMq3sq6z2xS0;
	Wed, 25 Jun 2025 10:28:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750811287;
	cv=none; b=jFdHRdK9W0RKeaRAmEfXusMhguZI1I6BJiIKoZh971KfYfL0jJv/yUQRQWvbLTBEyaxenZQ12ViDybL9tyN5/TWFFuq2Jn010fSJ4Gm5jutTTd+dm53brBFYrSmTEh/0yWD1Oh1eN5fdXMk/KQwHWpliENUVeR2ceofU0XzufA6bmdq+32YNlPEToNumCUSdUVBSHFGPp97kSdwTNe4qlhCOHRiKzXvauDmA+cd89QUw3VLOuE0Q08fiaz5ZLSDMsdeRJmFTwC/lD6/i3mOGRtAdxN8iZncWiGKFSYAUm9PC/EPkA7gMpebgv7zi67kX4dxkt8/lSlUX7Mxfgd8roA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750811287; c=relaxed/relaxed;
	bh=9Uj4nfGZq5m7cD0qyg2Mz1aKH9prRuM0UoVhM5TzRwU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g/YmpgmMaf0PQ2YVMYAJtv4q4qIRpXgU2bvheWT2NiScTaQitPhGtwXkP1+z1hBI9NgtkFRfmd1cAfMnRfFLZkG3eavj5CRexM6raCNRTju5m3nhgNOlnzIaWAv5KFMmdKc6Sp8EjHAKYLG/0a3noB6fOZMS4YFj2h5qMPOT9J8jBZy7wnkX/OwHFTCQvy8KQxO8yqAk7ryW2GGsiepKDt6AXYtNU2BmNV/Bpe/hC0eIoJT0vdsBDpuGMdqaVlo8P1H6f95e+ZfLquga73jbU7mfL+bmzWwuiy7TpDF3gpx+PZKWjGQVGjaPN6ubMHiT0lUOtLqkSWvCBV2ZNodU+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=e37NC5Jg; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=e37NC5Jg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRjMp533Xz2xKh
	for <linux-aspeed@lists.ozlabs.org>; Wed, 25 Jun 2025 10:28:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750811285;
	bh=9Uj4nfGZq5m7cD0qyg2Mz1aKH9prRuM0UoVhM5TzRwU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e37NC5JgqCB3oXE3YtFABqL935nsxqzLUVyCNYc9KDFiin+d3m3mtW9mm8+7qSt6w
	 I6FsN0fa8AfAQugRXHBrFzYLHu4DDB7stdQVluFSBW+3GizWWMfbdtrLwZKuxrt7Mf
	 hTVAkUylLeqi/9sodDfzAxtzc+HoIOPZEUmuzNeArDxxfz+mpXKS5IYg0vZKPe1Zdr
	 jBdIsH+Dsl43VhBC166MJH+YLgO3a3KDjiQRijzUN8iKCwqc9P5Z+UWfNWRl6KmZds
	 LzSSrX4rkeOWr4biV8oBIH3jKeo1ZquGvCSwDJd6jk05YjuoRd+o012YC0a7Q10SL0
	 QviUFvs/cAyYw==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6D791640A1;
	Wed, 25 Jun 2025 08:28:04 +0800 (AWST)
Message-ID: <0ba565ac9444503be954161a8d79fa0476bd78a0.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jammy Huang <jammy_huang@aspeedtech.com>, jassisinghbrar@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 25 Jun 2025 09:58:03 +0930
In-Reply-To: <20250623024456.2068370-2-jammy_huang@aspeedtech.com>
References: <20250623024456.2068370-1-jammy_huang@aspeedtech.com>
	 <20250623024456.2068370-2-jammy_huang@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Mon, 2025-06-23 at 10:44 +0800, Jammy Huang wrote:
> Introduce the mailbox module for AST27XX series SoC, which is responsible
> for interchanging messages between asymmetric processors.
>=20
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> =C2=A0.../mailbox/aspeed,ast2700-mailbox.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 57 +++++++++++++++++++
> =C2=A01 file changed, 57 insertions(+)
> =C2=A0create mode 100644 Documentation/devicetree/bindings/mailbox/aspeed=
,ast2700-mailbox.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mai=
lbox.yaml b/Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbo=
x.yaml
> new file mode 100644
> index 000000000000..9c5d7028e116
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.ya=
ml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/aspeed,ast2700-mailbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2700 mailbox controller
> +
> +maintainers:
> +=C2=A0 - Jammy Huang <jammy_huang@aspeedtech.com>
> +
> +description:
> +=C2=A0 ASPEED AST2700 has multiple processors that need to communicate w=
ith each
> +=C2=A0 other. The mailbox controller provides a way for these processors=
 to send
> +=C2=A0 messages to each other. It is a hardware-based inter-processor co=
mmunication
> +=C2=A0 mechanism that allows processors to send and receive messages thr=
ough
> +=C2=A0 dedicated channels.
> +=C2=A0 The mailbox's tx/rx are independent, meaning that one processor c=
an send a
> +=C2=A0 message while another processor is receiving a message simultaneo=
usly.
> +=C2=A0 There are 4 channels available for both tx and rx operations. Eac=
h channel
> +=C2=A0 has a FIFO buffer that can hold messages of a fixed size (32 byte=
s in this
> +=C2=A0 case).
> +=C2=A0 The mailbox controller also supports interrupt generation, allowi=
ng
> +=C2=A0 processors to notify each other when a message is available or wh=
en an event
> +=C2=A0 occurs.
> +
> +properties:
> +=C2=A0 compatible:
> +=C2=A0=C2=A0=C2=A0 const: aspeed,ast2700-mailbox
> +
> +=C2=A0 reg:
> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> +
> +=C2=A0 interrupts:
> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> +
> +=C2=A0 "#mbox-cells":
> +=C2=A0=C2=A0=C2=A0 const: 1
> +
> +required:
> +=C2=A0 - compatible
> +=C2=A0 - reg
> +=C2=A0 - interrupts
> +=C2=A0 - "#mbox-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +=C2=A0 - |
> +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +=C2=A0=C2=A0=C2=A0 mailbox@12c1c200 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "aspeed,ast270=
0-mailbox";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x12c1c200 0x200>;

I realise this is just an example, but with respect to the datasheet,
shouldn't this be sized as 0x100?

Otherwise,

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

