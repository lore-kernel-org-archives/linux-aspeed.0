Return-Path: <linux-aspeed+bounces-403-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAFBE77188
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 14:45:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4Fz31nmz3cXj;
	Sat, 11 Jan 2025 01:45:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.183.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736520343;
	cv=none; b=JsyWGwh2Cr8T06eHzGCDhcm7i/tl/0opOKtMm62Zu9GnJjqKww/jlJbuQBDfiNtycMGOqZRQYWWz9vpGdQ2Tzv8GjEpNiM1Y9c8gRQshUvJfASuZtiTX9hi1jBxS4oLLQ671gPcydXnklGIsMWo1xod1OsO0cWdzshI2wYDbxQhv3DXV1Tw1r774+by2DCkdR0sTUgj4OE8LLcrgrTf7XMpQSuD4LKJmKyQ5Y2Wy0a/yV7lhInJHvaEauJ3minPI7Oxe1cI6c1j94g2AJfSKxIOkKfii3NJmVwjE9h1Kc0i26AVAqgMa6UWkInA2GBEy9lRdyRkQKfhIKDK8W057LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736520343; c=relaxed/relaxed;
	bh=BuQ/lBXfZRP3KmcoAIIIjIvvj0TWlpOZ+bgtTbc13Ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NxvMozh0I1qe6rs8dsa/Xne97GIOvjs7WxMVpcLUQ099hKwY9yKJefmJzJL568F1dLPpupdGPmCMtVKg5/hCtsuUSymJnPJigUMVJs9alXlD10utba7k+Qh9LGJ/TzPrGpctq/lQttMiATmv4RU2nyHGcuYqbHwGhOL3irsO4kp2O6hj+ld/heuN6i+hakCwiQtc6mAZrn0krzbrSToXN6V4V8tiyq7FAvwds4nun43J5l0V4isfCJe38RUNgibnSAU+H9+jlNmB8F9u2+h+OcwnrXpvy0g6JdDkSdfAYROi+LCY2dRRXoviX4SZ9UfuxBBVnXswenGsXKnCkcHzNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=o768u8Ot; dkim-atps=neutral; spf=pass (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=o768u8Ot;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV4Fx6m0qz3cY0;
	Sat, 11 Jan 2025 01:45:41 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79EF1FF804;
	Fri, 10 Jan 2025 14:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuQ/lBXfZRP3KmcoAIIIjIvvj0TWlpOZ+bgtTbc13Ew=;
	b=o768u8Otcsz2Km36EsCHtEU5he37v6Eo3tHx2ozWdVQJXyjPuDsZOLWsGba3bIrjUGzP3Y
	ZKMtr/uwbqHC46+jWufNx7PWLIwMnBH4aJ6sEMdVfCV8HAhGEHQVGqGLotvIca27+WPBuL
	yOYCXHbamw/Fza1JVQB8BxpUv3JwMtiWKyY36HQvZJUgUz4AKqRGGOTi1nV+zrn46NfUnH
	7l1qgd/5NDOdgHrKm/HRIPARiCzrTBfQeaoPVReZVp/hi/ZkjK1/Aev3gYDSUJXhFzBB8n
	WQ/TWkmqAKqBwPY7IYCXgedFtcQDEzwIu4zfe5VBYWnCbnbHoSolOh4XAQoFvA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:13 +0100
Subject: [PATCH v3 11/27] spi: mxic: Support per spi-mem operation
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
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-11-7ab4bd56cf6e@bootlin.com>
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
 drivers/spi/spi-mxic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 809767d3145c17291525ab7c246085597e0ff5e6..eeaea6a5e3103952e71a474e0de84099bc476a79 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -522,7 +522,7 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 	int i, ret;
 	u8 addr[8], cmd[2];
 
-	ret = mxic_spi_set_freq(mxic, mem->spi->max_speed_hz);
+	ret = mxic_spi_set_freq(mxic, op->max_freq);
 	if (ret)
 		return ret;
 
@@ -582,6 +582,7 @@ static const struct spi_controller_mem_caps mxic_spi_mem_caps = {
 	.dtr = true,
 	.ecc = true,
 	.swap16 = true,
+	.per_op_freq = true,
 };
 
 static void mxic_spi_set_cs(struct spi_device *spi, bool lvl)

-- 
2.47.0


