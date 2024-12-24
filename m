Return-Path: <linux-aspeed+bounces-301-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5B0E77188
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Dec 2024 17:26:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YHhcq5NKLz304l;
	Wed, 25 Dec 2024 04:26:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.178.240
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735061163;
	cv=none; b=UjRcguEtXcY8qTCjU5bChKxwi3CvKR7YNUW+RlIh9Oz1SdPSgnk7v5KojOU81opO1VCEQB3pUJeRyVsE0dR37Al2CE56MsZ3dRy6s7w1QoBKhdtDbUorjxk5U68geEkp3Dx4qbsdYhsr33xdt61w+HcFP4AdKKq+B9At3e42Il40UNlsIa9am9AS/FnZAeZsWGTUadmKLA0COnrYr9kmZK774E6tykwS/K3kzH8eldsKe/R+Hdb+//bEpR7J78ntMCvYYefBxMH9qx41Bw2iR8e58G5HcyOoEGRtfaY+EnNOj3+63Beew0g7tZRW9U6Y3ObzWIkP+eSQocHzhr6a2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735061163; c=relaxed/relaxed;
	bh=dHPofq5XZq7az/ZH3pSbnokgc8b9g3SIFoGkVNSo6iM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LJ71zkojcf53audleANbklPLnffPwUPWhVp4yLL1bqB0X08T1djLKqr5JKsh+q62EfjqHTFlB9AggMXA+Ro/WNYSaKq3MIza6/v+YFCGr+aR+QzN0COC8jcA/XYDTLSNmatfqnUdOkOolNZ0tSYufIIgT3nO+vk3bizNYBOhUhXEm70vas8hqrlhi21B5QczZsJWkZ7Frs/vpLIUVy32U45TBlZkXPif3YEdsee62qGEg5BFH2NNnNjDFLG8+mvhz4s3t4P8ib0Pe/I1We4CH60XlFRltJuaPVstBPe1uI4NonWCxwgU/ebhFEcPg5WdjIO2eiDWsLO108V0+ZXT3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=dCoBmN1Z; dkim-atps=neutral; spf=pass (client-ip=217.70.178.240; helo=mslow1.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=dCoBmN1Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.178.240; helo=mslow1.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YHhcp0GQzz302W;
	Wed, 25 Dec 2024 04:26:01 +1100 (AEDT)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 91BFEC0B24;
	Tue, 24 Dec 2024 17:06:49 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C5BD740007;
	Tue, 24 Dec 2024 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735060002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHPofq5XZq7az/ZH3pSbnokgc8b9g3SIFoGkVNSo6iM=;
	b=dCoBmN1Zsbg4xR1kd5uwqWvdqw5NRNRqTHsjVIAxvOPpWGjePVJdoiMUap/IIyk1IZgVED
	bpU8xzpiemf1TCGirkGDqJbA2yfArVvUS0fkMLO4/cOBw4bsSCH33Eel9/vHSHFIPYU3Fx
	Pskt2ss8OSIR41cfnMJ6Qii9rwsehhu7SEliVI5KQycD9YnPhxf1gvwikQPrV6zly2XPcm
	hmWPX0JtoOYwWlBEH791HIfeXbCLgJ661nUu0/BjwTV6ohz1wjw6bLRgUiZvVZax/J7dZK
	rd9ljXu6CJ1UiZTTk1CDbGn8Xb/aP4eRUm3FzlYllBkt7ne3RGqccrBfk7c9vw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Dec 2024 18:05:49 +0100
Subject: [PATCH v2 04/27] spi: amd: Drop redundant check
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
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-4-ad218dbc406f@bootlin.com>
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


