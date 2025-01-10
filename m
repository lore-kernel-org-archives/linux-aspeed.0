Return-Path: <linux-aspeed+bounces-400-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8E9E7719D
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 14:45:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4Ft1Xpsz3c7R;
	Sat, 11 Jan 2025 01:45:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4b98:dc4:8::229"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736520338;
	cv=none; b=aOVxOO6ThCpIs+Ow2MP0EahYzhj3gb0ZolExfL0GJJHI/6IYTjITiB+ahMTrg9yJKTcfsUwqdgQ6b4LAoAomI1oXQzJ7yKq1/qUWo8UToQWQavkNdyi6mSzv53OJ0/5ZtOp06SY9IkwBnOiuKKb2twTZUp2JjX4QWPYBG2vd7/2Q7CHxhLMvjVJ+/Oxlamnsa7IYfrm9MwAgzoug58eAOcQocvRY3aN7iW/sXYoI6bmY/M/YwU0IFkDFJlQnxB0v015GZtfQpBotzcemCPsYBt+tZ23ABeq1ecmPy2x3Z1XIF0Bd/ZMFPZiOpHyV34r9HPb+bOuxCyasqdL2NgOe+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736520338; c=relaxed/relaxed;
	bh=JrcFdkL7v8hevVCz++URbVmucpyX6fBOW8nqTnbI9/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oKmBtZdkN3ICTb7HdQgiPj9dnBXyB9XhLjWUDlLOMugJC8hnXUEQwPfTbPribyydEtAP/xebj0dHTt43C7Ra3fL2rzadplSA94h0sfcbqafZEYTDJjt3uEi86O6aWsPoAxPx6WG2oNLO8Zo0bzDydlz3HaCY37UqItVLQsYCrfAxLtTbiL/4zD2qgY8WLAEq9M8ZHQJd9kcm1+aa9wqPUmRFOHKCS7umtNUc/U6Y0MBljzIZCgckt5iZT24la0XgIfgPtgUx7g2RNEMGdCjHa0D2z5bC/BjMm4KRzp6xHqsUuoXoXFMMG1xwItYAo5vdec3R1a9sjAcD2S20MyDKBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=gQIfRcfG; dkim-atps=neutral; spf=pass (client-ip=2001:4b98:dc4:8::229; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=gQIfRcfG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=2001:4b98:dc4:8::229; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV4Fr2pw1z3cXy;
	Sat, 11 Jan 2025 01:45:36 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF20FFF817;
	Fri, 10 Jan 2025 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JrcFdkL7v8hevVCz++URbVmucpyX6fBOW8nqTnbI9/s=;
	b=gQIfRcfGmYYAoyUyZ0m3FuxYEZ2Vhp0yGExEna36qZIVu0OMGDf3EYZj0i1/xdhyZUUBMS
	VGzcm/2MGkihSOmL+wjLfusd6OmVosbXg7TDvLO/D9+1XtbRlvunCI/OZtiAIsQegjQClm
	fR+2U8uPTsx7DZykr/2TkVTTt5jx0gM2zt3h73KX0TIP7GfigvYGWczUp9QQw/cooYoXit
	k+0rbpdIhC53zQLF78O68haof3hDkEE9O29a+Ox7cOCzRRmEObX4dNH3SpTWt+rLQWd9QA
	7W1kK52WnoQalg1NZh0Npkq4yuQWlphw9tpc/D51Qkb6ndqHS2QKZ4zPZIeOLA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:10 +0100
Subject: [PATCH v3 08/27] spi: fsl-qspi: Support per spi-mem operation
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
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-8-7ab4bd56cf6e@bootlin.com>
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

Cc: Han Xu <han.xu@nxp.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-fsl-qspi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 9ec53bf0dda8ead27bc7a11a9bb09a08efe2ea05..355e6a39fb41896f460e2474a90b8f0b42068ff3 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -522,9 +522,10 @@ static void fsl_qspi_invalidate(struct fsl_qspi *q)
 	qspi_writel(q, reg, q->iobase + QUADSPI_MCR);
 }
 
-static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi)
+static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
+				const struct spi_mem_op *op)
 {
-	unsigned long rate = spi->max_speed_hz;
+	unsigned long rate = op->max_freq;
 	int ret;
 
 	if (q->selected == spi_get_chipselect(spi, 0))
@@ -652,7 +653,7 @@ static int fsl_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	fsl_qspi_readl_poll_tout(q, base + QUADSPI_SR, (QUADSPI_SR_IP_ACC_MASK |
 				 QUADSPI_SR_AHB_ACC_MASK), 10, 1000);
 
-	fsl_qspi_select_mem(q, mem->spi);
+	fsl_qspi_select_mem(q, mem->spi, op);
 
 	if (needs_amba_base_offset(q))
 		addr_offset = q->memmap_phy;
@@ -839,6 +840,10 @@ static const struct spi_controller_mem_ops fsl_qspi_mem_ops = {
 	.get_name = fsl_qspi_get_name,
 };
 
+static const struct spi_controller_mem_caps fsl_qspi_mem_caps = {
+	.per_op_freq = true,
+};
+
 static int fsl_qspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -923,6 +928,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 4;
 	ctlr->mem_ops = &fsl_qspi_mem_ops;
+	ctlr->mem_caps = &fsl_qspi_mem_caps;
 
 	fsl_qspi_default_setup(q);
 

-- 
2.47.0


