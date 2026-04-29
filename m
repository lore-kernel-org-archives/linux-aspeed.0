Return-Path: <linux-aspeed+bounces-3980-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDAAFF887E
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Apr 2026 18:03:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5QCL6sbzz2yr6;
	Thu, 30 Apr 2026 04:03:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777485806;
	cv=none; b=ShFq6Jst9c42fFfGcRagv3E0SLP7YuTbwlPHQFewNzM5xAcZz69W/vOS1x+9A/GEHS0toUZ4QhxdbMjLDdenBTtKRJ8F9ZJH82lq0+qO59N9ZlZaj+xl/qtVY0PD8iSJBW5sdJEX0JS8byGNuGQICFT7MDdg4ViIp62btjTtGXK6ljvw1tx4ZGDXXlcs4hnSuUkG1QtzkkkEC6kgYdxjk9189wi59FDZQAynrFvjcNO8Adn3PNp49URfxMdooRJxP9d/amWIGJyNN2puAQv0Ed1trJ1gKpf5ywDX41xKH12F+17ztuTYB5lgEliOQJro/4goUHt0PkxdIqLaew+S6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777485806; c=relaxed/relaxed;
	bh=HprCtklTZSXAxrv5AUxEIcuHwzjnoOSSK/fyyTwUO1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hQjgjjB0bp80ChCshVf7w7N/Om51asp8dLbG8Ozfggki3cU7CEGZJKAcH3flyx8e+hhYJjWz2CBBunQ0iQZ67HeD1oHmVxkjtwbEd49X47Tnk7av0KxEqaGL48mq0Kz8qiAq4HhsXxUPjr5vWAsdQWY78CWk4BLsYAUT3KsFWzPMtHM24SrfcaDscAbqXCopnYUTmxrmtPKZrl9+52IV2kOdgKMRbUVmO29VxqXl3ZMMh6Zb0OWEuODk4sf6406v4jEZMV7KaimtU5pLg4q8gz7Ke734Hpf8ajzQ9L4B4mj70TTuGnMn3tP+YKRACC+n9T/JxHJ1KJCY5Z4cbgAnEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2h0yUx/p; dkim-atps=neutral; spf=pass (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2h0yUx/p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5QCH30Djz2yps;
	Thu, 30 Apr 2026 04:03:21 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 796031A3461;
	Wed, 29 Apr 2026 17:58:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45BF15FD43;
	Wed, 29 Apr 2026 17:58:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C10A61072B178;
	Wed, 29 Apr 2026 19:57:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777485483; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HprCtklTZSXAxrv5AUxEIcuHwzjnoOSSK/fyyTwUO1Q=;
	b=2h0yUx/p5Hja1S+pQd+gl50t3YIhkpxRsKG5nJ165vnvrTv90N4OXtorw37kK/rs2QOMtF
	UcAPQAMKCm9kV3K6OFJh2acQrCERzuvscuxFcscI84fQEWqCQ2rtotTXnFMopvBIxwPfON
	kL3XlLNf2JQ8p34gdBDBSTFxxPFVG3lp2kL7K6jIGQmPib7VBgXwOa+Ifudb8hrNj6Qibi
	XCM0FThdYK9o2KKUOjT5j8c8ladUrhTaPyatCIwsrXzpF5UcQB0FeJCDaPuox/5jC9U+XW
	3fQJes8ft8SlKmb/vtM3gnScS/HSiGG7M87RZUlOVt5IMRuvOEgWDBTr8IsPcg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 29 Apr 2026 19:56:44 +0200
Subject: [PATCH v3 07/11] mtd: spinand: winbond: Ensure chips are ordered
 by density
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
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-winbond-v6-18-rc1-cont-read-v3-7-0f38b3c229ad@bootlin.com>
References: <20260429-winbond-v6-18-rc1-cont-read-v3-0-0f38b3c229ad@bootlin.com>
In-Reply-To: <20260429-winbond-v6-18-rc1-cont-read-v3-0-0f38b3c229ad@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

All W35N0xJW chips have been added in a row, move the definition of the
2 and 4 Gb variants so their respective locations in the table.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 44 +++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index ad22774096e6..f4d4ffaa1f62 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -511,28 +511,6 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
 		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
-	SPINAND_INFO("W35N02JW", /* 1.8V */
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x22),
-		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 2, 1),
-		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
-					      &write_cache_octal_variants,
-					      &update_cache_octal_variants),
-		     0,
-		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
-		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
-		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
-	SPINAND_INFO("W35N04JW", /* 1.8V */
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x23),
-		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 4, 1),
-		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
-					      &write_cache_octal_variants,
-					      &update_cache_octal_variants),
-		     0,
-		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
-		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
-		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
 	/* 2G-bit densities */
 	SPINAND_INFO("W25M02GV", /* 2x1G-bit 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab, 0x21),
@@ -573,6 +551,17 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W35N02JW", /* 1.8V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x22),
+		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 2, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
+					      &write_cache_octal_variants,
+					      &update_cache_octal_variants),
+		     0,
+		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
+		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
 	/* 4G-bit densities */
 	SPINAND_INFO("W25N04KV", /* 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
@@ -592,6 +581,17 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W35N04JW", /* 1.8V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x23),
+		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 4, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
+					      &write_cache_octal_variants,
+					      &update_cache_octal_variants),
+		     0,
+		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
+		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
 };
 
 static int winbond_spinand_init(struct spinand_device *spinand)

-- 
2.53.0


