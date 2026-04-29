Return-Path: <linux-aspeed+bounces-3986-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88D0FF887E
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Apr 2026 18:07:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5QHR3Jrkz2yqT;
	Thu, 30 Apr 2026 04:06:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777486019;
	cv=none; b=fnCLixlj9bVde0VZqFPfBiTWmbDjQkZof/FgqrAprgEKoetv0kwYo+7Y6dTh6JZQRKt+K+uT3JmYRuB7z7aO+Qb0vtS0Izcufv0XaCkC+84NhLb/6LTNLwxjNO8B7dILfx+OmaXkT+gIzzdVOuwdNlsgJttbVYxIfLuZ9hE1fN96HDwnq3/cutnFNyM1SciQqhFj1dyPxz/PVc8WhNbCV6tagcBIVTwx222/tI0ccD/xvTgrEQDz4qfZeF7/Q9EjNDZpk3FrtsNPzUvx5QX77SVbUNlick7kY3V5q441sKrpBYoemCQ3tUEVMTxPRHLBoC4gFXFAX5qWA4HUZrNE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777486019; c=relaxed/relaxed;
	bh=yWmmYQ59pDWo8CPH+WDZNUJOtVHq1mv94yrIZNpMFTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=US7vnau/P0RiemORxEk9ofi4zGVO3RUTNmc8WrALfG9ruYw9sd6TfMavihjxvGpsKe8dI+GkaEjz76ICsh4piyaCd7b9Hdeq2X0k5Dfp5YFw7jhvw0nzOhyFWw6a18DGukCN961lgc1+bkQU3chlI2/6LG38MdWDN9fg4ojhoSR7jQ6KZA5m/St+MAD8CMN23SoNA7ZbRkuFdsm6iZdteje4l67EXQWjHhDUdlesuGJr9Pypj3ETPDSOPJFIJrrnj+07gWSrRMxBpfrACDVfHWbuElv1djmU6S45zxKxMtWFBgpCv1j6CYl5SsViP7RptwYUZ7vshyojMoolo74zEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=A0uy++Hp; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=A0uy++Hp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5QHQ0Pvjz2yjp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Apr 2026 04:06:57 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 700B14E42B5D;
	Wed, 29 Apr 2026 17:57:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 43A3C5FD43;
	Wed, 29 Apr 2026 17:57:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 773411072B168;
	Wed, 29 Apr 2026 19:57:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777485457; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yWmmYQ59pDWo8CPH+WDZNUJOtVHq1mv94yrIZNpMFTQ=;
	b=A0uy++HpVsqXp/AWhYrAI2hp+p7ETugdFS9ytd4dkSCZwTjv36+cFoiIWz21fMnMSR76Pc
	e9+HB7ILr3sOak88h+392wCRwwauqRweo0aEedItbcLJw5mneGcjRYsFKXfoStHcHckx0G
	YdRGnC9kioVwBBtwXgo9e23sCWa5jBacVqwNtOjjGywvq/J3Kk2xPGQJ6jU9zWelyclGMn
	a7dCpyogvUIXu6KO4oUR91xBUJDErBJKBAX4/2ba3x4QQEmjuGjYXboWm+Z0S1WSQ1mS/G
	EU+q6ezfH6vSeti6bArRAEV8f3ILa5MPp+YtCN06qckkQkyMqihgfsw411IjUQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 29 Apr 2026 19:56:38 +0200
Subject: [PATCH v3 01/11] mtd: spinand: Drop a too strong limitation
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
Message-Id: <20260429-winbond-v6-18-rc1-cont-read-v3-1-0f38b3c229ad@bootlin.com>
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

Since continuous reads may sometimes not be able to go past an erase
block boundary, it has been decided not to attempt longer reads and if
the user request is bigger, it will be split across eraseblocks.

As these request will anyway be handled correctly, there is no reason to
filter out cases where we would go over a target or a die, so drop this
limitation which had a side effect: any request to read more than the
content of an eraseblock would simply not benefit from the continuous
read feature.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 66c90419f6d5..fba3cc213c88 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -878,6 +878,12 @@ static int spinand_mtd_continuous_page_read(struct mtd_info *mtd, loff_t from,
 	 * Each data read must be a multiple of 4-bytes and full pages should be read;
 	 * otherwise, the data output might get out of sequence from one read command
 	 * to another.
+	 *
+	 * Continuous reads never cross LUN boundaries. Some devices don't
+	 * support crossing planes boundaries. Some devices don't even support
+	 * crossing blocks boundaries. The common case being to read through UBI,
+	 * we will very rarely read two consequent blocks or more, so let's only enable
+	 * continuous reads when reading within the same erase block.
 	 */
 	nanddev_io_for_each_block(nand, NAND_PAGE_READ, from, ops, &iter) {
 		ret = spinand_select_target(spinand, iter.req.pos.target);
@@ -968,19 +974,6 @@ static bool spinand_use_cont_read(struct mtd_info *mtd, loff_t from,
 	nanddev_offs_to_pos(nand, from, &start_pos);
 	nanddev_offs_to_pos(nand, from + ops->len - 1, &end_pos);
 
-	/*
-	 * Continuous reads never cross LUN boundaries. Some devices don't
-	 * support crossing planes boundaries. Some devices don't even support
-	 * crossing blocks boundaries. The common case being to read through UBI,
-	 * we will very rarely read two consequent blocks or more, so it is safer
-	 * and easier (can be improved) to only enable continuous reads when
-	 * reading within the same erase block.
-	 */
-	if (start_pos.target != end_pos.target ||
-	    start_pos.plane != end_pos.plane ||
-	    start_pos.eraseblock != end_pos.eraseblock)
-		return false;
-
 	return start_pos.page < end_pos.page;
 }
 

-- 
2.53.0


