Return-Path: <linux-aspeed+bounces-410-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD70E77188
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 14:45:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4GD1ts6z3cXk;
	Sat, 11 Jan 2025 01:45:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.70.183.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736520356;
	cv=none; b=lF2CTALU/TjQOtiHxFfS+sPc/s1/uUcfBtYmNGHTWr9BS2eoNkC6j4rPpA91aXRJSHByBRyVXBhOr2Xbpqs7lWGRzbwDtvMbGJL//BXjPDZStAhUrCTGPAXuOud/Ct/0Ih5fEtkojwkJplxxXiDSI36SS4/2c9NIo7/zh9r7PSZMVKQzcAnJrmdwgze8inuOXThHegBDoLDnTEb7p+0CvlpT+XD8AkNihfWIGnLPLcK+mOYgv2CbvahM82jM36y/b9bnZ7RRZptCuWfD2UpKnXCCtobLEoPKrswO4glCB9gjdBrLcxgGxXh06q6FQ7wLV/575+GYqmkSYXr5FvqH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736520356; c=relaxed/relaxed;
	bh=EpRU8Ni8GjnsQQyxRFEa2zYtIybiX1a/U99sUmUB8ik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QFY9aw+ZlMqzVqU37i4FofELUxVsW9qdqcDFQ/EQ95CZ/zDW16RGVUJPZdIZeRbZ3t88WWLzCwEif0oNKmsAxE5Ou7T2Z5QHdlVt0n91pcx4dtrx7oNTTKmLvlC39h+kUfl6a7Ptxij7bgjPWmGPpUNW0U9+ICFNGU//xLIapoKJAweWnfQ3py0ibrEEGsAo2r544waOiCcWDMNcMTM7oBJiqp80bPnEe1KP5P5WwqYAIkzqkg618w/jJrAgrDfEcd4/f5OAKKMDGzT1jMMRYO9RIv9kbrzBM1ne7CgDQsie/cF+FpaLG8Up1BHALCczOPMjS8fWZpbvsurZy0j/1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=ps2xwVTl; dkim-atps=neutral; spf=pass (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=ps2xwVTl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV4GB5YvZz3cXp;
	Sat, 11 Jan 2025 01:45:54 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52486FF809;
	Fri, 10 Jan 2025 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpRU8Ni8GjnsQQyxRFEa2zYtIybiX1a/U99sUmUB8ik=;
	b=ps2xwVTlM2PTpfSbUiaA7GQikbBH2xvfr/ZvvllsjJplPe0WaeZjLR3zfkV5ZPJo9Fsvfw
	Hvr/eNi/+vf5xgAEq3I6OWryO5KLCo2GlusGdMXRZQN3ls18h+0riFckUUqD9oNbjI/gR5
	0m3WtbaalZjIWYBQtsudpoGqxwxL12PtG0RvDneXjNijWN6EDWlsydN6yevpu2gg7yKNUr
	a/p/z1DcxBrwliH5lFJMR7tggXrkA4gBMPupZ1/c4m30EBZPNtO3XRfczF2zZwitdePeJE
	Y4T+AovB8ht2v/imVIx+K6HoyMofI2fs3bA6uDikBjR/LNw8J9gnI5lezSkcNw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:20 +0100
Subject: [PATCH v3 18/27] spi: spi-mem: Reorder spi-mem macro assignments
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
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-18-7ab4bd56cf6e@bootlin.com>
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

Follow the order in which all the `struct spi_mem_op` members are
defined.

This is purely aesthetics, there is no functional change.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/spi/spi-mem.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index c7a7719c264846ad9fce613ba96d9284ad7893e7..ca6ea01c40f85095ac2730cb424cfb21d7daa700 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -15,16 +15,16 @@
 
 #define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
 	{							\
+		.nbytes = 1,					\
 		.buswidth = __buswidth,				\
 		.opcode = __opcode,				\
-		.nbytes = 1,					\
 	}
 
 #define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
 	{							\
 		.nbytes = __nbytes,				\
-		.val = __val,					\
 		.buswidth = __buswidth,				\
+		.val = __val,					\
 	}
 
 #define SPI_MEM_OP_NO_ADDR	{ }
@@ -39,18 +39,18 @@
 
 #define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)		\
 	{							\
+		.buswidth = __buswidth,				\
 		.dir = SPI_MEM_DATA_IN,				\
 		.nbytes = __nbytes,				\
 		.buf.in = __buf,				\
-		.buswidth = __buswidth,				\
 	}
 
 #define SPI_MEM_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
 	{							\
+		.buswidth = __buswidth,				\
 		.dir = SPI_MEM_DATA_OUT,			\
 		.nbytes = __nbytes,				\
 		.buf.out = __buf,				\
-		.buswidth = __buswidth,				\
 	}
 
 #define SPI_MEM_OP_NO_DATA	{ }

-- 
2.47.0


