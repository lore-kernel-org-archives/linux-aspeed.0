Return-Path: <linux-aspeed+bounces-405-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3A6E7719D
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 14:45:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4G30BjRz3cXy;
	Sat, 11 Jan 2025 01:45:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4b98:dc4:8::229"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736520346;
	cv=none; b=cUusm2incBXp5RDc1sHqp2JHMv3Ma8bnEuqp/73mCP0Kj9nwLx2V47snaBV16zaUHYDg2ge12667FegjZlV6+KnoHRb2rfU1YBKCRtSUYFGDlEMgeqQvcnmOpc8GT6oyE6bxUF90nhzGygLF+VOoY+UKoNA5iBGGfwvLHepWHsuDIwNT5twZO8TxfoSyhE8c9uPiOsqzU8jIbqfPX6BXM8LvAwhM/OLs+SeH3tDPKkg+HDwWnET7RMFQjIVx/Pl4ibC4gPz86TcBH/pM+I4aFrw7V1PlcNDxgJKYUzkrXCp2QqLMOMfnj/VvFDJ5tvQPUV9837UZ/ysYeN9dsgR1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736520346; c=relaxed/relaxed;
	bh=lEtesl+ZX1jKYhDEYl+ivyiJHI5wxENJqdJo8H/qVyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cS/DVx2qYW7nj+pON8qZzgHB/XRUovbjtDSTObmyIJOUFi2zY98RiMcwumISjjtxLRCUNK1/p2Q8mILRAvsItBTPoS8H9FsgKosMJ15auf7qtsQkPxQYBYO3ddvNNLX9HZDswFHltZzfjqmIW4KR7Xu3YXp7Iaded9HAcqCNoYr+aKJZ3nXaCU31U/MGjxM04cYl+pqwXl8IHq8S+Wkk1qQvRZp8I+APIt8O1xNZK6/TE3GILrK9G/88tBCrmlsa1A1PFsCQH1INrthluPvOsyd0WVUNrScAa2BMsJNXkc03IPNBWmkgNN7ptLcOVjjSD9NorD/NQ6QAYhJOZb5kGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=AkbPtjem; dkim-atps=neutral; spf=pass (client-ip=2001:4b98:dc4:8::229; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=AkbPtjem;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=2001:4b98:dc4:8::229; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV4G13wKMz3cXn;
	Sat, 11 Jan 2025 01:45:45 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B95AFF810;
	Fri, 10 Jan 2025 14:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEtesl+ZX1jKYhDEYl+ivyiJHI5wxENJqdJo8H/qVyg=;
	b=AkbPtjemgG9FqkgaJjGa7C36NW/gvGEGOzho02DMPBK5j+7nW502+8z88v+WAS2eOxAaTW
	jdd3fWrMtdBZRiaxFSFPkK5hhbaP8601o/yp8LIzTaCn+jWEXCY4B8rpfBs3w4TeizkUrp
	/c8OzoVQIw7OI3/2ScJfim+8fsfxnZJDtdtsMs+cfzm+/316SnJ92sJ6gGsfdnkcydBXAG
	/plgKoiGdFPETi8haezUpgiK8UVF1bIY34tC0wHJqUa9ohbe3rmM/ktTbXf+aRSynONBcz
	7O4qHF218EFZ2GR1d8YNBk2ecn164hsNQ+y4u2mp+yWtZVr7XTMJOLjrqGqzUw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:15 +0100
Subject: [PATCH v3 13/27] spi: rockchip-sfc: Support per spi-mem operation
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
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-13-7ab4bd56cf6e@bootlin.com>
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


