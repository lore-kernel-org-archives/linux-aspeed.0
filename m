Return-Path: <linux-aspeed+bounces-415-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE9EE7719D
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 14:46:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4GP6qDvz3cY4;
	Sat, 11 Jan 2025 01:46:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4b98:dc4:8::229"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736520365;
	cv=none; b=omFf63hUlUfrlnZ03tA2C3M7UeCVlRRss5PNOjz/6pPkjEXf8BEQsNaq1i2f5SWzJ+9YljgJosB4HdEjzhHwZOPay347zFD2Ye5r5UsuWtEdjVg/zlLv6H5F7XQhB61UOeZOEZJnosUpicOJFCZWg2brueGMHzOajwzyDuBM/EX9Hx1BxAyfjgDwbTS34LjwA7XcHBEze6D9PegOvESAoQU2CJoWVzRJiZdxU3uvZcaEuBgVvgZGfkH4xQMnfvfY4IvvyuTZcj1dacQAdybHepqrt/rCqnSHCCSOYynhKsuS+z4wU4DYU1DHSDhkNFBClGNUwFzcms2bIxsrEsliuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736520365; c=relaxed/relaxed;
	bh=gqGs8PUET+BsGpw1lvBa5lHh5wRhBBbsSXm21QijbQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FUT13C3VFhXFLCgwFpzmeoovY3iheOAfY7Koe79NzLGLxo8Q4if5Ef3Wa7ClJJ5Mm1/xhe3rJXWDtCCcbPQJcNtf0a7W7CYEh1gYnr0CyFRQ7cETQF/M33eRoezDeoIovbHruQecrt1hvMOqsygXl/aCPsSrk3bdGFOYS6ah70mChel/Xkl2zl87ap6/IN8u0y+1Yxw6vT7KXvDMF2Mcn1z9wQQjGJ3S8gAPhCyxUwoBj/aj6ZkrMcKCslPcnYOXJ8Q88R/qHVEr450cDzfGPKzlXDgssVa/ly0CmJSt9YG+KZJEaQEcX5TJ+LxQm97W+j+t0NZoPIsJEMNxEBJ9Qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=knxkeRs+; dkim-atps=neutral; spf=pass (client-ip=2001:4b98:dc4:8::229; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=knxkeRs+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=2001:4b98:dc4:8::229; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV4GN1lcvz3cXP;
	Sat, 11 Jan 2025 01:46:03 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A47C0FF807;
	Fri, 10 Jan 2025 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqGs8PUET+BsGpw1lvBa5lHh5wRhBBbsSXm21QijbQY=;
	b=knxkeRs+zHJjSM4mur0EIav6g23HRoV1lnS4+lKJdZz5fYG2wByIPYx71fP8PFtE9m0n1+
	Lm5tNODPnNZG6BQWzHfBRhpwJlyk08XVMhzlHJS7Cg2uK9ESXuInSHhdj2CZzk4tbmCZSX
	p5yxJK3JQcjO9u4/0gB7gGiSjNt/GArPkCwrJ2E2DI9vFgfIVNtqJDmRBA700lhMrwk9Oz
	63srEcX99i9+LSSqmz3lsUHLvOzGs5hez3PUtpg16xQ3yPR8XABiVV2Hyyc5ype/UCIlNe
	NYtR0wrTL48JuM3smxZnH4XV4ekV59+bHA2Kgs0FOHyo3oR+TgD6AA5D9U7/SA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:25 +0100
Subject: [PATCH v3 23/27] mtd: spinand: Enhance the logic when picking a
 variant
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
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-23-7ab4bd56cf6e@bootlin.com>
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

Currently the best variant picked in the first one in the list provided
in the manufacturer driver. This worked well while all operations where
performed at the same speed, but with the introduction of DTR transfers
and per operation maximum frequencies, this no longer works correctly.

Let's continue iterating over all the alternatives, even if we find a
match, keeping a reference over the theoretically fastest
operation. Only at the end we can tell which variant is the best.

This logic happening only once at boot, the extra computing needed
compared to the previous version is acceptable wrt. the expected
improvements.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 94f33c8be031ac60208e22e4e3fa0d90cfae093c..a2a8cfd1752139e3227fa4a39ab0e25bbeec53f8 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1198,10 +1198,13 @@ spinand_select_op_variant(struct spinand_device *spinand,
 			  const struct spinand_op_variants *variants)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
+	const struct spi_mem_op *best_variant = NULL;
+	u64 best_op_duration_ns = ULLONG_MAX;
 	unsigned int i;
 
 	for (i = 0; i < variants->nops; i++) {
 		struct spi_mem_op op = variants->ops[i];
+		u64 op_duration_ns = 0;
 		unsigned int nbytes;
 		int ret;
 
@@ -1220,13 +1223,17 @@ spinand_select_op_variant(struct spinand_device *spinand,
 				break;
 
 			nbytes -= op.data.nbytes;
+
+			op_duration_ns += spi_mem_calc_op_duration(&op);
 		}
 
-		if (!nbytes)
-			return &variants->ops[i];
+		if (!nbytes && op_duration_ns < best_op_duration_ns) {
+			best_op_duration_ns = op_duration_ns;
+			best_variant = &variants->ops[i];
+		}
 	}
 
-	return NULL;
+	return best_variant;
 }
 
 /**

-- 
2.47.0


