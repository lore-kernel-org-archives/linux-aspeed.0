Return-Path: <linux-aspeed+bounces-173-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5250BD6ACF2
	for <linux-aspeed@archiver.kernel.org>; Wed, 27 Nov 2024 16:14:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xz4Jw1kmYz2xmk;
	Thu, 28 Nov 2024 03:14:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732724080;
	cv=none; b=QhyH74jUMI33zlWzFLSZFvWvDMX7to/ytGLwHoaRHTELaQBV0t4JZB6bCfk0OFSYxec+pSINupMxsiWfeSDZilR9unaiNQKb7hEZ+FGpg+jWjEPeMo4sE75hFdNSu7sdvmEdcCzlsG5pEkPa8+qo4tvnrVZYz8oPTT2NuiMGi6eY2y+wrmYjVIaUcIYC92H4P8GJjerCdwawzKw8JdNmF3NkQRNfA8SiWT//Nn/4wg8Zrf/LbjW69YREH3+lnRr9jdNr72tjCtasLxrxZ3VjSaDdeNjoiW1E0VRR4IzSEin2hd8/yV2je5naSlbd8dOM7aujXKwa1kCENawPplahxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732724080; c=relaxed/relaxed;
	bh=aShkXMyayZKWZRdrM7J5JHKi41tIxe5R2eQr9Tu6jG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB3agrO0lBLzO3UXgsFYz4DqewRAT8jP6pEu9Wa7k2c0F8q+dtQvCyApPt5lOlMb4tREr3jlXLQeraDhg0F+bLNadRs8UpEz5fMiHvyEnAG7QOemBbeprzVI0wX7Zr65RCclGhIDNf8yvPoC/4DhBrkh9YAbfZApkj/JCRtmp5C8S2D1rjeNyYPAc4X6BgY7WJ0iEBWiD9mJUeEaFhWdWSKeH5NveBlLn15BJqzRHrWnUkYy1CBiLBXjeNLRXrvWnSwf9sQobo83Z8+ORHCo4n9IbKvXyKeMwqD4ooCvWM08O1m357b8Q4e0NWsWwmkUkKrPXzT21vaO8p4fQCnZnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Yzy7GJrB; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Yzy7GJrB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xz4Jv0JDpz2x9g
	for <linux-aspeed@lists.ozlabs.org>; Thu, 28 Nov 2024 03:14:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4B2315C5639;
	Wed, 27 Nov 2024 16:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1F2C4CECC;
	Wed, 27 Nov 2024 16:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724075;
	bh=t/t+qxjEE72ckgaetIew3I8k7tV0KGgHqs4PPn6lneU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yzy7GJrBd/e3ed1KEIowTju/iUvh/T9yE4tGSE0foVfkz5XPzXIOav9a3ecTJoRt5
	 moLU8F3FSksk54D/GR/HMeNLeuUuKh3NiYt2bnkveJbvFmKh0fRGHABUGUbsZ9FriC
	 ZTUUjasE8OBdmpR7GkUMGtwjrFU+3VOiB+UijToRHYzP/qVaWiQoI22LUiD2adoIUe
	 6ANGhB0IE2OfxqeDIOQbHvGef7jPGS8zPibk4MFBmqNmk215695V7uGLXiUPItOMIv
	 EfDTid/dN/dhSFUnjvKfQh9oCGv4ZQsc6tA/55cUwZw/kBHf8zQju+TwCHdhHSgtVg
	 GCogrBmNZzflQ==
Date: Wed, 27 Nov 2024 16:14:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Jason Hsu <jasonhell19@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, patrick@stwcx.xyz,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	yang.chen@quantatw.com, jerry.lin@quantatw.com
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Message-ID: <20241127-resupply-tanned-1410c026f127@spud>
References: <20241127073409.147714-1-jason-hsu@quantatw.com>
 <20241127073409.147714-2-jason-hsu@quantatw.com>
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
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jmHGxiniHzsUH9Y8"
Content-Disposition: inline
In-Reply-To: <20241127073409.147714-2-jason-hsu@quantatw.com>


--jmHGxiniHzsUH9Y8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 03:34:08PM +0800, Jason Hsu wrote:
> From: Jason-Hsu <jasonhell19@gmail.com>
>=20
> Document the new compatibles used on Meta Ventura.
> Add subject prefix for the patch.
>=20
> Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>

I acked this on v1:
https://lore.kernel.org/all/20241022-purgatory-modify-fdcc5f1cff23@spud/

Where did that ack go?

> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/D=
ocumentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 2f92b8ab08fa..98ea2b3e0eb1 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -86,6 +86,7 @@ properties:
>                - facebook,greatlakes-bmc
>                - facebook,harma-bmc
>                - facebook,minerva-cmc
> +              - facebook,ventura-rmc
>                - facebook,yosemite4-bmc
>                - ibm,blueridge-bmc
>                - ibm,everest-bmc
> --=20
> 2.34.1
>=20

--jmHGxiniHzsUH9Y8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0dFZgAKCRB4tDGHoIJi
0mIfAQCayJEyg/gpu7kW1AsnuurZqhAYXJ0x4zKzE2K1FAFASQD7BAOqyd6ui9uH
b6YBGxhPSq91ve2zVGXLlpN06U7rIAY=
=Gnpn
-----END PGP SIGNATURE-----

--jmHGxiniHzsUH9Y8--

