Return-Path: <linux-aspeed+bounces-299-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D12E77188
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Dec 2024 17:23:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YHhZH3PvJz3028;
	Wed, 25 Dec 2024 04:23:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.178.240
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735061031;
	cv=none; b=igRzT/mwWVayr1X/1TykbN2Sp5Qlf3NuQjvivzVB20VGo//nXZqTVHMClFAB9fELfbiPx/Kvn9c8sv0safiVraQk3V6xbs1h7wo0e9A5G2eVY1IEwX5idKYu35ro4X1uPIcTosxUe7GSuBj//Bjs1Oh0VizjGNdy+BSHZUG+uSGo4cA8RWhWXWHEZFlp3kvgDnWUhlg4C9IOG82hyqsJg04gACNsS7scKeGfmR2N9KXJs5WrmyUA5NPpCHUkpMT+TQiwQCRTz6dgzCdIKfYe4jzczJobpoa/OTpSvbAnJu6mOwgc9/yJu19vZwKQ4rxZw+KyyV/0LHdzoPIRetDwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735061031; c=relaxed/relaxed;
	bh=y8cSrYQE/5lZoSPtcr0B2aeBjkjg2ZNQ2fjZw3v1pDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YlenbGmrSvcO/CoE9z2cPh1FpKMbsDj/XOfclafFylJ58MzzYnuTWFuPxoVBKkoFv0Xdan+WmZK24OovAoxE3GlM9mNP+HV5CukbH/kYhGIAeg1XP0hEd9sKp/53/yZc1R/+YlCwC2T9Vk+R01VJDv6VmmFlcked6SJ2/m5UZrQK3EULlA93/HOjEnoM2QeM2qzNmhH/SRXMGmRFfIp099TAlHWcGvm2kNk6TYXNm8tBHgz3JvpGxRWw/YHbQK6rwreltCfFdcFsILs5M2GzsvLXia1grriP5viinNkhE6tEjh8HcwiA8pPeCJP2mn7vkBgk55R/hGRbtXvYlS1biw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=G3fM9Jyx; dkim-atps=neutral; spf=pass (client-ip=217.70.178.240; helo=mslow1.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=G3fM9Jyx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.178.240; helo=mslow1.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1025 seconds by postgrey-1.37 at boromir; Wed, 25 Dec 2024 04:23:49 AEDT
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YHhZF3Yd3z2xfb;
	Wed, 25 Dec 2024 04:23:47 +1100 (AEDT)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 53C78C0C85;
	Tue, 24 Dec 2024 17:07:11 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 95E6A40007;
	Tue, 24 Dec 2024 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735060024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8cSrYQE/5lZoSPtcr0B2aeBjkjg2ZNQ2fjZw3v1pDQ=;
	b=G3fM9Jyx/pqZ4/g8+kyndnztJrbRdwlNeu5u3WX1Q7ABiRMZ/8p3TrZjaWql7NOeWhkeCl
	oJt9/493oqq4qDT1hSx6ybU7j0IFmNe3C0tIjfjNvXsgSPHWCLP8nduwUazFjV6REE97E+
	Ef5ozPMYpT0Xq+mumREXazIfa/Q3AwNYMSZEUswSkbBM1JrLzSvGGQo6LcaR8Qn2BXRcvd
	UixYfZiHXx4RbhUp+seIe9imfXkztxdqx5oSxHKtz2C30mGNFL+5iv5Po8s8UVAVvvJUa/
	UusiiucQRl7xwwUYDE/MAxtQDqTsf45LGBneTQvx5JDX8CMzaP99eS8+KJ/bBQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Dec 2024 18:05:54 +0100
Subject: [PATCH v2 09/27] spi: microchip-core-qspi: Support per spi-mem
 operation frequency switches
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
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-9-ad218dbc406f@bootlin.com>
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

This controller however performed a frequency check, which is also
observed during the ->check_op() phase.

The per-operation frequency capability is thus advertised to the spi-mem
core.

Cc: Conor Dooley <conor.dooley@microchip.com>
Cc: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-microchip-core-qspi.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index ad2b5ffa6153433490f09bdd4c362273a0218432..fa828fcaaef2d4b44c21e08c09e6afbb7ba3de3d 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -265,7 +265,8 @@ static irqreturn_t mchp_coreqspi_isr(int irq, void *dev_id)
 	return ret;
 }
 
-static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_device *spi)
+static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_device *spi,
+				     const struct spi_mem_op *op)
 {
 	unsigned long clk_hz;
 	u32 control, baud_rate_val = 0;
@@ -274,11 +275,11 @@ static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_devi
 	if (!clk_hz)
 		return -EINVAL;
 
-	baud_rate_val = DIV_ROUND_UP(clk_hz, 2 * spi->max_speed_hz);
+	baud_rate_val = DIV_ROUND_UP(clk_hz, 2 * op->max_freq);
 	if (baud_rate_val > MAX_DIVIDER || baud_rate_val < MIN_DIVIDER) {
 		dev_err(&spi->dev,
 			"could not configure the clock for spi clock %d Hz & system clock %ld Hz\n",
-			spi->max_speed_hz, clk_hz);
+			op->max_freq, clk_hz);
 		return -EINVAL;
 	}
 
@@ -399,7 +400,7 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 	if (err)
 		goto error;
 
-	err = mchp_coreqspi_setup_clock(qspi, mem->spi);
+	err = mchp_coreqspi_setup_clock(qspi, mem->spi, op);
 	if (err)
 		goto error;
 
@@ -457,6 +458,10 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 
 static bool mchp_coreqspi_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
+	struct mchp_coreqspi *qspi = spi_controller_get_devdata(mem->spi->controller);
+	unsigned long clk_hz;
+	u32 baud_rate_val;
+
 	if (!spi_mem_default_supports_op(mem, op))
 		return false;
 
@@ -479,6 +484,14 @@ static bool mchp_coreqspi_supports_op(struct spi_mem *mem, const struct spi_mem_
 			return false;
 	}
 
+	clk_hz = clk_get_rate(qspi->clk);
+	if (!clk_hz)
+		return false;
+
+	baud_rate_val = DIV_ROUND_UP(clk_hz, 2 * op->max_freq);
+	if (baud_rate_val > MAX_DIVIDER || baud_rate_val < MIN_DIVIDER)
+		return false;
+
 	return true;
 }
 
@@ -498,6 +511,10 @@ static const struct spi_controller_mem_ops mchp_coreqspi_mem_ops = {
 	.exec_op = mchp_coreqspi_exec_op,
 };
 
+static const struct spi_controller_mem_caps mchp_coreqspi_mem_caps = {
+	.per_op_freq = true,
+};
+
 static int mchp_coreqspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -540,6 +557,7 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->mem_ops = &mchp_coreqspi_mem_ops;
+	ctlr->mem_caps = &mchp_coreqspi_mem_caps;
 	ctlr->setup = mchp_coreqspi_setup_op;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 			  SPI_TX_DUAL | SPI_TX_QUAD;

-- 
2.47.0


