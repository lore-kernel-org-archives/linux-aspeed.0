Return-Path: <linux-aspeed+bounces-431-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F00E77188
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 18:28:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV9CR2Pf9z3cYR;
	Sat, 11 Jan 2025 05:28:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736533731;
	cv=none; b=eySTdDAUNcpblQ9aRRLn1Rvvod077Dli8fv2nCvLFjaqM9TtSdIWL2qelHBp/z2pvcGWJP2OrYpaS4iRLhlyDvijS/qumBwnSz8zoIYzO6YmAMKaG6/kYeiSeKkIm4DRtnzAE/AXVgPEABaQmTzI/6KciGt5txlwF5aXclqLZkwaxJuwbRz1aHdV5wcDTewOP9IpgLyuqQian1KK6UCi87JxzuimkfLhXEpARmVmHZbIkinJ8ZoVHxYkpkMDXJEIZ7ni0xVmAbC9cmCo29xnThcIQksmoXX7MwrLXvhB2PbVt4Egr6oRu8G+muRLEpSMnRvP+2ROEXsGuBbIv4ebcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736533731; c=relaxed/relaxed;
	bh=NLsgczFwbsqiup/iuqbZ95oXX45OVMvMIvOh/8/OVvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGahNPIyop9XSOjSJUecOWS0h7xt3WIHWq/KJzFa+5UwWebvwQkTwk71ACaqk9zSauohyrQWKI4CG8Q8RaIlqxJUE9Zg+S3geOzcNKtHYS9QLKoOOkfIArb1lveURBQRrNkwpgyAHvuuUztatoPgF6BfOYs6h7g24psZDbGYn1heS5w4b9O4dTWSEpdMDcBsaI/mHk/OGBjR9kehPpB86U9ACMmVY9gOjnuAes5Y++vAOWJukOaKyCTD8wJKMmjvau9fKAlUwAqJ2ZrG9cvfvN6pczjdkg1mhqGcDTRCdS2Q7LCbrqrxcwRG37BxYtdvIvWSQimDV46gYXDr37674w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=osZYI5oI; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=osZYI5oI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV9CP6Hw8z3cY8;
	Sat, 11 Jan 2025 05:28:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 676215C3C1E;
	Fri, 10 Jan 2025 18:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDCCC4CED6;
	Fri, 10 Jan 2025 18:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736533727;
	bh=TYFMjwc9ILvsgk5FB1BS5YUEXb8oE3r6UYK7GHBXgNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=osZYI5oI6hiesP0M2Esd1STQqJmI7el5YkceNLFM8+HrQ/N2LQ8QTOTxZQFbuU/TY
	 mb3OAUD+pNkKWyCcseCgaHiJSt4FishYXpULU2ninbOFjEnRJlcapsxfg3DZz8i4Of
	 tkdk7LEhgpT8osyxWzN5JpmIqOOXS6W6OC/juy2NlF2K7KWPPLlY3bjx7AMzPrpV6Y
	 2GhR+hvM7dBbWgY8OjfvS3qbehrIbT0IfxOUrmtMh599zDqoGF/GCwPQaOlME3sXY8
	 YtjnwrhhcHqQnehnF7ZjP0xVIPNfEVa6U4oSmg8nIzGiD72G2oEddP9wLtHkAoyqIx
	 cYQrRwOTXmSDg==
Date: Fri, 10 Jan 2025 18:28:36 +0000
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
	linux-stm32@st-md-mailman.stormreply.com,
	Pratyush Yadav <pratyush@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	stable+noautosel@kernel.org
Subject: Re: [PATCH v3 00/27] spi-nand/spi-mem DTR support
Message-ID: <b40af2ab-8b0a-4099-a636-13ed2a5151ea@sirena.org.uk>
References: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="aYdj4KKHQJTEiuns"
Content-Disposition: inline
In-Reply-To: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com>
X-Cookie: RELATIVES!!


--aYdj4KKHQJTEiuns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 03:45:02PM +0100, Miquel Raynal wrote:
> Hello Mark, hello MTD folks,
>=20
> Here is a (big) series supposed to bring DTR support in SPI-NAND.
>=20
> I could have split this into two but I eventually preferred showing the
> big picture. Once v1 will be over, I can make it two. However when we'll
> discuss merging, we'll have to share an immutable tag among the two
> subsystems.

