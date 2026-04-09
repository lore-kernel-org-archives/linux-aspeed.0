Return-Path: <linux-aspeed+bounces-3882-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771DCF31E3B
	for <linux-aspeed@archiver.kernel.org>; Thu,  9 Apr 2026 15:36:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fs3vD5llGz2yfS;
	Fri, 10 Apr 2026 01:36:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775749000;
	cv=none; b=dEck7wYCNMHDkGJ+2CW7PSd6TvgvgoYRq0KtBapGQNTAkQNkJNzV8OqXYxW4F1MZd/De6I0B92dMZhiF17DzOoCN9hGB77PzSpzK+b+Aww9wbBkGwDPZU1NL/u78L09ENGgw6KlX1XfmFOvKKQeeyY+vHNJgeZPGrafuviEwe4ccvlA7uxMQQCF6Ar/2Kdr/Ij8XuyGSHDlVdKr1tp9rY5E2yjkdDLGjND1av2wyi2ML4XZZyhdPJthVzE3IdFemRTW29bXPNdcXYVlbPqwsfohLX1wS3xwlSWxRfjObaXcSMUy79KFQFUIxhR0RVDTVaDw/NtK1n60UKDtfF2rwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775749000; c=relaxed/relaxed;
	bh=vgHNWQIVNQLVnmYjQa3phpy4f8LkLj4MRmL9b19wYtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flF27jAMr+V9n5/e6G/6TuHbVbGvzHUVBROA9jIjeuA/gJMMiWlhTe47lc6q4D3C+8vBWMiO7feLHt+IBI5VM1Jd4k0mm5i5q8rR7fOGp+sdBZ12mUvAmSusA1k1hPlQvBOC4IySyA0K4WsUlXk8EsVxOo9IxyoPjV/XG4GO82AD5YsZ0oxmBli3tMioYLYY61/N3r+NwiwlVyLoccJBsdkc/AqOBfLQ0HyzsJr9TA4/H/0/rZNPzXzd8JC8MDkh4sDxgjxK7H9edcFO0U6Z0mVbULdrq1GlUWJMM/hb4IztcRmbhd+pyUdtqtBaGF0luTjgCAgZg4Z6PBL/YVacZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Bl3HTEr+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Bl3HTEr+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fs3vC6BXcz2yT0
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Apr 2026 01:36:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A7DA64028B;
	Thu,  9 Apr 2026 15:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66950C4CEF7;
	Thu,  9 Apr 2026 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775748997;
	bh=vgHNWQIVNQLVnmYjQa3phpy4f8LkLj4MRmL9b19wYtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bl3HTEr+tRTCJMBfshW+D0LvT7+dVBTWHSVRPqwJg4GWRC1ZuqXeKWilLsfJAMsVk
	 NUN6t6sZeE1thBJbl2Kginnj0r/IxSLfPBkGtNKz9xYtpkPnUmtg2PB/qAtbv65/+9
	 3f2gf4qZaxr+kAIAi9OMoZtmY57x2HwVvNaRq8P7WgjnvgxhCPB/kki6hiGBz6Ol6w
	 lNP7TugPcnxA3T/T8vVT4NgWa3QzQUbN7s/bQ60y5NIMktwnD75TYzHUcZP/V3rg9j
	 W0J2hPaCl2AS/366YMN9Rlt1mtLsbQMqM0pg242CnTRb2Rku/de2xP6IPIeCLF+tYL
	 cC7KtRAboBOJQ==
Date: Thu, 9 Apr 2026 16:36:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Colin Huang <u8813345@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	colin.huang2@amd.com
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: aspeed: add Anacapa EVT1 EVT2
 board
Message-ID: <20260409-foster-stability-f77b38c6f7a0@spud>
References: <20260409-anacapa-devlop-phase-devicetree-v2-0-68f328671653@gmail.com>
 <20260409-anacapa-devlop-phase-devicetree-v2-1-68f328671653@gmail.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="94RiNPJk8aF+VXXp"
Content-Disposition: inline
In-Reply-To: <20260409-anacapa-devlop-phase-devicetree-v2-1-68f328671653@gmail.com>


--94RiNPJk8aF+VXXp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026 at 07:40:26PM +0800, Colin Huang wrote:
> Document Anacapa BMC EVT1 and EVT2 compatibles.
>=20
> Signed-off-by: Colin Huang <u8813345@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--94RiNPJk8aF+VXXp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCadfHgAAKCRB4tDGHoIJi
0lTBAQD3cz6MzoGwGp8mKC6FkE8r1DyqVtkBVRvjGhBwfipPqAEA62JE9BQgRbH1
0Zd5rQtyVO3BwX5MMW3LwT1FMuJtPwI=
=AvG8
-----END PGP SIGNATURE-----

--94RiNPJk8aF+VXXp--

