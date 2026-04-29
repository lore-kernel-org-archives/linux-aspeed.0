Return-Path: <linux-aspeed+bounces-3984-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8C6CD13D9
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Apr 2026 18:03:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5QCb3XcJz2yqP;
	Thu, 30 Apr 2026 04:03:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777485819;
	cv=none; b=FW1BwKNAcbJdz2Vo76kPXEk7lsDNymL+bw9LWLIm4UygIArvCERWv1LaX491YvRIywxhhSJPmj9xfWK6kA32u+Rq9fi5K6DsFQ8xOLZ5DWBon0I/glSfaP9JnoUTRpwTaNBPSHHtbGyQd7iuqwt4mlY3qbzTMn7XaGYZ1rHIvpNbtHvPb+kQgbnk3UKCL2T0G6fn+2LOgyUCyb9x3mqxlWxox4OlN9B4ycMVLu9pDyVBSP3pf/X/TvdVfvvd0SaUK87eqhwPwbCruMR5tWH8GwhcseSad8njw8/06zXT1/fM0etqKq8tINM0RS9eJ7B4gg3LqFEExz9UVwEK1AORvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777485819; c=relaxed/relaxed;
	bh=djNQC+WiehgbSjZPUHPGAOR2nkZcZmEr0KjHIcYf3t4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wu0FyXn9ZnVbmtqlahyzwzfG2mjC/U0hhiOiRbslV+qSP0+kszuVE+31iiutvfnUsBSEaKK6+uq5YRcGBD6LkIG8xo2nf40eiFAPpe7gVRHlXbnvf/9xu9HrlWsfeSMgg60TxEi7UGc2jxclzSsJqENipoTd+FGVLYbXEy9O4DCTTULwgcW1mfShTn5rWSqKvDEorHAouGSEu4N3rd538pE4kvJDJVdnFskq/ZOk40uqt9WXdoGJKD3N0G3VVMHpBM5kbnXFHBeCFCWAozoh0/vRmq1v62ZFMXgm+anXLk5UIhezbH6J7DqXHdVWj/L1u3bHw80+w7QmFJ25JAySig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NmSZF+iW; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NmSZF+iW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5QCZ1r4Rz2yjp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Apr 2026 04:03:38 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3F4D4C5CD60;
	Wed, 29 Apr 2026 17:59:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0CCFF5FD43;
	Wed, 29 Apr 2026 17:58:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C0971072B171;
	Wed, 29 Apr 2026 19:58:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777485495; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=djNQC+WiehgbSjZPUHPGAOR2nkZcZmEr0KjHIcYf3t4=;
	b=NmSZF+iWjEyn2SmSbXR4+EkHCCLdjDtILUG9X51p5SCiphlxZnjKNNGhMMDdv6+IE8Z0pT
	ASIHf/oK5ins8abEGkf3OT/DpAh4+l/rTkVjcESvNc56zjX3c6MzBilErApZ2Bhx8qWhnA
	q4skr5wiZcq3mmwHq2jiVNGW1mYCJN/tNbDh2F3BzrrvyfD4fdGmhsSID0jKhhjNOiGAz6
	jJJPYq8QKvuUtagfzMs9+zJqCAJairETws7j+Woa85G71iDosgPBr85dnsTyIGKlD82Shb
	llYfvCKlpMGTCJF/Xyt0qdAzxC71iYXH4L/FxQpv9jVgln0FJY4chh9edS6YQw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 29 Apr 2026 19:56:47 +0200
Subject: [PATCH v3 10/11] mtd: spinand: winbond: Create a helper to detect
 the need for the HS bit
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
Message-Id: <20260429-winbond-v6-18-rc1-cont-read-v3-10-0f38b3c229ad@bootlin.com>
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

The logic is not complex but might be reused to cleanup a bit the
section by moving it to a dedicated helper.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index b30a343a6672..ffbcd25b0366 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -421,30 +421,33 @@ static int w25n0xjw_set_sr4_hs(struct spinand_device *spinand, bool enable)
 	return spinand_write_reg_op(spinand, W25N0XJW_SR4, sr4);
 }
 
+/*
+ * SDR dual and quad I/O operations over 104MHz require the HS bit to
+ * enable a few more dummy cycles.
+ */
+static bool w25n0xjw_op_needs_hs(const struct spi_mem_op *op)
+{
+	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
+		return false;
+	else if (op->cmd.buswidth != 1 || op->addr.buswidth == 1)
+		return false;
+	else if (op->max_freq && op->max_freq <= 104 * HZ_PER_MHZ)
+		return false;
+
+	return true;
+}
+
 static int w25n0xjw_hs_cfg(struct spinand_device *spinand,
 			   enum spinand_bus_interface iface)
 {
 	const struct spi_mem_op *op;
-	bool hs;
 
 	if (iface != SSDR)
 		return -EOPNOTSUPP;
 
-	/*
-	 * SDR dual and quad I/O operations over 104MHz require the HS bit to
-	 * enable a few more dummy cycles.
-	 */
 	op = spinand->op_templates->read_cache;
-	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
-		hs = false;
-	else if (op->cmd.buswidth != 1 || op->addr.buswidth == 1)
-		hs = false;
-	else if (op->max_freq && op->max_freq <= 104 * HZ_PER_MHZ)
-		hs = false;
-	else
-		hs = true;
 
-	return w25n0xjw_set_sr4_hs(spinand, hs);
+	return w25n0xjw_set_sr4_hs(spinand, w25n0xjw_op_needs_hs(op));
 }
 
 static int w35n0xjw_write_vcr(struct spinand_device *spinand, u8 reg, u8 val)

-- 
2.53.0


