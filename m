Return-Path: <linux-aspeed+bounces-303-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC10E77188
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Dec 2024 17:26:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YHhdm0jR4z303N;
	Wed, 25 Dec 2024 04:26:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.178.240
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735061212;
	cv=none; b=afebGPFkGRL1Ui/qh+pxJsc4fdRzxxrYacFhzgtb5F9H2OjtX4e9QxidcPhOCfHvHB5QlEJup5jSYJgvnCboLNEbKLB+pdS0srgfQotGAVjaAfhD+Svl92ZaPWNh2X6Kw1lyhJmw1iSflWPQy5itSoDttosHP9GLa09zRHeQhFVbHgIp9nWvZ5YFfA+A+Y80TEe3DoZoZWKhO8ec442Ny7nMUjshyQ3K2bV2EYjCnW139+FBCnh+G2p5yV352PIAL8nwlqM7dBl+wcDQ1zNlplXpNPvnTkCvuvgv7GIqAa4c75OkR4PxZUzbd2TyhiwTWvDae1hHQfE0FWMoU4MA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735061212; c=relaxed/relaxed;
	bh=GhS+zZ6UEvQnr62N11JkbnpzTV68YUYjNDNf+0QneiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W1NwLuYFSEH2bijYbUq1NZ2pyyPU/Kw7LiXj58oqMANkyw0nixW9lJiNWxeaKsw+R1sbEr3s0lCpGSizQzP+ZtYE3ZDcyPO4r2XomPGMheaIoOU2EmnZXSCG0F7KONPCK6rM6gW7ODpGyibuPa3AjWsCPM7Q+BQmGqRA3PJliSM0gWeNVLPzmI2z8QLlj0PYEit2xf02RBLQjHhu/EDoAS4k1mD1q1MfMkyY5YzYdKkZrOIH0H48X1fKmFXX8R1m3+mFhOxcpCabRW/BgjH+v8KyEndR/dWYWNotcJ+fzKu0E/WmToSifL5PyolKQDSI+q1OkBC+cV8Sken73Fy1Fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=mjyzG3GW; dkim-atps=neutral; spf=pass (client-ip=217.70.178.240; helo=mslow1.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=mjyzG3GW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.178.240; helo=mslow1.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YHhdk2k09z3028;
	Wed, 25 Dec 2024 04:26:50 +1100 (AEDT)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id C508AC0CA1;
	Tue, 24 Dec 2024 17:06:58 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7169F40002;
	Tue, 24 Dec 2024 17:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735060011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GhS+zZ6UEvQnr62N11JkbnpzTV68YUYjNDNf+0QneiY=;
	b=mjyzG3GWELMq6c7f+8BEGOXFcDyZWw4zZFu5oZ2bXKmWLasrMO/ecJD+oTC5EHpPnh+quK
	/9s58HlReb6/z8C6P81U5uRXkQ/ZJaKPQTrjuCT/5lQKUh2hQHsGUUhSbHbz0u6oIDbciG
	/zw6CNFxXPEpc3SSOGj3alSbFeE499xV08jk+3HCwMJr8finn7su+O60xgOJj2KFY6ObfM
	Mb3x4z4jl8wpvnGBpRpLOJwKLFsP/QLpyr4h0RG5G1uW7kB++G9tcFYX5WEzbFWVmDjOHx
	HFM8urZlhjo6nG0RNMZ4fEgRUPTufSjchTwx2YIgxI17pCukEoKI0IFNCA6Bzg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Dec 2024 18:05:51 +0100
Subject: [PATCH v2 06/27] spi: cadence-qspi: Support per spi-mem operation
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
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-6-ad218dbc406f@bootlin.com>
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
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
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

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 0b45b7b2b3ab30951d94ea2ce57dcba3a2600847..e4862163252ed35053f743c74f1175e033940b17 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1407,7 +1407,7 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 	struct cqspi_flash_pdata *f_pdata;
 
 	f_pdata = &cqspi->f_pdata[spi_get_chipselect(mem->spi, 0)];
-	cqspi_configure(f_pdata, mem->spi->max_speed_hz);
+	cqspi_configure(f_pdata, op->max_freq);
 
 	if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) {
 	/*
@@ -1655,6 +1655,7 @@ static const struct spi_controller_mem_ops cqspi_mem_ops = {
 
 static const struct spi_controller_mem_caps cqspi_mem_caps = {
 	.dtr = true,
+	.per_op_freq = true,
 };
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi)

-- 
2.47.0


