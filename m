Return-Path: <linux-aspeed+bounces-388-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347B5E77188
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 12:43:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV1XQ32hBz2xHT;
	Fri, 10 Jan 2025 23:43:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736512982;
	cv=none; b=DPleU/57cL8EL3momMDG8uqb4BAXwYUdFwBsh1e64WdVM5YvcbhaeKzUPmsfv0FjR5S6PqXZJGxG9RuVDcSMzB6DR1fBrYYiA3kVVn8Y6IrG2mxAPUkNL+IzZOgY2dOTlsyy5bcT29ExsJQWdb3Gns1t1MYBlGB1nRKvyQggLNBxnx8dc2rbkuHQKsxo5ChQ1t+4R+2VSWBFMV5sCjvUzXp1dP8T+Lcz2YSV5t6n9X8hKC7t7De28MIclx2oAi3EjLiKtg0M97SdZ2q0NrRehifBBkbibrZSigfbrpSxIXo+3a1Re1LkUUk/ntUiXIoksdXjVX+wTyh4sxQibhc8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736512982; c=relaxed/relaxed;
	bh=wFC57NWqs87HrbGHaJbSRA+SgAQ9dhPfJP+b4s9z5lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3uLxxBMtyvC5LaWlLsiM1Mavop9+j9fSWO071f3aN89fusv1UfGWKDLDGK9EIgDEHkgS0Pvzgxr2X2uUGbmPZAuIC1rEinqY734hIcSyjOVHn9QUpeUuHVP0GEzhYPhkpCvlit5Ta9OMUp9UmB3xQkit6XSiMHlsqE+NAuQDZajxH7KuijHcaIusG4PV6V8KTjDkGHkmRIkpx61v698bLiJ8gwcsQ+HEivpoAQ9/Q61EG7WH4Fz9DErWeoqJMS1AHkMDFEOfwjci+Nib/LMZYCzXWNCEpYeOAJb1XUwUrQjivurfIRhLIV5fCw+avZ0/hRl7ILQKorOplDwbF1QcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KpD0sW7U; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KpD0sW7U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV1XN5jd4z2xGC;
	Fri, 10 Jan 2025 23:43:00 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CCE6B5C10C3;
	Fri, 10 Jan 2025 12:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0816AC4CEDD;
	Fri, 10 Jan 2025 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736512977;
	bh=jQisMlTjYfeo02yHCaf8/3pDTMXN8QMfrZ/MAhEXiCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KpD0sW7UIABuucxd/Qx8pWVveKRBTPjoee4MF0KjKw8i5YDBoDzL5JYvu4BaELO0t
	 M/U8H/SXs0PIabw+VP/Wmcv2zkse9maGzd/9rSoZgJ6hC/Lu3TEGJ9VrLXjmmeRFg1
	 vFZp71KV7rVxbfsUrwau0sxqutt53V+fSRgOWgFQTeVLDgWzOazdvg68BZ9FapN4Et
	 JWbE4PuKzWFwlzYvCA+Uzkc1/eq5V73FfErBUEePlT0QeeVOCwHPXy/saY0DV/C3w1
	 EubDaTDdWlxizzmd69Sr4YfE+GSogwgowB31K0GFRmk2/goQYinjInn1BjN5IFfOdI
	 Cy3tqd/O7Qjaw==
Date: Fri, 10 Jan 2025 12:42:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Sanjay R Mehta <sanju.mehta@amd.com>,
	Serge Semin <fancer.lancer@gmail.com>, Han Xu <han.xu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Steam Lin <stlin2@winbond.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 20/27] spi: spi-mem: Estimate the time taken by
 operations
Message-ID: <ca317e2c-cd09-4884-b9eb-9cf23ae88078@sirena.org.uk>
References: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
 <20241224-winbond-6-11-rc1-quad-support-v2-20-ad218dbc406f@bootlin.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RVMhmV/ewGAzdaKp"
Content-Disposition: inline
In-Reply-To: <20241224-winbond-6-11-rc1-quad-support-v2-20-ad218dbc406f@bootlin.com>
X-Cookie: Many are cold, but few are frozen.


--RVMhmV/ewGAzdaKp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2024 at 06:06:05PM +0100, Miquel Raynal wrote:
> In the SPI-NAND layer, we currently make list of operation variants from
> the fastest one to the slowest and there is a bit of logic in the core
> to go over them and pick the first one that is supported by the
> controller, ie. the fastest one among the supported ops.

