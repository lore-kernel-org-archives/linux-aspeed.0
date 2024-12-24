Return-Path: <linux-aspeed+bounces-297-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BB3E77188
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Dec 2024 17:08:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YHhDY6VL5z304x;
	Wed, 25 Dec 2024 04:08:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4b98:dc4:8::222"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735060109;
	cv=none; b=UrHnNGtx/TTZYhnSLAO7PZ3yMpM5Rgqeq+v+J+nleseCht63zxwJxpNsme8RUfSLaH8kVTEYHRlGsqKjTH7PudQ8NZALo+rn3OJP/T5m0PmZ9dXMZRg6oVji5Z9ptT8ktOe/l8B5AJHiqQ6Hz0xTWFmAwA3YHqkLnb46BC2F7wqaK2PCeoFkiqNQdBZXMj3Z4uD0hHQK0twMTqLCPH/0iHeC+GtL3WU7BCI4LmCB370rccYDaEyRgZrZ30Tt7NRYcPslYkbnUFftMX0o3j36zfFp/Kh+82euOLJP4CEa++Ny/W5ACc6yRd0xe1cgheoLbvPqiXmTEK2aXfZrHOZj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735060109; c=relaxed/relaxed;
	bh=+afwOEQnbaba+LXNGTuAYGtAsSXdRwU1zxfezGFUpKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BIFz1ZMKANXEtdLezzaX9YUe0cI63d7NIVocTsSPvupLBtE6fXdKJe20QI9Zf/APA3AhF8KVBYXnrFjr/pzUyaEjYhlJ/uPIUh35M3x8YqmD8oJI7hE8H7CKALmdfNnkhV3jk2qexSRP8n7Ctznzo5eSimkrZCgGdT97W+//3L9CVLwvvdRUQxaqou63NeiNA8wg8mXOAoXtulXalbtjt/2HE3pI4zKYn/ZVCvQoBRygri2pJVpMUxFxA8yaqyn/xqNPKboycdCIaFbhZUAo4bCnJnONJHZKhKoygynuL0JthRIx4sA9cPUr6PtaPM5o4GNB47qReqAgKWpnFtpcCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=d0I+Ib/8; dkim-atps=neutral; spf=pass (client-ip=2001:4b98:dc4:8::222; helo=relay2-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=d0I+Ib/8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=2001:4b98:dc4:8::222; helo=relay2-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YHhDW00Bzz2ypV;
	Wed, 25 Dec 2024 04:08:26 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E75BA40003;
	Tue, 24 Dec 2024 17:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735060104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+afwOEQnbaba+LXNGTuAYGtAsSXdRwU1zxfezGFUpKo=;
	b=d0I+Ib/8YxcbnQcn2sSQWaONcDnUHh95Y9JAP+oVs5WXmg2Uy0E5rDGRGpBGrDUJEyXQon
	VxhiFm+4tYji9gfM7q8vOOnXLtn+IvHFMGbNkB7dzoEczXAsiFUlyn4zrnLALlp1Ce0Jlu
	Hw9d4UR7pSwa/0gyR+riIqoOgQyQXFb5tRp2R2K3Xa3yjB3oZK0MekHyBcKnbdzkQy9sNJ
	E0XAxwcMD6aGjkrFFhK74YZt8QwlIhwb0Z1w6mNo9dmz4p4dEnC5gJB/4Cle4brwrReQAN
	TCisk9Cu9cEY8OTBN0HgMsbouJ6mBlOzAoR85kwDXQ5vlT5VbKdRcGLUnqSGcA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Dec 2024 18:06:11 +0100
Subject: [PATCH v2 26/27] mtd: spinand: winbond: Add comment about naming
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
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-26-ad218dbc406f@bootlin.com>
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

Make the link between the core macros and the datasheet.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 97517d495e57a6e9e616ed7e66b4a8e9fc1fe62a..51972ba0f193c7b27ece0296c1590ddfed0ac813 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -18,6 +18,11 @@
 
 #define W25N04KV_STATUS_ECC_5_8_BITFLIPS	(3 << 4)
 
+/*
+ * "X2" in the core is equivalent to "dual output" in the datasheets,
+ * "X4" in the core is equivalent to "quad output" in the datasheets.
+ */
+
 static SPINAND_OP_VARIANTS(read_cache_dtr_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),

-- 
2.47.0


