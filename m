Return-Path: <linux-aspeed+bounces-401-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D70E77188
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 14:45:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4Fw0dCmz3cXk;
	Sat, 11 Jan 2025 01:45:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.183.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736520340;
	cv=none; b=hM5etmTjJzjx0/ED+eynEv5mSAss97oLsarOsrC/sCOQK430tZfIywhW2lnlUhHill3wlcJ4FS5AZYfsmJM2e4Zdn2i4XaQHaFlZpEY34HDUhC42qqgUAy2CekwrbFpb+K9Hu5ugmUwirEvuJ21j7ybIvOM9jYqb5oX0K9mvfyBIjL2gTZtIUQ6mvkKvvBntLU0ojOOZ1XQjb5C6jVNBh4oyRp9xwI2LgCPNWTVvYdB2di03/bZEjqwB9PBDMOxaUBKxMtYP/wsc3tsgZTgnvlkQDw+nJ9IBGwZwbz8J6e/es9u2y1GtndbyIjF+VmwOuIExQm8KBm9HPw35YBoGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736520340; c=relaxed/relaxed;
	bh=y8cSrYQE/5lZoSPtcr0B2aeBjkjg2ZNQ2fjZw3v1pDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZ9Hy4TBYvyoau81psrdoA8cx69H94Up9P9B38wvL5Uq5SugzuxLxPNBF2sIRbfXuP/v+M5ii8I+sG89A1CFKurNoGo8KlmhQNe/ceWLDDrsHQdY4ddFSy/I6iz9GZqWbbTgq3/4L0/s9hDd3V8gr2a7IijXgLR60qSFtl4y+m/cCWeSxA0Dsto6J8ZmWRxGMXl4Cs59QACSCYI3fqR+QGjUQol8XidkF/iEHkOkaixvChKMIH52PJvUbKeu8hCqbh7dQpeV7rVnobZodks8++Os8oCaRKWAsV4TpxCVHeKtC2uNu+t0v3EQq6dpkFRP4rC4NvfuLmZ6E7kPMJsZpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=QUn2HxYY; dkim-atps=neutral; spf=pass (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=QUn2HxYY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV4Ft2S7Mz3cXq;
	Sat, 11 Jan 2025 01:45:38 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0B53FF80E;
	Fri, 10 Jan 2025 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8cSrYQE/5lZoSPtcr0B2aeBjkjg2ZNQ2fjZw3v1pDQ=;
	b=QUn2HxYYpXHzBUUQGFzw5CGFjm1mZXXTWJ41aFPg8sbXlUkse+ZsntwleUTKfbNS5EyysD
	juZhCK5l5FeDs7HRV23fT3CvZGeuXcdEKB7UgbLidckGhKI74rDX83gVklykbh3ArOXfUl
	saItcUGf5z3LqB4JRAwu5Cr0zWk0evBhDTKp/jtNDzx2ZEEzv//c+htDYI1x/ZX2eA5PNC
	RGsXz8QgcMZM2YLZ9Sm4pe9p1LsrniCqSGS/99f8j/CtQqRMVe+WDwgoF833kEMKnE06/c
	GkgTU07BB+ytJ1XpuckVJH59o34lIM6wWOP4bjBeGn1MpYHrc4StKbTkbZbLbg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:11 +0100
Subject: [PATCH v3 09/27] spi: microchip-core-qspi: Support per spi-mem
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
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-9-7ab4bd56cf6e@bootlin.com>
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


