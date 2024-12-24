Return-Path: <linux-aspeed+bounces-306-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376B4E77188
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Dec 2024 17:27:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YHhfR65l4z2xLR;
	Wed, 25 Dec 2024 04:27:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.178.240
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735061247;
	cv=none; b=L/lN5zWusm4NKYnsG3QNqKLQ5PUo1eWL9kXQnvENEuc1VOV5/NlRTnaqWhRwQiqyIrCcWVR2Th9t8CELn0lf76OOSHWzu0Os37E0oSfUxBybE3PJ66kP+fIS0OMmuL8JQHrq9cW1uQZLO5ueAC+x3pShPKWfGgwsyHMIm7BskVOcvbGdRo/5WPk2ra5XrqRYqhIJJN05wIYtf/IqxOzHgSYP5sAo9eOrsUtZ3N1O0WXxXtBbooWzyBOtBNmYkW1lIA7npWLu+TN2RZL6Qs67XrPfle27R2T7kJnGC4AlBV2deQy7hfIU0Gv7169/ImJjJFf5Jv/rkiFPdlR1rQACkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735061247; c=relaxed/relaxed;
	bh=lEtesl+ZX1jKYhDEYl+ivyiJHI5wxENJqdJo8H/qVyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VmPbyofMaZoj0YTt8Zba4MrZe843XJ9PHTzCZpKLgR7O5TTh0sf3/WTSblV7daTSMt/tsBeo+r4P9KqM9iHqv0uDXSQwXSVrbZ2/bLGaZjnhXx1pxgVJwCRy3dHhHukBFFDezLUVMvlrXwWzU40f0rW0is8OuWnmumyC52q3/dmmVoLvG2JMklXa2lU6ssc/3adkzJZynVJj/jIaXrSWKc9omVxH3cCM30KFEukkehvu9fwpo7UWCMBaojHRXYZ5dNwtiOXoTC3/J2JUZiYsoKWFzcWaMGU3UZXCTsYXpGmdQZMcRJtKDERZJhmICaLRFo8jMmNIodMGKtrm1LIBLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=DaW6nsGt; dkim-atps=neutral; spf=pass (client-ip=217.70.178.240; helo=mslow1.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=DaW6nsGt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.178.240; helo=mslow1.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YHhfQ17Jzz2xFq;
	Wed, 25 Dec 2024 04:27:25 +1100 (AEDT)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 78CD6C104F;
	Tue, 24 Dec 2024 17:07:30 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E12540006;
	Tue, 24 Dec 2024 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735060043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEtesl+ZX1jKYhDEYl+ivyiJHI5wxENJqdJo8H/qVyg=;
	b=DaW6nsGtxuL+VYTH1qyP+YcJ77RsDjocTmrTX77zhswDh2dpoPQ7dTfszm/J3jjEBRY5KB
	aooxCYrkpL4fX16VawH5/5KqUNJsk9aqS6BGmvbz6ObcpbsaFmYgLZQlEx+Bodnu5oWR3P
	KRIBVH9kiSLknUd3N6A1zOWiFvQJcEbXzqEt+ITzV+92bY3YGH7x1qw0+MyPohznFDJNlN
	GdNaNe4cJbRvKcA6QWHpdfUlnJpsIWl8PP66NbhgGyxBAfnD5YdxpCi8r3QWvEUomyv2XN
	hVZ22K0QC0AyukvmC4TpqJTrn8KHwL5hqbww3Eea1wOCIfneUyUkesAjY9jKHA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Dec 2024 18:05:58 +0100
Subject: [PATCH v2 13/27] spi: rockchip-sfc: Support per spi-mem operation
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
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-13-ad218dbc406f@bootlin.com>
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

Cc: Han Xu <han.xu@nxp.com>
Cc: Haibo Chen <haibo.chen@nxp.com>
Cc: Yogesh Gaur <yogeshgaur.83@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-rockchip-sfc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 69d0f21755684a8a01724c29eb97123044dcf6ae..a8163fbc18923f8a96114785e46623476cf97d04 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -491,11 +491,11 @@ static int rockchip_sfc_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op
 	u32 len = op->data.nbytes;
 	int ret;
 
-	if (unlikely(mem->spi->max_speed_hz != sfc->frequency)) {
-		ret = clk_set_rate(sfc->clk, mem->spi->max_speed_hz);
+	if (unlikely(op->max_freq != sfc->frequency)) {
+		ret = clk_set_rate(sfc->clk, op->max_freq);
 		if (ret)
 			return ret;
-		sfc->frequency = mem->spi->max_speed_hz;
+		sfc->frequency = op->max_freq;
 		dev_dbg(sfc->dev, "set_freq=%dHz real_freq=%ldHz\n",
 			sfc->frequency, clk_get_rate(sfc->clk));
 	}
@@ -535,6 +535,10 @@ static const struct spi_controller_mem_ops rockchip_sfc_mem_ops = {
 	.adjust_op_size = rockchip_sfc_adjust_op_size,
 };
 
+static const struct spi_controller_mem_caps rockchip_sfc_mem_caps = {
+	.per_op_freq = true,
+};
+
 static irqreturn_t rockchip_sfc_irq_handler(int irq, void *dev_id)
 {
 	struct rockchip_sfc *sfc = dev_id;
@@ -567,6 +571,7 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 
 	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	host->mem_ops = &rockchip_sfc_mem_ops;
+	host->mem_caps = &rockchip_sfc_mem_caps;
 	host->dev.of_node = pdev->dev.of_node;
 	host->mode_bits = SPI_TX_QUAD | SPI_TX_DUAL | SPI_RX_QUAD | SPI_RX_DUAL;
 	host->max_speed_hz = SFC_MAX_SPEED;

-- 
2.47.0


