Return-Path: <linux-aspeed+bounces-420-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9434E7719C
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 14:52:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4Q43YGNz3cXv;
	Sat, 11 Jan 2025 01:52:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736520764;
	cv=none; b=GMu3j81mX+cHsaLAghwFp6WrmR8TpDl8BFpAZJ/T0dZApjOTd/jUbviw7gULJpLMtnODC/5Ob4xZobz0lrT5bUlD4Ic1QCODH33CmtSaKiYHCWyfIlhjKC6hHaaXG/l3LKBoqVzvVG0WBLrlwHyyTc0FZVIzoXkKkMPww9kfdjoy3AhpsZ190EyXmEAQTXg+nEvN8yVUXGwrpY2RQzzhSaE7T47KMVTDF7HYTzXI78iVtqqujUp9VigNVOqcT2mjkv288SkVbtNRmavKth2W/LfSqbtVdXLX8bnEwZR4/+KDuJMWzmDUBI3SfDUCYVWiKcclAb0T6mAfWAX6Xp0EWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736520764; c=relaxed/relaxed;
	bh=fSAq9ftH8WS0Cu3Bt+E6Xa84rtG0m/mz4MYDXGMgD4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJJUqCpVFzOGHnDJ86RtzPUyjKfS2uXsB7zi6Mx4Z8bBbJ3AnJO2MwN8fY9BWQJRoBW7DfuUe2arWUIDv6yNpe0jGgIjFy76nomqVR5hdEiKCKGabr4yg4D97hovRfTnHNhH668PXJthmaKbd7zcWnzAeUMAKTM54yf9Sh9uy2XiELZ6QZryabm7RMO2oRNYHrXFJtgcL3RMXOH23pSNN0oyPr3/WIgZFKVOTKDKlUzR2OrPG4/Hh3uVoSMOuFQ9sEEZL6PCm2KVPfCxDxz7zQrcZr37GQfboFoNmGiAdsECQ7YMHWghEzdcPAUgZ+nP5TQuJ8zJU6LH8Iep9xzMYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gLi8UcH9; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gLi8UcH9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV4Q31d8dz3cXk;
	Sat, 11 Jan 2025 01:52:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 521DAA4214C;
	Fri, 10 Jan 2025 14:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C0AC4CED6;
	Fri, 10 Jan 2025 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736520760;
	bh=aNCFEV4RXYP85CjPd7vNqTGzYYPEBIBQoTBIen40yHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLi8UcH9DGe79azEcqPclXToIx5qw10enSJS5mjJaQRBBZ+5CLBrfh7Mpi7iMW0TO
	 A/rbMrNTS+PA9NpBPcVMM2z4ku1oxppk3W6llOIBhZvOuDHhGVRljWiAOR1U+h7yFg
	 tOqGBw0ZgHBSqZRgs8RWqGihl1fJ89d10Xtujow1iFSpmcSQgrYpctK/HiN6tIbDI+
	 n5yG5j4ZixygYt6rjBddVkMwyc9Hf5TbHnNKtMpk9hIBLXmn5EBUF3ghvXFuOE1FRu
	 mrmh66XV3EANLgY1TKzwxSp7POGpX7PmaPlVbxRNm2IDDx7avzqsmJ+qIFj+4ZvpJn
	 l1C5E9zSehWHg==
Date: Fri, 10 Jan 2025 14:52:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Sanjay R Mehta <sanju.mehta@amd.com>, Han Xu <han.xu@nxp.com>,
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
Message-ID: <c9043531-c733-4153-a814-79aab387883e@sirena.org.uk>
References: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
 <20241224-winbond-6-11-rc1-quad-support-v2-20-ad218dbc406f@bootlin.com>
 <ca317e2c-cd09-4884-b9eb-9cf23ae88078@sirena.org.uk>
 <87tta6ag5b.fsf@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="D5dtr3CwiZ2FNoyO"
Content-Disposition: inline
In-Reply-To: <87tta6ag5b.fsf@bootlin.com>
X-Cookie: RELATIVES!!


--D5dtr3CwiZ2FNoyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 03:37:52PM +0100, Miquel Raynal wrote:
> On 10/01/2025 at 12:42:47 GMT, Mark Brown <broonie@kernel.org> wrote:

> > This breaks the build:

> > /build/stage/linux/drivers/spi/spi-mem.c:580:5: error: conflicting type=
s for =E2=80=98spi_mem_calc_op_duration=E2=80=99; have =E2=80=98u64(struct =
spi_mem_op *)=E2=80=99 {aka =E2=80=98long long unsigned int(struct spi_mem_=
op *)=E2=80=99}
> >   580 | u64 spi_mem_calc_op_duration(struct spi_mem_op *op)

> Crap, that's a fixup that landed in the wrong commit (mtd: spinand:
> Enhance the logic when picking a variant). I'll fix it.

Please only resend that patch - the rest builds and tests fine in my CI,
I'm just checking a merge fixup.

--D5dtr3CwiZ2FNoyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeBNC0ACgkQJNaLcl1U
h9DAqAf/Qrz25ymjeY3vF9YJzCAUUyBS18sTyjX0LHFtT3TgKFe5BYRlKvM8thbH
laiQ60LjJlTDfHpTNzluTCzAgMXm72nOcj/jI4aNjM++Vr/I/xwvVZWbnIH6eZXN
/6oik+AWx+8+dkg/KM9xeJmz1c7efDMcu1KPjM4jv1cuGHe/SMAy0HroYpo6o1+d
WMMbRDqbjT+aZF/9ZnqhOxl1+UaPqyhWYWMlmrT0HbsD+DGGfSXjiPKYVe3+gv7s
n3Oxrkni3O74YgOIN1Tg924Beg9+V7xFVjC+xdzZ0l/uY22fPkMHM+lVFwz9Qy0r
ZmvCpIfRn+q++xWYtiLBpITHKteMvw==
=Dk/0
-----END PGP SIGNATURE-----

--D5dtr3CwiZ2FNoyO--

