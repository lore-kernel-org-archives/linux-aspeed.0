Return-Path: <linux-aspeed+bounces-396-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0251E77188
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 14:45:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4Fk202zz3cXd;
	Sat, 11 Jan 2025 01:45:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.183.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736520330;
	cv=none; b=VcbiPcy1JyBmXpx5ZX0Qk2ffpRIoaKNRS1RLwQSyuUltp7CtLOZo2ZFbQK7mZFQqUNwAa4QoOfYKylvpB4obIQZR1HImrYuy/PFyk0ny1W7au6qOQZrPrwaebhXt3RJaoRVBQYLG193ZiId0CyFbV9Z4qaXnVuQTDWH2H6K0b2KdvjhcyrInYBRHynHJPEuqApPud0oVKdElAtZTKTrm3bEkdyMY99zQmOLIn1q0SNwrd5hhvUDgo21oByoAdEiW590FFnqGBiUjFnwBjRkz0wiajA223TxTW2O0hlNUVoVfpzdyWe+cteKw/S2fGSpa4EvbYwHEFrx+IlZ/BTk1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736520330; c=relaxed/relaxed;
	bh=dHPofq5XZq7az/ZH3pSbnokgc8b9g3SIFoGkVNSo6iM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jx2FJIc6T2binPFu/9wruuFUNiZLp77EnqJktXSCGF0yu3Glw96h4jX2s+w6a4u0PbMo6xiwC2QuIFEKnMPUQ7Xzk2jbhwnAfmX9uCZaMamlUcfaC/nPLAv/XieIDC1AHqh2mgktQdRyw5t6J72x6T23FEyklsnyCIESebF9OtIR0PJ+KMyo3tskJgVFU9Ph/C1AmvaEZCXPmjwYYcfnn1D6lXBu6sByBB44TMvY98ma+4424LpZ7Qj9zfBduTmHVmRFkC/E7e4K3y2uDwHfEQi8L/mC6S5JCai0OE4ucmHas/ZCqbPx8fE7Z5LFLd/PgoeXRNWu7ICmGLTU9OByEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=QaykDlSw; dkim-atps=neutral; spf=pass (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=QaykDlSw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV4Fh5lHgz3cXQ;
	Sat, 11 Jan 2025 01:45:28 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54FB5FF809;
	Fri, 10 Jan 2025 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHPofq5XZq7az/ZH3pSbnokgc8b9g3SIFoGkVNSo6iM=;
	b=QaykDlSwtQxbTXSFx/WQbVyeesPYBW12EuQ2e83119ikzKXwERkm59oGK8cQtYV6jA7uyt
	nr0ZCtAn6FdPe6RrgAHZUYM5u6MoLPdP9IIAGGaJSQAmLzW3vc+a8hwSFBOZwUzvG9d5N1
	RjjVie2+9GL+I2Tptx7o5sBeHjizza20bxGbLeeGet2CiAEMHRZkLBeEbDnOHiRhGwYr5Y
	ItlINRNMCLBiOuXDN1+EGarnTO9PBFL6oX9U+iDjUsW7jHNbW8kimAtb9fed96Wwmrt6BB
	EBm+jPCNzi6JMVBbchseGwpaeMN7nYjD9MwmTcRdl7W6F45psfhShwxgJ9a7uA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:06 +0100
Subject: [PATCH v3 04/27] spi: amd: Drop redundant check
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
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-4-7ab4bd56cf6e@bootlin.com>
References: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com>
In-Reply-To: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com>
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

Both spi and spi-mem cores already take care of checking the minimum and
maximum speed for transfers depending on the controller
capabilities. There is no reason to repeat this check in controller
drivers.

Once this possible error condition removed from the function, it makes
no longer sense to return an int.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-amd.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 485ae1e382e3eb8f4d72ebb0fb15c51b9a118d3b..fbe795bbcf507abcbbd973b226b5db0de1584898 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -298,19 +298,16 @@ static const struct amd_spi_freq amd_spi_freq[] = {
 	{ AMD_SPI_MIN_HZ,   F_800KHz,         0},
 };
 
-static int amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
+static void amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
 {
 	unsigned int i, spd7_val, alt_spd;
 
-	if (speed_hz < AMD_SPI_MIN_HZ)
-		return -EINVAL;
-
 	for (i = 0; i < ARRAY_SIZE(amd_spi_freq); i++)
 		if (speed_hz >= amd_spi_freq[i].speed_hz)
 			break;
 
 	if (amd_spi->speed_hz == amd_spi_freq[i].speed_hz)
-		return 0;
+		return;
 
 	amd_spi->speed_hz = amd_spi_freq[i].speed_hz;
 
@@ -329,8 +326,6 @@ static int amd_set_spi_freq(struct amd_spi *amd_spi, u32 speed_hz)
 		amd_spi_setclear_reg32(amd_spi, AMD_SPI_SPEED_REG, spd7_val,
 				       AMD_SPI_SPD7_MASK);
 	}
-
-	return 0;
 }
 
 static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
@@ -679,9 +674,7 @@ static int amd_spi_exec_mem_op(struct spi_mem *mem,
 
 	amd_spi = spi_controller_get_devdata(mem->spi->controller);
 
-	ret = amd_set_spi_freq(amd_spi, op->max_freq);
-	if (ret)
-		return ret;
+	amd_set_spi_freq(amd_spi, op->max_freq);
 
 	if (amd_spi->version == AMD_SPI_V2)
 		amd_set_spi_addr_mode(amd_spi, op);

-- 
2.47.0


