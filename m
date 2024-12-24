Return-Path: <linux-aspeed+bounces-304-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0605EE77188
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Dec 2024 17:26:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YHhds4GVHz302c;
	Wed, 25 Dec 2024 04:26:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.178.240
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735061217;
	cv=none; b=W3I9dBRdjFdbYEAbS0RROQWtDt8q2H449ticai1wChEH87xTBBHGuOd/NFwMap8GDnisDlzOm81EHuNuyr0/xNf/5V1tga07CEIBYo/0+xkXdeMAdIylI+ZzDPW7kY5UNkcCi6i9PgtloRNDoFBZWw+Ocl7qRwF37CEzL6CZsM0DFBpWndaRW3XbOBWs9BSelH+Get4ufDpP0ttvKH/Dr+pY4wIWlvphjAhnLuoy5XVfzK/mzcVVC99LjeoKawExuxSaZyHshx8BxqlrSJqq7yy+fYcLHIPiUzw3PFwOwP9ovtw5qOqjdfzT+kR0Wio6+SgAycBGsQdFmcctNbtCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735061217; c=relaxed/relaxed;
	bh=fr6JNepud+tKAg7jOJTxXgDVqn2KcjPpqjlaMsDjliI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NzofMHRkEwniYqZG8lRmBZbXc/nonPNfxnX1ueMzvBCcL3q4aIEBnm1PZJnmF1JrC/89Zwez6Ox0hxV3OBVrjxG8DONNDKxNSB+XW+MlDyhdlXLjUZRP2pubipBOTKQxOtVgG/AClB1zi09w8tGUe6GwIER1+m8xqmWZYYXOCfKA5cOQwrPiuihisM8noCEacfKoU2AcPsWlEV7T5PIZavvT2YhLAzP06blRGkTjldKCce9Qoo+V596AHmXmEO5Pj7Z12Fgn8L7Ez0rFYnnECLaHyOHuGZrCgoV6XJ0KilCt4pkYALo11a+1jrvVIGUKarqf5AVCOXpDRzlN0lv8tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=CSkCFlGk; dkim-atps=neutral; spf=pass (client-ip=217.70.178.240; helo=mslow1.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=CSkCFlGk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.178.240; helo=mslow1.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YHhdq6PZdz3055;
	Wed, 25 Dec 2024 04:26:55 +1100 (AEDT)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 7B20CC0F20;
	Tue, 24 Dec 2024 17:07:25 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BBA440003;
	Tue, 24 Dec 2024 17:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735060038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fr6JNepud+tKAg7jOJTxXgDVqn2KcjPpqjlaMsDjliI=;
	b=CSkCFlGkm/AGyyqDWBoKC7f7WIvlY1M7GORyxbGUIKrt6+6czKidzsUbaL50gf93p9ddfS
	ZDqqJzVHIrU+0eS3KnqkFg1TLgu61zH9wAj7SXssYuQjZdV+Xz6PZEGNfDw37RqTWIbQ8x
	vSLtuog6dZuxiOd4/sEdwboRPu4qNi/P4c1X9KNUNcIBlnnrmXbI53nY8yVPe3N6oJ1srV
	BkxymrrotzeCoj0I7nF4KAX/dPmTd0mJ/P0jAz8/YNMUF2fhKS26pn+Cfn8tqMLznGUk3D
	sMdnGKR2Mf7E4llNfEReKSM6aKdGKK8Sa9GmbNuls5gBRTL8o7veelGjWtCVYw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Dec 2024 18:05:57 +0100
Subject: [PATCH v2 12/27] spi: nxp-fspi: Support per spi-mem operation
 frequency switches
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
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-12-ad218dbc406f@bootlin.com>
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

Every ->exec_op() call correctly configures the spi bus speed to the
maximum allowed frequency for the memory using the constant spi default
parameter. Since we can now have per-operation constraints, let's use
the value that comes from the spi-mem operation structure instead. In
case there is no specific limitation for this operation, the default spi
device value will be given anyway.

The per-operation frequency capability is thus advertised to the spi-mem
core.

Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-nxp-fspi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 1161b9e5a4dce633718e22022410b5e7435bb51c..bad6b30bab0ecb90d0aaf603b6de5bc834d19de6 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -705,9 +705,10 @@ static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
  * Value for rest of the CS FLSHxxCR0 register would be zero.
  *
  */
-static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi)
+static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
+				const struct spi_mem_op *op)
 {
-	unsigned long rate = spi->max_speed_hz;
+	unsigned long rate = op->max_freq;
 	int ret;
 	uint64_t size_kb;
 
@@ -931,7 +932,7 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 				   FSPI_STS0_ARB_IDLE, 1, POLL_TOUT, true);
 	WARN_ON(err);
 
-	nxp_fspi_select_mem(f, mem->spi);
+	nxp_fspi_select_mem(f, mem->spi, op);
 
 	nxp_fspi_prepare_lut(f, op);
 	/*
@@ -1149,6 +1150,10 @@ static const struct spi_controller_mem_ops nxp_fspi_mem_ops = {
 	.get_name = nxp_fspi_get_name,
 };
 
+static const struct spi_controller_mem_caps nxp_fspi_mem_caps = {
+	.per_op_freq = true,
+};
+
 static int nxp_fspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -1246,6 +1251,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
 	ctlr->mem_ops = &nxp_fspi_mem_ops;
+	ctlr->mem_caps = &nxp_fspi_mem_caps;
 
 	nxp_fspi_default_setup(f);
 

-- 
2.47.0


