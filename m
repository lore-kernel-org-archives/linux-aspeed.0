Return-Path: <linux-aspeed+bounces-399-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69EBE7719C
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 14:45:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4Fr2bHgz3cYF;
	Sat, 11 Jan 2025 01:45:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4b98:dc4:8::229"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736520336;
	cv=none; b=WbMtlBS9mBtwhPhQf1yHBQn61dhTLi4/QvoVaQ28m8YCceG7+tS+9JlEbKTERBBGYocY6N6phhzsCAwSTOSLZ+0mVle29MuNH2hXhmO8KWvAukeBYoW1t3Hu0uLS3gog8/bmVBa7w74M2IKCkPmUCv4pIhdWbHVBXPfT8ZF4VZdyfnGx2X461/XOdXvIeGzxnDsQ+KxL9b+KnvpBRuyrtzebO6Nm5DrSCX9l/ozw01FhFwxVjGjBvJV+bBEdEDHvZj681PwtqlzGeVbTBK3hjAQInY1tG35APIymRm7rvHv5CM8XNs7Qov8sc0+Alkmmm5iZZY8x1Fd7MT136eodDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736520336; c=relaxed/relaxed;
	bh=BZ7N9DxFJs+ypWx4tpIWo4afnbo0gO3jjiMo2DbsJnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=beC5zOpz4BfdRRPhY1RS0dkUGAPJqVwholYmhNqTLBYmW/IG2r5Tq3zuPfoZHvNUOArDIEMsRFNLdWCA2/bqXEbemSAqZOCPgeZG4dfBptq1s3eN/DE5ywDaFyZaKjNwcYPjExHMBpgE5KQD1l2K+YNnYtJAT/i07hYfRnlqA42QjCCmz79jOQ3dS/QppVU6+u40spLaZXyQtZQgPz9dtZDT94jlslu88Lp7GL+yUVPLcDZ1+JPs7susVxvT9yOnhF2STdsAA44lZClkuX2Ru3a3fb8tgWQzaZ0Roko6UJJoJ3TkjkbARHAH9ZTx+DkxSbh+XMSV0XjzsixrKJJhLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=Ep+W3Rww; dkim-atps=neutral; spf=pass (client-ip=2001:4b98:dc4:8::229; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=Ep+W3Rww;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=2001:4b98:dc4:8::229; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV4Fp426lz3cXk;
	Sat, 11 Jan 2025 01:45:34 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1317AFF807;
	Fri, 10 Jan 2025 14:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZ7N9DxFJs+ypWx4tpIWo4afnbo0gO3jjiMo2DbsJnA=;
	b=Ep+W3RwwhmDUkoOO8gMAhVAvq+JxfEHNNEhlItnkm6ggFf2cddQXzxap3MgR9mXKCDscmq
	m/wfrLsZs+FKMbbg3tKL/2WRy+/PqYCmxdj31+BFkJ6U5x977eYrMYR4dWMjtIP/3LrZOr
	+9YwOhVFPYowtfyY29H0gM+j+73hpW4Om/PtB2G7ZEY2XAWCJZ8fN34jETT6A7RWvtNVug
	+95UyUbdJXRSJsOX/bPjB6A+lRpnt8Hsb4V24g0Id8tv5VrIKh/LnBd4/KNLdRLwc3FzxP
	0132EdjtSokHP0suQe2WqJ8kvsWTOT3s3qDIdFB6l5xjeBP3BxhjdUWbwB3+gg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:09 +0100
Subject: [PATCH v3 07/27] spi: dw: Support per spi-mem operation frequency
 switches
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
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-7-7ab4bd56cf6e@bootlin.com>
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

The per-operation frequency capability is thus advertised to the spi-mem
core.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-dw-core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 431788dd848cea1d854affe0d1fb971f680824a1..3d49b1dbaed4d491c0df659c061582e71f2c514d 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -677,7 +677,7 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	 * operation. Transmit-only mode is suitable for the rest of them.
 	 */
 	cfg.dfs = 8;
-	cfg.freq = clamp(mem->spi->max_speed_hz, 0U, dws->max_mem_freq);
+	cfg.freq = clamp(op->max_freq, 0U, dws->max_mem_freq);
 	if (op->data.dir == SPI_MEM_DATA_IN) {
 		cfg.tmode = DW_SPI_CTRLR0_TMOD_EPROMREAD;
 		cfg.ndf = op->data.nbytes;
@@ -894,6 +894,10 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
 		dw_writel(dws, DW_SPI_CS_OVERRIDE, 0xF);
 }
 
+static const struct spi_controller_mem_caps dw_spi_mem_caps = {
+	.per_op_freq = true,
+};
+
 int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 {
 	struct spi_controller *host;
@@ -941,8 +945,10 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		host->set_cs = dw_spi_set_cs;
 	host->transfer_one = dw_spi_transfer_one;
 	host->handle_err = dw_spi_handle_err;
-	if (dws->mem_ops.exec_op)
+	if (dws->mem_ops.exec_op) {
 		host->mem_ops = &dws->mem_ops;
+		host->mem_caps = &dw_spi_mem_caps;
+	}
 	host->max_speed_hz = dws->max_freq;
 	host->flags = SPI_CONTROLLER_GPIO_SS;
 	host->auto_runtime_pm = true;

-- 
2.47.0


