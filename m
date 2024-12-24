Return-Path: <linux-aspeed+bounces-298-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FE8E77188
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Dec 2024 17:08:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YHhDf1pbFz305G;
	Wed, 25 Dec 2024 04:08:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.183.194
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735060114;
	cv=none; b=M0GEV8TqCzVtfxxbucVGTo3PeLDPUGW9+/Tkldtx7ukau3qsAQkX8T8kjzqNFWCWqGMVEmzA4W4s78G0QV8ZWwCDGPJW23XQpjRsKXWku1LnTMrgDheaecNUylrw9drfnme2XBfzBtwkdY7UJ/XNKiNoDPXGAWs9f5vNUkwYlM2SFfXIG1xC61QZ2Z9vRkATx+7Aqa8xQ/2EfLEW6SqiTc256IoGD0EgP6lrG58+bStgiUCscdrzEGrOWL9t7vfUPXWIPKl4HLW7vSXQfMPtWksxrpkC4Xo7QIzbxFXVcvZTq5CWgt+Nr6Gi4NJON6i0GMvgznRKvPrHfAU1xi84bA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735060114; c=relaxed/relaxed;
	bh=st7iZmfts2tp/8JHKFXB7UyuKEKOlhrYdKjKeGEcYRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ly/xhxjJ4pizJC0q9LfuV+rZQgGeE5lQ5vrCkMMC6I337F87JRaKNYPD5P+n35qyXci4c/rFPmuirlcuelXmk3lobQco4/lWkT7H1JhFTjWcS1vowooBqhxXY4PBEM3MjD/MX1nC0hTQJgB17mVMr0eSQMNegQna8BEbtiBMMawQX2q6AKWX2/J5hisCRY8eEH2cllvs/YVzsqIFSumzzGDBHVwdNsmeFCcxsT3i5GmELWLhujb2ypw7PmdYI37kHc7NYRncQI7y4jAyorEMFLcZE1MuhIBr6042TOIB95r3XRKQm4Y81E6kijfSPiEBJBkuX3yoaXKxu5KNdjNGew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=C6PU0+1o; dkim-atps=neutral; spf=pass (client-ip=217.70.183.194; helo=relay2-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=C6PU0+1o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.183.194; helo=relay2-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YHhDb70J3z302D;
	Wed, 25 Dec 2024 04:08:31 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6BD5240004;
	Tue, 24 Dec 2024 17:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735060109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=st7iZmfts2tp/8JHKFXB7UyuKEKOlhrYdKjKeGEcYRI=;
	b=C6PU0+1oRp15Veqp9zxnzsWiEF4EXFnjn/8rqCWVdcYin0pJ2xwfhRPvZRHBNh0jF+5OK2
	ybueriz7GuiSPXhebd+kw8TvM3Np469mC+/RmPtvvOULmkxUcLApE+gZhr0NAeUtYc1HY4
	0bBususlDBpKDw5EHbp5TH5AQ4qGppu4b7AtWUNqdiU3dFi7kevDTJ4tvv5m27FYwj8r5K
	vGW6SjZOKYr9SFdM8I2QDjP1wwpUF1MbDQmQVPfOvQP93eBhPxxV31sh2SCJyt9BRQv6+/
	fCiLuztwNjULwAHbXZVaUw+WenD6DT1nMBqCN5356EYSnmpCgCS4nxil91kYFw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Dec 2024 18:06:12 +0100
Subject: [PATCH v2 27/27] mtd: spinand: winbond: Add support for DTR
 operations
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
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-27-ad218dbc406f@bootlin.com>
References: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
In-Reply-To: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Han Xu <han.xu@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
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
 Raju Rangoju <Raju.Rangoju@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <stlin2@winbond.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-mtd@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com

W25N01JW and W25N02JW support many DTR read modes in single, dual and
quad configurations.

DTR modes however cannot be used at 166MHz, as the bus frequency in
this case must be lowered to 80MHz.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 51972ba0f193c7b27ece0296c1590ddfed0ac813..8394a1b1fb0c125ddb614269069d107463e905a3 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -24,10 +24,15 @@
  */
 
 static SPINAND_OP_VARIANTS(read_cache_dtr_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_DTR_OP(0, 8, NULL, 0, 80 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_DTR_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_DTR_OP(0, 4, NULL, 0, 80 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_DTR_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DTR_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0, 54 * HZ_PER_MHZ));
 

-- 
2.47.0


