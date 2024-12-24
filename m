Return-Path: <linux-aspeed+bounces-285-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DCAE77188
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Dec 2024 17:07:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YHhCY6h2Zz2xYs;
	Wed, 25 Dec 2024 04:07:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.183.194
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735060057;
	cv=none; b=bTjFOmRm20OsuOH+n8x1I52GZ72tTOzV/AZWJkWfPSVciSmw5fDsq4QbfEX6LxBDmf+Cv7Uo4wm6BKMj1Tp8s6wOvU1X+buplqNtEhWBJEl2ccQaJq+C2hmwdfs4kpM1HpEkD9vAyEVu/0ZT0iUl6+ezy2P5XBFQg24QnSvn4u87ygyiPKD/FgH71Y26C6dFgwVd4vCezehJEgfabo/uKecTwhuwfC+Txs+7u4nNsqWndTFTFBiUSa2g0VVMvKnG71bvMdwMfHjfaIPSAHzJqULUbJWzwY6+ZS2FNBULup6lS1PIZWqk3xqfk2ddi5rdk9gUnzxER6IAXOngk0Hq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735060057; c=relaxed/relaxed;
	bh=XOM20MlWPFKmxw5KkK0hLotjF6wgAi7LSWkedeOSHRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KdtAnKAHjoHEEMirFekF+2m4nEoWP3CiHBaUXnjzZz7yowoqQbc7YxtT4kUGpTBj3CEZNsyp4MYAMyVw6QoxnMhKzeqbNonIk0e/ejquPcgEd0CdRtYL8o/r/DJ0VNgLmXyPkrSdIIsbzAF3+XmLUiMXXUStX5tTG4fxujwZ/RPpwh+W3n9z2DZC2mNDHateUDgctRKmWCOJYezF+y01uPb1U/7DqgKeasgjSSA02KhHFW/YK8kZ72sVx2sxTAigSblZjlOHdJYa+lPC80MQl3qIBwuTkmG1+gdxxKHwyuyYEs0hkeTt/J/J4TYJAZtMLkvq+QX9qB54qUNwaCzp+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=WEqy7wuq; dkim-atps=neutral; spf=pass (client-ip=217.70.183.194; helo=relay2-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=WEqy7wuq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.183.194; helo=relay2-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Wed, 25 Dec 2024 04:07:35 AEDT
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YHhCW372jz2xFn;
	Wed, 25 Dec 2024 04:07:35 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 855D640005;
	Tue, 24 Dec 2024 17:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735060048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOM20MlWPFKmxw5KkK0hLotjF6wgAi7LSWkedeOSHRU=;
	b=WEqy7wuq6RwMz+PAePa2DV0UWxNA0CjDFyyhPIa1ok9AYXUxtSOC5LaKKkX2kgjgZDZJff
	HE3uP6Iw/75aAKHbYo99Erji2n5j6ZaGIofgAqWasIkveKsnzJRP/DAYDmELBUwX5t2yRi
	BlSzXZrvixFO58BqCjd479+atWiy6dSink1AV0QWhBJZcoOp8O3VeO5gWwONxPYoxO3J1J
	Zw+6/wxJMELASkiOjTs1mg/wVULXVib/3zHvq1BEVhlXwbEb7bYdEdaMX2d5kiTlhQqM95
	FKq3UjonETDWNu0XJDW+rogVeCwX+eJW33u5+C5XScMnSSHgQX+cK3w8YCNUUQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Dec 2024 18:05:59 +0100
Subject: [PATCH v2 14/27] spi: spi-sn-f-ospi: Support per spi-mem operation
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
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-14-ad218dbc406f@bootlin.com>
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

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-sn-f-ospi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index adac645732fedfe6e33a5a0979ba43d5d203bfce..6ad4b729897e3909a5e22b33aa47b812219a6ee5 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -335,7 +335,6 @@ static void f_ospi_config_indir_protocol(struct f_ospi *ospi,
 static int f_ospi_indir_prepare_op(struct f_ospi *ospi, struct spi_mem *mem,
 				   const struct spi_mem_op *op)
 {
-	struct spi_device *spi = mem->spi;
 	u32 irq_stat_en;
 	int ret;
 
@@ -343,7 +342,7 @@ static int f_ospi_indir_prepare_op(struct f_ospi *ospi, struct spi_mem *mem,
 	if (ret)
 		return ret;
 
-	f_ospi_config_clk(ospi, spi->max_speed_hz);
+	f_ospi_config_clk(ospi, op->max_freq);
 
 	f_ospi_config_indir_protocol(ospi, mem, op);
 
@@ -577,6 +576,10 @@ static const struct spi_controller_mem_ops f_ospi_mem_ops = {
 	.exec_op = f_ospi_exec_op,
 };
 
+static const struct spi_controller_mem_caps f_ospi_mem_caps = {
+	.per_op_freq = true,
+};
+
 static int f_ospi_init(struct f_ospi *ospi)
 {
 	int ret;
@@ -614,6 +617,7 @@ static int f_ospi_probe(struct platform_device *pdev)
 		| SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL
 		| SPI_MODE_0 | SPI_MODE_1 | SPI_LSB_FIRST;
 	ctlr->mem_ops = &f_ospi_mem_ops;
+	ctlr->mem_caps = &f_ospi_mem_caps;
 	ctlr->bus_num = -1;
 	of_property_read_u32(dev->of_node, "num-cs", &num_cs);
 	if (num_cs > OSPI_NUM_CS) {

-- 
2.47.0