This breaks the build:

/build/stage/linux/drivers/spi/spi-mem.c:580:5: error: conflicting types fo=
r =E2=80=98spi_mem_calc_op_duration=E2=80=99; have =E2=80=98u64(struct spi_=
mem_op *)=E2=80=99 {aka =E2=80=98long long unsigned int(struct spi_mem_op *=
)=E2=80=99}
  580 | u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from /build/stage/linux/drivers/spi/spi-mem.c:12:
/build/stage/linux/include/linux/spi/spi-mem.h:427:5: note: previous declar=
ation of =E2=80=98spi_mem_calc_op_duration=E2=80=99 with type =E2=80=98u64(=
struct spi_mem *, struct spi_mem_op *)=E2=80=99 {aka =E2=80=98long long uns=
igned int(struct spi_mem *, struct spi_mem_op *)=E2=80=99}
  427 | u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op=
 *op);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from /build/stage/linux/include/linux/linkage.h:7,
                 from /build/stage/linux/arch/arm/include/asm/bug.h:5,
                 from /build/stage/linux/include/linux/bug.h:5,
                 from /build/stage/linux/include/linux/thread_info.h:13,
                 from /build/stage/linux/include/linux/sched.h:14,
                 from /build/stage/linux/include/linux/ratelimit.h:6,
                 from /build/stage/linux/include/linux/dev_printk.h:16,
                 from /build/stage/linux/include/linux/device.h:15,
                 from /build/stage/linux/include/linux/dmaengine.h:8,
                 from /build/stage/linux/drivers/spi/spi-mem.c:8:
/build/stage/linux/drivers/spi/spi-mem.c:593:19: error: conflicting types f=
or =E2=80=98spi_mem_calc_op_duration=E2=80=99; have =E2=80=98u64(struct spi=
_mem_op *)=E2=80=99 {aka =E2=80=98long long unsigned int(struct spi_mem_op =
*)=E2=80=99}
  593 | EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
      |                   ^~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/include/linux/export.h:56:28: note: in definition of mac=
ro =E2=80=98__EXPORT_SYMBOL=E2=80=99
   56 |         extern typeof(sym) sym;                                 \
      |                            ^~~
/build/stage/linux/include/linux/export.h:69:41: note: in expansion of macr=
o =E2=80=98_EXPORT_SYMBOL=E2=80=99
   69 | #define EXPORT_SYMBOL_GPL(sym)          _EXPORT_SYMBOL(sym, "GPL")
      |                                         ^~~~~~~~~~~~~~
/build/stage/linux/drivers/spi/spi-mem.c:593:1: note: in expansion of macro=
 =E2=80=98EXPORT_SYMBOL_GPL=E2=80=99
  593 | EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
      | ^~~~~~~~~~~~~~~~~
/build/stage/linux/include/linux/spi/spi-mem.h:427:5: note: previous declar=
ation of =E2=80=98spi_mem_calc_op_duration=E2=80=99 with type =E2=80=98u64(=
struct spi_mem *, struct spi_mem_op *)=E2=80=99 {aka =E2=80=98long long uns=
igned int(struct spi_mem *, struct spi_mem_op *)=E2=80=99}
  427 | u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op=
 *op);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~

--RVMhmV/ewGAzdaKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeBFcYACgkQJNaLcl1U
h9BhIgf+KXE1JExJo+WBN7mYcyQ4HitVxI+rVexdbI+QMmjPpB2umRebJU2u0F2O
zJlk5R6eGXdOn3H83H0CacUm11VVNZmqP1yUSytO4sjiyHdh7Zp70UkidrhA0O9F
pRM9l9bBbWV3FzLgZCYjZ03y6A+A9CrIsGRVAuX/rAUHENGshIN+Wa1j4ZwRkI+u
Nid4YWfQkB1UjSFhcx6d9iDq65hTlrHDn5ThFmIDGZCTS8NRcUAevtkdwoU9thC7
1xTCkJ92ejUGQ3TTzVrlg6qsnSJTAARPhDZ8WasEfN+L/LWyRI181QAMRKG4oOOi
swVXAClyqCX9avFjDoBP8aArkjRb4A==
=qXZ3
-----END PGP SIGNATURE-----

--RVMhmV/ewGAzdaKp--

