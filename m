Return-Path: <linux-aspeed+bounces-402-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B31E7719C
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 14:45:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4Fx4dzTz3cXm;
	Sat, 11 Jan 2025 01:45:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4b98:dc4:8::229"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736520341;
	cv=none; b=a4wfo5G1Wc17vm6zrm9np64W8Rcs5BvBooh+GftArnLfstyZbFPfN9aU/8SGkAq3D8yPY7+5/cBlmRm2VaKcj/zwSUIA7tOINM/9cBbA/OmEBCI+BWkOxR2IPV8oAWQ9NWdiQtbBs7zH3SY/R3pnJnr89/+G0tuRBAoqYCA5L06jkx6NBaqQzBHOnNCHwxUPSIPShWqL9E6DTYWmX5v0torsQRT1FrQtAgetzye9PkAEH6RtRQsIt0lXpFqOY7xpirl4NiZFVTdRqL0JHIXAyMXQd+XQlRyaCm7ZZJbxYfxOp3ZBeZhwJBO5QoFA5++Vq9ROIW/LnB1B70urPriuFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736520341; c=relaxed/relaxed;
	bh=NPTwujdULqDMAWJvUaFFPZ6Ty000e2Bmk5z+jRzLZ3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=guKijWNMJqrs0xl4w9dIb90PGQwJyhE2b1Cf2sj8yMUaUr6Ov3zTkWQEoOBVB6vVK7KK4kq5C6MkegTMEJ7XWq6Wfl7RhVdO/J7wmiZQDMJmUCcHE/vMZqII3Ya5iufZHggL2sEOH74PYJySgs5UKGyjtxlHE106SWzKUtkCgZRHzy75Gy3mA3+COM3LChXE+ot0k95x3ZwMx8MTOzaXeCPMbtLI8AMN3zsEHo7ZXb0+e3uUaVe9NzvsdrYydoUIPtHyvDeAlLQLd750nXRQnP44FadSCY1ad9slnrJ2dYOh6PhfSyR4aE89YGmMZDPhxm1+geXJ8ZWZbUDtgcwsqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=NdcWYGi1; dkim-atps=neutral; spf=pass (client-ip=2001:4b98:dc4:8::229; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=NdcWYGi1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=2001:4b98:dc4:8::229; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV4Fw1G8pz3cY0;
	Sat, 11 Jan 2025 01:45:39 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A46A0FF809;
	Fri, 10 Jan 2025 14:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPTwujdULqDMAWJvUaFFPZ6Ty000e2Bmk5z+jRzLZ3I=;
	b=NdcWYGi1v9pxLBZsF3uk8cw7BXVazpNl372ViS/+mQi5NYuRvTcZpVJSjQyLpYYOdqwPB0
	IE+9az2ocBWsu7R9mPdVrxkPW6brhIIFmQOMfdU8qzRbJPwkPzZ4z/9KT0DUeRkDkh/Xdc
	4f7KS1JcMFPfscC+Wvdqle7XCFjgPaXNOeFIfFw5D1VClohHzyTCHGEF4C7JtF+7QpcYtT
	tCuXXhXSHACZGtQZ9Olam9DqrbdkPCIw+qb7mMjqLen0IXXudi2z7tzzW1zrC24lt6iJC0
	ljUSZf1Dl07xg/1WWqy9zI3EGG3qFB/FKnzloYnFFIsJiShp/NNGAfeLmBaREA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:12 +0100
Subject: [PATCH v3 10/27] spi: mt65xx: Support per spi-mem operation
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
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-10-7ab4bd56cf6e@bootlin.com>
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

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mt65xx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 85f3bafc975dbc3fd95f77b8dcfc0ca9aac32f5d..197bf2dbe5de7e853ccddf2c90d8bff40202f025 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -961,7 +961,7 @@ static int mtk_spi_mem_exec_op(struct spi_mem *mem,
 
 	mtk_spi_reset(mdata);
 	mtk_spi_hw_init(mem->spi->controller, mem->spi);
-	mtk_spi_prepare_transfer(mem->spi->controller, mem->spi->max_speed_hz);
+	mtk_spi_prepare_transfer(mem->spi->controller, op->max_freq);
 
 	reg_val = readl(mdata->base + SPI_CFG3_IPM_REG);
 	/* opcode byte len */
@@ -1122,6 +1122,10 @@ static const struct spi_controller_mem_ops mtk_spi_mem_ops = {
 	.exec_op = mtk_spi_mem_exec_op,
 };
 
+static const struct spi_controller_mem_caps mtk_spi_mem_caps = {
+	.per_op_freq = true,
+};
+
 static int mtk_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1160,6 +1164,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	if (mdata->dev_comp->ipm_design) {
 		mdata->dev = dev;
 		host->mem_ops = &mtk_spi_mem_ops;
+		host->mem_caps = &mtk_spi_mem_caps;
 		init_completion(&mdata->spimem_done);
 	}
 

-- 
2.47.0


