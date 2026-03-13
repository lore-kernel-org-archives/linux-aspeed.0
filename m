Return-Path: <linux-aspeed+bounces-3664-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8993C107BCC6
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Mar 2026 16:24:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXVDv5RtFz3cK4;
	Sat, 14 Mar 2026 03:24:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773419071;
	cv=none; b=MaBDVTYUmf2R9kxW+zdBuQ53Xhk0YDzZDtTdOezy1EeTLNwmP+I7z/6QBnEsrJnCEJIJ9HtmdVFYVz7hS97nE8xKetGs74wIzSwHVh4tVFBOFJNZXFCOE8YkW47VO6OEpRA9ckEbqWR399H+seKjPCDGpgVBwEc7qSIXsJ6CapizC6qYqCI5eIO2JchM5WQ1pIzdlgsS5HEr34hVeEO1yYnUHtG+q0aeWYZz5p8CYBXRaEa1yd/JLNhnZkT8edUlpc/DX5CZNHZJY+el76s3zKxywQ+b3q3MFOf3e9jht9jpJN2WWsGk0Zd/YyvsgNx9APfWbbGGMmpTqwlduOOObw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773419071; c=relaxed/relaxed;
	bh=WDoG6lWL1T3lToH/x6cJPVB9JP2JhQbK4YLDXdEvjis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEA0R7tx0tPsuSB9kz/2V4Wu4oxPt3yNjEtUXpos2A05xMLepScVwXxtjzr6Ak4QwlmxTzYdp3SzZ89c37w3Fnfh/BNYxKTUbRWGNRJk98X0iR/GNJ//VPEeZb/IsguqeIMjihoXDs4Ei+F2CaME9ZDYVTgAyx7RWitUoEn17tbjpMVqbqrEkfaZwvDgBlm3Xt6pvYOqIcqcq1mJRb0LsH4XI4DR51ju7ubwSh+3yNIDwScG6j/YTD+7f9veIU+kbjeolC6BcFSAhYYgbaAKMqSDHaNWvBFcgx6IA1Vf67sxt6jEoh8nPF+dSZIaCu8kkRQ9ZYo0SRT2QnC/VL9t1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NYtH8FoC; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NYtH8FoC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXVDs2lzhz3blq;
	Sat, 14 Mar 2026 03:24:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 625CF41AFE;
	Fri, 13 Mar 2026 16:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC9CC19421;
	Fri, 13 Mar 2026 16:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773419067;
	bh=nO2xN0bDN0di6NgmvrvHhZmDL3VlQvUs/UOpTeiuJe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYtH8FoCr6ad2IGGddfsQz/i3/rgc4qD74Qn/NXfwLySdulz3ldgIt7/Iuwmq74as
	 +JcUXGNF78o2C73GYhk/AXAeXOg1QvyMw/Nk0CvB7itIB9K8CWmL/DsF/CC8Sxehsj
	 zFchOBuN4oE5yrqNUUwaFkgpADo4Ok5WUHWdD9Opd57YYyAwQe2mvEBtB8DtPVHaMx
	 FeUfzB1C4DfIBWOcSRIKHbCWvWMuI/la9OwP0z9382xeOFGhbhhVoa/oxvGDIDMOCl
	 86FIfIl01DgJnrhGMYENdeylbCF3WxPqjoQNRTYY+g8lbpjzV6HWwKu4FcnwgeRr7q
	 wT34YX1lhTIJA==
Date: Fri, 13 Mar 2026 16:24:22 +0000
From: Conor Dooley <conor@kernel.org>
To: aspeedyh <yh_chung@aspeedtech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	maciej.lawniczak@intel.com, broonie@kernel.org
Subject: Re: [PATCH 0/7] soc: aspeed: Add AST2600 eSPI controller support
Message-ID: <20260313-energy-casket-ca8adc1f1fd1@spud>
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
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
	protocol="application/pgp-signature"; boundary="Ri4H3n7qcgGpiS4k"
Content-Disposition: inline
In-Reply-To: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>


--Ri4H3n7qcgGpiS4k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 06:07:35PM +0800, aspeedyh wrote:
> This series adds initial support for the eSPI controller found on ASPEED
> AST2600 BMC SoCs.
>=20
> The series introduces a eSPI controller framework for ASPEED SoCs under
> drivers/soc/aspeed/, adds AST2600-specific controller support for
> peripheral and flash channels, defines the corresponding devicetree=20
> binding, and adds the AST2600 eSPI controller node to the SoC dtsi.
>=20
> The driver is intended to support host-BMC communication over the BMC-side
> eSPI slave controller present on AST2600 systems.

This all seems to be in the wrong places entirely, shouldn't an eSPI
driver and bindings go in the spi subsystem? FSL's appears to be there.
Mark?

>=20
> Patch summary:
> 1. dt-bindings: soc: aspeed: Add AST2600 eSPI controller
> 2. soc: aspeed: Introduce core eSPI controller support
> 3. soc: aspeed: Add AST2600 peripheral channel port I/O support
> 4. soc: aspeed: Add eSPI TAFS backend support
> 5. soc: aspeed: Add espi flash channel support
> 6. soc: aspeed: Add sysfs controls for flash LUN selection
> 7. arm: dts: aspeed: Add eSPI node for AST2600
>=20
> This series has been tested on AST2600 platform with Intel's host eSPI
> controller.
>=20
> Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>

Unless you're an fanatical employee of Aspeed, I doubt that this signoff
reflects your actual name!

> ---
> aspeedyh (7):
>       dt-bindings: soc: aspeed: Add AST2600 eSPI controller
>       soc: aspeed: Introduce core eSPI controller support
>       soc: aspeed: Add AST2600 peripheral channel port I/O support
>       soc: aspeed: Add eSPI TAFS backend support
>       soc: aspeed: Add eSPI flash channel support
>       soc: aspeed: Add sysfs controls for flash backend selection
>       arm: dts: aspeed: Add eSPI node for AST2600
>=20
>  .../bindings/soc/aspeed/aspeed,ast2600-espi.yaml   |  74 +++
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |  11 +
>  drivers/soc/aspeed/Kconfig                         |   7 +
>  drivers/soc/aspeed/Makefile                        |   1 +
>  drivers/soc/aspeed/espi/Makefile                   |   1 +
>  drivers/soc/aspeed/espi/aspeed-espi-comm.h         |  62 +++
>  drivers/soc/aspeed/espi/aspeed-espi.c              | 618 +++++++++++++++=
++++++
>  drivers/soc/aspeed/espi/aspeed-espi.h              |  63 +++
>  drivers/soc/aspeed/espi/ast2600-espi.c             | 304 ++++++++++
>  drivers/soc/aspeed/espi/ast2600-espi.h             | 302 ++++++++++
>  drivers/soc/aspeed/espi/espi_storage.c             | 322 +++++++++++
>  drivers/soc/aspeed/espi/espi_storage.h             |  32 ++
>  12 files changed, 1797 insertions(+)
> ---
> base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
> change-id: 20260313-upstream_espi-d9fea66d1772
>=20
> Best regards,
> --=20
> aspeedyh <yh_chung@aspeedtech.com>
>=20

--Ri4H3n7qcgGpiS4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabQ6NgAKCRB4tDGHoIJi
0r9rAQCzRJj+qeLcVgcLte6ZhkBlAd80bAZXjUF47eDDrK5abgD/bQdbCvmv8GKV
PXvZhB78H2Kl0OTJ/ssW+ILpkoWz9Q8=
=dRsP
-----END PGP SIGNATURE-----

--Ri4H3n7qcgGpiS4k--