The following changes since commit 9d89551994a430b50c4fffcb1e617a057fa76e20:

  Linux 6.13-rc6 (2025-01-05 14:13:40 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
nand-dtr

for you to fetch changes up to 226d6cb3cb799aae46d0dd19a521133997d9db11:

  spi: spi-mem: Estimate the time taken by operations (2025-01-10 15:20:04 =
+0000)

----------------------------------------------------------------
spi: Add spi-nand DTR support

This series adds support for DTR in the SPI subsystem's NAND support,
allowing it to be used by the MTD framework.

----------------------------------------------------------------
Miquel Raynal (20):
      spi: spi-mem: Extend spi-mem operations with a per-operation maximum =
frequency
      spi: spi-mem: Add a new controller capability
      spi: amd: Support per spi-mem operation frequency switches
      spi: amd: Drop redundant check
      spi: amlogic-spifc-a1: Support per spi-mem operation frequency switch=
es
      spi: cadence-qspi: Support per spi-mem operation frequency switches
      spi: dw: Support per spi-mem operation frequency switches
      spi: fsl-qspi: Support per spi-mem operation frequency switches
      spi: microchip-core-qspi: Support per spi-mem operation frequency swi=
tches
      spi: mt65xx: Support per spi-mem operation frequency switches
      spi: mxic: Support per spi-mem operation frequency switches
      spi: nxp-fspi: Support per spi-mem operation frequency switches
      spi: rockchip-sfc: Support per spi-mem operation frequency switches
      spi: spi-sn-f-ospi: Support per spi-mem operation frequency switches
      spi: spi-ti-qspi: Support per spi-mem operation frequency switches
      spi: zynq-qspi: Support per spi-mem operation frequency switches
      spi: zynqmp-gqspi: Support per spi-mem operation frequency switches
      spi: spi-mem: Reorder spi-mem macro assignments
      spi: spi-mem: Create macros for DTR operation
      spi: spi-mem: Estimate the time taken by operations

 drivers/mtd/nand/spi/core.c           |  2 ++
 drivers/spi/spi-amd.c                 | 21 ++++++------
 drivers/spi/spi-amlogic-spifc-a1.c    |  7 +++-
 drivers/spi/spi-cadence-quadspi.c     |  3 +-
 drivers/spi/spi-dw-core.c             | 10 ++++--
 drivers/spi/spi-fsl-qspi.c            | 12 +++++--
 drivers/spi/spi-mem.c                 | 64 +++++++++++++++++++++++++++++++=
++++
 drivers/spi/spi-microchip-core-qspi.c | 26 +++++++++++---
 drivers/spi/spi-mt65xx.c              |  7 +++-
 drivers/spi/spi-mxic.c                |  3 +-
 drivers/spi/spi-nxp-fspi.c            | 12 +++++--
 drivers/spi/spi-rockchip-sfc.c        | 11 ++++--
 drivers/spi/spi-sn-f-ospi.c           |  8 +++--
 drivers/spi/spi-ti-qspi.c             |  7 +++-
 drivers/spi/spi-zynq-qspi.c           | 13 +++++--
 drivers/spi/spi-zynqmp-gqspi.c        | 13 ++++---
 include/linux/spi/spi-mem.h           | 56 +++++++++++++++++++++++++++++-
 17 files changed, 235 insertions(+), 40 deletions(-)

--aYdj4KKHQJTEiuns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeBZtMACgkQJNaLcl1U
h9C2zQgAgu3h0M+rMbhCSl4Ax1wuwWzdK82xuQKhEOqQKPe4KB4vTzh1sfMWcvDX
8SFJrtxYI819QKXozGjqkxGXmY25Bk5rPF08p4qZ3pGBRfKalLOrfNgc36Duv4g5
W3ClxWr1pkFaw8XfEqrYoYqNT9lA1LzW7Ddqu0IxmHQDW66BfVxU4pHVlQsntB3H
qaWW/ZntqizjTUbrIfbDuvoNwCmRCZByjvjAMgDX3q0K1DTqbPL+UNoRUNs6lBek
PBRAiB+Mc0gd6XVtsVTnhimLpsP9Y5BVdXCEd0V3Z+gj+n/FRB1qEvp4WnSndtZ8
Fm9HJmek861NtHjuBt7awHizmBwvkQ==
=1HVr
-----END PGP SIGNATURE-----

--aYdj4KKHQJTEiuns--

