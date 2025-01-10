Return-Path: <linux-aspeed+bounces-397-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B0AE7719F
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 14:45:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4Fm2CM7z3cXp;
	Sat, 11 Jan 2025 01:45:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.183.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736520332;
	cv=none; b=PDcwuB5664VmIgr8F+4fyme3pEXgQWX+EF5QLsZnpoZisUBYAIvDCCUifDHyEAb/xPDcnDAjYvBP7gYeyP2q21KnrFKkvUbqjFu/sQsF4ZvQ6NRjVzo3/YcRlRAb9xG/pAPBmTu7ZnfhKZAWP/f+EjP9IB7dS0roJqCPSDafIuqWS+A4AAfr1ECxwaVup7fZML/Id9beWiA44oho+XgOIN2MPANkf71S6dTYr2Ptt7vgsgGOovSkwU5Jc5EqBj3vh4kAUzQsWSBcbLAjglWlPDCkomH06u0FNeWoMEltyfdNqW4ZDAZXD8xcZtiMvnKrwmN7yaRnym3qggr5HV8yeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736520332; c=relaxed/relaxed;
	bh=dplhgiiMhu5lUlvijJ09whzPZ6kRkT4F5CXKBJnyGI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nPQNfRk3Km5g8GQLRFiX+j+xOzuMQ2PEDFYbcRekUOZYAnDtJfoXS3FXjoAPcxFe1HoRe1v8rr+8ZnNXgoi9k4NcbdfOzub44uPwLK3k4WhWHsa8rBzak5vKfjTaCN8dWNERZp0fd3Mmk6387+JaMAWj3OLJCSBZTQ5z07JslFtb/QPvd9rafo6y9iO7iHoeDZymPo+q3M+9S7bO7DFCNJW1M3Oiq+ARkefJHKoO09u8YjH0mUhoHNpJFRtEyv1c9XxC0ybT+DNxTXzhCpl7AIFYVD8rafevBiSvF3+a7GE5SRKdco8vzYY/FPE3xj25GCBN3dJ4pzWchiUsrZJ+Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=PY2OAUb0; dkim-atps=neutral; spf=pass (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=PY2OAUb0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV4Fk4q0kz3cXQ;
	Sat, 11 Jan 2025 01:45:30 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27B4CFF806;
	Fri, 10 Jan 2025 14:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dplhgiiMhu5lUlvijJ09whzPZ6kRkT4F5CXKBJnyGI0=;
	b=PY2OAUb0ukChGfwopJPw5yxfekY09UhFNW75L8Y7tCwOjbIbfVx7fo0Dswgyb3igQ6xWhr
	3KyjlDET81zaWtehYnsXqPAEAFxTno2n9VxbVL5HZxlK2K9XpNWSiPedwRBxRm7zeMIhPc
	kRfrPaNYzwOft0xCq53psN+wTMfxeiZ9rFS4rWpYCNwbYui5sqhxKr6ul+O48UTEGBkbhA
	ywmE8QaTOjhj02EdxOvBnfwTRIXYdWqzWVkC2TCA+J4LtSCzNl9vi/9WAtAXZUuxtHQL09
	pRZb7ONm8IPYsgXgZ0JPZheqTYnG+trhaiHP2Lucbg0X5Px7hoHuy6Y8p5GHdw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:07 +0100
Subject: [PATCH v3 05/27] spi: amlogic-spifc-a1: Support per spi-mem
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
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-5-7ab4bd56cf6e@bootlin.com>
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
 drivers/spi/spi-amlogic-spifc-a1.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a1.c b/drivers/spi/spi-amlogic-spifc-a1.c
index fadf6667cd51c40a29749b378b82161a337edc62..18c9aa2cbc290d8ac179438ab42c27e1a722d422 100644
--- a/drivers/spi/spi-amlogic-spifc-a1.c
+++ b/drivers/spi/spi-amlogic-spifc-a1.c
@@ -259,7 +259,7 @@ static int amlogic_spifc_a1_exec_op(struct spi_mem *mem,
 	size_t data_size = op->data.nbytes;
 	int ret;
 
-	ret = amlogic_spifc_a1_set_freq(spifc, mem->spi->max_speed_hz);
+	ret = amlogic_spifc_a1_set_freq(spifc, op->max_freq);
 	if (ret)
 		return ret;
 
@@ -320,6 +320,10 @@ static const struct spi_controller_mem_ops amlogic_spifc_a1_mem_ops = {
 	.adjust_op_size = amlogic_spifc_a1_adjust_op_size,
 };
 
+static const struct spi_controller_mem_caps amlogic_spifc_a1_mem_caps = {
+	.per_op_freq = true,
+};
+
 static int amlogic_spifc_a1_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctrl;
@@ -356,6 +360,7 @@ static int amlogic_spifc_a1_probe(struct platform_device *pdev)
 	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctrl->auto_runtime_pm = true;
 	ctrl->mem_ops = &amlogic_spifc_a1_mem_ops;
+	ctrl->mem_caps = &amlogic_spifc_a1_mem_caps;
 	ctrl->min_speed_hz = SPIFC_A1_MIN_HZ;
 	ctrl->max_speed_hz = SPIFC_A1_MAX_HZ;
 	ctrl->mode_bits = (SPI_RX_DUAL | SPI_TX_DUAL |

-- 
2.47.0


