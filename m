Return-Path: <linux-aspeed+bounces-429-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54495E77188
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 17:52:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV8Q05zwyz30Th;
	Sat, 11 Jan 2025 04:52:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736531576;
	cv=none; b=myvgVwmASmn44H3BGxzYS+lNUyIZ7JmPtfvPp4vjX6rfbPjUdmrlFFL0KxhPr8wbEwsomm2p5vyMPjzl8EPwtQaqpbDpcAH2asX/EnWJaT6V8Ia5SMn2pRNJZIm1rhK/pXA0+BXpIgnN4AczPCGItQU34nTDFtGcLY1sfdGg4R/efHn5MAHeq+/bBzuluNHabeFC+lwtft5gN8Kw3J1Jc60/PL3lLcryIS+PvEntxSI63qJUX7ZaBXPAYuonoR1Te+dyjFn8cxMtBkjW6U7rBAgl9C623Ktv3rKkA2toQEp4fYAY7//5vqIdSUEmRljJb3HTwpSdSGbVvTBdYE3a4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736531576; c=relaxed/relaxed;
	bh=cciXjXaJHFEUNA5037+UId8KeSaNCbPgvSHybbYxbUk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j+Pbb+g538JCgZGibjlsDh0H1SeV7SbWz1A9KWwaGTV6czTYnUfvsKvnlmvKJQPvHHxTPZwRsq5ttQsRqGPL2AFVpn5bwb++8EFU6qLIQ3HD8K8X9CmnX7hrUzdMihOQExj2Sw+m767/TWqMkvunBVRZlsBRFNLHBWlsgW9zNkfCwtJ3pgY3PKG5RoxpSnTqldJa2zKOgQuz8DBDFPTmtrImdJxNViaoNQYhuIP5HP6h4cDog3SocrmcYyTFAO6h2hl2kxru8P8bVlGvc/t1YZE4Sa09T59weOOHK6zVWUGTb3v+KNmds0oXp0qE3fdt8+PpKHGewLqnN+EVwrzrgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hJ9bZT9t; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hJ9bZT9t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV8Pz4NC3z2yk3;
	Sat, 11 Jan 2025 04:52:55 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 340365C5115;
	Fri, 10 Jan 2025 17:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAD3C4CED6;
	Fri, 10 Jan 2025 17:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736531571;
	bh=SFidNPCEzzdhqDMHpT0ZBS1qDa7/zS3vqT1bcr65LnE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hJ9bZT9tczqg36KU4u6eeqTb1soNKUi4jFKxz0hhNEszVpwr9k9zEWBeBj7Mv9EED
	 WkgOWH7Sb6St0SIyCxaPqkDmrETi94j9+2Ii3LVSi50No2Tk9CRK/+4lP24fibBK+C
	 4Xi60yQOKPXklaK9wG0OHqz+GL9IWOfAfGvWL/mx95640061C2vJ9JNQWZHjp8e1SJ
	 tk2Au3qdBiIO8/j+Vhg+Mn2ElcAgfycx4KvLzJfuqwmIlZUJCgL8rgJG0ixc4veeVD
	 5jxTUrrLRJ50EQtM2lNw2rOhAolT6/GzU0UpbvdfSKClNKd26SMe3dm35W60OL39tW
	 +EFtowt4redjg==
From: Mark Brown <broonie@kernel.org>
To: Sanjay R Mehta <sanju.mehta@amd.com>, Han Xu <han.xu@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Raju Rangoju <Raju.Rangoju@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <stlin2@winbond.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-mtd@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable+noautosel@kernel.org
In-Reply-To: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com>
References: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com>
Subject: Re: (subset) [PATCH v3 00/27] spi-nand/spi-mem DTR support
Message-Id: <173653156367.340868.12224888423783635897.b4-ty@kernel.org>
Date: Fri, 10 Jan 2025 17:52:43 +0000
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 10 Jan 2025 15:45:02 +0100, Miquel Raynal wrote:
> Here is a (big) series supposed to bring DTR support in SPI-NAND.
> 
> I could have split this into two but I eventually preferred showing the
> big picture. Once v1 will be over, I can make it two. However when we'll
> discuss merging, we'll have to share an immutable tag among the two
> subsystems.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[20/27] spi: spi-mem: Estimate the time taken by operations
        commit: 226d6cb3cb799aae46d0dd19a521133997d9db11

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


