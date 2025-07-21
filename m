Return-Path: <linux-aspeed+bounces-1757-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7D4C83F1A
	for <linux-aspeed@archiver.kernel.org>; Mon, 21 Jul 2025 01:12:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blj6c5Y2Mz30WT;
	Mon, 21 Jul 2025 11:12:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753060328;
	cv=none; b=igYlOlBboisXlfwR3ITAzIwP6pLTFH2wX/Xm3HhxnPIzHLupKDltD5+08q+5xvzRqFXXj7iwsz7GpG5r99T5borTNfdMVuyM9LmLVqUAKV0Dllc+tWOdThLoeBT1Zsxq2/neoZ9zIAOk73QQ3Eemjyb+rBKl4+KtMymcnV5ODafSArxqJkkHK55A9jEZkzv7BLRy5D/qkLLdfygVojFUn42WKVV/VN4X17epBoK5zokLd9fHga3hMH5A7VOqet0yUzobUWFlqkQoWSEz+7U5D942G46uwU/0taDl73zPI65wHqpj0bo7hKSps1XVLLt/12p+xPeZ8REI6uJ3DVuy7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753060328; c=relaxed/relaxed;
	bh=s//7MjuX07y4aMFmJCpTEwCT9TCj/TYkQ55O0eQjT4I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BpOK3f/uuL5o+fMuOkrVeDUivUCt1tfKR4WTFznyQIJBFJLxgLvHKYyji79ilRVwhKVTfB8S4s3PsPZA1XqZO+TIsUj/B2yQpSUmQMnRaZks2uUwGvKubZkiZNSCEY5SUYbQo5bGApbyfNBiiznQqXm01QfSchiyhNIvW+7o7mCyB+aDvQU3B4NrwJpx2UUO51kNk7uVQbu53/VpCaDJggMLHbB7kbV2g3nWIRGuvcJKKRnwNr+ic3AzwZdEw/8P1R5cg/XCf3MTPyUKSptoTGPguc6iIOZBpcp2tiTxGA/yvALaaNpN5Q5NhQ1S4GYiAVciyU9mx4BWTgi0mYDYpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Pqbl3gkg; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Pqbl3gkg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blj6c1qB2z2yfx
	for <linux-aspeed@lists.ozlabs.org>; Mon, 21 Jul 2025 11:12:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1753060326;
	bh=s//7MjuX07y4aMFmJCpTEwCT9TCj/TYkQ55O0eQjT4I=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Pqbl3gkgwV28WX8LMF7FFKluhrO2t0iskwad6rrW6ZNv0dkVaSarK2ey92y9gEMOX
	 LGvjl/Zy4czwCdITA9MMQ+6srHX+KsESqY1ZXNfQwzQSvcojwuUhGk8pU7Bw2LI5iI
	 Q6YGhuceFsEqgcshG/gHVKukz3OGhTPgNE1AULMrQwsHSFB1B9JBGN8zjtm+C+DH+O
	 OSnOr0fyXffZpA9nrC8Nyg07E5EzysIyFJp0LkHWr216oO2+72EUjDABLyiIXo4IvM
	 wQZznT4B56QHjxwOIp+OeAOI04nLwIE62l3BKzZYkOg5wWJYHUqLsPKNmViXqy0C9f
	 IXHrXVKuscvpA==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3FD3D6443C;
	Mon, 21 Jul 2025 09:12:04 +0800 (AWST)
Message-ID: <0b9b6c712bff18a25da218c507d18b9a8f18c7e8.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 5/9] ARM: dts: aspeed: wedge400: Extend data0
 partition to 64MB
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: rentao.bupt@gmail.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Tao Ren
 <taoren@meta.com>
Date: Mon, 21 Jul 2025 10:42:03 +0930
In-Reply-To: <20250706042404.138128-6-rentao.bupt@gmail.com>
References: <20250706042404.138128-1-rentao.bupt@gmail.com>
	 <20250706042404.138128-6-rentao.bupt@gmail.com>
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

On Sat, 2025-07-05 at 21:23 -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
>=20
> Extend wedge400 BMC flash's data0 partition to 64MB for larger
> persistent storage.
>=20
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
> Changes in v2:
> =C2=A0 - None (the patch is introduced in v2).
>=20
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/=
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
> index 3e4d30f0884d..cf6c768cbad5 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
> @@ -92,7 +92,7 @@ tpm@0 {
> =C2=A0 * Both firmware flashes are 128MB on Wedge400 BMC.
> =C2=A0 */
> =C2=A0&fmc_flash0 {
> -#include "facebook-bmc-flash-layout-128.dtsi"
> +#include "facebook-bmc-flash-layout-128-data64.dtsi"

My preference here is that we maintain two separate DTS for Wedge400:

- aspeed-bmc-facebook-wedge400.dts
- aspeed-bmc-facebook-wedge400-data64.dts

We do so such that we implement aspeed-bmc-facebook-wedge400.dts like:

   > cat aspeed-bmc-facebook-wedge400.dts
   #include "aspeed-bmc-facebook-wedge400-data64.dts"
  =20
   &fmc_flash0 {
   /delete-node/partitions;
   #include "facebook-bmc-flash-layout-128.dtsi"
   };

aspeed-bmc-facebook-wedge400-data64.dts includes facebook-bmc-flash-
layout-128-data64.dtsi as usual.

From there we can consider aspeed-bmc-facebook-wedge400.dts to be
deprecated and can remove it in a future release. At least with this
arrangement any revert of the (future) patch removing aspeed-bmc-
facebook-wedge400.dts has no other impact. Further, both layouts will
be supported in at least one release, making it possible to update the
kernel without requiring a simultaneous update to the flash layout.

Andrew

