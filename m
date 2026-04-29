Return-Path: <linux-aspeed+bounces-3988-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45676FF887E
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Apr 2026 18:07:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5QHW1pNLz2yr0;
	Thu, 30 Apr 2026 04:07:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777486023;
	cv=none; b=VVVK/25mVX8DW87DBS10Pl1It5zWDKOdkiMk2d64Eh5i7tLVn5Oj4cl6nLzKgVxYIhVgqOFJVQVYtCHZWI8BHznCiLhlgbgVNqWoWt+xqdCM18J6Q+qzuVzoj4XjxQoCU+9117FLOEsnDcDFSumKGo9EPGmuGjJTFoN8pO9C+sFDsrzD3Tb1vXSn00IjO2vV/5rjHC+CJEzZ22kECGgfTiPxF7b8r/G9TwvaZL3eiTRPTD6NkHoiQOn0CJUcwf/QJNPN97pqvf/yViVrK67DatxvsbAf4KDvsfavZNAMK5Q5ICG90R5HfbeHpgbW3YtGsycFz0vJSwwvv53rQcBOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777486023; c=relaxed/relaxed;
	bh=5tIkRnE1ORjoj4u0h1eWmFg73tjo03bMRc5hBjhSYqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n34AuCYCfaavJX2nHCMM26Skg6ROWkEwJYO62XPnytxRL7BwtRbknLd32kFAtclvoZuXDTlGGe4NQv714KyFe6TJK/tI5HG5PG/Fb1euku4VF8fu98tTMPpEHc5UYHmnDSbgr42ebTT4NUDkl8eFggWTR5A6dbPGV+wpifxQMfz6nhWnmrBbA/+ubSdZCgHiExheDMsX8GuGaskBfRyDMQvuJ91C25Z8ITVZGictowb5ym5PXNr9cUwHSww0CC1bAF1Nz5oy5wtuCjoEGU+46U6MSLIoSAtpIGk09QBmoTlajzJJ86RLjd2NuQwrO37tYJViXK3UfZl2m+EhVNuyaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Vmb/o8DH; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Vmb/o8DH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5QHQ4WL8z2yqP
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Apr 2026 04:06:58 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 35F694E42B73;
	Wed, 29 Apr 2026 17:58:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 09E735FD43;
	Wed, 29 Apr 2026 17:58:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A14B1072B175;
	Wed, 29 Apr 2026 19:58:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777485491; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5tIkRnE1ORjoj4u0h1eWmFg73tjo03bMRc5hBjhSYqM=;
	b=Vmb/o8DHri8qfjlDxdgxVCmz1cOiWo5fai2OHnEYLHyIsyVdpDTgWD44JJKYBik+Bop6+W
	qO/mPLDC2HvVPtzzFzJzmO0zmj8Ud0q8Cl6mkOzfLIV5t4BqhYfAOS/P4cCduBkSpSOfmM
	5M8eLmzfXkqP4D5NBRKhvhmcWtsq9c1mg0MVwung6UnlsGwZeb4fsNZ/pNVgjm2S/Vrlqz
	cQsoBDbxgbA6MAC7jdwUUgJJZj7f2xsTfwFvpawEIDwOwqd6ZhkIt1k16aESiXmhdrWfdA
	Wg5O+8KVvlIUYgrSqKw5HE7tXplaioeNXtYi4yXBgQzvAFVe4lpxohvMt0C13A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 29 Apr 2026 19:56:46 +0200
Subject: [PATCH v3 09/11] mtd: spinand: winbond: Create a helper to write
 the HS bit
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
Message-Id: <20260429-winbond-v6-18-rc1-cont-read-v3-9-0f38b3c229ad@bootlin.com>
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

Updating the HS bit is not complex but implies reading, setting/clearing
a bit and writing. Clean a bit this section by moving this logic in its
own helper.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 6c11f59a9f8d..b30a343a6672 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -404,13 +404,28 @@ static int w25w35nxxjw_ecc_get_status(struct spinand_device *spinand, u8 status)
 	return -EINVAL;
 }
 
+static int w25n0xjw_set_sr4_hs(struct spinand_device *spinand, bool enable)
+{
+	int ret;
+	u8 sr4;
+
+	ret = spinand_read_reg_op(spinand, W25N0XJW_SR4, &sr4);
+	if (ret)
+		return ret;
+
+	if (enable)
+		sr4 |= W25N0XJW_SR4_HS;
+	else
+		sr4 &= ~W25N0XJW_SR4_HS;
+
+	return spinand_write_reg_op(spinand, W25N0XJW_SR4, sr4);
+}
+
 static int w25n0xjw_hs_cfg(struct spinand_device *spinand,
 			   enum spinand_bus_interface iface)
 {
 	const struct spi_mem_op *op;
 	bool hs;
-	u8 sr4;
-	int ret;
 
 	if (iface != SSDR)
 		return -EOPNOTSUPP;
@@ -429,20 +444,7 @@ static int w25n0xjw_hs_cfg(struct spinand_device *spinand,
 	else
 		hs = true;
 
-	ret = spinand_read_reg_op(spinand, W25N0XJW_SR4, &sr4);
-	if (ret)
-		return ret;
-
-	if (hs)
-		sr4 |= W25N0XJW_SR4_HS;
-	else
-		sr4 &= ~W25N0XJW_SR4_HS;
-
-	ret = spinand_write_reg_op(spinand, W25N0XJW_SR4, sr4);
-	if (ret)
-		return ret;
-
-	return 0;
+	return w25n0xjw_set_sr4_hs(spinand, hs);
 }
 
 static int w35n0xjw_write_vcr(struct spinand_device *spinand, u8 reg, u8 val)

-- 
2.53.0


